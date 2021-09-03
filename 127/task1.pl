#!/usr/local/bin/perl


use 5.034;

my @a = split ',\s*', <>;
my @b = split ',\s*', <>;

@a = sort { $a <=> $b } @a;
@b = sort { $a <=> $b } @b;


my $ai = 0;
my $bi = 0;

while ($ai < @a && $bi < @b) {
    if ($b[$bi] < $a[$ai]) {
        $bi ++;
        next;
    }

    if ($b[$bi] == $a[$ai]) {
        say "1";
        exit;
    }
    if ($b[$bi] > $a[$ai]) {
        $ai ++;
    }
}

say "0";
