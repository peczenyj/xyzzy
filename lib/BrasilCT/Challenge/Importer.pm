package BrasilCT::Challenge::Importer;

use BrasilCT::Challenge::Line;
use FindBin qw($Bin);
use Text::CSV;
use Graph;
use Moo;

has file_lines => (
  is => 'ro', 
  default => sub {
    "${Bin}/data/lines.csv"
  }
);

has file_stations => (
  is => 'ro', 
  default => sub {
    "${Bin}/data/stations.csv"
  }
);

sub import_stations {
  my ($self) = @_;

  open my $file, '<', $self->file_stations;
  my @stations;

  my $csv = Text::CSV->new;
  
  my $header = $csv->getline($file);

  while(my $row = $csv->getline($file)){

    push @stations, BrasilCT::Challenge::Station->new(
        id => $row->[0],
        name => $row->[3],
      );
  }

  \@stations;
}

sub import_lines {
  my ($self) = @_;

  open my $file, '<', $self->file_lines;
  my @lines;

  my $csv = Text::CSV->new;
  
  my $header = $csv->getline($file);

  while(my $row = $csv->getline($file)){

    push @lines, BrasilCT::Challenge::Line->new(
        station1 => $row->[0],
        station2 => $row->[1],
        line => $row->[2],
      );
  }

  \@lines;
}

1;