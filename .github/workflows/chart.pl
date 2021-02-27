#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

open my $tally_fh, '<', 'data/proyectos.csv' or die "No se puede abrir $!";


say <<EOC;
# Gráfica del estado de los proyectos


| Versión | Cuantos               |
|---------|-----------------------|
EOC

while ( my $line = <$tally_fh> ) {
  my ($version, $cuantos) = split(/,\s+/, $line );
  say "| $version | ", "⬛" x $cuantos, "|";
}


