package Git::Class::Test::Role::Execute;

use Moo; with 'Git::Class::Role::Execute';

has no_capture => (is => 'rw');

1;
