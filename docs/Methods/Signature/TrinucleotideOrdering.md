# Trinucleotide context ordering

Code to generate a list of 96 trinucleotide contexts with a pyrimidine reference in the most widely used ordering.
This is the ordering in which trinucleotide contexts are typically displayed in the mutational profiles plots
representing the single-base substitution mutational signatures by COSMIC.

## Python code

```py
from itertools import product

subs = [''.join(z) for z in product('CT', 'ACGT') if z[0] != z[1]]  
flanks = [''.join(z) for z in product('ACGT', repeat=2)]  
contexts = sorted([(s, f) for s, f in product(subs, flanks)], key=lambda x: (x[0], x[1]))  
contexts_with_format = [f[0] + s[0] + f[1] + '>' + s[1] for s, f in contexts]

## Full list in Python format

full_list = [
    'ACA>A', 'ACC>A', 'ACG>A', 'ACT>A', 'CCA>A', 'CCC>A', 'CCG>A', 'CCT>A', 'GCA>A', 'GCC>A', 'GCG>A', 'GCT>A', 'TCA>A', 'TCC>A', 
    'TCG>A', 'TCT>A', 'ACA>G', 'ACC>G', 'ACG>G', 'ACT>G', 'CCA>G', 'CCC>G', 'CCG>G', 'CCT>G', 'GCA>G', 'GCC>G', 'GCG>G', 'GCT>G',
    'TCA>G', 'TCC>G', 'TCG>G', 'TCT>G', 'ACA>T', 'ACC>T', 'ACG>T', 'ACT>T', 'CCA>T', 'CCC>T', 'CCG>T', 'CCT>T', 'GCA>T', 'GCC>T',
    'GCG>T', 'GCT>T', 'TCA>T', 'TCC>T', 'TCG>T', 'TCT>T', 'ATA>A', 'ATC>A', 'ATG>A', 'ATT>A', 'CTA>A', 'CTC>A', 'CTG>A', 'CTT>A',
    'GTA>A', 'GTC>A', 'GTG>A', 'GTT>A', 'TTA>A', 'TTC>A', 'TTG>A', 'TTT>A', 'ATA>C', 'ATC>C', 'ATG>C', 'ATT>C', 'CTA>C', 'CTC>C',
    'CTG>C', 'CTT>C', 'GTA>C', 'GTC>C', 'GTG>C', 'GTT>C', 'TTA>C', 'TTC>C', 'TTG>C', 'TTT>C', 'ATA>G', 'ATC>G', 'ATG>G', 'ATT>G',
    'CTA>G', 'CTC>G', 'CTG>G', 'CTT>G', 'GTA>G', 'GTC>G', 'GTG>G', 'GTT>G', 'TTA>G', 'TTC>G', 'TTG>G', 'TTT>G']
```

## Reference

- Ferran Muiños
