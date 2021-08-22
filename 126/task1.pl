#!/usr/local/bin/perl
use 5.032;

my $N = $ARGV[0];
my @a = 1 .. $N;
say @a -  grep (/1/, @a);
