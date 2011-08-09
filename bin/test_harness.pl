#!/usr/bin/env perl

use Modern::Perl;
use Simple::Quiz;
use Data::Dumper;

my $quiz_file = $ARGV[0];

my $quiz = Simple::Quiz->new(filename => $quiz_file, title => "Learning cantonese", mode => 'shuffle');

my @sections = (1 .. 5);

if ($quiz->load_sections(\@sections)) {
  say "Sections loaded successfully";
}

if ($quiz->start()) {
  say "\n";
  say "Quiz started successfully: " . $quiz->title . "(section " . $quiz->current_section . ")";
  say "Preparing questions in " . $quiz->mode . " mode..";
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

}
