use Test::Text; # -*- mode: cperl -*-
use Test::More;

if ( $ENV{'TRAVIS_PULL_REQUEST'} =~ /\d/ ) {
  plan skip_all => "Check relevant only for push";
}

for my $dir (qw(temas proyectos) ) {
  just_check( $dir, '.', 'Spanish', 0 );
}

just_check( '.','.', 'Spanish');

done_testing;
