use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'Git::Class',
  AUTHOR        => 'Kenichi Ishigaki <ishigaki@cpan.org>',
  VERSION_FROM  => 'lib/Git/Class.pm',
  ABSTRACT_FROM => 'lib/Git/Class.pm',
  PREREQ_PM => {
    'Test::More'          => '0.47',
    'Test::UseAllModules' => '0.11',
  },
  ($ExtUtils::MakeMaker::VERSION >= 6.31
    ? ( LICENSE => 'perl' )
    : ()
  ),
);
