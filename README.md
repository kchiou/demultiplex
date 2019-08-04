# demultiplex

This repository contains code for demultiplexing [double-digest RADseq](https://doi.org/10.1371/journal.pone.0037135) data. The code was written by [Christina Bergey](http://christinabergey.com).

## Table of Contents

* [Before beginning](#before-beginning)

* [Running the pipeline](#running-the-pipeline)

## Before beginning

* Move all fastq files to the `data/` folder. Files may be compressed (with extension `.fastq.gz`) or not.

* Rename all fastq files so that they follow the following format: `{prefix}_BC{index}_R{read number}.fastq(.gz)`.

* Edit the file `config.pl`.

	* On line 4, set `$is_compressed = 1` if fastq files are compressed (with extension `.fastq.gz`).
	
	* On line 7, edit `$num_indices` to the number of unique PCR indices used (i.e., the integer(s) following "BC" in the fastq filenames).
	
	* On line 10, edit `$num_barcodes` to the number of barcoded adapter sequences used.
	
	* On line 20, edit `$prefix` to match the first portion of the fastq filenames.

* Ensure that `ea-utils` is installed and that the directory containing `fastq-mcf` is added to the `$PATH`. This can be done by adding a `module load [module]` line to the `pbs/Demultiplex.pbs` or `slurm/Demultiplex.sh` files directly after the headers (i.e., after the lines starting with `#PBS` or `#SBATCH`).

## Running the pipeline

To run the pipeline, simply submit a job to the job scheduler using either the `pbs/Demultiplex.pbs` or `slurm/Demultiplex.sh` files. Examples below:

### PBS

```
qsub pbs/Demultiplex.pbs
```

### Slurm

```
sbatch slurm/Demultiplex.sh
```