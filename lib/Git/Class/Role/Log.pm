package Git::Class::Role::Log;

use Any::Moose '::Role'; with 'Git::Class::Role::Execute';
requires 'git';

sub log {
  my $self = shift;

  # my ($options, @args) = $self->_parse_args(@_);

  $self->git( log => @_ );
}

1;

__END__

=head1 NAME

Git::Class::Role::Log

=head1 DESCRIPTION

This is a role that does C<git log ...>. See L<http://www.kernel.org/pub/software/scm/git-core/docs/git-log.html> for details.

=head1 METHOD

=head2 log

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
