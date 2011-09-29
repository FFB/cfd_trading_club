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
    $c->stash->{page} = 'register';

    #my $form = $c->stash->{form};

    #$form->load_config_file('register.yaml');

    #$c->stash->{form} = $form;
}


=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
