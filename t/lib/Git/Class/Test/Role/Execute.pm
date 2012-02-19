package Git::Class::Test::Role::Execute;

use Any::Moose; with 'Git::Class::Role::Execute';

has no_capture => (is => 'rw');

1;
