# Extract minibams from Hartwig data in googleCloud

## 1. Create the VM and the storage bucket.
(This tutorial assumes that you already have the credentials to access the data and use the GCP)

First, from [Google Cloud Platform website](https://console.cloud.google.com/), you create a VM (_Compute Engine -> VM instances. Create Instance_). In this case we choose an __e2-highmem8 (8vCPU, 4 core, 64GB RAM__). Region: _europe-west3 (Frankfurt)_ . In _Availability policies - VM_,  _Provisioning model_: SPOT. Attach a disk of 250GB, persistent (_Advanced options - Disks - Add new disk - Edit Name and Size_). Then, we can connect using a ssh web terminal or a local one. 

    !!! info
        It's important to create the VM in the same region where the data is, so we avoid charges for moving data between regions, if any. 


Next, prepare the VM:

``` bash
screen -R mysession
curl -O https://repo.anaconda.com/miniconda/Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
chmod 755 Miniconda3-py39_22.11.1-1-Linux-x86_64.sh
bash Miniconda3-py39_22.11.1-1-Linux-x86_64.sh 
eval "$(/home/miguel_grau/miniconda3/bin/conda shell.bash hook)"
conda create -n samtools -y
conda activate samtools
conda config --add channels bioconda
conda config --add channels conda-forge
conda install samtools==1.11  -y
conda install -c anaconda python  -y
conda install -c anaconda python=3 -y
gcloud auth login
gcloud config set project instant-carrier-264511

# if the persistent disk doesn't appear automatically with a df -H:
# Replace google-disk-1 with your disk name
mkdir -p /ext/ssd/
sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/disk/by-id/google-disk-1
sudo mount -o discard,defaults /dev/disk/by-id/google-disk-1 /ext/ssd/
sudo chmod a+w /ext/ssd/
```

Next, create a bucket where the results will be copied during the minibam generation (_Cloud Storage - Buckets_). _Location type: Region, europe-west4 (Netherlands)_


## 2. Prepare the input file

Our input file is a ~bed file with samples IDs and regions (IDs_regions.csv), e.g.:
```
CPCT02010702    3:43228348-43228748
CPCT02010702    14:101303564-101303964
CPCT02010702    19:18451144-18451544
CPCT02010728    2:176568493-176568893
```

    !!! info
        The regions file must be sort by sampleID.


We need to extract the CRAM URLs from the _manifest.json_ of the hartwig release of interest, in this case _20230914v_:

```
#/data/bbg/datasets/hartwig/20230914/scripts/minibam/extract_urls.py

import json
import csv

def extract_cram_url(json_data, sample_id):
    for item in json_data["data"]:
        if item["sampleId"] == sample_id:
            return item["crams"]["tumor"]["url"]
    return None

def process_manifest(json_file_path, txt_file_path, csv_output_path):
    with open(json_file_path, 'r') as json_file:
        manifest_data = json.load(json_file)

    with open(txt_file_path, 'r') as txt_file, open(csv_output_path, 'w', newline='') as csv_file:
        csv_writer = csv.writer(csv_file, delimiter='\t')
        csv_writer.writerow(["SampleID", "GenomicRegion", "Tumor_CRAM_URL"])

        for line in txt_file:
            parts = line.strip().split()
            sample_id, genomic_region = parts[0]+"T", parts[1]

            cram_url = extract_cram_url(manifest_data, sample_id)

            if cram_url is not None:
                csv_writer.writerow([sample_id, genomic_region, cram_url])
            else:
                print(f"Warning: No CRAM URL found for sample {sample_id}")

if __name__ == "__main__":
    json_file_path = "/data/bbg/datasets/hartwig/20230914/manifest.json"
    txt_file_path = "/data/bbg/datasets/hartwig/20230914/scripts/minibam/IDs_regions.csv"
    csv_output_path = "IDs_regions_url.csv"

    process_manifest(json_file_path, txt_file_path, csv_output_path)

```

So the output is a file including the urls:
```
SampleID        GenomicRegion   Tumor_CRAM_URL
CPCT02010702T   3:43228348-43228748     gs://example_url/CPCT02010702T/cram/CPCT02010702T_dedup.realigned.cram
CPCT02010702T   14:101303564-101303964  gs://example_url/CPCT02010702T/cram/CPCT02010702T_dedup.realigned.cram
CPCT02010702T   19:18451144-18451544    gs://example_url/CPCT02010702T/cram/CPCT02010702T_dedup.realigned.cram
```
## 3. Create minibams

For each line, it extracts the regions in a minibam. If the next region is from the same sample, it keeps the cram. If not, it deletes the cram and downloads the next one.

```
#/data/bbg/datasets/hartwig/20230914/scripts/minibam/dwnRunMiniBam_multi.py

import subprocess

def execute_command(command):
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output, error = process.communicate()
    return output, error, process.returncode

def process_web_addresses(file_path, bucket_name):
    previous_file = ""
    regions = ""
    with open(file_path, 'r') as file:
        next(file)
        for line in file:
            web_address = line.strip().split("\t")[2]
            file_name = web_address.split("/")[-1]
            region = line.split("\t")[1]

            if file_name != previous_file:
              # Delete previous crams
              if previous_file != "":
                ofile_name = previous_file.split('.cram')[0]+".mini.bam" 
                # Process the file with samtools
                samtools_command = f"samtools view -b /ext/ssd/{previous_file} {regions} > /ext/ssd/{ofile_name}"
                print ("Running samtools... ")
                execute_command(samtools_command)
                print (samtools_command)

                # Upload the results to the Google Cloud Storage bucket
                upload_command = f"gsutil cp /ext/ssd/{ofile_name} gs://{bucket_name}/"
                print ("Copying results... ")
                execute_command(upload_command)
                print (upload_command)
 
                del_command = f"rm /ext/ssd/{previous_file} /ext/ssd/{previous_file}.crai"
                execute_command(del_command)
                print (del_command)
                regions = ""

              # Download the new crams using gsutil
              download_command = f"gsutil -u instant-carrier-264511 cp {web_address} /ext/ssd/"
              print ("Downloading "+file_name)
              execute_command(download_command)
              print (download_command)
              download_icommand = f"gsutil -u instant-carrier-264511 cp {web_address}.crai /ext/ssd/"
              execute_command(download_icommand)
              print (download_icommand)
        
            regions += region if regions == "" else " "+region
            previous_file = file_name
        
        #Last extraction
        # Delete previous crams
        if previous_file != "":
            ofile_name = previous_file.split('.cram')[0]+".mini.bam"
            # Process the file with samtools
            samtools_command = f"samtools view -b /ext/ssd/{previous_file} {regions} > /ext/ssd/{ofile_name}"
            print ("Running samtools... ")
            execute_command(samtools_command)
            print (samtools_command)

            # Upload the results to the Google Cloud Storage bucket
            upload_command = f"gsutil cp /ext/ssd/{ofile_name} gs://{bucket_name}/"
            print ("Copying results... ")
            execute_command(upload_command)
            print (upload_command)

            del_command = f"rm /ext/ssd/{previous_file} /ext/ssd/{previous_file}.crai"
            execute_command(del_command)
            print (del_command)

if __name__ == "__main__":
    txt_file_path = "IDs_regions_url.csv"  # Replace with the actual path to your text file
    gcs_bucket_name = "masha_bkt"  # Replace with the actual name of your GCS bucket

    process_web_addresses(txt_file_path, gcs_bucket_name)

```

The script extracts the minibams one by one, deleting a cram before download a new one (that's why our persistent disk is only 250GB). It process ~100 samples per day, so this approach is only valid for small datasets. If you plan to do it for thousands of samples, contact us.


## Reference

- Miguel
- Federica
- Carlos