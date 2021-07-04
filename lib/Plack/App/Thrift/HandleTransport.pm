package Plack::App::Thrift::HandleTransport;
use strict;
use warnings;
use base 'Thrift::Transport';

sub new {
    my $class = shift;
    my ($handle) = @_;

    my $self = { handle => $handle };
    bless $self, $class;

    return $self;
}

sub read {
    my $self = shift;
    my ($len) = @_;

    $self->{handle}->read(my $buf, $len);

    return $buf;
}

1;
