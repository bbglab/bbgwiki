<!-- Vep -->

# Ensembl-VEP

!!! note annotate ""
    VEP determines the effect of your variants (insertions, deletions and structural variants) on genes, transcripts, and protein sequence, as well as regulatory regions.

## How and where to install a new version?

There is a shared folder in datasets where there are several vep cache versions and docker containers. If you are planning to download one, make sure to store it in this location.

`/workspace/datasets/vep`

The easiest way to use a new version of vep is downloading the [docker container](https://hub.docker.com/r/ensemblorg/ensembl-vep/tags?page=1). Most popular versions are already downloaded in `/workspace/datasets/vep/homo_sapiens` (or `/workspace/datasets/vep/mus_musculus` for mice).

An example for downloading a new version:

```sh
singularity pull docker://ensemblorg/ensembl-vep:release_109.0
```

Once the container is ready, we can download the vep-cache required:

```sh
singularity exec ensembl-vep_109.sif INSTALL.pl -c 109_GRCh38/ -a cf -s homo_sapiens --ASSEMBLY GRCh38
```

*IMPORTANT*. Each database only works with the specific ensembl-vep version used to download the database. In the previous example, the `109_GRCh38/` will work only with the ensembl-vep_109 version.

For more details, you can follow the [installation guide](https://www.ensembl.org/info/docs/tools/vep/script/vep_download.html).

## How to use

Once you are in a working node:

```sh
mgrau@bbgn009:/workspace/datasets/vep/homo_sapiens$ singularity exec ensembl-vep_109.sif vep

#----------------------------------#
# ENSEMBL VARIANT EFFECT PREDICTOR #
#----------------------------------#

Versions:
  ensembl              : 109.10baaec
  ensembl-funcgen      : 109.cba2db8
  ensembl-io           : 109.4946a86
  ensembl-variation    : 109.18a12b6
  ensembl-vep          : 109.3

Help: dev@ensembl.org , helpdesk@ensembl.org
Twitter: @ensembl

http://www.ensembl.org/info/docs/tools/vep/script/index.html

Usage:
./vep [--cache|--offline|--database] [arguments]

Basic options
=============

--help                 Display this message and quit

-i | --input_file      Input file
-o | --output_file     Output file
--force_overwrite      Force overwriting of output file
--species [species]    Species to use [default: "human"]

--everything           Shortcut switch to turn on commonly used options. See web
                       documentation for details [default: off]
--fork [num_forks]     Use forking to improve script runtime

For full option documentation see:
http://www.ensembl.org/info/docs/tools/vep/script/vep_options.html

```

## Example job

A real example command could be:

```sh
mgrau@bbgn009:/workspace/datasets/vep/homo_sapiens$ singularity exec vep109.sif vep --dir /workspace/datasets/vep/ -i variants_ref38.vcf.gz --offline --format vcf --vcf --cache -o exampleout.vcf --species homo_sapiens --assembly GRCh38 --fork 8
```

To speed up the process, it is recommended to use the downloaded vep-cache files specifying the directory (`--dir`) and the `--offline` and `--cache` options. VEP allows multithreating using the `--fork` option.

For full option documentation see [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html).

Full instructions on how to download and use cached files can be found [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html).

## Additional comments

Be careful when running VEP with the TAB output and then merging again the variants from a VCF file, some indels are reformated in VEP and you cannot pair them with the original mutations.

!!! info
    You can find another example using VEP data and google cloud -- see [Extract minibams from Hartwig data in googleCloud](../Plots_and_scripts/minibam_hartwig_GCP.md) section.

## Links

- [Ensembl-VEP documentation](https://www.ensembl.org/info/docs/tools/vep/script/VEP_script_documentation.pdf)
- [Ensembl-VEP tutorial](https://www.ensembl.org/info/docs/tools/vep/script/vep_tutorial.html)
- [Ensembl-VEP examples](https://www.ensembl.org/info/docs/tools/vep/script/vep_example.html)
- [Ensembl-VEP web application](https://www.ensembl.org/Tools/VEP)

## Reference

- Miguel Grau
- Federica Brando
- Carlos López-Elorduy
