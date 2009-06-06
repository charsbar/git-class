package Git::Class::Test::Role::Execute::PrepareOptions;

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

sub two_dashes_and_a_value : Test {
  my $class = shift;

  my $got = join ' ', $obj->_prepare_options({ key => 'value' });
  ok $got eq '--key=value', $class->message($got);
}

sub two_dashes_and_a_blank : Test {
  my $class = shift;

  my $got = join ' ', $obj->_prepare_options({ key => '' });
  ok $got eq '--key', $class->message($got);
}

sub one_dash_and_a_value : Test {
  my $class = shift;

  my $got = join ' ', $obj->_prepare_options({ k => 'value' });
  ok $got eq '-k value', $class->message($got);
}

sub one_dash_and_a_blank : Test {
  my $class = shift;

  my $got = join ' ', $obj->_prepare_options({ k => '' });
  ok $got eq '-k', $class->message($got);
}

1;
