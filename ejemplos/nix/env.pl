

use strict;
use warnings;

my $output_file= %ENV{'out'};
open( my $out, ">", $output_file)
  or die "No se puede abrir $output_file: $!";
print $out %ENV;
close $out;
