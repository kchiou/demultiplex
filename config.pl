#!/usr/bin/perl

# Are the files compressed (with extension fastq.gz)?
our $is_compressed = 1;

# Number of unique indexed primers used
our $num_indices = 1;

# Number of unique barcoded adapters used
our $num_barcodes = 12;

our $barcodes_file = "ddRADseq_adapter_P1-flex_barcodes_sabre.txt";
our $adapters_list = "adapters_list.fa";

##########################################################################################
#       Filename must be in the format {prefix}_BC{index}_R{read number}.fastq(.gz)      #
##########################################################################################

# Prefix of fastq or fastq.gz filenames
our $prefix = "FecalSeq_L2";

1;