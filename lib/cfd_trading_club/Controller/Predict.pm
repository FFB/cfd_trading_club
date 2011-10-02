package cfd_trading_club::Controller::Predict;
use Moose;
use namespace::autoclean;

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

    my @tickers = ("SPX");
    my %ticker_images  = ( SPX => 'images/SP-500.jpg' );
    my @confidence_levels = ('Good guess', 'Ballsy', 'Sensei');

    $c->stash(  tickers => \@tickers,
                ticker_images  => \%ticker_images,
                confidence_levels => \@confidence_levels,
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
