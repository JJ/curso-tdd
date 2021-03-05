#!/usr/bin/env perl

use CPAN::Meta::YAML;
for my $f (split(";",$ENV{'yaml_files'})) {
  open my $fh, "<:utf8", $f;
  my $yaml_text = do { local $/; <$fh> };
  my $yaml = CPAN::Meta::YAML->read_string($yaml_text)
    or die CPAN::Meta::YAML->errstr;
  close $fh;
  print "✓ YAML «$f»";
}
