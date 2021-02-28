#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

open my $tally_fh, '<', 'data/proyectos.csv' or die "No se puede abrir $!";


my $output= <<EOC;
Proyectos por hito

EOC

while ( my $line = <$tally_fh> ) {
  my ($version, $cuantos) = split(/,\s+/, $line );
  $output .= "v$version ⇒ " . "⬛" x $cuantos . "\n";
}
say "$output\n--;

