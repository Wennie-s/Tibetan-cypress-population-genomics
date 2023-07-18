#!/usr/bin/perl
##usage est_sfs_input.dfe.pl [freq file of specific species][outgroup1][outgroup2][num]
#
use strict;
use File::Basename;

my $dirname=dirname($ARGV[0]);
my $in=basename($ARGV[0],".frq");
my $out=$in.".input.txt";
my $output=join "/", ($dirname,$out);
my $hap=$ARGV[3];
###  27 Pade.txt
#    17 Palb.txt
#    28 Pdav.txt
#    14 Pqio.txt
#    19 Prot.txt
#    36 Ptra.txt
#    21 Ptrs.txt
#

open IN, "<", $ARGV[0] or die "cannot open the species frq file: $!";
open OUT1, "<", $ARGV[1] or die "cannot open the outgroup1 frq file: $!";
open OUT2, "<", $ARGV[2] or die "cannot open the outgroup2 frq file: $!";
open OUTPUT, ">", $output or die "cannot produce the output file: $!";
#my $hap=$ARGV[3]
my %snps;

while(<IN>){
	chomp;
	if ($_ =~/^CHROM/){next;}
	my $a=0;
	my $t=0;
	my $c=0;
	my $g=0;

	my @line=split(/\t/,$_);
	my $snp_id=join":",($line[0],$line[1]);

	my @allele1=split(/:/,$line[4]);
        my $alle1=$allele1[0];
        my $alle1_c=$allele1[1];

        if ($alle1 =~ "A"){$a=sprintf("%.0f",$hap*$alle1_c);}
        if ($alle1 =~ "T"){$t=sprintf("%.0f",$hap*$alle1_c);}
        if ($alle1 =~ "C"){$c=sprintf("%.0f",$hap*$alle1_c);}
        if ($alle1 =~ "G"){$g=sprintf("%.0f",$hap*$alle1_c);}

        my @allele2=split(/:/,$line[5]);
        my $alle2=$allele2[0];
        my $alle2_c=$allele2[1];

        if ($alle2 =~ "A"){$a=sprintf("%.0f",$hap*$alle2_c);}
        if ($alle2 =~ "T"){$t=sprintf("%.0f",$hap*$alle2_c);}
        if ($alle2 =~ "C"){$c=sprintf("%.0f",$hap*$alle2_c);}
        if ($alle2 =~ "G"){$g=sprintf("%.0f",$hap*$alle2_c);}
	
	my $acgt=join",",($a,$c,$g,$t);

	$snps{$snp_id}=$acgt;

}

my @out1_a;
my @out1_t;
my @out1_c;
my @out1_g;

while(<OUT1>){
        chomp;
        if ($_ =~/^CHROM/){next;}
        my $a=0;
        my $t=0;
        my $c=0;
        my $g=0;
        my @line=split(/\t/,$_);

        my @allele1=split(/:/,$line[4]);
        my $alle1=$allele1[0];
        my $alle1_c=$allele1[1];

        if ($alle1 =~ "A"){$a=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "T"){$t=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "C"){$c=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "G"){$g=sprintf("%.0f",$alle1_c/1.1);}


        my @allele2=split(/:/,$line[5]);
        my $alle2=$allele2[0];
        my $alle2_c=$allele2[1];

        if ($alle2 =~ "A"){$a=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "T"){$t=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "C"){$c=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "G"){$g=sprintf("%.0f",$alle2_c/1.1);}

        push @out1_a, $a;
        push @out1_t, $t;
        push @out1_c, $c;
        push @out1_g, $g;

}

while(<OUT2>){
        chomp;
        if ($_ =~/^CHROM/){next;}
        my $a=0;
        my $t=0;
        my $c=0;
        my $g=0;
 
        my @line=split(/\t/,$_);
        my $snp_id=join":",($line[0],$line[1]);

        my @allele1=split(/:/,$line[4]);
        my $alle1=$allele1[0];
        my $alle1_c=$allele1[1];

        if ($alle1 =~ "A"){$a=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "T"){$t=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "C"){$c=sprintf("%.0f",$alle1_c/1.1);}
        if ($alle1 =~ "G"){$g=sprintf("%.0f",$alle1_c/1.1);}


        my @allele2=split(/:/,$line[5]);
        my $alle2=$allele2[0];
        my $alle2_c=$allele2[1];

        if ($alle2 =~ "A"){$a=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "T"){$t=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "C"){$c=sprintf("%.0f",$alle2_c/1.1);}
        if ($alle2 =~ "G"){$g=sprintf("%.0f",$alle2_c/1.1);}

	###make the output
	if (exists $snps{$snp_id}){
		my $out1_alleles=join",",(shift(@out1_a),shift(@out1_c),shift(@out1_g),shift(@out1_t));
		my $out2_alleles=join",",($a,$c,$g,$t);

		print OUTPUT "$snps{$snp_id}\t$out1_alleles $out2_alleles\n";
	}else{
	        my $out1_alleles=join",",(shift(@out1_a),shift(@out1_c),shift(@out1_g),shift(@out1_t));
                my $out2_alleles=join",",($a,$c,$g,$t);

		my $snps_a=0;
		my $snps_c=0;
		my $snps_g=0;
		my $snps_t=0;

	        if ($alle1 =~ "A"){$snps_a=$hap;}
	        if ($alle1 =~ "C"){$snps_c=$hap;}
        	if ($alle1 =~ "G"){$snps_g=$hap;}
        	if ($alle1 =~ "T"){$snps_t=$hap;}

		my $species_snp=join",",($snps_a,$snps_c,$snps_g,$snps_t);
		
		print OUTPUT "$species_snp\t$out1_alleles\t$out2_alleles\n";
		}
		
}


