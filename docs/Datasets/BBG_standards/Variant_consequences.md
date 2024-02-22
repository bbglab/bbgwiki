# Variant consequences

**DISCLAIMER**:  the decisions reflected in the instructions below might not be the best solution for all use cases, but are done with the best of my knowledge and with the best intention to make something useful and applicable across projects in the lab.


## Problem

The problem is here, when having multiple annotations for a given variant, how to summarize that.

```sh
chr10:103590136_A>T     chr10:103590136 T       ENSG00000107954 ENST00000369780 Transcript      missense_variant,splice_region_variant  2172    1489    497
chr10:113850156_C>G     chr10:113850156 G       ENSG00000288933 ENST00000692647 Transcript      intron_variant,non_coding_transcript_variant    -       -
chr10:132808904_T>C     chr10:132808904 C       ENSG00000171811 ENST00000368586 Transcript      splice_region_variant,synonymous_variant        7751    7665
```

We could also define a way of grouping consequences into: Nonsense, Missense, Splice affecting, Synonymous.
Since some times we might not be interested in having very detailed consequence types but more broader categories.

## Description

This document contains information on how to handle this situation to get a single consequence per variant if this is the goal of the users in some project.

The first section covers how to rank the variants according to the deleteriousness, and the second section covers how to group variants into broader consequence types.

So far we have been using the following ranking of Sequence Ontology terms associated with consequence types of variants: <https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html>
For the grouping of variants we have been using ad-hoc collections on a case by case basis -- see e.g. boostDM. I agree that it would be good to establish once and for all a consensus grouping of SO consequence types for general variant analyses.

## Reducing to a single consequence per variant

### Step 1: Choose one consequence per transcript
In some cases you might get more than one consequence type, for the same variant in the same transcript.

In these cases you want to preserve only the most deleterious one, but you might want to be careful with variants in non-coding transcripts.

By applying `most_deleterious_within_variant()` function to the string of variant consequence you will get a single consequence per transcript.

See the order of the consequences in the `CONSEQUENCES_LIST_WITHIN` list to understand which is the priority of consequence types when grouping.


```py
CONSEQUENCES_LIST_WITHIN = [
    'NMD_transcript_variant',
    'non_coding_transcript_exon_variant',
    'non_coding_transcript_variant',
    'mature_miRNA_variant',

    'transcript_ablation',
    'splice_acceptor_variant',
    'splice_donor_variant',
    'stop_gained',
    'frameshift_variant',
    'stop_lost',
    'start_lost',
    'transcript_amplification',
    'inframe_insertion',
    'inframe_deletion',
    'missense_variant',
    'protein_altering_variant',
    'splice_region_variant',
    'splice_donor_5th_base_variant',
    'splice_donor_region_variant',
    'splice_polypyrimidine_tract_variant',
    'incomplete_terminal_codon_variant',
    'start_retained_variant',
    'stop_retained_variant',
    'synonymous_variant',
    'coding_sequence_variant',
    '5_prime_UTR_variant',
    '3_prime_UTR_variant',
    'intron_variant',
    'upstream_gene_variant',
    'downstream_gene_variant',
    'TFBS_ablation',
    'TFBS_amplification',
    'TF_binding_site_variant',
    'regulatory_region_ablation',
    'regulatory_region_amplification',
    'feature_elongation',
    'regulatory_region_variant',
    'feature_truncation',
    'intergenic_variant',
    '-'
]

consequence_rank_dict_within = {consequence : rank for rank, consequence in enumerate(CONSEQUENCES_LIST_WITHIN)}
rank_consequence_dict_within = {rank : consequence for rank, consequence in enumerate(CONSEQUENCES_LIST_WITHIN)}


def most_deleterious_within_variant(impact_vep_string):
    """
    to be used when summarizing the different consquences assigned to a same variable in the same transcript
    here we change for example the relevance of NMD_transcript_variant, since we do not want it to make it very damaging
    """
    # TODO: revise if we need to have a try and except or it is better to make sure that the consequence
    # dictionary and ranks correspond to the correct ensembl version?
    try :
        all_consequences = impact_vep_string.split(",")
        all_consequences_ranks = map(lambda x: consequence_rank_dict_within[x], all_consequences)
        return rank_consequence_dict_within[min(all_consequences_ranks)]
    except:
        return '-'
```





### Step 2: From a single consequence per variant per transcript, to a single consequence per variant.

Consequence list taken from: [https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html](https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html)

List of consequences updated on the 2023-06-22. Ensembl 109

```py
CONSEQUENCES_LIST = [
    'transcript_ablation',
    'splice_acceptor_variant',
    'splice_donor_variant',
    'stop_gained',
    'frameshift_variant',
    'stop_lost',
    'start_lost',
    'transcript_amplification',
    'inframe_insertion',
    'inframe_deletion',
    'missense_variant',
    'protein_altering_variant',
    'splice_region_variant',
    'splice_donor_5th_base_variant',
    'splice_donor_region_variant',
    'splice_polypyrimidine_tract_variant',
    'incomplete_terminal_codon_variant',
    'start_retained_variant',
    'stop_retained_variant',
    'synonymous_variant',
    'coding_sequence_variant',
    'mature_miRNA_variant',
    '5_prime_UTR_variant',
    '3_prime_UTR_variant',
    'non_coding_transcript_exon_variant',
    'intron_variant',
    'NMD_transcript_variant',
    'non_coding_transcript_variant',
    'upstream_gene_variant',
    'downstream_gene_variant',
    'TFBS_ablation',
    'TFBS_amplification',
    'TF_binding_site_variant',
    'regulatory_region_ablation',
    'regulatory_region_amplification',
    'feature_elongation',
    'regulatory_region_variant',
    'feature_truncation',
    'intergenic_variant'
]

consequence_rank_dict = { consequence : rank for rank, consequence in enumerate(CONSEQUENCES_LIST) }
rank_consequence_dict = { rank : consequence for rank, consequence in enumerate(CONSEQUENCES_LIST) }
consequence_rank_dict


list_of_annotations # this is the column of annotation
list_of_single_annotations = []
for x in list_of_annotations:
    all_consequences = x.split(",")
    all_consequences_ranks = map(lambda x: consequence_rank_dict[x], all_consequences)
    list_of_single_annotations.append(rank_consequence_dict[min(all_consequences_ranks)])

```

