#!/usr/bin/perl
#usage est_sfs_ancestral_derived.pl [freq file of specific species][est_sfs.output.p_anc.txt]

###input
#1. frq: REF & ALT
#2. p_anc: the probability of major allele being ancestral

#to do:
#1. determine whether the major allele is REF or ALT
#2. however, if the REF=ALT=0.5,assume the former is major,then we need to compare the order of A,C,G,T and which is >0, and which equal the REF
#3. determine whether the major allele is ancestral or derived
#4. determine the derived is REF or ALT



use strict;
use File::Basename;

my $dirname=dirname($ARGV[0]);
my $in=basename($ARGV[0],".frq");
my $out=$in.".ances_derive.txt";
my $output=join "/", ($dirname,$out);

###  27 Pade.txt
#    17 Palb.txt
#    28 Pdav.txt
#    14 Pqio.txt
#    19 Prot.txt
#    36 Ptra.txt
#    21 Ptrs.txt
#

open FRQ, "<", $ARGV[0] or die "cannot open the species frq file: $!";
open P, "<", $ARGV[1] or die "cannot open the p_anc file: $!";
open OUTPUT, ">", $output or die "cannot produce the output file: $!";

my @major_p;  ##the probability of the major allele to be the ancestral allele

while(<P>){
	chomp;
	if ($_ =~/^0/){next;}
	my @line=split(/ /,$_);
	my $major_pr=$line[2];
	push @major_p, $major_pr;
}

my %base_order;
$base_order{A}=1;
$base_order{C}=2;
$base_order{G}=3;
$base_order{T}=4;


while(<FRQ>){

	my $major;  ##define the major allele
	my $derived;
	
	chomp;
	if ($_ =~/^CHROM/){print OUTPUT "CHROM\tPOS\tDerived\n";next;}
	
	my @line=split(/\t/,$_);

	my @ref=split(/:/,$line[4]);
	my $ref_allele=$ref[0];
	my $ref_frq=$ref[1];

	my @alt=split(/:/,$line[5]);
	my $alt_allele=$alt[0];
	my $alt_frq=$alt[1];
	
	my $p=shift(@major_p);

	if($ref_frq>$alt_frq) {
		$major=$ref_allele;
		if ($p>0.5){
		$derived="ALT";}
		else{
		$derived="REF";}
	}
	if($ref_frq<$alt_frq){
		$major=$alt_allele;
		if ($p>0.5){
		$derived="REF";}
		else{
		$derived="ALT";}
	}
	if($ref_frq==$alt_frq){
		if($base_order{$ref_allele}<$base_order{$alt_allele}){
			$major=$ref_allele;
			if ($p>0.5){
			$derived="ALT";}
			else{$derived="REF";}
			
		}
		else{ 
			$major=$alt_allele;
			if ($p>0.5){
			$derived="REF";}
			else{$derived="ALT";}
		}
	}
	
	print OUTPUT "$line[0]\t$line[1]\t$derived\n";

	
}









