#! /usr/bin/perl -w    #统计每个bin中基因数量
use POSIX;
use strict;
use Bio::SeqIO;
use Bio::Seq;

my ($file1,$file2) = @ARGV;
open(INPUT1,"$file1");##基因组fasta
open(INPUT2,"$file2");##gff3
chomp (my @gff=<INPUT2>);
#open OUTPUT1,">LTR.fa"or die "Can't create OUTPUT1";
my $seqfile = Bio::SeqIO->new(-file=>$file1, -format=>'fasta');
while(my $seq_obj = $seqfile->next_seq) {
        my $id = $seq_obj->display_name;
        my $seq = $seq_obj->seq;
		my $chr_length=length($seq);
		my $bin_size=5000000;
		my $bin_num=POSIX::ceil($chr_length/$bin_size);
	for(my $i=0;$i<$bin_num;$i++){
	my $n=$i*$bin_size;
	my $m=$n+$bin_size-1;
	my $total_gene=0;
	my $len=0;
	foreach my $line(@gff){
	my @array=split/\t/,$line;
	my $gene_start=$array[3];
	my $gene_end=$array[4];


	# print "$array[0]\t$id\t$ltr_start\t$ltr_end\n";

	if (($array[0] eq $id)&&($gene_end<$m)&&($gene_start>$n)){
	$len=$gene_end-$gene_start+1;
	#print "$len\n";
	$total_gene+=$len;
	}

}
	
# print "total gene length$total_gene\n";
	my $gene_ratio=$total_gene/$bin_size;
 print "$id\t$n\t$m\t$gene_ratio\n";
	}

	}
	
close 	INPUT1;
close 	INPUT2;
#close 	OUTPUT1;		


