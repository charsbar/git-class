requires 'Capture::Tiny'       => 0;
requires 'Carp::Clan'          => 0;
requires 'Module::Find'        => 0;
requires 'Moo'                 => 0;
requires 'MRO::Compat'         => 0;
requires 'Path::Tiny'          => 0;
requires 'Scope::Guard'        => 0;
requires 'Try::Tiny'           => 0;
requires 'URI::Escape'         => 0;

if ($^O ne 'MSWin32') {
  requires 'String::ShellQuote' => 0;
}

on testing => sub {
  requires 'Test::More'          => '0.98'; # for sane subtest
  requires 'Test::UseAllModules' => '0.12';
};
