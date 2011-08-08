#!/usr/bin/env perl


my $quiz_file = $ARGV[0];

my $quiz = eval { Simple::Quiz->load_questions($quiz_file) };
if (!$@) {
  say "Quiz loaded questions successfully.";
} 

if ($quiz->load_sections(1,2,3)) {
  say "Sections loaded successfully";
}

if ($quiz->start()) {
  say "Quiz started successfully";
}
