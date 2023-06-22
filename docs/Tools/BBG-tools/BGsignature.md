# BGsignature

## Description

BGsignature is a package used to compute mutational profiles. A mutational profile corresponds to the count or the normalized frequencies of mutations in every possible k-nucleotide (e.g., trinucleotide or pentanucleotide) contexts. 

BGsignature package includes three tools:

* __count__: get the number of mutations in the k-nucleotide contexts
* __frequency__: get the frequency of mutations (count divided by total mutations) in the k-nucleotide contexts
* __normalize__: get the normalized frequency of mutations taking into account the k-nucleotide contexts

The count and the frequency of mutations can be computed for a set of regions or for a set of mutations that fall within certain regions.

## Instalation 

```bash
pip install bgsignature
```

## Input

BGsignature requires two input files:

* __mutation file__: a compressed tab separated file (tsv) including an header and at least the following columns: CHROMOSOME, POSITION, REF, ALT. Other useful but not necessary columns to include in the mutation file are SAMPLE, CANCER_TYPE and SIGNATURE.
* __regions file__: 

# Examples

```bash
<examples on how to compute the mutational profiles of 192 channels used by the methods in intogen>
```


## Repository
Click here to see the [repository of BgReference](https://bitbucket.org/bgframework/bgsignature/src/master/){:target="_blank"}.

## Reference
- Stefano Pellegrini
