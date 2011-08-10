#!/usr/bin/env perl

#PODNAME: TestScript

use Modern::Perl;
use Simple::Quiz;
use Data::Dumper;

if (!$ARGV[0]) {
  die("Please specify a file test_harness.pl <filename>");
}

my $quiz_file = $ARGV[0];

my $quiz = Simple::Quiz->new(filename => $quiz_file, title => "Learning cantonese", mode => 'shuffle');

#my @sections = (1 .. 5);
my @sections = qw/three four/;

if ($quiz->load_sections(\@sections)) {
  say "Sections loaded successfully";
}

if ($quiz->start()) {
  say "\n";
  say "Quiz started successfully: " . $quiz->title; 
  say "Preparing questions in " . $quiz->mode . " mode..";
  while (my $section = $quiz->next_section()) {
      say "Section " . $quiz->current_section;
      while (my $question = $quiz->next_question()) {
        say "How do you say \"" . $question->{question} . "\" in cantonese?";
        my $answer = <STDIN>;
        chomp $answer;
        my $check_answer = $quiz->answer_question_approx($answer);
        if ($check_answer) {
          print "Correct: ";
        } else {
          print "Incorrect: ";
        }
        say "Answer is $question->{answer}..";
      }
      say "Quiz completed.";
  }

}
