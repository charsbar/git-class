package Git::Class::Role::Bisect;

use Moo::Role; with 'Git::Class::Role::Execute';
requires 'git';

sub bisect {
  my $self = shift;

  # my ($options, @args) = $self->_get_options(@_);

  $self->git( bisect => @_ );
}

1;

__END__

=head1 NAME

Git::Class::Role::Bisect

=head1 DESCRIPTION

This is a role that does C<git bisect ...>. See L<http://www.kernel.org/pub/software/scm/git-core/docs/git-bisect.html> for details.

=head1 METHOD

=head2 bisect

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
