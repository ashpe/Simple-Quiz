#!/usr/bin/env perl

use Modern::Perl;
use Simple::Quiz;

my $quiz_file = $ARGV[0];

my $quiz = Simple::Quiz->new(filename => $quiz_file);

if ($quiz->load_sections(1,5)) {
  say "Sections loaded successfully";
}

if ($quiz->start()) {
  say "Quiz started successfully";
}
