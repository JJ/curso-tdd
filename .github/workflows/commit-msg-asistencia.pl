#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

open my $tally_fh, '<', 'data/asistencia.csv' or die "No se puede abrir $!";


my $output= <<EOC;
Asistencia por día

EOC

while ( my $line = <$tally_fh> ) {
  next if $line =~ /^F/;
  my ($dia, $cuantos) = split(/,\s+/, $line );
  $output .= "$dia 📅 " . "⛹" x $cuantos . "\n";
}
say "$output\n--";

