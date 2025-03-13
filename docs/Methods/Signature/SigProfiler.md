# SigProfiler

SigProfiler is a suite of tools for extracting mutational signatures developed mostly by people at the Ludmil Alexandrov's lab (see https://github.com/AlexandrovLab).


You can check for detailed information and documentation here:
https://osf.io/t6j7u/wiki/home/


I will proceed to discuss some details on specific recommended usage that is probably not documented but that can make a difference for the final results.

## Running SigProfilerExtractor

There are instructions on how to run it here: 
https://github.com/AlexandrovLab/SigProfilerExtractor


### Input
You can provide your VCFs or mutation matrices to SigProfilerExtractor.

Note that if you want to get a decomposition of the extracted signatures into known COSMIC signatures, you need to make sure that the regions you sequenced have a trinucleotide composition similar to that of the whole-genome or whole-exome, since this two are the options that the tool can assume for normalization of the counts for the posterior. Otherwise it makes no sense to use this automatic decomposition.

## How it works and what to take into account?

* When you run SigProfilerExtractor you get multiple different sets of extracted signatures based on the different range that you asked for.
* Then it automatically selects one of those sets based on its internal criteria.
* It then takes the signatures and the mutational profile of each of the provided samples and it assigns the extracted signatures to the samples.

**_WARNING:_ this assignment of the extracted signatures is of low quality and it should not be trusted**

Once you get the set of extracted signatures that you trust, you should use them through [SigProfilerAssignment](https://github.com/AlexandrovLab/SigProfilerAssignment) to get the proportion of mutations of each sample that correspond to each signature. Doing this in these two steps increases the accuracy of the result. To be more specific you should provide the extracted set of signatures as the [signature_database](https://github.com/AlexandrovLab/SigProfilerAssignment#:~:text=will%20be%20used.-,signature_database,-String) option of this second tool.



* Another output that the tool provies is to do a deconstruction of those extracted signatures into the known COSMIC signatures if you asked for that. But there is no magic trick here, or at least not that I know. (look at the comment for the input in case you are interested in getting this)


## Scripts that may be used if interested:

Full credit to @efigb for the script

```python
#!/usr/bin/env python3

"""
Run SigProfilerExtractor with the specified parameters.
"""

# Remember to use conda environment sigproext which has SigProfilerExtractor module installed

import click
from SigProfilerExtractor import sigpro as sig

@click.command()
@click.argument('input_type', default='matrix')  # When argument parameter is not needed to be specified in the command
@click.argument('output_dir')                     
@click.argument('input')                           
@click.option('--ref_genome', default='GRCh38', help='Reference genome to use') # When option parameter has to be specified in the command
@click.option('--max_sig', default=10, help='Maximum number of signatures')
@click.option('--nmf_replicates', default=100, help='Number of NMF replicates')
@click.option('--cpu', default=-1, help='Number of processors to be used to extract the signatures. Default value will use all available processors, which may cause a memory error.')

# Run SigProfilerExtractor
def main(input_type, output_dir, input, ref_genome, max_sig, nmf_replicates, cpu):
    
    sig.sigProfilerExtractor(
        input_type=input_type,
        output=output_dir,
        input_data=input, 
        reference_genome=ref_genome,
        minimum_signatures=1,
        maximum_signatures=max_sig,
        nmf_replicates=nmf_replicates,
	    cpu=cpu
    )

if __name__ == "__main__":
    main()

### EXAMPLE OF COMMAND: python3 sigprofiler_extractor2.py matrix ./output_dir count_matrix_wgs_20240821.txt --ref_genome GRCh38 --max_sig 10 --nmf_replicates 100 --cpu 10
```


## Reference
Sources:
- Informal discussions with people that knows.
- Rocio Chamorro (did some tests and confirmed this)
- Elisabet Figuerola (provided the script)


Contributors:
- Ferriol Calvet