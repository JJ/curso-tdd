#!/usr/bin/env raku

my $equipos-fn = @*ARGS[0] // "../equipos.txt";
my $asistencia-fn = @*ARGS[1] // "../asistencia-agil-20210223.dat";

my $equipos = $equipos-fn.IO.slurp;

my $names = $equipos ~~ m:g/"@" (\w+)/;
my $set-of-names = Set( $names.list.map: ~*[0] );

my @asistencia = $asistencia-fn.IO.lines;
my $set-of-asistentes = Set();

for @asistencia -> $asistente {
    next if $asistente ~~ /^^\d/;
    $set-of-asistentes ∪= $asistente.split(":")[0];
}
say $set-of-asistentes ∖ $set-of-names;



