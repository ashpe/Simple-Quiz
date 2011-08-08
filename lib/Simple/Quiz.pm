package Simple::Quiz;

use Moose;
use Data::Dumper;

has 'filename', is => 'rw', isa => 'Str';
has 'section_start', is => 'rw', isa => 'Int';
has 'section_max', is => 'rw', isa => 'Int';
has 'sections', is => 'rw', isa => 'ArrayRef', predicate => '_has_sections';

sub load_sections {
  my ($self, $start, $max) = @_;
  $self->section_start($start);
  $self->section_max($max);
  $self->sections(["Load the sections here"]);
}

sub start {
  my $self = shift;

  if (!$self->_has_sections) {
    die("Error: No sections specified for quiz");
  }

  return 1;
}

1;
