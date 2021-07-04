package GreetingService;
use strict;
use warnings;
use base 'Thrift::GreetingServiceIf';

use Thrift::Types;

sub new {
    my $class = shift;

    my $self = {};
    bless $self, $class;

    return $self;
}

sub greet {
    my $class = shift;
    my ($greeting) = @_;

    return Thrift::Reply->new(
        { sentence => sprintf( 'Hello, %s!', $greeting->name ) } );
}

1;
