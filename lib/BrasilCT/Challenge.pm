use strict;
use warnings;
package BrasilCT::Challenge;

# ABSTRACT: main controller

use BrasilCT::Challenge::CentralStation;
use Dancer;
use Dancer::Plugin::REST;

prepare_serializer_for_format;

set environment => 'development';

my $stations = BrasilCT::Challenge::CentralStation->new;

get '/listarUmCaminho/:de/:para.:format' => sub {

  $stations->listarUmCaminho(params->{de}, params->{para});
};

get '/listarMenorCaminho/:de/:para.:format' => sub {

  $stations->listarMenorCaminho(params->{de}, params->{para});
};

get '/calcularTempoMenorCaminho/:de/:para.:format' => sub {

  my $x = eval { $stations->calcularTempoMenorCaminho(params->{de}, params->{para}) };

  { 
    x = $x,
    error => $@,
  } 
};

1;
