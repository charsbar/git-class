package Git::Class::Test::Role::Error::Basic;

use strict;
use warnings;
use Test::Classy::Base;
use Git::Class::Test::Role::Error;
use Capture::Tiny 'capture';
use Try::Tiny;

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

  my $e;
  my $obj = try {
    Git::Class::Test::Role::Error->new(die_on_error => 1);
  } catch { $e = shift };
  ok !$e, $class->message('object is successfully created');
  return $class->abort_this_test('object is not created') if $e;

  ok $obj->_die_on_error, $class->message('init_arg should work');

  undef $e;
  try { $obj->_error('set error') } catch { $e = shift };
  ok $e && $e =~ /^set error/, $class->message('error message is correct');

  $obj->_die_on_error(0);
  undef $e;
  my ($out, $err) = capture {
    try { $obj->_error('set error') } catch { $e = shift };
  };
  ok !$e && $err =~ /^set error/, $class->message('should not die');
}

sub verbose : Tests(3) {
  my $class = shift;

  my $e;
  my $obj = try {
    Git::Class::Test::Role::Error->new(verbose => 1);
  } catch { $e = shift };
  ok !$e, $class->message('object is successfully created');
  return $class->abort_this_test('object is not created') if $e;
  ok $obj->is_verbose, $class->message('init_arg should work');

  $obj->is_verbose(0);
  ok !$obj->is_verbose, $class->message('can make it quite');
}

1;
