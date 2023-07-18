#!/usr/bin/perl -w
#created by MaYZ

use strict;
use warnings;


my($fileIn1,$fileIn2,$outgroups,$fileOutbase)=@ARGV;
die("usage: invcf.gz grouptxt outgroupnames outSFSbase\n")unless($fileOutbase);

my %groupToind;
open(F,'<',$fileIn2) or die("$!: $fileIn2\n");
while(<F>){
  chomp;
  next if(/^\s*$/);
  next if(/^\s*#/);
  my($method,$group,$ind)=split /\s+/;
  $groupToind{$group}{$ind}=1;
}
close(F);

my %groupToindno;
foreach my $group(keys %groupToind){
  my @ind=keys %{$groupToind{$group}};
  $groupToindno{$group}=@ind;
}


my %noToind;
my %indToGt;
my %hapNotositeNo;
open(F,"gzip -dc $fileIn1 |") or die("$!: $fileIn1\n");
while(<F>){
  chomp;
  if (/^\s*#CHROM/){
    s/#//;
    my ($CHROM,$POS,$ID,$REF,$ALT,$QUAL,$FILTER,$INFO,$FORMAT,@ind)=split /\t/;
    for (my $i=0;$i<@ind;$i++){
      $noToind{$i}=$ind[$i];
    }
  }
  next if(/^\s*$/);
  next if(/^\s*#/);
  my($CHROM,$POS,$ID,$REF,$ALT,$QUAL,$FILTER,$INFO,$FORMAT,@ind)=split /\t/;
  for (my $i=0;$i<@ind;$i++){
    my (@siteInfo)=split /:/,$ind[$i];
    my $indGt=shift (@siteInfo);
    $indToGt{$noToind{$i}}=$indGt;
  }
  my ($outgroup1,$outgroup2)=split(/,/,$outgroups);
  next if ($indToGt{$outgroup1} ne $indToGt{$outgroup2});
  my  $anceAllele=$indToGt{$outgroup1};
  next if ($anceAllele eq '0/1' or $anceAllele eq '1/0');
  foreach my $group (keys %groupToind){
    my $hapNo=0;
    foreach my $ind(keys %{$groupToind{$group}}){
      if ($indToGt{$ind} ne $anceAllele){
        if ($indToGt{$ind} eq '0/1' or $indToGt{$ind} eq '1/0'){
         $hapNo++;
         print "hapNo+=1 for $indToGt{$ind}\n";
        }else{
         $hapNo++;
         $hapNo++;
         print "hapNo+=2 for $indToGt{$ind}\n";
        }
      }else{
        next;
      }
    }
    $hapNotositeNo{$group}{$hapNo}++;
  }
}
close(F);


foreach my $group(keys %hapNotositeNo){
  my $fileOut="$fileOutbase.$group.SFS";
  open(Fo,'>',$fileOut) or die("$!: $fileOut\n");
  for (my $i=1;$i<$groupToindno{$group}*2;$i++){
    print Fo "$hapNotositeNo{$group}{$i} ";
  }
  print Fo "\n";
  close(Fo);
}


