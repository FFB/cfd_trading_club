package cfd_trading_club::Controller::Predict;
use Moose;
use namespace::autoclean;
use DateTime;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

cfd_trading_club::Controller::Predict - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{page} = 'predict';

    my @predictors;
    my %data = (
        ticker => 'SPX',
        image  => 'images/SP-500.jpg',
    );
    push @predictors, \%data;
    my @confidence_levels = ('Good guess', 'Ballsy', 'Sensei');

    $c->stash(
        predictors        => \@predictors,
        confidence_levels => \@confidence_levels,
    );
    $c->forward('stash_time_to_close');
}

=head2 calculate_time_to_close

Calculates time duration until the next 12:00 (am or pm, whichever is closest).
Returns a hashref
{
    hours =>
    mins  =>
    secs  =>
}

=cut

sub stash_time_to_close :Private {
    my ( $self, $c ) = @_;

    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    my $hours_remaning = 11 - $dt->hour_12_0;
    my $mins_remaning  = 59 - $dt->min;
    my $secs_remaning  = 59 - $dt->sec;

    $c->stash->{time_remaining} = {
        hours => $hours_remaning,
        mins  => $mins_remaning,
        secs  => $secs_remaning,
    };
}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
