# ArchR: Processing scATAC sequencing data

[ArchR](https://www.archrproject.com/) is a R package used for the analysis of scATAC
sequencing data. After processing raw scRNAseq FASTQ files using
[CellRanger](https://bbglab.github.io/bbgwiki/Methods/Sequencing/singleCell/CellRanger/).

## Installation

Installation requires the packages: devtools, and Bioconductor packages.

1. Install devtools

    ```r
    if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
    ```

2. Install Bioconductor

    ```r
    if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
    ```

3. Install ArchR

    ```r
    devtools::install_github("GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories())
    ```

Alternatively, [Seurat](https://bbglab.github.io/bbgwiki/Methods/Sequencing/singleCell/Seurat_scRNA_seq/) is a
frequently used R package to analyze both scRNA and scATAC sequencing data.

### References

- Article: <https://www.nature.com/articles/s41588-021-00790-6>
- Github page: <https://github.com/GreenleafLab/ArchR>

### Reference

- Axel Rosendahl Huber
