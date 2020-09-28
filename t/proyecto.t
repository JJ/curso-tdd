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
  } else {
    chdir $repo_dir;
    `git pull`
  }
  my $student_repo =  Git->repository ( Directory => $repo_dir );
  my ($output, @result ) =  capture_merged { $student_repo->command("checkout", $version) };
  unlike $output, qr/returned error/, "Repositorio tag-eado correctamente";

  my @repo_files = $student_repo->command("ls-files");
  my $README =  read_text( "$repo_dir/README.md"); # Lo necesito en versiones 3 y 4

  my ($this_version) = ( $version =~ /^v(\d+)/ );

  if ($this_version >= 2 ) {
    diag( check( "Tests para hito 2") );
    like( $README, qr/[lL]og/, "Se menciona un logger en el README");
    like( $README, qr/issue/, "Hay enlace a al menos un issue");
  }


  if  ( $this_version >= 3 ) {
    diag( check( "Tests para hito 3") );
    my @hus = grep(  m{HU/}, @repo_files  );
    cmp_ok $#hus, ">=", 0, "Hay varias historias de usuario";
  }

  my $qa; # A partir de aquí hace falta el fichero de configuración
  if ( $this_version >= 5 ) {
    diag( check( "Tests para hito 5") );
    $qa = config_file( \@repo_files, $repo_dir );
    ok( $qa, check( "Fichero de configuración correcto" ) );
    ok( $qa->{"lenguaje"}, check( "Lenguaje " . $qa->{'lenguaje'} . "detectado"));
    file_present( $qa->{'build'}, \@repo_files, "de construcción" );
    file_present( $qa->{'ficheros'}, \@repo_files, "de clase" );
    language_checks( $qa->{'lenguaje'}, \@repo_files );
  }

  if ( $this_version >= 7 ) {
    diag( check( "Tests para hito 7") );
    file_present( $qa->{'test'}, \@repo_files, "de test" );
  }

  my $runner = $qa->{'runner'};
  if ( $this_version >= 8) {
    diag( check( "Tests para hito 8") );
    ok( $runner, check( "La clave runner $runner en el fichero de configuración" ) );
    like( $README, qr/$runner\s+test/, check("«$runner test» en el README"));
  }

  if ( $this_version >= 9 ) {
    diag( check( "Tests para hito 9") );
    file_present( '.travis.yml', \@repo_files, "de CI" );
    travis_pass( $README, $user, $name );
  }

  if ( $this_version >= 10 ) {
    diag( check( "Tests para hito 10") );
    like( $README, qr/$runner\s+coverage/, check("«$runner coverage» en el README"));
    codecov_pass( $README );
  }

  if ( $this_version >= 11 ) {
    diag( check( "Tests para hito 11") );
    like( $README, qr/$runner\s+run/, check("«$runner run» en el README"));
    codecov_pass( $README );
  }

  if ( $this_version >= 12 ) {
    diag( check( "Tests para hito 12") );
    file_present( $qa->{'dateador'}, \@repo_files, "dateador" );
  }
}

done_testing;

sub check {
  return BOLD.GREEN ."✔ ".RESET.join(" ",@_);
}

sub file_present {
  my ($file, $ls_files_ref, $name ) = @_;
  my @files = (ref($file) eq 'ARRAY')?@$file:($file);
  for my $file (@files ) {
    ok( grep( /$file/, @$ls_files_ref ), "Fichero $name → $file presente" );
  }

}

sub config_file {
  my ($ls_files_ref, $repo_dir) = @_;
  file_present( "qa.json", $ls_files_ref, "de configuración" );
  return from_json(read_text( $repo_dir.'/qa.json' ));
}

sub language_checks {
  my ($language, $ls_files_ref) = @_;
  if ($language =~ /python/i ) {
    file_present( "pyproject.toml", $ls_files_ref, "Python" );
  } elsif ( $language =~ /Typescript/i || $language =~ /node/i ) {
    file_present( "package.json", $ls_files_ref, "JS" );
  }
}

sub travis_domain {
  my ($README, $user, $name) = @_;
  my ($domain) = ($README =~ /.Build Status..https:\/\/travis-ci.(\w+)\/$user\/$name\.svg.+$name\)/i);
  return $domain;
}

sub travis_status {
  my $README = shift;
  my ($build_status) = ($README =~ /Build Status..([^\)]+)\)/);
  my $status_svg = `curl -L -s $build_status`;
  return $status_svg =~ /passing/?"Passing":"Fail";
}

sub travis_pass {
  my ($README, $user, $name ) = @_;
  my $travis_domain = travis_domain( $README, $user, $name );
  ok( $travis_domain =~ /(com|org)/ , "Está presente el badge de Travis con enlace al repo correcto");
  if ( $travis_domain =~ /(com|org)/ ) {
    is( travis_status($README), 'Passing', "Los tests deben pasar en Travis");
  }
}

sub codecov_pass {
  my $README = shift;
  my $codecov_perc = codecov_perc( $README );
  cmp_ok $codecov_perc, ">", 85, "Porcentaje de cobertura OK";
  
}

sub codecov_perc {
  my $README =  shift;
  my ($codecov_status ) = ($README =~ /\((https:\/\/codecov\.io\/\S+badge\.svg)/ );
  ok( $codecov_status, "Badge de codecov detectado" );
  my $codecov_svg = `curl -L -s $codecov_status`;
  ok( $codecov_svg, "Badge de codecov descargado" );
  my ($codecov_perc) = ($codecov_svg =~ /(\d+)%<\/text/);
  ok( $codecov_perc, "Porcentaje de cobertura es $codecov_perc" );
  return $codecov_perc;
}
