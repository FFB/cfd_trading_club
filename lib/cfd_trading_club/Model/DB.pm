package cfd_trading_club::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';
use DateTime;
use Math::Round qw/round/;
use Math::SigFigs;

__PACKAGE__->config(
    schema_class => 'cfd_trading_club::Schema',

    connect_info => {
        dsn => 'dbi:Pg:dbname=cfd_trading_club',
        user => '',
        password => '',
    }
);

my @index_tickers = (
    'SPX',
    'EURO50',
    'FTSE',
    'ASX200',
);

my @commod_tickers = (
    'GOLD',
    'SILVER',
    'OIL',
    'SUGAR',
);

my @forex_tickers = (
    'AUDUSD',
    'EURUSD',
    'GBPUSD',
    'AUDNZD',
);

my %period_text = (
    1  => 'Mon  6 Feb PM',
    2  => 'Tue  7 Feb AM',
    3  => 'Tue  7 Feb PM',
    4  => 'Wed  8 Feb AM',
    5  => 'Wed  8 Feb PM',
    6  => 'Thu  9 Feb AM',
    7  => 'Thu  9 Feb PM',
    8  => 'Fri 10 Feb AM',
    9  => 'Fri 10 Feb PM',
    10 => 'Sat 11 Feb AM',
);

sub get_tickers {
    my $self = shift;

    my $rs = $self->resultset('Ticker')->search;

    my @ticker_data = ();
    while (my $ticker = $rs->next) {
        push @ticker_data, { id => $ticker->id, name => $ticker->text, };
    }

    return \@ticker_data;
}

sub get_banner_string {
    my $self = shift;

    my $rs = $self->resultset('LatestPrice')->search(
        {},
        {
            order_by => { -desc => 'time' },
        },
    );

    my @banner_things;
    my $price_data;

    my $i = 0;
    while ((my $price = $rs->next) && $i < 13) {
        $price_data->{$price->get_column('ticker')} = $price->get_column('price');
        $i++;
    }

    for my $x (@index_tickers, @commod_tickers, @forex_tickers) {
        my $banner_string = $x . ': ' . $price_data->{$x};
        if ($x eq 'AUDNZD') {
            my $rate = $price_data->{AUDUSD} / $price_data->{NZDUSD};
            $banner_string = $x . ': ' . FormatSigFigs($rate, 5);
        }
        push @banner_things, $banner_string;
    }

    return \@banner_things;
}

# Retrieves the latest user predictions inside the current prediction time, if any
sub get_user_predictions {
    my ($self, $user_id) = @_;

    my $earliest_time = $self->get_prediction_start_time;

    my $dtf = $self->schema->storage->datetime_parser;
    my $rs = $self->resultset('LatestPrediction')->search(
        {},
        {
            bind => [$user_id, $dtf->format_datetime($self->get_prediction_start_time)],
        },
    );

    my %latest_preds;
    while (my $prediction = $rs->next) {
        $latest_preds{$prediction->get_column('ticker')} = $prediction->get_column('direction');
    }

    return \%latest_preds;
}

# Retrieves all of user's prediction history with results
sub get_user_results {
    my ($self, $user_id) = @_;

    my @rows = $self->resultset('FinalPrediction')->search(
        {},
        {
            bind => [$user_id],
        },
    )->all();

    my $final_user_prediction;
    for my $row (@rows) {
        $final_user_prediction->{$row->period}->{$row->ticker} = $row->direction;
    }

    @rows = $self->resultset('PeriodResult')->search()->all();

    my $user_results;
    for my $row (@rows) {
        push @{ $user_results->{$row->period_id}->{data} }, {
            ticker     => $row->ticker->id,
            direction  => $final_user_prediction->{$row->period_id}->{$row->ticker->id},
            actual     => $row->direction,
        };
    }

    for my $period (sort { $b <=> $a } keys %$user_results) {
        my $number_of_guesses = 0;
        my $correct_count = 0;

        for my $prediction (@{ $user_results->{$period}->{data} }) {

            $prediction->{result} = 0;
            $prediction->{direction} = 'none' unless defined $prediction->{direction};
            if (lc($prediction->{direction}) ne 'none') {
                $number_of_guesses++;
                $prediction->{result} = -1;

                if (lc($prediction->{direction}) eq lc($prediction->{actual})) {
                    $correct_count++;
                    $prediction->{result} = 1;
                }
            }
        }

        my $pc_correct = $number_of_guesses > 0 ? round(100 * $correct_count / $number_of_guesses) . '%'
                       : '-';

        $user_results->{$period}->{date}     = $period_text{$period};
        $user_results->{$period}->{pc}       = $pc_correct;
        $user_results->{$period}->{quantity} = $number_of_guesses;
        $user_results->{$period}->{points}   = $correct_count;
    }

    return $user_results;
}

sub get_period_text {
    my $self = shift;

    return \%period_text;
}

# Generates correctly formatted data for predictors based on
# variables provided at top of page
sub generate_predictors {
    my $self = shift;

    my %index_hash = (
        name       => 'Equity Index Futures',
        predictors => [],
    );
    for my $ticker (@index_tickers) {
        push @{ $index_hash{predictors} }, {ticker => $ticker};
    }

    my %commod_hash = (
        name       => 'Commodities',
        predictors => [],
    );
    for my $ticker (@commod_tickers) {
        push @{ $commod_hash{predictors} }, {ticker => $ticker};
    }

    my %forex_hash = (
        name       => 'FX',
        predictors => [],
    );
    for my $ticker (@forex_tickers) {
        push @{ $forex_hash{predictors} }, {ticker => $ticker};
    }

    my @categories = (\%index_hash, \%commod_hash, \%forex_hash);

    return \@categories;
}

# Returns the earliest datetime after which predictions
# could have been made for the next prediction period
sub get_prediction_start_time {
    my $self = shift;

    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    # Earliest prediction time for the weekend or Monday morning is Sat 00:00
    # For all othertimes the earliest prediction time the closest previous noon or midnight
    if ($dt->day_of_week >= 6 or ($dt->day_of_week == 1 and $dt->hour < 12)) {
        $dt->subtract(days => 1) if $dt->day_of_week == 7;
        $dt->subtract(days => 2) if $dt->day_of_week == 1;
        $dt = $self->set_time_0000($dt);
    }
    else {
        if ($dt->hour < 12) {
            $dt = $self->set_time_0000($dt);
        }
        else {
            $dt = $self->set_time_1200($dt);
        }
    }

    return $dt;
}

sub set_time_0000 {
    my ($self, $dt) = @_;
    $dt->set(
        hour   => 0,
        minute => 0,
        second => 0,
    );
    return $dt;
}

sub set_time_1200 {
    my ($self, $dt) = @_;
    $dt->set(
        hour   => 12,
        minute => 0,
        second => 0,
    );
    return $dt;
}

=head1 NAME

cfd_trading_club::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<cfd_trading_club>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<cfd_trading_club::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.41

=head1 AUTHOR

Zane Moser

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
