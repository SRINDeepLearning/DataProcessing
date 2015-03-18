#!/usr/bin/perl

use strict;
use warnings;


open (main, 'campaign_claim-update.csv') or die "Can't open!";
open(my $out, '>user_claim.txt');

my @claimed;

while(my $line = <main>){
	chomp $line;
	my @entry = split(/\|/, $line);
	
	push @claimed, $entry[3];
}

close main;
open(redeem, 'campaign_redeem-update.csv') or die "Can't open!";

my %redeemed_user;
my %redeem_code;
my %claimed_user;
while(my $line = <redeem>){
	chomp $line;
	my @entry = split(/\|/, $line);

	$redeemed_user{$entry[8]}++;
	$redeem_code{$entry[3]} = $entry[8];
	$claimed_user{$entry[8]} = 0;
}

foreach my $a (@claimed){
	$claimed_user{$redeem_code{$a}}++;
}

print $out "user_id|totalredeem|totalclaimed\n";
foreach my $a (keys %redeemed_user){
	print $out $a."|".$redeemed_user{$a}."|".$claimed_user{$a}."\n";
}
my @users = keys %claimed_user;
my $totalusers = @users;
print $out "Total Unique Redeemed Users: ".$totalusers."\n";

my @users_c;
foreach my $a (keys %claimed_user){
	if(%claimed_user{$a} != 0){
		push @users_c, $a;
	}
}
my $users_c = @users_c;
print $out "Total Unique Claimed Users: ".$users_c."\n";

