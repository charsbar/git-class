use strict;
use warnings;
use lib 't/lib';
use Test::Classy;
use Cwd;

my $cwd = Cwd::cwd;

load_tests_from 'Git::Class::Test::Cmd';
run_tests;

END { chdir $cwd if $cwd ne Cwd::cwd }
