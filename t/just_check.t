use Test::Text; # -*- mode: cperl -*-

unless ( $ENV{TRAVIS_PULL_REQUEST} ) {
  plan tests => "no_plan";
} else {
  plan skip_all => "Check relevant only for push";
}

for my $dir (qw(temas proyectos) ) {
  my $tesxt = Test::Text->new($dir, ".", "Spanish", @_);
  $tesxt->check();
}

done_testing;
