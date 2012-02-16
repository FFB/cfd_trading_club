package cfd_trading_club::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cfd_trading_club::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    if ($c->req->method eq 'POST') {
        $c->detach('login_post');
    }
}

sub login_post :Private {
    my ( $self, $c ) = @_;

    my $username = $c->req->params->{username};
    my $password = $c->req->params->{password};

    if ($username and $password and $c->authenticate({username => $username, password => $password,})) {
        $c->session->{username} = $c->user->get('username');
        my $destination = '/';
        $destination = $destination . $c->stash->{path} if $c->stash->{path};
        $c->res->redirect($c->uri_for($destination));
        $c->detach();
    }

    $c->flash->{login_error} = 1;
    $c->res->redirect($c->uri_for("/login"));
}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
