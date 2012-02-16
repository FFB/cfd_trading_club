package cfd_trading_club::Controller::Root;
use Moose;
use namespace::autoclean;
use Data::Dump qw/dump/;

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

# Check if a user is logged in and set state of
# account widget
sub auto :Private {
    my ( $self, $c ) = @_;

    if ($c->user_exists) {
        $c->stash->{admin} = $c->assert_user_roles(qw/ admin /);
    }

    $c->session->{path} = $c->req->path unless grep { $c->req->path =~ /$_/ } 'login', 'logout';
    $c->stash->{path}   = $c->session->{path};

    $c->log->debug(dump($c->session));
    $c->forward('prepare_user');
    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub about :Local {
    my ( $self, $c ) = @_;
}

sub open_outcry :Path('/competition/open-outcry') :Args(0) {
    my ( $self, $c ) = @_;
}

sub market_move :Path('/competition/market-move') :Args(0) {
    my ( $self, $c ) = @_;
}

sub forum :Local {
    my ( $self, $c ) = @_;
}

sub ajax :Local {
    my ( $self, $c ) = @_;

    my $ticker = $c->req->params->{ticker};

    $c->stash->{status_msg} = 'Prediction saved';
    $c->detach( $c->view('JSON') );
}

sub logout :Local {
    my ( $self, $c ) = @_;
    my $path = $c->req->params->{path};

    $c->logout();
    delete $c->session->{username};

    $c->res->redirect($c->uri_for($path));
}

sub prepare_user :Private {
    my ( $self, $c ) = @_;

    $c->stash->{logged_in} = 0;

    if ($c->user_exists) {
        $c->stash->{logged_in} = 1;
        $c->stash->{username}  = $c->session->{username};
    }
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
