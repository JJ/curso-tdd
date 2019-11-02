# -*- cperl -*-

use Test::More;
use Git;
use File::Slurper qw(read_text);
use JSON;
use Term::ANSIColor qw(:constants);

use v5.14; # For say

if ( $TRAVIS_PULL_REQUEST ) {
  plan tests => "no_plan";
} else {
  plan skip_all => "Check relevant only for PRs";
}

my $repo = Git->repository ( Directory => '.' );
my $diff = $repo->command('diff','HEAD^1','HEAD');
my $diff_regex = qr/a\/proyectos.md/;
my $github;

SKIP: {
  my ($this_hito) = ($diff =~ $diff_regex);
  skip "No hay envío de proyecto", 5 unless defined $this_hito;
  my $diag=<<EOC;

"Failed test" indica que no se cumple la condición indicada
Hay que corregir el envío y volver a hacer el pull request,
aumentando en uno el número de la versión del hito en el
fichero correspondiente.

EOC
  diag $diag;
  my @files = split(/diff --git/,$diff);
  my ($diff_hito) = grep( /$diff_regex/, @files);
  my @lines = split("\n",$diff_hito);
  my @adds = grep(/^\+[^+]/,@lines);
  my $url_repo;
  if ( $adds[0] =~ /\(http/ ) {
    ($url_repo) = ($adds[0] =~ /\((http\S+)\)/);
  } else {
    ($url_repo) = ($adds[0] =~ /^\+.+(http\S+)\b/s);
  }
  diag(check( "Encontrado URL del repo $url_repo" ));
  my ($user,$name) = ($url_repo=~ /github.com\/(\S+)\/(.+)/);
  my $repo_dir = "/tmp/$user-$name";
  unless (-d $repo_dir) {
    mkdir($repo_dir);
    `git clone $url_repo $repo_dir`;
  }
  my $student_repo =  Git->repository ( Directory => $repo_dir );
  my @repo_files = $student_repo->command("ls-files");
  isnt( grep( /qa.json/, @repo_files), 0, "Fichero de configuración presente" );
  my $qa = from_json(read_text( $repo_dir.'/qa.json' ));
  my $build_file = $qa->{'build'};
  isnt( grep( /$build_file/, @repo_files), 0, "Fichero de construcción $build_file presente");
}

done_testing;

sub check {
  return BOLD.GREEN ."✔ ".RESET.join(" ",@_);
}
