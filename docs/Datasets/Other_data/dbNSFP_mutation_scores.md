
# dbNSFP mutation scores

## Introduction

The [dbNSFP database](https://sites.google.com/site/jpopgen/dbNSFP) curates a large collection of mutation
scores that can reveal very useful for variant effect analysis, including benchmarking of new variant effect tools.

## How to fetch mutation scores from the dbNSFP database

We can retrieve mutation scores for a given set of input mutations using the command line from the ENSEMBL-VEP
alongside the [dbNSFP plugin](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html#dbnsfp).

Within an interactive session in the cluster, you can use the following command line as a
template and modify it according to your specific needs:

```sh
singularity exec /data/bbg/datasets/vep/homo_sapiens/ensembl-vep_111.0.sif vep --dir /data/bbg/datasets/vep/ \
--tab -i input_mutations.tsv --offline --cache -o output_annotated_mutations.tsv \
--species homo_sapiens --assembly GRCh38 --fork 8 --canonical \
--plugin dbNSFP,/data/bbg/datasets/vep/homo_sapiens/plugins/dbNSFP4.5a_grch38.gz,\
SIFT_score,SIFT4G_score,Polyphen2_HDIV_score,Polyphen2_HVAR_score,MutationAssessor_score,FATHMM_score,MetaLR_score,MetaRNN_score,CADD_raw,VEST4_score,PROVEAN_score,REVEL_score,ESM1b_score,EVE_score,AlphaMissense_score,phyloP100way_vertebrate,phyloP470way_mammalian,phyloP17way_primate
```

## Remarks

`input_mutations.tsv` must be in an accepted format for VEP, a tab separated file with **chromosome**, **start**,
**end** and **variant** like in the following example will work.

```tsv
17  43045712    43045712    T/C
```

`output_annotated_mutations.tsv` is the filename of the output.

`--canonical` is a VEP command line option, it simply adds a column pointing out whether the transcript is canonical.

Right after `--plugin dbNSFP,/data/bbg/datasets/vep/homo_sapiens/plugins/dbNSFP4.5a_grch38.gz` and separated by commas
it goes the list of all the accepted scores that you want to be mapped to your query mutations.
You can check out the full list of scores here:

Bear in mind that some scores have several tracks of data and some postprocessing might be required after the query.

## Reference

Ferran Muiños,
Paula Gomis,
Miguel Grau

Updated 2024/07/01
