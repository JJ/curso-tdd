use Test::Text; # -*- mode: cperl -*-
use Test::More;

if ( $ENV{'TRAVIS_PULL_REQUEST'} ne '' ) {
  plan skip_all => "Check relevant only for push";
}

for my $dir (qw(temas proyectos) ) {
  my $tesxt = Test::Text->new($dir, ".", "Spanish", @_);
  $tesxt->check();
}

done_testing;
