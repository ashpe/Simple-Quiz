package Simple::Quiz;
{
  $Simple::Quiz::VERSION = '0.001';
}

# ABSTRACT: Simple quiz API

use Modern::Perl;
use Moose;
use YAML::XS qw/LoadFile/;
use Data::Dumper;
use POSIX qw/ceil/;
use String::Approx qw/amatch/;

has 'filename', is => 'rw', isa => 'Str';
has 'status', is => 'rw', isa => 'Bool', predicate => '_has_started';
has 'title', is => 'rw', isa => 'Str';
has 'current_section', is => 'rw', isa => 'Str';
has 'current_question', is => 'rw', isa => 'Int';
has 'mode', is => 'rw', isa => 'Str';
has 'completed_questions', is => 'rw', isa => 'ArrayRef', default => sub { [] };
has 'completed_sections', is => 'rw', isa => 'ArrayRef', default => sub { [] };
has 'section_keys', is => 'rw', isa => 'ArrayRef', default => sub { [] };
has 'sections', is => 'rw', isa => 'HashRef', predicate => '_has_sections', default => sub { {} };

sub load_sections {
  my ($self, $sections) = @_;

  if ($self->_has_started) {
     return 0;
  }  
  
  open my $fh, '<', $self->filename;
  my $questions_input = LoadFile($fh);

  my @section_errors;

  # Read through sections and load all found sections into sections.
  foreach (@{$sections}) { 
    my $section = $questions_input->{questions}{sections}{$_};
    if (defined $section) {
      $self->sections->{$_} = $section;
      push @{$self->section_keys}, $_;
    } else {
      push @section_errors, $_;
    }
  }

  my $error_total = scalar @section_errors;
  if ($error_total == scalar @${sections}) {
    return 0;
    $self->sections(undef);
  } elsif (scalar @section_errors >= 1) {
    say "Error can't load following sections: @section_errors";
  } 

  return 1;
}

sub start {
  my $self = shift;
  if (scalar keys %{$self->sections} == 0) {
    die("Error: No sections specified for quiz");
  }

  if ($self->mode eq 'shuffle') {
    my $section = $self->section_keys->[rand(scalar @{$self->section_keys})];
    $self->current_section($section);
  }    
  $self->status(1); 
  return 1;
}

sub next_question {
  my $self = shift;
  my $section = $self->sections->{$self->current_section};
  if (scalar @{$section} == scalar @{$self->completed_sections}) {
    return 0; 
  } else {
    $self->current_question($self->get_next_index());
    my $next_question = $section->[$self->current_question];
    return $next_question;
  }
}

sub get_next_index {
  my $self = shift;
  my $section = $self->sections->{$self->current_section};
  my $next_index;  

  do {
    $next_index = int(rand(scalar @{$section}));
  } while(grep { $_ == $next_index } @{$self->completed_sections});
 
  return $next_index;
 
}

# Matches exactly - typos = incorect
sub answer_question_exact {
  my ($self, $answer) = @_;
  
  my $section = $self->sections->{$self->current_section};
  my $cur_question = $self->current_question;  

  push @{$self->completed_sections}, $cur_question;
  my $correct_answer = $section->[$cur_question]{answer};
  if ($answer eq $correct_answer) {
    return 1;
  } else {
    return 0;
  }

}

# Matches a certain amount of a word to allow for typos.
sub answer_question_approx {
  my ($self, $answer) = @_;
  
  my $section = $self->sections->{$self->current_section};
  my $cur_question = $self->current_question;  

  push @{$self->completed_sections}, $cur_question;
  my $correct_answer = $section->[$cur_question]{answer};
  my $matches = amatch(lc($correct_answer), lc($answer));

  if ($matches) {
    return 1;
  } else {
    return 0;
  }

}

sub section_complete {
  my ($self, $section) = @_;
  push @{$self->completed_sections}, $section;
}

1;

__END__
=pod

=head1 NAME

Simple::Quiz - Simple quiz API

=head1 VERSION

version 0.001

=head1 AUTHOR

Ashley Pope <irashp@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ashley Pope.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

