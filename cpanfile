requires 'Any::Moose'          => '0.09';
requires 'Capture::Tiny'       => 0;
requires 'Carp::Clan'          => 0;
requires 'File::Spec'          => 0;
requires 'Module::Find'        => 0;
requires 'Mouse'               => '0.23';
requires 'MRO::Compat'         => 0;
requires 'Path::Extended'      => '0.19';
requires 'Scope::Guard'        => 0;
requires 'Try::Tiny'           => 0;
requires 'URI::Escape'         => 0;

if ($^O ne 'MSWin32') {
  requires 'String::ShellQuote' => 0;
}

on testing => sub {
  requires 'Test::Classy'        => '0.07';
  requires 'Test::More'          => '0.47';
  requires 'Test::UseAllModules' => '0.12';
};
