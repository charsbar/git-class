package Git::Class::Test::Cmd::Basic;

use strict;
use warnings;
use Test::Classy::Base;
use Git::Class::Cmd;
use Path::Extended;
use File::Temp qw/tempdir/;
use Cwd;

my $CMD;
my $CWD = Cwd::cwd;
my $GIT_DIR = dir(tempdir(CLEANUP => 1));

local $ENV{GIT_CLASS_TRACE} = 1;

sub initialize {
  my $class = shift;

  $GIT_DIR->remove if $GIT_DIR->exists;
  $GIT_DIR->mkdir;
  chdir $GIT_DIR;

  $CMD = Git::Class::Cmd->new(verbose => 1);

  $class->skip_this_class('git is not available') unless $CMD->is_available;
}

sub test00_init : Tests(2) {
  my $class = shift;

  my $got = $CMD->git('init');

  ok $got, $class->message("initialized local repository");
  ok !$CMD->_error, $class->message('and no error');
}

sub test01_add : Tests(2) {
  my $class = shift;

  my $file = $GIT_DIR->file('README');
  $file->save('readme');
  ok $file->exists, $class->message("created README file");

  my $got = $CMD->git('add', 'README');

  ok !$CMD->_error, $class->message('added README to the local repository without errors');
}

sub test02_commit : Tests(2) {
  my $class = shift;

  my $got = $CMD->git('commit', { message => 'committed README' });

  ok $got, $class->message("committed to the local repository");
  ok !$CMD->_error, $class->message('and no error');
}

sub finalize {
  my $class = shift;

  chdir $CWD;

  $GIT_DIR->remove;
}

1;
