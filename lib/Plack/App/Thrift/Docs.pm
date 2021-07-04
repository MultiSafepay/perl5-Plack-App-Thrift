package Plack::App::Thrift::Docs;
use strict;
use warnings;
use parent qw/Plack::Component/;

use JSON ();
use Text::Caml;

use Plack::Util::Accessor qw( thrift_json_file );

sub call {
    my $self = shift;
    my $env  = shift;

    my $document = $self->_parse_thrift_json_file();

    my $html = Text::Caml->new->render(<<'TEMPLATE', $document);
<html>
    <body>
        <h1>Docs</h1>

        <h2>Services</h2>

        {{#services}}
        {{name}}()

        <h3>Structs</h3>

        {{#structs}}
        {{name}}
        <ol>
        {{#fields}}
        <li>{{typeId}} {{name}}</li>
        {{/fields}}
        </ol>
        {{/structs}}

        <h3>Functions</h3>
        {{#functions}}
        {{#returnType}}
        {{class}}
        {{/returnType}}
        {{name}}(
        {{#arguments}}
        {{typeId}} {{name}}
        {{/arguments}}
        )
        {{/functions}}
        {{/services}}
    <body>
</html>
TEMPLATE

    return [ 200, [ 'Content-type' => 'text/html', 'Content-Length' => length($html) ], [$html] ];
}

sub _parse_thrift_json_file {
    my $self = shift;

    my $json = do {
        local $/;
        open my $fh, '<', $self->thrift_json_file or die $!;
        <$fh>;
    };

    return JSON::decode_json($json);
}

1;
__END__

=head1 NAME

Plack::App::Thrift::Docs - Thrift service documentation

=head1 SYNOPSIS

    my $processor = MyThriftServiceProcessor->new();

    my $psgi = builder {
        mount '/'     => Plack::App::Thrift->new(processor => $processor);
        mount '/docs' => Plack::App::Thrift::Docs->new(thrift_json_file => '.json');
    };

=head1 DESCRIPTION

L<Plack::App::Thrift> and L<Plack::App::Thrift::Docs> implement a Thrift over HTTP and generate automatic documentation
for your service.

=head1 ATTRIBUTES

=head2 C<thrift_json_file>

Pass path to the thrift json file that can be generated with the following command:

    thrift -r --out . --gen json .thrift

=head1 CREDITS

=head1 AUTHOR

Viacheslav Tykhanovskyi, C<vti@cpan.org>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2021, MultiSafepay B.V.

This program is free software, you can redistribute it and/or modify it under
the terms of the Artistic License version 2.0.

=cut
