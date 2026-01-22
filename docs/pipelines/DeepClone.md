# DeepClone pipelines

## Introduction

This page is to summarize the usage of the pipelines and tools used within the context of DeepClone.
The main steps are: duplex library preparation protocol, deepUMIcaller, the generation of duplex metrics and deepCSA.

The documentation and basic information regarding DeepClone can be found in the protocols paper that can be found here:
[protocols.io link](https://www.protocols.io/view/deepclone-an-end-to-end-protocol-to-study-somatic-dm6gp1jodgzp/v2)

You will find the basic list of steps in the website and also the main version of the manuscript and then you can check
for a more detailed explanation of all the steps in the supplementary document also available in protocols.io.

There are some internal definitions on how we use the pipelines but the access to this information is restricted and
should be requested internally to the PROMINENT team.

## Duplex protocol

The steps are described in the protocol, and there is an alternative and more useful version of it in the supplementary material.
We recommend users to use the supplementary material one.

## deepUMIcaller

We use the code available in [deepUMIcaller](https://github.com/bbglab/deepUMIcaller.git), we generally use the dev branch
since this contains the most updated version of the code and is generally stable.

We run it via Seqera platform so that we have full record of the runs and coordination of the different projects.

We always put the work directory in /scratch and the outputs can either go to the s3 or to nobackup or nobackup2.

## Metrics

## deepCSA

We use the code available in [deepCSA](https://github.com/bbglab/deepCSA.git), we generally use the dev branch
since this contains the most updated version of the code and is generally stable.

We run it via Seqera platform so that we have full record of the runs and coordination of the different projects.

Add the irbcluster profile when running the pipeline so that the default structural parameters are automatically set.

We always put the work directory in /scratch and the outputs usually in nobackup or nobackup2.

## References

Duplex library prep. protocol:

- Morena Pinheiro
- Erika López-Arribillaga
- Nuría Samper

Computational pipelines:

- Ferriol Calvet (main developer)
- Elisabet Figuerola (owns extensive internal documentation)
- Rocío Chamorro (in particular for metrics)
- Miguel Grau (developer)
