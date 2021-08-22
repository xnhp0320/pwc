#!/usr/local/bin/perl
#

use 5.034;

use experimental 'signatures';
no warnings 'experimental::signatures';

my $N = $ARGV[0];
say "input $N";

sub introot ($x) {
    int (.4 + sqrt ($x));
}

for (my $x = 3; $x <= int ($N / sqrt(2)); $x ++) {
    my $b_sq = $N * $N - $x * $x;
    my $b = introot($b_sq);
    say "($x $b $N)" if $x * $x + $b * $b == $N * $N;
}

# N^2 + y^2 = z^2
# N^2 = z^2 - y^2
# when z^2 - y^2 > N^2 stop searching, we would like the z^2 - y^2 is the smallest
# then y = z - 1 is the case.
# so we should search until z^2 - (z-1)^2 = 2z - 1 > N^2

my $z = $N + 1;
while (2 * $z - 1 <= $N * $N) {
    my $b_sq = $z * $z - $N * $N;
    my $b = introot($b_sq); 
    say "($N $b $z)" if $z * $z == $b * $b + $N * $N;
    $z ++;
}
