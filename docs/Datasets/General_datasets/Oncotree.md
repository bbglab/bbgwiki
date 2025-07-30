# Oncotree Repository

## Description

Different versions of the Oncotree have been used and modified according to specific projects, resulting in
inconsistencies when these projects or tools needed to interact with each other. To address this issue, the BBGLab has
created a repository to unify the Oncotree versions.

This repository contains **all the different Oncotrees** used by the BBGLab, with the latest version as the main branch.

## Repository Structure

Oncotree repository: [https://github.com/bbglab/oncotree](https://github.com/bbglab/oncotree)

Structure:

- `mappings/`: Contains the different mappings (JSON files) between various Oncotree versions. For example, you will
find the mapping between the Oncotree used by the CGI2021 version and the Intogen2023 version.
- `scripts/`: Contains the different scripts used to generate the Oncotree, as well as the various mappings.
- `oncotree.tsv`: Latest version of the Oncotree.
- `tree_cancer_types.json`: Latest version of the Oncotree in JSON format.
- `definitions.json`: Contains the dictionary that relates tumor type IDs to their corresponding full names.

## Different Oncotree Versions

Ideally, you should use the latest version of the Oncotree stored in the `oncotree.tsv` file. However, you can still
access different versions of the Oncotree by changing the repository tag.

These tags are named after the tools that used the specific Oncotree versions. For example, to access the Oncotree
version used by the CGI2021 tool, change the tag to `cgi2021`.

## Reference

- Federica Brando
- Carlos López-Elorduy
