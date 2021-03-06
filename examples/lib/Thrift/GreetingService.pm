#
# Autogenerated by Thrift Compiler (0.13.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
use 5.10.0;
use strict;
use warnings;
use Thrift::Exception;
use Thrift::MessageType;
use Thrift::Type;

use Thrift::Types;


# HELPER FUNCTIONS AND STRUCTURES

package Thrift::GreetingService_greet_args;
use base qw(Class::Accessor);
Thrift::GreetingService_greet_args->mk_accessors( qw( greeting ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{greeting} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{greeting}) {
      $self->{greeting} = $vals->{greeting};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'GreetingService_greet_args';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1)
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == Thrift::TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == Thrift::TType::STRUCT) {
        $self->{greeting} = Thrift::Greeting->new();
        $xfer += $self->{greeting}->read($input);
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('GreetingService_greet_args');
  if (defined $self->{greeting}) {
    $xfer += $output->writeFieldBegin('greeting', Thrift::TType::STRUCT, 1);
    $xfer += $self->{greeting}->write($output);
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package Thrift::GreetingService_greet_result;
use base qw(Class::Accessor);
Thrift::GreetingService_greet_result->mk_accessors( qw( success ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{success} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{success}) {
      $self->{success} = $vals->{success};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'GreetingService_greet_result';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1)
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == Thrift::TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^0$/ && do{      if ($ftype == Thrift::TType::STRUCT) {
        $self->{success} = Thrift::Reply->new();
        $xfer += $self->{success}->read($input);
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('GreetingService_greet_result');
  if (defined $self->{success}) {
    $xfer += $output->writeFieldBegin('success', Thrift::TType::STRUCT, 0);
    $xfer += $self->{success}->write($output);
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package Thrift::GreetingServiceIf;

use strict;


sub greet{
  my $self = shift;
  my $greeting = shift;

  die 'implement interface';
}

package Thrift::GreetingServiceRest;

use strict;


sub new {
  my ($classname, $impl) = @_;
  my $self     ={ impl => $impl };

  return bless($self,$classname);
}

sub greet{
  my ($self, $request) = @_;

  my $greeting = ($request->{'greeting'}) ? $request->{'greeting'} : undef;
  return $self->{impl}->greet($greeting);
}

package Thrift::GreetingServiceClient;


use base qw(Thrift::GreetingServiceIf);
sub new {
  my ($classname, $input, $output) = @_;
  my $self      = {};
  $self->{input}  = $input;
  $self->{output} = defined $output ? $output : $input;
  $self->{seqid}  = 0;
  return bless($self,$classname);
}

sub greet{
  my $self = shift;
  my $greeting = shift;

    $self->send_greet($greeting);
  return $self->recv_greet();
}

sub send_greet{
  my $self = shift;
  my $greeting = shift;

  $self->{output}->writeMessageBegin('greet', Thrift::TMessageType::CALL, $self->{seqid});
  my $args = Thrift::GreetingService_greet_args->new();
  $args->{greeting} = $greeting;
  $args->write($self->{output});
  $self->{output}->writeMessageEnd();
  $self->{output}->getTransport()->flush();
}

sub recv_greet{
  my $self = shift;

  my $rseqid = 0;
  my $fname;
  my $mtype = 0;

  $self->{input}->readMessageBegin(\$fname, \$mtype, \$rseqid);
  if ($mtype == Thrift::TMessageType::EXCEPTION) {
    my $x = Thrift::TApplicationException->new();
    $x->read($self->{input});
    $self->{input}->readMessageEnd();
    die $x;
  }
  my $result = Thrift::GreetingService_greet_result->new();
  $result->read($self->{input});
  $self->{input}->readMessageEnd();

  if (defined $result->{success} ) {
    return $result->{success};
  }
  die "greet failed: unknown result";
}
package Thrift::GreetingServiceProcessor;

use strict;


sub new {
    my ($classname, $handler) = @_;
    my $self      = {};
    $self->{handler} = $handler;
    return bless ($self, $classname);
}

sub process {
    my ($self, $input, $output) = @_;
    my $rseqid = 0;
    my $fname  = undef;
    my $mtype  = 0;

    $input->readMessageBegin(\$fname, \$mtype, \$rseqid);
    my $methodname = 'process_'.$fname;
    if (!$self->can($methodname)) {
      $input->skip(Thrift::TType::STRUCT);
      $input->readMessageEnd();
      my $x = Thrift::TApplicationException->new('Function '.$fname.' not implemented.', Thrift::TApplicationException::UNKNOWN_METHOD);
      $output->writeMessageBegin($fname, Thrift::TMessageType::EXCEPTION, $rseqid);
      $x->write($output);
      $output->writeMessageEnd();
      $output->getTransport()->flush();
      return;
    }
    $self->$methodname($rseqid, $input, $output);
    return 1;
}

sub process_greet {
    my ($self, $seqid, $input, $output) = @_;
    my $args = Thrift::GreetingService_greet_args->new();
    $args->read($input);
    $input->readMessageEnd();
    my $result = Thrift::GreetingService_greet_result->new();
    $result->{success} = $self->{handler}->greet($args->greeting);
    $output->writeMessageBegin('greet', Thrift::TMessageType::REPLY, $seqid);
    $result->write($output);
    $output->writeMessageEnd();
    $output->getTransport()->flush();
}

1;
