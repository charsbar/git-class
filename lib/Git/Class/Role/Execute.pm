package Git::Class::Role::Execute;

use Any::Moose '::Role'; with 'Git::Class::Role::Error';
use Capture::Tiny qw(capture tee);

sub _execute {
  my ($self, @args) = @_;

  @args = map { _quote($_) } @args;

  if ($ENV{GIT_CLASS_TRACE}) {
    print STDERR join ' ', @args, "\n";
  }

  my ($out, $err) = do {
    local *capture = *tee if $self->is_verbose;
    capture { system(@args) };
  };

  $self->_error($err) if $err;

  wantarray ? split /\n/, $out : $out;
}

sub _parse_args {
  my $self = shift;

  my (%options, @args);
  foreach my $arg (@_) {
    if (ref $arg eq 'HASH') {
      %options = (%options, %{ $arg });
    }
    else {
      push @args, $arg;
    }
  }
  return (\%options, @args);
}

sub _merge_args {
  my $self = shift;

  my ($options, @args) = $self->_parse_args(@_);

  foreach my $key (sort keys %{ $options }) {
    my $value = $options->{$key};
       $value = '' unless defined $value;
    $key =~ s/_/\-/g;
    if (length $key == 1) {
      unshift @args, "-$key", ($value ne '' ? $value : ());
    }
    else {
      unshift @args, "--$key".(($value ne '') ? "=$value" : '');
    }
  }
  return @args;
}

sub _quote {
  my $value = shift;

  return '' unless defined $value;

  my $option_name;
  if ($value =~ s/^(\-\-[\w\-]+=)//) {
    $option_name = $1;
  }
  if ($^O eq 'MSWin32') {
    $value =~ s/\%/^\%/g;
    $value =~ s/"/"""/g;
    $value = qq{"$value"};
  }
  else {
    require String::ShellQuote;
    $value = String::ShellQuote::shell_quote_best_effort($value);
  }
  $value = $option_name . $value if $option_name;

  return $value;
}

1;

__END__

=head1 NAME

Git::Class::Role::Execute

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 AUTHOR

Kenichi Ishigaki, E<lt>ishigaki@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by Kenichi Ishigaki.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
