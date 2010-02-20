use strict;
use warnings;
use ExtUtils::MakeMaker;

my %params = (
  NAME          => 'Git::Class',
  AUTHOR        => 'Kenichi Ishigaki <ishigaki@cpan.org>',
  VERSION_FROM  => 'lib/Git/Class.pm',
  ABSTRACT_FROM => 'lib/Git/Class.pm',
  LICENSE       => 'perl',
  PREREQ_PM => {
    'Any::Moose'          => '0.09',
    'Capture::Tiny'       => 0,
    'File::Spec'          => 0,
    'Module::Find'        => 0,
    'Mouse'               => '0.23',
    'Path::Extended'      => '0.12',
    'URI::Escape'         => 0,
    (($^O ne 'MSWin32') ? ('String::ShellQuote' => 0) : ()),
  },
  BUILD_REQUIRES => {
    'Test::Classy'        => '0.07',
    'Test::More'          => '0.47',
    'Test::UseAllModules' => '0.12',
  },
  META_MERGE => {
    resources => {
      repository => 'http://github.com/charsbar/git-class',
    },
  },
);

my $eumm = $ExtUtils::MakeMaker::VERSION;
delete $params{LICENSE}          if $eumm < 6.31;
delete $params{MIN_PERL_VERSION} if $eumm < 6.48;
delete $params{META_MERGE}       if $eumm < 6.46;
delete $params{META_ADD}         if $eumm < 6.46;

if ($eumm < 6.52 && $params{CONFIGURE_REQUIRES}) {
  $params{PREREQ_PM} = {
    %{ $params{PREREQ_PM}          || {} },
    %{ $params{CONFIGURE_REQUIRES} },
  };
  delete $params{CONFIGURE_REQUIRES};
}
if ($eumm < 6.5503 && $params{BUILD_REQUIRES}) {
  $params{PREREQ_PM} = {
    %{ $params{PREREQ_PM}      || {} },
    %{ $params{BUILD_REQUIRES} },
  };
  delete $params{BUILD_REQUIRES};
}

WriteMakefile(%params);
