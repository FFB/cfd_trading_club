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

    # Determine current time
    my $dt = DateTime->now;
    my %time_remaining = (
        hours => 0,
        mins  => 1,
        secs  => 10,
    );

    $c->stash(
        predictors        => \@predictors,
        confidence_levels => \@confidence_levels,
        time_remaining    => \%time_remaining,
    );
}

=head1 AUTHOR

Zane Moser,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
