package Simple::Quiz;

use Moose;
use Data::Dumper;

has 'filename', is => 'rw', isa => 'Str';
has 'sections', is => 'rw', isa => 'ArrayRef', predicate => '_has_sections';

sub load_data {
  my ($self, $file) = @_;
  $self->$filename($file);
  return $self->$filename;
}

sub set_sections {
  my ($self, $sections) = @_;
  print Dumper($sections);
}

sub start {
  my $self = shift;

  if (!$self->_has_sections) {
    die("Error: No sections specified for quiz");
  }

  return 1;
}

