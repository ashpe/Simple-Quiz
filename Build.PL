
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'English' => '0',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'Test::More' => '0'
  },
  'configure_requires' => {
    'ExtUtils::MakeMaker' => '6.30',
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Simple quiz API',
  'dist_author' => [
    'Ashley Pope <irashp@gmail.com>'
  ],
  'dist_name' => 'Simple-Quiz',
  'dist_version' => '0.001',
  'license' => 'perl',
  'module_name' => 'Simple::Quiz',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Data::Dumper' => '0',
    'Modern::Perl' => '0',
    'Moose' => '0',
    'POSIX' => '0',
    'String::Approx' => '0',
    'YAML::XS' => '0'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
