requires 'perl', '5.008001';

requires 'Thrift', 'v0.13.0';
requires 'Plack';
requires 'Text::Caml';
requires 'JSON';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
