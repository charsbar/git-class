use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'Git::Class',
  AUTHOR        => 'Kenichi Ishigaki <ishigaki@cpan.org>',
  VERSION_FROM  => 'lib/Git/Class.pm',
  ABSTRACT_FROM => 'lib/Git/Class.pm',
  PREREQ_PM => {
    'Any::Moose'          => '0.09',
    'Capture::Tiny'       => 0,
    'File::Spec'          => 0,
    'Module::Find'        => 0,
    'Mouse'               => '0.23',
    'Test::Classy'        => '0.07',
    'Test::More'          => '0.47',
    'Test::UseAllModules' => '0.12',
    'URI::Escape'         => 0,
    (($^O ne 'MSWin32') ? ('String::ShellQuote' => 0) : ()),
  },
  ($ExtUtils::MakeMaker::VERSION >= 6.31
    ? ( LICENSE => 'perl' )
    : ()
  ),
);
