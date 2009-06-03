package Git::Class::Test::Role::Execute::MergeArgs;

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

  my @args = $obj->_merge_args(
    'arg1', { first => 'value1' }, 'arg2', { second => 'value2' },
  );
  ok do { grep /\-\-first=value1/, @args }, $class->message('got first option');
  ok do { grep /\-\-second=value2/, @args }, $class->message('got second option');
  ok do { grep /arg1/, @args }, $class->message('got first arg');
  ok do { grep /arg2/, @args }, $class->message('got second arg');
}

1;
