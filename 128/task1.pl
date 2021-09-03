#!/usr/local/bin/perl
use 5.034;
use warnings;
use strict;
use feature 'signatures';
no warnings 'experimental::signatures';
use Data::Dumper;



#my @a = ( 
#          [ 1, 0, 0, 0, 1, 0 ],
#          [ 1, 1, 0, 0, 0, 1 ],
#          [ 1, 0, 0, 0, 0, 0 ]
#         );
#
my @a = ( 
    [ 0, 0, 1, 1 ],
    [ 0, 0, 0, 1 ],
    [ 0, 0, 1, 0 ]
); 

my @r;

for my $y ( 0 .. @a - 1 ) {
    push @r, [];
    for my $x ( 0 .. @{$a[0]} - 1) {
        push $r[$y]->@*, [];
    }
}

use List::Util qw/ min /;

sub search_max ( $a, $x, $y ) {

    if ($y == @{$a[0]} - 1 &&
        $x == @$a - 1) {
        
        if ($a[$x][$y] == 0) {
            $r[$x][$y] = [$x, $y];
        } else {
            $r[$x][$y] = [undef, undef];
        }
        return;
    }

    if ($x == @$a - 1) {
        search_max( $a, $x, $y + 1);
        my ($xdown, $ydown) = @{$r[$x][$y+1]};

        if ($a[$x][$y] == 0) {
            if (defined($xdown) && defined($ydown)) {
                $r[$x][$y] = [$xdown, $ydown];
            } else {
                $r[$x][$y] = [$x, $y];
            }
        } else {
            $r[$x][$y] = [undef, undef];
        }
        return;
    }

    if ($y == @{$a[0]} - 1) {
        search_max( $a, $x + 1, $y);
        my ($xright, $yright) = @{$r[$x+1][$y]};

        if ($a[$x][$y] == 0) {
            if (defined($xright) && defined($yright)) {
                $r[$x][$y] = [$xright, $yright];
            } else {
                $r[$x][$y] = [$x, $y];
            }
        } else {
            $r[$x][$y] = [undef, undef];
        }
        return;
    }

    if ($a[$x][$y] == 0) {
        search_max( $a, $x + 1, $y);
        search_max( $a, $x, $y + 1);

        my ($xright, $yright) = @{$r[$x+1][$y]};
        my ($xdown, $ydown) = @{$r[$x][$y+1]};
        if (defined($xright) && defined($xdown)) {
            $r[$x][$y] = [min($xright, $xdown), min($yright, $ydown) ];
        } elsif (defined ($xright)) {
            $r[$x][$y] = [$xright, $y];
        } elsif (defined ($ydown)) {
            $r[$x][$y] = [$x, $ydown];
        }

    } else {
        $r[$x][$y] = [undef, undef];
        search_max ( $a, $x + 1, $y);
        search_max ( $a, $x, $y + 1);
    }
}

search_max ( \@a, 0, 0 );

my @area;
my $maxarea = 0;
my ($xmax, $ymax);
for my $x ( 0 .. @a - 1 ) {
    push @area, [];
    for my $y ( 0 .. @{$a[0]} - 1) {
        my ($xx, $yy) = @{$r[$x][$y]};
        if (defined($xx)) {
            my $dx = $xx - $x + 1;
            my $dy = $yy - $y + 1;

            if ($dx * $dy >= $maxarea) {
                $maxarea = $dx * $dy;
                $xmax = $x;
                $ymax = $y;
            }

            push @{$area[$x]}, ($dx * $dy); 
        } else {
            push @{$area[$x]}, 0;
        }
    }
}

print "Input: \n";

for my $x ( 0 .. @a - 1) {
    for my $y ( 0 .. @{$a[0]} - 1) {
        print $a[$x][$y], " ";
    }
    print "\n";
}

print "\n";
for my $x ( $xmax .. $r[$xmax][$ymax][0]) {
    for my $y ( $ymax .. $r[$xmax][$ymax][1]) {
        print $a[$x][$y], " ";
    }
    print "\n";
}

