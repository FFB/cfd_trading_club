package cfd_trading_club::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

cfd_trading_club::Controller::Root - Root Controller for cfd_trading_club

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

use Data::Dump qw/dump/;

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub login :Local {
    my ( $self, $c ) = @_;

    my $username = $c->req->params->{username};
    my $password = $c->req->params->{password};

    if ($username and $password) {
        if ($c->authenticate({ username => $username,
                               password => $password,
                             })) {
            $c->flash( userdata => $c->user->get('upi') );
        }
        else {
            $c->res->redirect($c->uri_for('/'));
        }
    }

    $c->res->redirect($c->uri_for('/'));
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;