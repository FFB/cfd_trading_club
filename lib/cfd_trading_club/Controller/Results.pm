package cfd_trading_club::Controller::Results;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cfd_trading_club::Controller::Results - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub open_outcry :Path('/results/open-outcry') :Args(0) {
}

sub market_move :Path('/results/market-move') :Args(0) {
    my ( $self, $c ) = @_;

    my $user_results;
    #if ($c->user_exists) {
    #    $user_results = $c->model('DB')->get_user_results($c->user->id);
    #}
    $user_results = $c->model('DB')->get_user_results(1);

    $c->stash->{user_results} = $user_results;
}

sub portfolio :Path('/results/portfolio-planner') :Args(0) {
}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
