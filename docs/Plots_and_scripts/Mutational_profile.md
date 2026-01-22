# Mutational profile

The function `plot_signature`  will allow you to plot the mutational profile of a sample given the vector of 96 channels
(see y axis in the example figure) with the frequencies of each nucleotide change.
It takes as input the the vector with the mutations frequency  (`profile`) and the title of the plot (`title`).

The function `minor_tick_labels`  is needed to generate the labels of the plot.

## Example

![Plot mutational profile](../assets/images/plot_mutational_profile.png)

## Function

``` py
import seaborn as sns
import numpy as np

def minor_tick_labels():
    major_labels = ['C>A', 'C>G', 'C>T', 'T>A', 'T>C', 'T>G']
    flanks = ['AA', 'AC', 'AG', 'AT', 'CA', 'CC', 'CG', 'CT',
              'GA', 'GC', 'GG', 'GT', 'TA', 'TC', 'TG', 'TT']
    minor_labels = []
    for subs in major_labels:
        for flank in flanks:
            minor_labels.append(flank[0] + subs[0] + flank[1])
    return minor_labels
    
def plot_signature(profile, title=None):
    """
    Args:
        profile: 96-array in lexicographic order
        title: string

    Returns:
        produces the signature bar plot
    """

    fig, ax = plt.subplots(figsize=(15, 2))
    total = np.sum(profile)
    if abs(total - 1) > 0.01:
        profile = profile / total
    sns.set(font_scale=1.5)
    sns.set_style('white')

    # bar plot
    barlist = ax.bar(range(96), profile)
    color_list = ['#72bcd4', 'k', 'r', '#7e7e7e', 'g', '#e6add8']
    for category in range(6):
        for i in range(16):
            barlist[category * 16 + i].set_color(color_list[category])
    ax.set_xlim([-0.5, 96])
    ymax = np.max(profile) * 1.2
    ax.set_ylim(0, ymax)

    # ax.set_ylabel('subs rel freq')
    labels = ['C>A', 'C>G', 'C>T', 'T>A', 'T>C', 'T>G']
    major_ticks = np.arange(8, 8 + 16 * 5 + 1, 16)
    minor_ticks = np.arange(0.2, 96.2, 1)
    ax.tick_params(length=0, which='major', pad=30, labelsize=12)
    ax.tick_params(length=0, which='minor', pad=5, labelsize=10)
    ax.set_xticks(major_ticks, minor=False)
    ax.set_xticklabels(labels, minor=False)
    ax.set_xticks(minor_ticks, minor=True)
    ax.set_xticklabels(minor_tick_labels(), minor=True, rotation=90)
    
    ax.spines['top'].set_visible(False)
    ax.spines['bottom'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.spines['right'].set_visible(False)
    
    ax.set_title(title, fontsize=24)
    plt.show()
```

!!! note
    - The function normalizes the vector so that the sum of all the frequencies is equal to 1.
    - If you want to normalize the frequencies so that the trinucleotide composition of the genomic regions from which
    - the mutations have been obtained, you need to normalize the vector taking into account the trinucleotide
    - composition before using the function plot_signature.

## Normalization of the vector

In order to normalize the vector you will need to import from
[bgreference](https://bbglab.github.io/bbgwiki/Tools/BBG-tools/BGreference/){:target="_blank"} the reference genome in
which the data has been sequenced.

You will also need the vector with the mutations frequency (`profile`) and the directory of a file with the genomic
regions from which the mutations have been obtained (`regions_file_dir`),
with at least the columns: `CHROMOSOME`, `START`, `END`.

### Needed functions

```py
from itertools import product
import pandas as pd
import numpy as np

cb = dict(zip('ACGT','TGCA'))

def triplet_index(triplet):

    a, ref, b = tuple(list(triplet))
    s = 16 * (ref == 'T')
    t = 4 * ((a == 'C') + 2 * (a == 'G') + 3 * (a == 'T'))
    u = (b == 'C') + 2 * (b == 'G') + 3 * (b == 'T')
    return s + t + u


def sbs_format(triplet_count):
    """Maps ref triplets to 96 SBS channel"""

    vector = []
    for ref in 'CT':
        for alt in 'ACGT':
            if alt != ref:
                for a, b in product(cb, repeat=2):
                    vector.append(triplet_count[triplet_index(a + ref + b)])
    return vector
    
    
def triplets():

    for ref in 'CT':
        for a, b in product(cb, repeat=2):
            yield a + ref + b


def count_triplets(seq):

    return [seq.count(t) + seq.count(rev(t)) for t in triplets()]
    
def rev(seq):
    """reverse complement of seq"""

    return ''.join(list(map(lambda s: cb[s], seq[::-1]))) 

def get_triplet_counts_region(regions_file_dir,reference_genome=hg38):
    """
    Function to obtain the vector with 96 triplet counts given the regions file.
    """
    regions=pd.read_csv(regions_file_dir,sep='\t',dtype={'CHROMOSOME':'string'})
    assert(np.all(regions.apply(lambda r: r['END'] - r['START'] + 1 > 0, axis=1)))
    regions['interval'] = regions.apply(lambda r: (r['CHROMOSOME'], r['START'], r['END']), axis=1)
        
    counts = np.zeros(32)
    for chrom, start, end in list(regions['interval']):
        try:
            seq = reference_genome(chrom, start-1, size=end-start+3)  # sequence +1 nt 5' and 3' flanking nucleotides
            c = np.array(count_triplets(seq))
            counts += c
        except Exception as e:
            print(e)
    return sbs_format(list(map(int, counts)))
```

### Normalization

```python
region_triplet_abundance=get_triplet_counts_region(regions_file_dir)
normalized_profile = np.array(profile)/np.array(region_triplet_abundance)
```

## Reference

- Paula Gomis
- Ferran Muiños
