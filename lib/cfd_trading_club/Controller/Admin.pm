package cfd_trading_club::Controller::Admin;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cfd_trading_club::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

# Check if a user is admin
sub auto :Private {
    my ( $self, $c ) = @_;

    unless ($c->check_user_roles('admin')) {
        $c->res->redirect('/');
        $c->detach;
    }

    return 1;
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my $tickers = $c->model('DB')->get_tickers();
    $c->stash->{tickers} = $tickers;
}

sub upload :Local {
    my ( $self, $c ) = @_;

    my $tickers = $c->model('DB')->get_tickers();
}


=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
