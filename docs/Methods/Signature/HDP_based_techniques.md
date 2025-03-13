# HDP-based signature extraction

There are different tools to extract signatures using the Hierarchical Dirichlet process principles:

## mSigHDP
(https://github.com/steverozen/mSigHdp)

In general we should not be using mSigHDP, from discussions we have had internally and with some other users in other labs the easiest to use Hierarchical Dirichlet process (HDP)-based method for extracting signatures is the original HDP.

Probably this one is more efficient than the original implementation but the parameters need to be adjusted, and we as basic users probably do not have the expertise to do so in an informed enough way, so initially I would suggest to keep it simple and go to the original method, see below.


## HDP
This is the original HDP implementation for signature extraction. (see here: https://github.com/nicolaroberts/hdp)


The easiest way to run it is through the HDP wrapper written by McGranahanLab available here: 
https://github.com/McGranahanLab/HDP_sigExtraction/tree/main

There is an explanation on how to generate the inputs for this wrapper, but you still have to install the original HDP as a dependency.


### Installing HDP

This tool was developed in an early R version and some default compiling mechanisms have changed since then. 

You will find installation instructions in the original repo but some problems might appear while following them.


These are some instructions that can help troubleshoot the process of installing HDP:

When installing it in newer R versions you would find an issue with the installation that can be solved by:

To ensure that the compiler uses the `-fcommon` flag when building your shared object (.so file), you need to modify the compilation process in a way that this flag is passed to the C compiler. Since the file you provided is ${R_HOME}/share/make/shlib.mk, and it controls the linking of shared libraries, the best approach is to add the -fcommon flag to the compilation or linking stage.

Here are the steps you should follow:

1. Modify the Makeconf file (preferred)
The `shlib.mk` file includes `${R_HOME}/etc${R_ARCH}/Makeconf`, which typically contains the compilation and linking flags for R packages. You can modify the Makeconf file to add the `-fcommon` flag to the `CFLAGS` or `LDFLAGS` (for linking).
Locate the Makeconf file. This is typically found in:
Linux/MacOS: `$(R_HOME)/etc/Makeconf`
Windows: May vary depending on your setup.

Edit the `Makeconf` file and add `-fcommon` to the `CFLAGS` variable, which controls the flags for the C compiler. For example:

`CFLAGS = -g -O2 -fcommon`
Or, if you want to pass it during the linking stage (though usually CFLAGS is enough):

`LDFLAGS = -fcommon`


## Reference

Source:
- Result after some hours of web searching + chatGPT probably

Contributor:
- Ferriol Calvet
