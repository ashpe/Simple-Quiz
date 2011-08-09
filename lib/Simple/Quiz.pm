package Simple::Quiz;

use Modern::Perl;
use Moose;
use YAML::XS qw/LoadFile/;
use Data::Dumper;

has 'filename', is => 'rw', isa => 'Str';
has 'title', is => 'rw', isa => 'Str';
has 'section_start', is => 'rw', isa => 'Int';
has 'section_max', is => 'rw', isa => 'Int';
has 'sections', is => 'rw', isa => 'ArrayRef', predicate => '_has_sections';

sub load_sections {
  my ($self, $start, $max) = @_;
  $self->section_start($start);
  $self->section_max($max);

  open my $fh, '<', $self->filename;
  my $questions_input = LoadFile($fh);
  print Dumper($questions_input->{questions}{sections}{1});

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
