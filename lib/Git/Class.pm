package Git::Class;

use strict;
use warnings;
use base 'Exporter';
use Git::Class::Cmd;

our $VERSION = '0.01';

our @EXPORT_OK = 'git';

sub git { Git::Class::Cmd->new(@_) }

1;

__END__

=head1 NAME

Git::Class - a simple git wrapper

=head1 SYNOPSIS

  use strict;
  use warnings;
  use Git::Class;

  my $git = Git::Class::Cmd->new;
  my $worktree = $git->clone('git://github.com/charsbar/git-class/master/tree');
  $worktree->add('myfile');
  $worktree->commit;
  $worktree->push;

=head1 DESCRIPTION

This class is a simple wrapper of a C<git> executable.

=head1 EXPORTABLE FUNCTION

=head2 git

returns a Git::Class::Cmd object.

=head1 SEE ALSO

L<Git::Class::Cmd>

L<Git::Class::Worktree>

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
