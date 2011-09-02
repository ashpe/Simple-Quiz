#!/usr/bin/env perl

use Simple::Quiz::Create;

my $create_quiz = Simple::Quiz::Create->new(title => "Maths Quiz", filename => "Maths");

$create_quiz->add_section("1 times table");

my $question = { question => "1x1", answer => 1 };
$create_quiz->add_question_to_section("1 times table", $question);
$create_quiz->generate_quiz; 

