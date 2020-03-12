# -*- cperl -*-

use Test::More;
use Git;
use File::Slurper qw(read_text);
use JSON;
use Term::ANSIColor qw(:constants);
use Capture::Tiny qw(capture_merged);

use v5.14; # For say

unless ( $ENV{'TRAVIS_PULL_REQUEST'} =~ /\d/ ) {
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
    ($url_repo) = ($adds[0] =~ /\((https\S+)\)/);
  } else {
    ($url_repo) = ($adds[0] =~ /^\+.+(https\S+)\b/s);
  }
  ok $url_repo, "Detectado un enlace a repo en $adds[0]";
  my ($version) = @adds[0] =~ /(v\d+\.\d+\.\d+)/;
  diag(check( "Encontrado URL del repo $url_repo con versión $version" ));
  my ($user,$name) = ($url_repo=~ /github.com\/(\S+)\/(.+)/);
  my $repo_dir = "/tmp/$user-$name";
  unless (-d $repo_dir) {
    mkdir($repo_dir);
    `git clone $url_repo $repo_dir`;
  }
  my $student_repo =  Git->repository ( Directory => $repo_dir );
  my ($output, @result ) =  capture_merged { $student_repo->command("checkout", $version) };
  unlike $output, qr/returned error/, "Repositorio tag-eado correctamente";
  
  my @repo_files = $student_repo->command("ls-files");

  if ( $version =~ /^v0/ ) {
    my @hus = grep(  m{HU/}, @repo_files  );
    cmp_ok $#hus, ">=", 0, "Hay varias historias de usuario";
  } elsif ( $version =~ /^v1/ ) {
    my $qa = config_file( \@repo_files, $repo_dir );
    file_present( $qa->{'build'}, \@repo_files, "de construcción" );
    file_present( $qa->{'clase'}, \@repo_files, "de clase" );
    language_checks( $qa->{'lenguaje'}, \@repo_files );
  } elsif ( $version =~ /^v2/ ) {
    my $qa = config_file( \@repo_files, $repo_dir );
    file_present( $qa->{'build'}, \@repo_files, "de construcción" );
    file_present( $qa->{'test'}, \@repo_files, "de test" );
  }
}

done_testing;

sub check {
  return BOLD.GREEN ."✔ ".RESET.join(" ",@_);
}

sub file_present {
  my ($file, $ls_files_ref, $name ) = @_;
  ok( grep( /$file/, @$ls_files_ref ), "Fichero $name → $file presente" );
  
}

sub config_file {
  my ($ls_files_ref, $repo_dir) = @_;
  file_present( "qa.json", $ls_files_ref, "de configuración" );
  return from_json(read_text( $repo_dir.'/qa.json' ));
}

sub language_checks {
  my ($language, $ls_files_ref) = @_;
  if ($language =~ /python/i ) {
    file_present( "requirements.txt", $ls_files_ref, "Python" );
  } elsif ( $language =~ /Typescript/i || $language =~ /node/i ) {
    file_present( "package.json", $ls_files_ref, "JS" );
  }
}
