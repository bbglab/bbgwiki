# MaveDB mutation scores

## Introduction

The [MaveDB](https://www.mavedb.org/) is a public repository for datasets from Multiplexed Assays
of Variant Effect (MAVEs),
such as those generated by deep mutational scanning (DMS) or massively parallel reporter assay (MPRA) experiments.

## How to fetch mutation scores from the MaveDB database

We can retrieve mutation scores for a given set of input mutations using the command line from the ENSEMBL-VEP
alongside the [MaveDB plugin](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html#mavedb).

Within an interactive session in the cluster, you can use the following command line as a template and modify it
according to your specific needs:

```sh
singularity exec /data/bbg/datasets/vep/homo_sapiens/ensembl-vep_111.0.sif vep --dir /data/bbg/datasets/vep/ \
--tab -i input_mutations.tsv --offline --cache -o output_annotated_mutations.tsv \
--species homo_sapiens --assembly GRCh38 --fork 8 --canonical \
--plugin MaveDB,file=/data/bbg/datasets/vep/homo_sapiens/plugins/MaveDB_variants.tsv.gz
```

## Remarks

`input_mutations.tsv` must be in an accepted format for VEP, a tab separated file with **chromosome**, **start**,
**end** and **variant** like in the following example will work.

```tsv
17  43045712    43045712    T/C
```

`output_annotated_mutations.tsv` is the filename of the output.

`--canonical` is a VEP command line option, it simply adds a column pointing out whether the transcript is canonical.

Bear in mind that some scores have several tracks of data and some postprocessing might be required after the query.

## Reference

Ferran Muiños,
Paula Gomis,
Miguel Grau

Updated 2024/07/01
