package BrasilCT::Challenge::CentralStation;


use BrasilCT::Challenge::Importer;
use BrasilCT::Challenge::Station;
use BrasilCT::Challenge::Line;
use Graph;
use Graph::RandomPath;
use Moo;

has graph => ( is => 'lazy' );
has stations => ( is => 'lazy');
has lines => ( is => 'lazy' );


sub _build_graph {
  my ($self) = @_;

  my $g = Graph->new;

  foreach my $station (@{$self->stations}){
    $g->add_vertex($station->id);
  }

  foreach my $line (@{$self->lines}){
    $g->set_edge_attribute($line->station1, $line->station2, "line", $line->line);
  }

  $g
}

sub _build_stations {
  BrasilCT::Challenge::Importer->new->import_stations;
}

sub _build_lines {
  BrasilCT::Challenge::Importer->new->import_lines;
}

sub listarUmCaminho {
  my ($self, $de, $para) = @_;

  my @path = eval{ Graph::RandomPath->create_generator($self->graph, $de, $para)->() };

  {
    caminho => \@path,
  }
}

sub listarMenorCaminho {
  my ($self, $de, $para) = @_;

  my @stations = $self->graph->SP_Dijkstra($de, $para);

  { caminho => \@stations }
}

sub calcularTempoMenorCaminho {
  my ($self, $de, $para) = @_;

  my @stations         = $self->graph->SP_Dijkstra($de, $para);

  my $total_time       = 0;
  my $previous_line    = undef;
  my $previous_station = shift @stations; 

  my @lines;  
  foreach my $current_station (@stations) {

    my $current_line = $self->graph->get_edge_attribute($previous_station, $current_station, "line");

    $total_time += 3;
    $total_time += 12 if defined($previous_line) && $previous_line != $current_line;
    
    $previous_line    = $current_line;
    $previous_station = $current_station;
  }

  { 
    de => $de,
    para => $para,
    tempo => $total_time
  }
}

1;