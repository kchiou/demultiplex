#!/bin/bash
#SBATCH --job-name="DeMultiplex"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=30:00:00
#SBATCH --mem=4GB

# module load ea-utils/intel/1.1.2

./demultiplex.pl

# Example code below for running various "sets" of data in serial with automated customizations by editing config.pl in between each run.
# sed -i 's/is_compressed = 0/is_compressed = 1/g' config.pl
# sed -i 's/PREFIX/FecalSeq1/g' config.pl
# sed -i 's/num_indices = 1/num_indices = 4/g' config.pl
# ./demultiplex.pl
# sed -i 's/FecalSeq1/FecalSeq2/g' config.pl
# sed -i 's/num_indices = 4/num_indices = 1/g' config.pl
# ./demultiplex.pl
# sed -i 's/FecalSeq2/FecalSeq3a/g' config.pl
# ./demultiplex.pl
# sed -i 's/FecalSeq3a/FecalSeq3b/g' config.pl
# ./demultiplex.pl
# sed -i 's/FecalSeq3b/Kafue1/g' config.pl
# sed -i 's/num_indices = 1/num_indices = 8/g' config.pl
# ./demultiplex.pl
# sed -i 's/Kafue1/Kafue2a/g' config.pl
# sed -i 's/num_indices = 8/num_indices = 4/g' config.pl
# ./demultiplex.pl
# sed -i 's/Kafue2a/Kafue2b/g' config.pl
# ./demultiplex.pl
# sed -i 's/Kafue2b/Kafue2c/g' config.pl
# ./demultiplex.pl

exit
