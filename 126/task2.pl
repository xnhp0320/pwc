#!/usr/local/bin/perl

use 5.032;


my $m = <<EOL;
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
EOL

my @m;
foreach (split "\n", $m) {
    my @line = split ' ', $_;
    push @m, \@line;
}

my $rows = scalar @m;
my $columns = $m[0]->@*;

for my $x (0 .. $rows - 1) {
    for my $y (0 .. $columns - 1) {

        my $curr =  $m[$x]->[$y];
        if ($curr eq "x") {
            print " $curr";
            print "\n" if $y == $columns - 1;
            next;
        }

        my $mc = 0;
        my @probe = ( [-1, -1],
                      [-1, 0],
                      [-1, 1],
                      [0, 1],
                      [1, 1],
                      [1, 0],
                      [1, -1],
                      [0, -1] );
        foreach my $ref (@probe) {
            my $dx = $ref->[0];
            my $dy = $ref->[1];
            if ($x + $dx >= 0 && $x + $dx < $rows &&
                $y + $dy >= 0 && $y + $dy < $columns) {
                if ($m[$x + $dx]->[$y + $dy] eq "x") {
                    $mc ++;
                }
            }
        }

        print " $mc";
        print "\n" if $y == $columns - 1;
    }
}


