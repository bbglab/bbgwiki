# MosaicForecast

A machine learning method that leverages read-based phasing and read-level features to accurately detect mosaic SNVs (SNPs, small indels) from NGS data. It builds on existing algorithms to achieve a multifold increase in specificity.

## Description

**MosaicForecast** is a machine learning-based variant caller designed for the sensitive detection of postzygotic mosaic single nucleotide variants (mSNVs) from whole-genome or whole-exome sequencing data. Developed by the Park Lab at Harvard Medical School, MosaicForecast integrates read-level features and a random forest classifier to distinguish mosaic mutations from germline variants and sequencing artifacts with high precision.

## Dependency:

### Required Interpreter Versions:

* Python version 3.6+
* R version 3.5+

### Installation of Dependencies:

1. We have created a docker image with all dependencies installed:  
	https://hub.docker.com/r/yanmei/mosaicforecast  
	Usage:  
		docker image pull yanmei/mosaicforecast:0.0.1  
		docker run -v ${your_local_directory}:/MF --rm -it yanmei/mosaicforecast:0.0.1 /bin/bash  
		gunzip hs37d5.fa.gz  
		Phase.py /MF/demo/ /MF/demo/phasing hs37d5.fa /MF/demo/test.input 20 k24.umap.wg.bw 4 
```
Please note that "${your_local_directory}:/MF" is the absolute path of your local mosaicforecast directory. After attaching your local MF directory to the docker image, you would be able to read and write from that directory in your docker image. The attached directory in the docker image would be "/MF".
```
		
	 
2. You could also install conda first (https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh), and then create an environment using conda through this command:  
conda env create --name MF --file environment.yaml  
The environment 'MF' could be activated through this command:  
conda activate MF  
Other dependencies and resources could be downloaded though running:  
bash downloads.sh 

