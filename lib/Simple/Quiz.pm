package Simple::Quiz;

use Modern::Perl;
use Moose;
use YAML::XS qw/LoadFile/;
use Data::Dumper;

has 'filename', is => 'rw', isa => 'Str';
has 'title', is => 'rw', isa => 'Str';
has 'sections', is => 'rw', isa => 'ArrayRef', predicate => '_has_sections', default => sub { [] };

sub load_sections {
  my ($self, $sections) = @_;
  
  open my $fh, '<', $self->filename;
  my $questions_input = LoadFile($fh);

  my @section_errors;

  # Read through sections and load all found sections into sections.
  foreach (@{$sections}) { 
    my $section = $questions_input->{questions}{sections}{$_};
     if (defined $section) {
      push @{$self->sections}, $section;
     } else {
      push @section_errors, $_;
     }
  }

  if (scalar @section_errors >= 1) {
    say "Error can't load following sections: @section_errors";
  }

  #$questions_input->{questions}{sections}{1});
  #print Dumper(@sections);

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
