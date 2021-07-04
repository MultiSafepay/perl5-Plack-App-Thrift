package Plack::App::Thrift::MemoryTransport;
use strict;
use warnings;
use base 'Thrift::Transport';

sub new {
    my $class = shift;
    my ($memory) = @_;

    my $self = { memory => $memory };
    bless $self, $class;

    return $self;
}

sub write {
    my $self = shift;
    my ($buf) = @_;

    ${ $self->{memory} } .= $buf;

    return $self;
}

1;
