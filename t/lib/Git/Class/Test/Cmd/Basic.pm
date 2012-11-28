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
my $GIT_DIR = dir(tempdir(CLEANUP => 1))->resolve;

local $ENV{GIT_CLASS_TRACE} = 1;

sub initialize {
  my $class = shift;

  $GIT_DIR->remove if $GIT_DIR->exists;
  $GIT_DIR->mkdir;
  chdir $GIT_DIR;

  $CMD = Git::Class::Cmd->new(verbose => 1);

  $class->skip_this_class('git is not available') unless $CMD->is_available;
}

sub test00_init : Tests(4) {
  my $class = shift;

  is dir(Cwd::cwd()) => $GIT_DIR, $class->message("current directory is correct");

  my $got = $CMD->git('init');

  ok $got, $class->message("initialized local repository");
  ok !$CMD->_error, $class->message('and no error');

  ok $GIT_DIR->subdir('.git')->exists, $class->message('.git exists');
}

sub test01_config : Tests(4) {
  my $class = shift;

  $class->skip_this_test('not in a local repository') unless $GIT_DIR->subdir('.git')->exists;

  my $got = $CMD->config('user.email' => 'test@localhost');

  ok !$CMD->_error, $class->message('set local user.email without errors');

  $got = $CMD->config('user.name' => 'foo bar');

  ok !$CMD->_error, $class->message('set local user.name without errors');

  my $config = $GIT_DIR->file('.git/config')->slurp;
  like $config => qr/email\s*=\s*test\@localhost/, $class->message("contains user.email");;
  like $config => qr/name\s*=\s*foo bar/, $class->message("contains user.name");;
}

sub test02_add : Tests(2) {
  my $class = shift;

  $class->skip_this_test('not in a local repository') unless $GIT_DIR->subdir('.git')->exists;

  my $file = $GIT_DIR->file('README');
  $file->save('readme');
  ok $file->exists, $class->message("created README file");

  my $got = $CMD->git('add', 'README');

  ok !$CMD->_error, $class->message('added README to the local repository without errors');
}

sub test03_commit : Tests(2) {
  my $class = shift;

  $class->skip_this_test('not in a local repository') unless $GIT_DIR->subdir('.git')->exists;

  my $got = $CMD->git('commit', { message => 'committed README', author => 'A U Thor <author@example.com>' });

  ok $got, $class->message("committed to the local repository");
  ok !$CMD->_error, $class->message('and no error');
}

sub finalize {
  my $class = shift;

  chdir $CWD;

  $GIT_DIR->remove;
}

1;
