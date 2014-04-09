package Graph::RandomPath;
 
use 5.010000;
use strict;
use warnings;
use base qw(Exporter);
use Graph;
use Carp;
 
our $VERSION = '0.01';
 
our %EXPORT_TAGS = ( 'all' => [ qw(
         
) ] );
 
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
 
our @EXPORT = qw(
);
 
sub create_generator {
  my ($class, $g, $src, $dst, %opt) = @_;
 
  $opt{max_length} //= 64;
   
  my %to_src = map { $_ => 1 } $src, $g->all_successors($src);
  my %to_dst = map { $_ => 1 } $dst, $g->all_predecessors($dst);
   
  my $copy = $g->new;
  $copy->set_edge_weight($_->[1], $_->[0], 1) for grep {
    $to_src{$_->[0]} and $to_src{$_->[1]} and
    $to_dst{$_->[0]} and $to_dst{$_->[1]}
  } $g->edges;
   
  my $sptg;
   
  eval {
    $sptg = $copy->SPT_Dijkstra($dst);
  };
   
  if ($@) {
    # This is here in case the module is updated to allow user-
    # supplied weights for the edges, which might then be nega-
    # tive and require a different shortest path algorithm.
    $sptg = $copy->SPT_Bellman_Ford($dst);
  }
   
  Carp::confess "Unable to generate paths for these parameters" unless
    (defined $sptg->get_vertex_attribute($src, 'weight') and
    $sptg->get_vertex_attribute($src, 'weight') < $opt{max_length});
 
  return sub {
    my @path = ($src);
    my $target = rand($opt{max_length});
    while (1) {
      my $v = $copy->random_predecessor($path[-1]);
 
      last if $path[-1] eq $dst and
        (not defined $v or @path > $target);
         
      my $w = $sptg->get_vertex_attribute($v, 'weight') // 0;
       
      if (@path + $w > $opt{max_length}) {
        my $v = $sptg->get_vertex_attribute($v, 'p');
      };
       
      push @path, $v;
    }
    @path;
  }
}
 
1;