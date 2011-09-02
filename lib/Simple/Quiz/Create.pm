package Simple::Quiz::Create;
{
    $Simple::Quiz::Create::VERSION = '0.001';
}

use Modern::Perl;
use Moose;
use YAML::XS qw/LoadFile/;
use Carp;

# ABSTRACT: Module for creating simple quizzes 
#has 'completed_questions', is => 'rw', isa => 'ArrayRef', default => sub { [] };


# Simple::Quiz::Create->new(title => "Cake", sections => \%sections, filename => "super_quiz");
# Simple::Quiz::Create->generate_quiz;

has 'title', is => 'rw', isa => 'Str';
has 'filename', is => 'rw', isa => 'Str';
has 'sections', is => 'rw', isa => 'HashRef', default => sub { [] };


sub generate_quiz {
    my $self = shift;
    
    my @compulsary_attr = qw/filename sections questions/;
    foreach my $attribute (@compulsary_attr) {
        if (!$self->$attribute) {
            croak "$attribute is required to generate quiz!";
        }
    }
    
    if (!$self->_check_section_format) {
        croak "Sections are incorrect format, must be a hash of arrays which contain hashes, with question/answer in minimum in each array.";
    }    

    my %quiz;
    $quiz{title} = $self->title if $self->title;
    #TODO: Add check that sections is correct format
    $quiz{questions} = $self->sections;
   
    DumpFile($self->filename, \%quiz);    
}

sub _check_section_format {
    my $self = shift;
    return 1;
}

sub add_section {
    my ( $self, $section, $questions ) = @_;
    $self->sections->{$section} = $questions || [];
    return 1;
}

sub add_question_to_section {
    my ( $self, $section, $question ) = @_;
    push @{$self->sections->{$section}}, $question;
    return 1;
}

1;
