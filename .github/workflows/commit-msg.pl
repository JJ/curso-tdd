#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

open my $tally_fh, '<', 'data/proyectos.csv' or die "No se puede abrir $!";

my @lines = <$tally_fh>;
close $tally_fh;

my @data = map([split( /,\s+/, $_ )], @lines );

my $output= <<EOC;
Proyectos por hito

EOC

for my $line ( sort { $a->[0] <=> $b->[0] } @data ) {
  my ($version, $cuantos) = @$line;
  $output .= sprintf("%3s","v$version") . " ⇒ " . "⬛" x $cuantos . "\n";
}
say "$output\n--";

