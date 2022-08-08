<!-- Vep -->

# Ensembl-VEP
!!! note annotate ""
    VEP determines the effect of your variants (insertions, deletions and structural variants) on genes, transcripts, and protein sequence, as well as regulatory regions.


## Usage
In order to install VEP, you can follow the [installation guide](https://www.ensembl.org/info/docs/tools/vep/script/vep_download.html).

Once it is installed, simply load the `ensembl-vep` module:

```
$ vep

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
```

For full option documentation see [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_options.html).

Instructions on how to download and use cached files can be found [here](https://www.ensembl.org/info/docs/tools/vep/script/vep_cache.html).

To enable offline mode and use of the cache, pass the `--offline` and `--cache` flags.

## Example job
### Serial job
Here is an example job running on 1 core and 1GB of memory:

```bash
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 1
#$ -l h_rt=1:0:0
#$ -l h_vmem=1G

vep -i homo_sapiens_GRCh38.vcf \
    --cache \
    --offline \
    --output_file results
```

## Links

- [Ensembl-VEP documentation](https://www.ensembl.org/info/docs/tools/vep/script/VEP_script_documentation.pdf)
- [Ensembl-VEP tutorial](https://www.ensembl.org/info/docs/tools/vep/script/vep_tutorial.html)
- [Ensembl-VEP examples](https://www.ensembl.org/info/docs/tools/vep/script/vep_example.html)
- [Ensembl-VEP web application](https://www.ensembl.org/Tools/VEP)

## Reference

- _To be added_
