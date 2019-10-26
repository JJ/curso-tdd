use Test::Text; # -*- mode: cperl -*-

for my $dir (qw(. temas proyectos) ) {
  my $tesxt = Test::Text->new($dir, ".", "Spanish", @_);
  $tesxt->check();
}

done_testing;
