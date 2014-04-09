package BrasilCT::Challenge::Line;

use Moo;

has station1 => (is => 'ro', required => 1); 
has station2 => (is => 'ro', required => 1);
has line     => (is => 'ro', required => 1);

1;