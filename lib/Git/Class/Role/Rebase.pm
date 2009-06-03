package Git::Class::Role::Rebase;

use Any::Moose '::Role'; with 'Git::Class::Role::Execute';
requires 'git';

sub rebase {
  my $self = shift;

  # my ($options, @args) = $self->_parse_args(@_);

  $self->git( rebase => @_ );
}

1;

__END__

=head1 NAME

Git::Class::Role::Rebase

=head1 DESCRIPTION

This is a role that does C<git rebase ...>. See L<http://www.kernel.org/pub/software/scm/git-core/docs/git-rebase.html> for details.

=head1 METHOD

=head2 rebase

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
