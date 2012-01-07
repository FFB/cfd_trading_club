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

    $c->stash->{path} = $c->req->path;
    $c->forward('prepare_user');
    return 1;
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'home';
}

sub about :Local {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'about';
}

sub competition :Local {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'competition';
}

sub stats :Local {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'stats';
}

sub links :Local {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'links';
}

sub ajax :Local {
    my ( $self, $c ) = @_;

    my $ticker = $c->req->params->{ticker};

    $c->stash->{status_msg} = 'Prediction saved';
    $c->detach( $c->view('JSON') );
}

sub login :Local {
    my ( $self, $c ) = @_;

    my $username = $c->req->params->{username};
    my $password = $c->req->params->{password};
    my $path     = $c->req->params->{path};

    if ($username and $password and $c->authenticate({username => $username, password => $password,})) {
        $c->session->{username} = $c->user->get('username');
    }
    else {
        $c->flash->{login_error} = 1;
    }

    $c->res->redirect($c->uri_for($path));
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
