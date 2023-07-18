#! /usr/bin/perl
use strict;
use warnings;


my @file=`ls *.cram`;
my $genomeSize=10919522436;


open(O,'>',"00.GenomeCoverage.pl.out");
print O "#ID\tCoveredSites\tSumDepth\tGenomeCoverage\tEffectiveDepth\n";
foreach my $file(@file){
    chomp $file;
    my $id;
    if($file=~m/(\S+).cram/){
        $id=$1;
    }else{
        die "$file\n";
    }

    my $sites=0;
    my $depth=0;
    open(F,"/data/soft/samtools/bin/samtools depth -aa $file --reference /data2/tmp/Cugi_genome/whole_resequence/SplitBig.Cugi.all.chr.fasta |");
    while(<F>){
        chomp;
        next if(/^\s*$/);
        my @a=split("\t",$_);
	next if($a[2] );
        $sites++;
        $depth+=$a[2];
    }
    close(F);

    my $gc=$sites/$genomeSize;
    my $ed=$depth/$genomeSize;
    print O  "$id\t$sites\t$depth\t$gc\t$ed\n";




}

close(O);
