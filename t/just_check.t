use Test::Text; # -*- mode: cperl -*-
use Test::More;

if ( $ENV{'CI'} ) {
  plan skip_all => "No se ejecuta en Travis";
}

for my $dir (qw(temas problemas) ) {
  just_check( $dir, '.', 'Spanish', 0 );
}

just_check( '.','.', 'Spanish');

