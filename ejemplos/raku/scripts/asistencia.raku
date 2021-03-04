#!/usr/bin/env raku


use IO::Glob;

my $dir = @*ARGS[0] // "..";
my $prefix = @*ARGS[1] // "asistencia-agil-";

chdir($dir);

say "Fecha,Asistencia";
my @asistencia;
for glob("$prefix*") -> $file {
    my @contents = $file.lines;
    push @asistencia, @contents[0] ~ ", " ~ ( @contents.elems - 2 ); # Except me and first line
}
say @asistencia.sort.join("\n");
