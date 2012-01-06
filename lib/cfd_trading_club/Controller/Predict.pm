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
    push @predictors, {ticker => 'SPX'};
    push @predictors, {ticker => 'Euro50'};
    push @predictors, {ticker => 'FTSE'};
    push @predictors, {ticker => 'ASX200'};

    my %stocks = (
        name => 'Equity Indicies',
        data => \@predictors,
    );

    my @sorted_predictors;
    push @sorted_predictors, \%stocks;

    $c->stash(
        predictors => \@sorted_predictors,
    );
    $c->forward('stash_time_to_close');
    $c->forward('stash_next_prediction_period');
}

sub ajax :Local {
    my ( $self, $c ) = @_;

    $c->stash->{status_msg} = 'Prediction saved';
    $c->detach( $c->view('JSON') );
}

=head2 calculate_time_to_close

Calculates time duration until the next 12:00 from Monday 12:00pm to Saturday 12:00am
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

    my $hours_remaining = 11 - $dt->hour_12_0;
    my $mins_remaining  = 59 - $dt->min;
    my $secs_remaining  = 59 - $dt->sec;

    if ($dt->day_of_week >= 6) {
        $hours_remaining += 12 * (8 - $dt->day_of_week);
        if ($dt->hour < 12) {
            $hours_remaining += 12;
        }
    }

    $c->stash->{time_remaining} = {
        hours => $hours_remaining,
        mins  => $mins_remaining,
        secs  => $secs_remaining,
    };
}

=head2 stash_next_prediction_period

Stashs the data describing the next prediction time period
Prediction periods range from Monday evenings to Saturday mornings
{
    day_of_week => (Day of week)
    half        => (Morning or afternoon)
    day         => (1-31)
    month       => (Full name of month)
}

=cut

sub stash_next_prediction_period :Private {
    my ( $self, $c ) = @_;

    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    my %next_prediction_period;

    if ($dt->day_of_week >= 6) {
        # Advance the time to Monday
        $dt->add(days => (8 - $dt->day_of_week));
        %next_prediction_period = (
            day_of_week => 'Monday',
            half        => 'Evening',
            day         => $dt->day,
            month       => $dt->month_name,
        );
    }
    else {
        $dt->add( hours => 12 );
        %next_prediction_period = (
            day_of_week => $dt->day_name,
            half        => ($dt->hour < 12 ? 'Morning' : 'Evening'),
            day         => $dt->day,
            month       => $dt->month_name,
        );
    }

    $c->stash->{next_prediction_period} = \%next_prediction_period;
}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
