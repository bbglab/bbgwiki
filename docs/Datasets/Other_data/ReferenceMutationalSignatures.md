# Reference Mutational Signatures

## COSMIC: Catalogue of Somatic Mutations in Cancer

- URL: [cancer.sanger.ac.uk/signatures](https://cancer.sanger.ac.uk/signatures/)
- Extracted from tumors
- SBS, ID, DBS, CN and SV mutational processes
- Maintained by the Sanger Institute

### *Highlights*
- COSMIC displays for each signature a battery of analyses showing about tissue prevalence, strand asymmetry, enrichment of histone modifications, nucleosome occupancy, CTCF occupancy, etc.

### *Where is this data stored in the cluster?*
A tab-separated table with the COSMIC v3.4 signatures is available at `/data/bbg/datasets/COSMIC_signatures/COSMIC_v3.4_SBS_GRCh38.txt`. Rows represent the 96 possible mutational contexts (as trinucleotides) and columns the name of the reference signature. Each column sums to one and the values in each cell are the contribution of the mutational context to that signature. Bear in mind that this contribution was calculated for the whole genome content and you may need to adjust these contributions if your genome content is different (*e.g.*: panel sequencing).

### *Signature groups*
As you probably know for several of the signatures in the COSMIC reference catalog there is a known aetiology, and this allows us to define several signature groups.

[AlexandrovLab](https://github.com/AlexandrovLab) has defined these groups of COSMIC signatures.
You can use them for your own analysis, but when running any of the tools they developed, it is very easy to filter out any of these groups in case you known that some of those exposures is not present in your samples.

See below a copy of their original table that can be found [here](https://github.com/AlexandrovLab/SigProfilerAssignment/blob/main/README.md#:~:text=Signature%20subgroup,ID%20signatures%20excluded).


|Signature subgroup |           SBS signatures excluded | DBS signatures excluded | ID signatures excluded |
| ----------- | ----------- | ----------- | ----------- |
|MMR_deficiency_signatures|     6, 14, 15, 20, 21, 26, 44|      7, 10|  7|
|POL_deficiency_signatures|     10a, 10b, 10c, 10d, 28|         3|      -|
|HR_deficiency_signatures|      3|                              13|      6|
|BER_deficiency_signatures|     30, 36|                         -|      -|
|Chemotherapy_signatures|       11, 25, 31, 35, 86, 87, 90, 99|     5|      -|
|Immunosuppressants_signatures| 32|                             -|      -|
|Treatment_signatures|          11, 25, 31, 32, 35, 86, 87, 90, 99| 5|      -|
|APOBEC_signatures|             2, 13|                          -|      -|
|Tobacco_signatures |           4, 29, 92|                      2|      3|
|UV_signatures|                 7a, 7b, 7c, 7d, 38|             1|      13|
|AA_signatures|                 22a, 22b|                             20|      23|
|Colibactin_signatures|         88|                             -|      18|
|Artifact_signatures|           27, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 95|14|-|
|Lymphoid_signatures|           9, 84, 85|                      -|      -|

  


## SIGNAL

- URL: [signal.mutationalsignatures.com](https://signal.mutationalsignatures.com/)
- Extracted from both tumors and experimental mutagenesis assays
- SBS, DBS and SV mutational processes
- Maintained by the University of Cambridge

### *Highlights*

- SIGNAL curates organ-specific signatures, consisting on typical profiles that can be realised as weighted combinations of mutational signatures at different organs.
  For example, [here](https://signal.mutationalsignatures.com/explore/referenceCancerSignature/60/organSpecificSignatures) is an example of which organ-specific profiles **Signature 1**
  contributes to depending on the tissue.
