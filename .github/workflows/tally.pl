#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;

open my $proyectos_fh, '<', 'proyectos.md' or die "No se puede abrir $!";

my $proyectos = do { local $/; <$proyectos_fh> };

my (@versions) = $proyectos =~ /v(\d+)\./g;

my %tally;

for my $v (@versions) {
  $tally{$v}++;
}

for my $k (sort keys %tally) {
  say "$k, $tally{$k}";
}