You can also set up the environment manually, even though it is not recommended.
Theres a list of packages in the [git-repository](https://github.com/parklab/MosaicForecast)

## Resources:
You will find how to download them in the [git-repository](https://github.com/parklab/MosaicForecast):

* Human reference genome: 
* Mappability score: Umap score (k=24)   

#### Regions to filter out:

* Segmental Duplication regions (should be removed before calling all kinds of mosaics):  
* Regions enriched for SNVs with >=3 haplotypes (should be removed before calling all kinds of mosaics):  
* Simple repeats (should be removed before calling mosaic INDELS):  

#### Population allele frequency

* gnomAD datasets (recommend to remove variants with population MAF>0.001%):  

## Usage:

### Phasing:

**Usage:** 

python Phase.py bam_dir output_dir ref_fasta input_positions min_dp_inforSNPs Umap_mappability(bigWig file,k=24) n_threads_parallel sequencing_file_format(bam/cram)

**Note:** 

1. Name of bam files should be "sample.bam" under the bam\_dir, and there should be index files under the same directory (samtools index sample.bam).   
2. There should be a fai file under the same dir of the fasta file (samtools faidx input.fa).
3. File format of the input\_positions: chr pos-1 pos ref alt sample, sep=\t 
4. The "min\_dp\_inforSNPs" is the minimum depth of coverage of trustworthy neaby het SNPs, can be set to 20.
5. The program to extract mappability score: "bigWigAverageOverBed" should be downloaded and installed, and its path should be added to the PATH environment variable.

**Demo:**
```
python Phase.py demo demo/phasing ${human_g1k_v37_decoy.fasta} demo/test.input 20 ${k24.umap.wg.bw} 2
```
**Output:**
```
output_dir/all.phasing
```
| sample | chr | pos | ref | alt | phasing | conflicting_reads | mappability | variant_type |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| test | 12 | 52644508 | C | T | hap=3 | 0 | 1.0 | SNP |
| test | 15 | 75918044 | G | A | hap=3 | 0 | 1.0 | SNP |
| test | 1 | 1004865 | G | C | hap=3 | 0 | 1.0 | SNP |
| test | 1 | 2591769 | AG | A | hap>3 | 1 | 0.0 | DEL |
| test | 1 | 33801576 | TTTGTTG | T | hap=2 | 0 | 0.583333 | DEL |

```
hap=2: likely het variants
hap=3: likely mosaic variants
hap>3: likely cnv/repeat
conflicting_reads: number of read pairs supporting both ref and alt alleles.

Intermediate files:
1. output_dir/all.merged.inforSNPs.pos: all nearby inforSNPs of candidate mosaics.
2. output_dir/all_2x2table: 2x2 tables by all nearby inforSNPs.
3. output_dir/all.phasing_2by2: Phasing results of mosaics and all nearby inforSNPs (2x2 table).
4. output_dir/multiple_inforSNPs.log: Phasing results of different pairs of inforSNPs.

```

### Extraction of read-level features:

**Usage:**

python ReadLevel_Features_extraction.py input.bed output_features bam_dir ref.fa Umap_mappability(bigWig file,k=24) n_jobs_parallel sequencing_file_format(bam/cram)

**Note:**

1. Names of bam files should be "sample.bam" under the bam_dir, and there should be index files under the same directory (samtools index sample.bam). Cram files are also supported.
2. There should be a fai file under the same dir of the fasta file (samtools faidx input.fa)
3. File format of the input.bed: chr pos-1 pos ref alt sample, sep=\t 
4. We did not use gnomad population AF as an feature (instead we use it to filter), but you can use it to train your model if you have interest in common variants
5. The program to extract mappability score: "bigWigAverageOverBed" should be downloaded and installed, and its path should be added to the PATH environment variable.

**Demo:**
```
python ReadLevel_Features_extraction.py demo/test.input demo/test.features demo ${ref.fa} ${k24.umap.wg.bw} 2 bam  
```
**Output:**
```
A list of read-level features for each input site.
```

| id | dp_p | conflict_num | mappability | type | length | GCcontent | ref_softclip | alt_softclip | querypos_p | leftpos_p | seqpos_p | mapq_p | baseq_p | baseq_t | ref_baseq1b_p | ref_baseq1b_t | alt_baseq1b_p | alt_baseq1b_t | sb_p | context | major_mismatches_mean | minor_mismatches_mean | mismatches_p | AF | dp | mosaic_likelihood | het_likelihood | refhom_likelihood | althom_likelihood | mapq_difference | sb_read12_p | dp_diff |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| test\~11\~40316580\~C\~T | 0.3183008162818 | 0 | 1 | SNP | 0 | 0.476190476190476 | 0.0240384615384615 | 0 | 0.1582 | 0.16521 | 0.68821 | NA | 0.91657 | -0.57364 | 0.98911 | 0.21893 | 0.67576 | -0.8528 | 0.69934 | GGA | 0.00878 | 0.0144466666666667 | 0.29396 | 0.028 | 214 | 0.999414559235067 | 3.90999117967593e-49 | 0.000585440764932926 | 0 | 0 | 0.69142 | -12.8571 |
| test\~12\~52644508\~C\~T | 0.197545792452075 | 0 | 1 | SNP | 0 | 0.571428571428571 | 0.0208333333333333 | 0 | 0.19325 | 0.20057 | 0.88251 | NA | 0.11764 | -0.95448 | 0.31536 | 0.6827 | 0.31601 | 0.58756 | 0.13401 | CGC | 0.01236 | 0.0127266666666667 | 0.17424 | 0.054 | 203 | 0.999999999985368 | 5.11687178601205e-39 | 1.46319954019795e-11 | 0 | 0 | 0.36124 | -12.8571 |

### Genotype Prediction:

**Usage:**

Rscript Prediction.R input\_file(feature\_list) model\_trained model\_type(Phase|Refine) output\_file(predictions)

**Note:**

1. The "input\_file" is a list of read-level features obtained in the last step.
2. The "model\_trained" is the pre-trained RF model to predict genotypes.
3. If you trained model with refined-genotypes (mosaic, het, refhom, repeat), then the "model\_type" is "Refine"; otherwise if you trained model with Phasing (hap=2, hap=3, hap>3), then the "model\_type" is "Phase". 
4. We also added annotations of additional filtrations: Predicted mosaics with extra-high read depths (>=2X), sites with >=1.5X read depths and >=20% AF were marked as "low-confidence"; predicted mosaics with only one alt allele and <1% AF were marked as "cautious".  

> You may use our models trained with brain WGS data for SNPs (paired-end read at 50-250X read depths, we train our models based on Mutect2-PON callings. To our experience, the models were pretty robust across different depths, but the best strategy would be using a model with similar depth with your data):
>
> * models\_trained/50xRFmodel\_addRMSK\_Refine.rds
> * models\_trained/100xRFmodel\_addRMSK\_Refine.rds
> * models\_trained/150xRFmodel\_addRMSK\_Refine.rds
> * models\_trained/200xRFmodel\_addRMSK\_Refine.rds
> * models\_trained/250xRFmodel\_addRMSK\_Refine.rds
>
> We also pre-trained a model for mosaic deletions (using paired-end read at 250X, with phasing information):
> * models\_trained/deletions\_250x.RF.rds

**Demo:**
```
Rscript Prediction.R demo/test.SNP.features models_trained/250xRFmodel_addRMSK_Refine.rds Refine demo/test.SNP.predictions   
Rscript Prediction.R demo/test.DEL.features models_trained/deletions_250x.RF.rds Phase demo/test.DEL.predictions
```
**Output:**
```
Genotype predictions for all input sites.
```

| id | AF | dp | prediction | het | mosaic | refhom | repeat |
| --- | --- | --- | --- | --- | --- | --- | --- |
| test\~11\~40316580\~C\~T | 0.028 | 214 | mosaic | 0.002 | 0.958 | 0 | 0.04 |
| test\~12\~52644508\~C\~T | 0.054 | 203 | mosaic | 0.002 | 0.982 | 0 | 0.016 |
| test\~15\~75918044\~G\~A | 0.036 | 193 | mosaic | 0.006 | 0.812 | 0 | 0.182 |
| test\~1\~1004865\~G\~C | 0.085 | 212 | mosaic | 0.006 | 0.988 | 0 | 0.006 |

```
1. prediction: genotype predictions including refhom, het, mosaic and repeat.
2. het/mosaic/refhom/repeat: genotyping probabilities for each genotype.
```

## Reference

* [git-repository](https://github.com/parklab/MosaicForecast)
* Joan Enric
