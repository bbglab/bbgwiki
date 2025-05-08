# Nucleotide content of the genome

## Introduction

The nucleotide content of the genome refers to the frequency and distribution of *n*-nucleotide sequences across the DNA. We most common count used is by trinucleotides. In principle, there are 4³ = 64 possible trinucleotide combinations, given the four DNA bases (A, C, G, and T). However, because DNA is double-stranded and sequences are often analyzed without strand specificity, many genomic analyses collapse reverse-complement pairs. As a result, the 64 trinucleotides are reduced to 32 unique trinucleotide contexts, with each context representing both a sequence and its reverse complement.

It is important to take into account the nucleotide content of the genome we are using when performing analysis that rely on the distribution of mutations across genomic positions, as the *n*-nucleotides are not equally represented. 

## Where is this data stored in the cluster?

This page aims to gather the nucleotide counts files stored in the cluster for several genomes and nucleotide combinations:
- **Whole genome GRCh38 trinucleotide counts (32 channels)**
    + Created by [Alexandrov Lab for SigProfiler](https://github.com/AlexandrovLab/SigProfilerMatrixGenerator/tree/master/SigProfilerMatrixGenerator/references/chromosomes/context_distributions)
    + Stored at `/data/bbg/datasets/genomes/context_counts/sigprofiler/context_counts_GRCh38_96.csv`  
    + Rows represent trinucleotides, columns chromosomes and cells are filled with the absolute trinucleotide count for the reference genome
