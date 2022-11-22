#!/usr/bin/perl

use Data::Dumper;

use strict;
use warnings;

my $args = $#ARGV + 1;
if ($args != 1) {
	print "geb.pl <year>";
	exit;
}

my $file = 'Geburtstage.ics';

local $/ = "\r\n";
open my $info, $file or die "Could not open $file: $!";

my $entry = 0;
my %sum;
while( my $line = <$info>)  {   
	chomp($line);
	$entry = $entry + 1 if ($line =~ "BEGIN:VEVENT*");
	my ($key,$val) = split(':',$line);
	$sum{$entry}{$key} = $val;
}
print "Subject,Start Date,Start Time,End Date,End Time, All Day Event, Categories, Show Time As\n";

while (my ($key,$val) = each %sum) {
	#print Dumper $val;
     	my ($year, $month, $day) = $val->{'DTSTART;VALUE=DATE'} =~ /\b(\d{4})(\d{2})(\d{2})\b/;      
	my ($age)  = $val->{'SUMMARY'} =~ /(\d+)/;
	if ($age) {
		my $nage = sprintf("%d", $age);
		my $next = $nage + 1;
		$val->{'SUMMARY'} =~ s/(\d+)/$next/g;
	}
	my $nyear = $year + 1;
	print "$val->{'SUMMARY'},$month/$day/$nyear,,,,YES,,\n" if ($nyear eq $ARGV[0]);
}

close $info;
