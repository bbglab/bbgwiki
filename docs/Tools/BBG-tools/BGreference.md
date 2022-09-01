# BgReference

## Description
BgReference is a library to fast retrive Genome Reference partial sequences.

## Instalation 
```bash
conda install -c conda-forge -c bbglab bgreference
```
or
```bash
pip install bgreference
```

## Examples

```bash
from bgreference import hg19, hg38
# Get 10 bases from chromosome one build hg19
hg19('1', 12345, size=10)

# Get the sequence of the whole chromosome
hg19('1',(1), size=None)

# You can use synonymous sequence names
hg19(2, 23456)
hg19('2', 23456)
hg19('chr2', 23456)

hg19('MT', 234, size=3)
hg19('chrM', 234, size=3)
hg19('chrMT', 234, size=3)
```
## Repository
Click here to see the [repository of BgReference](https://bitbucket.org/bgframework/bgreference/src/master/){:target="_blank"}.

## Reference
- Jordi Deu-Pons
- Miguel Grau
- Carlos López Elorduy
- Paula Gomis 
