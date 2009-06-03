package Git::Class::Test::Role::Execute::Execute;

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

sub echo : Test {
  my $class = shift;

  my ($out, $err) = $obj->_execute(echo => 'foo');
  ok $out =~ /foo/, $class->message('executed and captured successfully');
}

sub echo_with_space : Test {
  my $class = shift;

  my ($out, $err) = $obj->_execute(echo => 'foo bar');
  ok $out =~ /foo bar/, $class->message('looks like quote worked properly');
}

sub tee : Test {
  my $class = shift;

  $obj->is_verbose(1);
  my ($out, $err) = $obj->_execute(echo => 'foo bar');
  ok $out =~ /foo bar/, $class->message('you will see "foo bar" when you run "prove -lv"');
}

1;
