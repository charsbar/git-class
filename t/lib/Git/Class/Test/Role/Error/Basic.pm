package Git::Class::Test::Role::Error::Basic;

use strict;
use warnings;
use Test::Classy::Base;
use Git::Class::Test::Role::Error;
use Capture::Tiny 'capture';

sub basic : Tests(5) {
  my $class = shift;

  my $obj = Git::Class::Test::Role::Error->new;

  ok $obj->can('_die_on_error'), $class->message('has _die_on_error accessor');
  ok $obj->can('is_verbose'), $class->message('has is_verbose predicate');
  ok $obj->can('_error'), $class->message('has _error accessor');

  ok !$obj->_die_on_error, $class->message('_die_on_error is false');
  ok !$obj->is_verbose, $class->message('is_verbose is false');
}

sub die_on_error : Tests(4) {
  my $class = shift;

  my $obj = eval {
    Git::Class::Test::Role::Error->new(die_on_error => 1);
  };
  ok !$@, $class->message('object is successfully created');
  return $class->abort_this_test('object is not created') if $@;

  ok $obj->_die_on_error, $class->message('init_arg should work');

  eval { $obj->_error('set error') };
  ok $@ && $@ =~ /^set error/, $class->message('error message is correct');

  $obj->_die_on_error(0);
  my ($out, $err) = capture { eval { $obj->_error('set error') } };
  ok !$@ && $err =~ /^set error/, $class->message('should not die');
}

sub verbose : Tests(3) {
  my $class = shift;

  my $obj = eval {
    Git::Class::Test::Role::Error->new(verbose => 1);
  };
  ok !$@, $class->message('object is successfully created');
  return $class->abort_this_test('object is not created') if $@;
  ok $obj->is_verbose, $class->message('init_arg should work');

  $obj->is_verbose(0);
  ok !$obj->is_verbose, $class->message('can make it quite');
}

1;
