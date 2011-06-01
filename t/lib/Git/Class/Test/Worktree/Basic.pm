package Git::Class::Test::Worktree::Basic;

use strict;
use warnings;
use Test::Classy::Base;
use Git::Class::Cmd;
use Git::Class::Worktree;
use Path::Extended;
use File::Temp qw/tempdir/;
use Cwd;

my $TREE;
my $CMD;
my $CWD = Cwd::cwd;
my $GIT_DIR = dir(tempdir(CLEANUP => 1));

local $ENV{GIT_CLASS_TRACE} = 1;

sub initialize {
  my $class = shift;

  $GIT_DIR->remove if $GIT_DIR->exists;
  $GIT_DIR->mkdir;

  $CMD = Git::Class::Cmd->new(verbose => 1);

  $class->skip_this_class('git is not available') unless $CMD->is_available;
}

sub test00_chdir : Tests(3) {
  my $class = shift;

  ok dir($CWD) eq dir(Cwd::cwd()), $class->message('we are in the current directory');

  $TREE = Git::Class::Worktree->new( path => $GIT_DIR->absolute ); 

  ok dir(Cwd::cwd()) eq dir($TREE->_path), $class->message('current directory has changed properly');

  ok dir($CWD) eq dir($TREE->_cwd), $class->message('previous current directory is stored');
}

sub test01_init : Tests(2) {
  my $class = shift;

  my $got = $TREE->init;

  ok $got, $class->message("initialized local repository");
  ok !$TREE->_error, $class->message('and no error');
}

sub test02_add : Tests(2) {
  my $class = shift;

  my $file = $GIT_DIR->file('README');
  $file->save('readme');
  ok $file->exists, $class->message("created README file");

  my $got = $TREE->add('README');

  ok !$TREE->_error, $class->message('added README to the local repository without errors');
}

sub test02_commit : Tests(2) {
  my $class = shift;

  my $got = $TREE->commit({ message => 'committed README' });

  ok $got, $class->message("committed to the local repository");
  ok !$TREE->_error, $class->message('and no error');
}

sub test99_demolish : Tests(2) {
  my $class = shift;

  ok dir($CWD) ne dir(Cwd::cwd()), $class->message('current directory is not the same as the stored directory');

  undef $TREE; # to demolish

  ok dir($CWD) eq dir(Cwd::cwd()), $class->message('restored previous current directory after demolishing');;
}

sub finalize {
  my $class = shift;

  chdir $CWD;

  $GIT_DIR->remove;
}

1;
