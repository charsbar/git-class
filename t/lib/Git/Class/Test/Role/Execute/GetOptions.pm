package Git::Class::Test::Role::Execute::GetOptions;

use strict;
use warnings;
use Test::Classy::Base;
use Git::Class::Test::Role::Execute;

my $obj;

sub initialize {
  my $class = shift;

  $obj = eval { Git::Class::Test::Role::Execute->new };
  $class->skip_this_class($@) if $@;
}

sub basic : Tests(4) {
  my $class = shift;

  my ($opts, @args) = $obj->_get_options(
    'arg1', { first => 'value1' }, 'arg2', { second => 'value2' },
  );
  ok $opts->{first} eq 'value1', $class->message('got first option');
  ok $opts->{second} eq 'value2', $class->message('got second option');
  ok $args[0] eq 'arg1', $class->message('got first arg');
  ok $args[1] eq 'arg2', $class->message('got second arg');
}

sub options_with_same_key : Test {
  my $class = shift;

  my ($opts, @args) = $obj->_get_options(
    { key => 'value1' }, { key => 'value2' },
  );
  ok $opts->{key} eq 'value2', $class->message('first option is overwritten');
}

sub no_options : Tests(2) {
  my $class = shift;

  my ($opts, @args) = $obj->_get_options('foo');
  ok ref $opts eq 'HASH' && !%{ $opts }, $class->message('got a blank hash reference');
  ok $args[0] eq 'foo', $class->message('args are not affected');
}

1;
