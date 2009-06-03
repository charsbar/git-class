package Git::Class::Cmd;

use Any::Moose; with qw(
  Git::Class::Role::Execute

  Git::Class::Role::Add
  Git::Class::Role::Bisect
  Git::Class::Role::Branch
  Git::Class::Role::Checkout
  Git::Class::Role::Clone
  Git::Class::Role::Commit
  Git::Class::Role::Diff
  Git::Class::Role::Fetch
  Git::Class::Role::Grep
  Git::Class::Role::Init
  Git::Class::Role::Log
  Git::Class::Role::Merge
  Git::Class::Role::Move
  Git::Class::Role::Pull
  Git::Class::Role::Push
  Git::Class::Role::Rebase
  Git::Class::Role::Reset
  Git::Class::Role::Remove
  Git::Class::Role::Show
  Git::Class::Role::Status
  Git::Class::Role::Tag
);

has '_git' => (
  is        => 'rw',
  isa       => 'Str',
  init_arg  => 'exec_path',
  builder   => '_find_git',
  predicate => 'is_available'
);

sub _find_git {
  my $self = shift;

  my $file = $ENV{GIT_EXEC_PATH};

  return $file if $file && -f $file;

  require Config;
  require File::Spec;
  my $path_sep = $Config::Config{path_sep} || ';';

  foreach my $path ( split /$path_sep/, ($ENV{PATH} || '') ) {
    return 'git' if -f File::Spec->catfile($path, 'git')
                 || -f File::Spec->catfile($path, 'git.cmd')
                 || -f File::Spec->catfile($path, 'git.exe');
  }
  return;
}

sub git {
  my ($self, $cmd, @args) = @_;

  unless ($self->is_available) {
    $self->_error("git binary is not available");
    return;
  }

  $self->_execute( $self->_git, $cmd, $self->_merge_args(@args) );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Git::Class::Cmd

=head1 SYNOPSIS

  use strict;
  use warnings;
  use Git::Class;

  my $git = Git::Class::Cmd->new;
  my $worktree = $git->clone('git://github.com/charsbar/git-class/master/tree');

  my $captured = $git->status; # as a whole
  my @captured = $git->status; # split by "\n"

  # other interface, mainly for internal use
  my $cmd = Git::Class::Cmd->new( die_on_error => 1, verbose => 1 );
  $cmd->git( commit => { message => 'a commit message', all => '' } );

=head1 DESCRIPTION

This is a simple wrapper of a C<git> executable. The strength is that you can run a C<git> command and capture the output in a simple and more portable way than using C<open> to pipe (which is not always implemented fully).

As of this writing, most of the git commands (methods of this class) simply returns the output, but this will be changed in the near future, especially when called in the list context, where we may want sort of proccessed data like what files are affected etc.

=head1 METHODS

Most of the git commands are implemented as a role. See Git::Class::Role::* for details.

=head2 git

takes a git command name (whatever C<git> executable recognizes; it doesn't matter if it's implemented in this package (as a method/role) or not), and options/arguments for that.

Options may be in a hash reference (or hash references if you prefer). You don't need to care about the order and shell-quoting, and you don't need to prepend '--' to the key in this case, but you do need to set its value to a blank string("") if the option doesn't take a value. Of course you can pass option strings merged in the argument list.

Returns a captured text in the scalar context, or split lines in the list context. If some error (or warnings?) might occur, you can see it in C<$object->_error>.

Note that if the C<$object->is_verbose>, the captured output is printed as well. This may help if you want to issue interactive commands.

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
