#!/usr/bin/env perl

use Modern::Perl;
use Simple::Quiz;

my $quiz_file = $ARGV[0];

my $quiz = Simple::Quiz->new(filename => $quiz_file, title => "Learning cantonese");

my @sections = (1 .. 5);

if ($quiz->load_sections(\@sections)) {
  say "Sections loaded successfully";
}

if ($quiz->start()) {
  say "Quiz started successfully: " . $quiz->title;
}
