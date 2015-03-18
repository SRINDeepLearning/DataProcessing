#!/usr/bin/perl

use strict;
use warnings;


open (doc, 'campaign_redeem-update.csv') or die "Can't open!";
open(my $out, '>user_redeem.txt');

my %user_redeem;

while(my $line = <doc>){
	chomp $line;
	my @entry = split(/\|/, $line);
	
	$user_redeem{$entry[8]}++;
}


foreach my $a (keys %user_redeem){
	print $out $a."|".$user_redeem{$a}."\n";
}

my @users = keys %user_redeem;
my $totalusers = @users;
print $out "Total Users: ".$totalusers."\n";

close doc;