`list_of_single_annotations` will be a list with a single annotation per row that can be added as a new column in the dataframe that you will have.

## Broader categories of variants

Going from the previous list into a more broader terms.

```py
GROUPING_DICT = {
    'transcript_ablation': 'nonsense',
    'splice_acceptor_variant': 'nonsense',
    'splice_donor_variant': 'nonsense',
    'stop_gained': 'nonsense',
    'frameshift_variant': 'nonsense',
    'stop_lost': 'nonsense',
    'start_lost': 'nonsense',

    'missense_variant': 'missense',
    'inframe_insertion': 'missense',
    'inframe_deletion': 'missense',

    'splice_donor_variant': 'essential_splice',
    'splice_acceptor_variant': 'essential_splice',
    'splice_donor_5th_base_variant': 'essential_splice',


    'splice_region_variant': 'splice_region_variant',
    'splice_donor_region_variant': 'splice_donor_region_variant',
    'splice_polypyrimidine_tract_variant': 'splice_polypyrimidine_tract_variant',

    'synonymous_variant': 'synonymous',
    'incomplete_terminal_codon_variant': 'synonymous',
    'start_retained_variant': 'synonymous',
    'stop_retained_variant': 'synonymous',

    'protein_altering_variant' : 'protein_altering_variant', ##
    'transcript_amplification' : 'transcript_amplification', ##
    'coding_sequence_variant': 'coding_sequence_variant', ##


    '5_prime_UTR_variant': 'non_coding_exon_region',
    '3_prime_UTR_variant': 'non_coding_exon_region',
    'non_coding_transcript_exon_variant': 'non_coding_exon_region',

    'NMD_transcript_variant': 'non_coding_exon_region',

    'intron_variant': 'intron_variant',

    'non_coding_transcript_variant' : 'non_coding_transcript_variant',
    'mature_miRNA_variant': 'non_coding_transcript_variant', # TODO fix this

    'upstream_gene_variant': 'non_genic_variant',
    'downstream_gene_variant': 'non_genic_variant',
    'TFBS_ablation': 'non_genic_variant',
    'TFBS_amplification': 'non_genic_variant',
    'TF_binding_site_variant': 'non_genic_variant',
    'regulatory_region_ablation': 'non_genic_variant',
    'regulatory_region_amplification': 'non_genic_variant',
    'feature_elongation': 'non_genic_variant',
    'regulatory_region_variant': 'non_genic_variant',
    'feature_truncation': 'non_genic_variant',
    'intergenic_variant': 'non_genic_variant',
    '-'  : '-'

}


PROTEIN_AFFECTING_DICT = {

    'nonsense' : 'protein_affecting',
    'missense' : 'protein_affecting',
    'essential_splice' : 'protein_affecting',
    'splice_region' : 'ambiguous',
    'synonymous' : 'non_protein_affecting',

    'protein_altering_variant' : 'protein_affecting',
    'transcript_amplification' : 'protein_affecting',
    'coding_sequence_variant' : 'ambiguous',

    'splice_region_variant': 'ambiguous',
    'splice_donor_region_variant': 'ambiguous',
    'splice_polypyrimidine_tract_variant': 'ambiguous',

    'non_coding_exon_region' : 'non_protein_affecting',
    'intron_variant' : 'non_protein_affecting',
    'non_coding_transcript_variant' : 'non_protein_affecting',
    'non_genic_variant' : 'non_protein_affecting',
    '-'  : '-',
}


consequence_rank_dict = { consequence : rank for rank, consequence in enumerate(CONSEQUENCES_LIST) }
rank_consequence_dict = { rank : consequence for rank, consequence in enumerate(CONSEQUENCES_LIST) }
consequence_rank_dict


list_of_annotations # this is the column of annotation
list_of_single_annotations = []
list_of_broad_annotations = []
list_of_protein_affecting_annotations = []
for x in list_of_annotations:
    all_consequences = x.split(",")
    all_consequences_ranks = map(lambda x: consequence_rank_dict[x], all_consequences)
    single_consequence = rank_consequence_dict[min(all_consequences_ranks)]
    list_of_single_annotations.append(single_consequence)
    list_of_broad_annotations.append(GROUPING_DICT[single_consequence])
    list_of_protein_affecting_annotations.append(PROTEIN_AFFECTING_DICT[single_consequence])

```

`list_of_single_annotations` will be a list with a single annotation per row that can be added as a new column in the dataframe that you will have.
`list_of_broad_annotations` will be a list with a single broad annotation per row that can be added as a new column in the dataframe that you will have.

## Reference

For the list of variant consequences:
<http://www.ensembl.org/info/genome/variation/prediction/predicted_data.html>

For the dictionary, we should agree on the definitions, but this was done by me on the 2023-06-22.

- Ferriol Calvet
