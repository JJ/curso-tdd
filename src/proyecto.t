# -*- cperl -*-

use Test::More;
use Git;
use File::Slurper qw(read_text);
use Term::ANSIColor qw(:constants);
use Capture::Tiny qw(capture_merged);
use YAML qw(LoadFile);

use v5.14; # For say

my ($version) = $ENV{'version'} =~ /(v\d+\.\d+\.\d+)/;
diag(check( "Encontrada versión $version" ));

my $student_repo =  Git->repository ( Directory => "." );
my ($output, @result ) =  capture_merged { $student_repo->command("checkout", $version) };
unlike $output, qr/returned error/, "Repositorio tag-eado correctamente";

my @repo_files = $student_repo->command("ls-files");
my $repo_dir = ".";
my $README =  read_text( "$repo_dir/README.md"); # Lo necesito en versiones 3 y 4

my ($this_version) = ( $version =~ /^v(\d+)/ );

my $config;

if ( $this_version >= 1 ) {
  diag( check ("Tests para hito 1") );
  my $agil_name = -e "$repo_dir/agil.yaml" ? "agil.yaml" : "agil.yml";
  if ( ok( -e "$repo_dir/$agil_name", check("Está el fichero de configuración «$agil_name»")) ) {
    $config = LoadFile("$repo_dir/$agil_name");
    ok( $config, check("Fichero de configuración para corrección $agil_name cargado correctamente") );
    ok( $config->{'personas'}, "Lista de personas presente en el fichero" );
  }
}

if ($this_version >= 2 ) {
  diag( check( "Tests para hito 2") );
  like( $README, qr/[Ss]oluci.n/, "Se menciona una solución en el README");
}

if ($this_version >= 3 ) {
  diag( check( "Tests para hito 3") );
  like( $README, qr/[lL]og/, "Se menciona un logger en el README");
}

if ( $this_version >= 6 ) {
  diag( check( "Tests para hito 6") );
  file_present( $config->{'excepciones'}, \@repo_files, "con excepciones" );
}

if ( $this_version >= 7 ) {
  diag( check( "Tests para hito 7") );
  file_present( $config->{'taskfile'}, \@repo_files, "con gestor de tareas" );
  ok( $config->{'lenguaje'}, check("Se ha declarado el lenguaje de programación") );
}

if ( $this_version >= 8 ) {
  diag( check( "Tests para hito 8") );
  ok( $config->{'linter'}, check("Linter declarado") );
}

if ( $this_version >= 9 ) {
  diag( check( "Tests para hito 9") );
  ok( $config->{'aserciones'}, check( "Se ha declarado la biblioteca de aserciones" ) );
  file_present( $config->{'test'}, \@repo_files, "con tests" );
}

my $testing = $config->{'testing'};
my $runner;
if ( $this_version >= 10) {
  diag( check( "Tests para hito 10") );
  ok( $testing, check( "La clave testing en el fichero de configuración en este tag" ) );
  $runner = $testing->{'runner'};
  ok( $runner, check( "La clave testing en el fichero de configuración en este tag" ) );
  like( $README, qr/$runner\s+test/, check("«$runner test» en el README"));
  ok( $testing->{'framework'}, check( "«testing->{'framework'}» declarado como framework" ));
}

if ( $this_version >= 12 ) {
  diag( check( "Tests para hito 12") );
  file_present( $config->{'dateador'}, \@repo_files, "con fichero declarando dependencia a inyectar" );
}

if ( $this_version >= 13) {
  diag( check( "Tests para hito 13") );
  like( $README, qr/$runner\s+coverage/, check("«$runner coverage» en el README"));
}

done_testing;

# --------------------------------------- subs --------------------------------------

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
  file_present( "agil.yaml", $ls_files_ref, "de configuración" );
  return LoadFile("$repo_dir/agil.yaml");
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
