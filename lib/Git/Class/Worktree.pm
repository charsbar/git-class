package Git::Class::Worktree;

use Any::Moose; with 'Git::Class::Role::Execute';
use File::Spec;

has '_path' => (
  is       => 'rw',
  isa      => 'Str',
  init_arg => 'path',
  required => 1,
  trigger  => sub {
    my ($self, $path) = @_;
    $self->{path} = File::Spec->rel2abs($path);
    $self->_execute( chdir => $path );
  },
);

has '_cmd' => (
  is         => 'rw',
  isa        => 'Git::Class::Cmd',
  init_arg   => 'cmd',
  builder    => '_build__cmd',
  handles    => [qw(
    add branch checkout commit diff fetch init log move 
    push pull rebase reset remove show status tag
  )],
);

sub _build__cmd {
  my $self = shift;
  require Git::Class::Cmd;
  return Git::Class::Cmd->new(
    die_on_error => $self->_die_on_error,
    verbose      => $self->is_verbose,
  );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Git::Class::Worktree

=head1 SYNOPSIS

  use strict;
  use warnings;
  use Git::Class::Worktree;

  my $work = Git::Class::Worktree->new(path => 'path/to/somewhere');
  $work->init;
  $work->add('.');
  $work->commit;

=head1 DESCRIPTION

This is another (experimental) interface to C<git> executable for convenience. Note that this will change the current directory to the path you specify when you create an object.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
