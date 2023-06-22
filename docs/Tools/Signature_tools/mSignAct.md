# mSigAct

## Description

mSigAct is a signature fitting tool (R) to evaluate the improvement of the fitting in a given sample when adding an additional signature (test signature).\
It was developed by Steve Rozen lab (https://github.com/steverozen/mSigAct).

## Getting started

Load the main library:

```
library(pbmcapply)
```
Load mSigTools and mSigAct:
```
setwd("/path/to/mSigAct")
source("/path/to/mSigAct/mSigAct.v0.10.R")
source("/path/to/mSigAct/mSigTools.v0.13.R")
```

### Input

You need to prepare several input files:
- signature_file: A matrix table with the probabilities of the signatures (from COSMIC) that you want to test. The last column is the test signature. (96 channels)
- mutation_file: A matrix table with the counts from the samples that you want to analize (96 channels)

Format for the signature_file:
```
index	SBS1	SBS5	SBS18	SBS40	SBS31
ACAA	0.0008861572308774719	0.01199760047990402	0.05153385774453816	0.02820375109889615	0.0095349845981014
ACCA	0.002280404612190334	0.009438112377524496	0.015810387424537924	0.013401782437064129	0.018490274115815084
ACGA	0.000177031410683197	0.001849630073985203	0.002431597559596655	0.0029203884116587504	0.001659127299040705
ACTA	0.0012802271507033455	0.006608678264347131	0.02141406904336149	0.014801968661832024	0.006276698456611824
CCAA	0.00031205536798394046	0.007428514297140572	0.07404864996302571	0.020802766767980138	0.010694374758876832
CCCA	0.0017903176560617096	0.006138772245550889	0.019612885665882485	0.014701955360062887	0.011593901607754323

```

Format for the mutation_file: 
```
index	sample_0	sample_1	sample_2	sample_3
ACAA	1	0	1	1
ACCA	0	1	1	1
ACGA	0	0	0	0
ACTA	0	1	0	1
CCAA	3	1	1	0
CCCA	0	1	1	0
```

Important!! The order of the rows should be this one:

```
['ACAA', 'ACCA', 'ACGA', 'ACTA', 'CCAA', 'CCCA', 'CCGA', 'CCTA', 'GCAA', 'GCCA', 'GCGA', 'GCTA', 'TCAA', 'TCCA', 'TCGA', 'TCTA', 'ACAG', 'ACCG', 'ACGG', 'ACTG', 'CCAG', 'CCCG', 'CCGG', 'CCTG', 'GCAG', 'GCCG', 'GCGG', 'GCTG', 'TCAG', 'TCCG', 'TCGG', 'TCTG', 'ACAT', 'ACCT', 'ACGT', 'ACTT', 'CCAT', 'CCCT', 'CCGT', 'CCTT', 'GCAT', 'GCCT', 'GCGT', 'GCTT', 'TCAT', 'TCCT', 'TCGT', 'TCTT', 'ATAA', 'ATCA', 'ATGA', 'ATTA', 'CTAA', 'CTCA', 'CTGA', 'CTTA', 'GTAA', 'GTCA', 'GTGA', 'GTTA', 'TTAA', 'TTCA', 'TTGA', 'TTTA', 'ATAC', 'ATCC', 'ATGC', 'ATTC', 'CTAC', 'CTCC', 'CTGC', 'CTTC', 'GTAC', 'GTCC', 'GTGC', 'GTTC', 'TTAC', 'TTCC', 'TTGC', 'TTTC', 'ATAG', 'ATCG', 'ATGG', 'ATTG', 'CTAG', 'CTCG', 'CTGG', 'CTTG', 'GTAG', 'GTCG', 'GTGG', 'GTTG', 'TTAG', 'TTCG', 'TTGG', 'TTTG']
```

Import the matrices:
```
sigs <- as.matrix(read.table(signature_file, sep = '\t', header = T, row.names = 1))
muts <- as.matrix(read.table(mutation_file, sep = '\t', header = T, row.names = 1))
```

Prepare some variables:
```
outpath <- '/path/to/output/folder/'
cores <- 'cores_to_use'

name_file <- basename(mutation_file)

outpath_name <- paste(outpath, name_file, sep ='/')
dir.create(outpath_name, showWarnings = FALSE)

names_sigs <- colnames(sigs)
print(colnames(sigs))
target_signature <- names_sigs[length(names_sigs)]

```

Run the function:
```

mSigAct <- process.one.group(muts, sigs,
                             target.sig.name = target_signature,
                             path.root = outpath_name,
                             obj.fun = obj.fun.nbinom.maxlh,
                             nbinom.size=10, ## = dispersion parameter
                             mc.cores=cores) ## = number of cores to use

```

### Output

Extract p-values and exposures and calculate a bonferroni adjusted p-pvalue.\
Build the output table.\
Save the output.

```
pval<-mSigAct$pval

apval<-p.adjust(pval,"bonferroni")
exposure<-mSigAct$exposure
df<-t(rbind(pval,apval,exposure))
df<-df[order(df[,1],decreasing = F),]

name_outfile <- paste("results", name_file, "mSigAct", target_signature, "tsv", sep ='.')
write.table(df, file = paste(outpath, name_outfile, sep ="/"), sep ='\t')

name_outfile <- paste("results", name_file, "mSigAct", target_signature, "rds", sep ='.')
saveRDS(mSigAct, file = paste(outpath, name_outfile, sep ="\t"))

```
## Reference

Alvin W. T. Ng et al. ,Aristolochic acids and their derivatives are widely implicated in liver cancers in Taiwan and throughout Asia.Sci. Transl. Med.9,eaan6446(2017).DOI:10.1126/scitranslmed.aan6446

BBglab membes to ask to:
- Monica
- Ferran
