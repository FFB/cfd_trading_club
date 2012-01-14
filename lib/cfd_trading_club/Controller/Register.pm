package cfd_trading_club::Controller::Register;
#use Moose;
use base 'Catalyst::Controller::HTML::FormFu';
#//use namespace::autoclean;

#BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cfd_trading_club::Controller::Register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) :FormConfig('register') {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    if ($form->submitted_and_valid) {
        my $new_user = $c->model('DB::User')->new_result({});

        $form->model->update($new_user);
        $c->flash->{status_msg} = "Form Submitted";

        $c->authenticate({username => $form->param_value('username'), password => $form->param_value('password')});
        $c->session->{username} = $c->user->get('username');
        $c->res->redirect('/register');
    }

    $c->forward('finish_form');

    my @users = $c->model('DB::User')->get_column('username')->all;
    $c->stash->{users} = \@users;
}

sub finish_form :Private {
    my ( $self, $c ) = @_;

    my $form = $c->stash->{form};

    # Add regex constraint to UPI
    $form->constraint({
        name => 'upi',
        type => 'Regex',
        regex => q/^[a-zA-Z]{4}\d{3}/,
        message => "UPI must be of the form 'abcd123'",
    });

    # Change default error messages for required fields
    my $required_constraints = $form->get_constraints({ type => 'Required' });
    for my $required (@$required_constraints) {
        $required->{message} = 'Field required';
    }
    $form->process;

    $c->stash->{form} = $form;
}


=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
