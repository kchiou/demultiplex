#!/usr/bin/perl

use strict;
use warnings;

require ("config.pl");

our $is_compressed;
our $num_indices;
our $num_barcodes;
our $prefix;
our $barcodes_file;
our $adapters_list;

for (my $i = 1; $i <= $num_indices; $i++) {

	print STDERR "Demultiplexing BC" . $i . "...\n";

	# Pre-demultiplexing - Unzip.

	# Read 1
	print STDERR "Decompressing reads\n";

	my $gunzip_cmd_r1 = "gunzip -c data/" . $prefix . "_BC" . $i . "_R1.fastq.gz ";
	$gunzip_cmd_r1 .= "> data/" . $prefix . "_BC" . $i . "_R1.fastq ";

	if ($is_compressed) {
		system($gunzip_cmd_r1);
	}

	# Read 2
	my $gunzip_cmd_r2 = "gunzip -c data/" . $prefix . "_BC" . $i . "_R2.fastq.gz ";
	$gunzip_cmd_r2 .= "> data/" . $prefix . "_BC" . $i . "_R2.fastq ";

	if ($is_compressed) {
		system($gunzip_cmd_r2);
	}

	# Demultiplexing

	print STDERR "Demultiplexing PE reads\n";

	my $split_cmd = "~/bin/sabre pe -c -m 1 ";
	$split_cmd .= "-f data/" . $prefix . "_BC" . $i . "_R1.fastq ";
	$split_cmd .= "-r data/" . $prefix . "_BC" . $i . "_R2.fastq ";
	$split_cmd .= "-b " . $barcodes_file . " ";
	$split_cmd .= "-u demultiplexed/current-unknown_R1.fastq ";
	$split_cmd .= "-w demultiplexed/current-unknown_R2.fastq";

	system($split_cmd);

	# Rename demultiplexed sequences from current-BC*_R*.fastq
	# to BC*-BC*_R*.fastq
	print STDERR "Renaming files\n";
	for (my $b = 1; $b <= $num_barcodes; $b++) {
		for (my $r = 1; $r <= 2; $r++) {
			my $mv_cmd = "mv demultiplexed/current-BC${b}_R${r}.fastq demultiplexed/BC${i}-BC${b}_R${r}.fastq";
			system($mv_cmd);
		}
	}

	# Also rename unknown barcodes
	system("mv demultiplexed/current-unknown_R1.fastq demultiplexed/" . $prefix . "_BC${i}-unknown_R1.fastq");
	system("mv demultiplexed/current-unknown_R2.fastq demultiplexed/" . $prefix . "_BC${i}-unknown_R2.fastq");

	print STDERR "Removing adapter sequences and moving files\n";
	# Remove adapter sequences with fastq-mcf
	for ($b = 1; $b <= $num_barcodes; $b++) {
		## Make sure ea-utils module is loaded -- ``module load ea_utils/intel/1.1.2``

		my $adapt_cmd = "fastq-mcf ";
		$adapt_cmd .= "-o demultiplexed/BC${i}-BC${b}_TRIM_R1.fastq ";
		$adapt_cmd .= "-o demultiplexed/BC${i}-BC${b}_TRIM_R2.fastq ";
		$adapt_cmd .= "-l 15 -q 15 -w 4 -u -P 33 " . $adapters_list . " ";
		$adapt_cmd .= "demultiplexed/BC${i}-BC${b}_R1.fastq ";
		$adapt_cmd .= "demultiplexed/BC${i}-BC${b}_R2.fastq";

		system($adapt_cmd);

		my $mv_cmd_r1 = "mv demultiplexed/BC${i}-BC${b}_TRIM_R1.fastq demultiplexed/BC${i}-BC${b}_R1.fastq";
		my $mv_cmd_r2 = "mv demultiplexed/BC${i}-BC${b}_TRIM_R2.fastq demultiplexed/BC${i}-BC${b}_R2.fastq";

		system($mv_cmd_r1);
		system($mv_cmd_r2);

		my $mv_cmd_r3 = "mv demultiplexed/BC${i}-BC${b}_R1.fastq demultiplexed/" . $prefix . "_BC${i}-BC${b}_R1.fastq";
		my $mv_cmd_r4 = "mv demultiplexed/BC${i}-BC${b}_R2.fastq demultiplexed/" . $prefix . "_BC${i}-BC${b}_R2.fastq";

		system($mv_cmd_r3);
		system($mv_cmd_r4);

	}

}

exit;