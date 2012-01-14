#! /usr/bin/env perl

# This script hits various bloomberg websites for prices and enters them into the cfd database
# Designed to be called frequently to keep up to date with latest delayed price

use strict;
use warnings;
use DBI;
use LWP::UserAgent;
use XML::LibXML;
use DateTime;
use Data::Dump qw/dump/;
use HTML::Display;
use WWW::Mechanize;
use DateTime::Format::Pg;

my @ticker_codes = (qw[ SPX EURO50 FTSE ASX200 GOLD SILVER OIL SUGAR AUDUSD NZDUSD EURUSD GBPUSD ]);

my $dbh = DBI->connect("dbi:Pg:dbname='cfd_trading_club'", "", "") or die "could not establish database connection";

my $mech = WWW::Mechanize->new;
$mech->agent('Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.15 (KHTML, like Gecko) Ubuntu/10.10 Chromium/10.0.608.0 Chrome/10.0.608.0 Safari/534.15');

my $parser = XML::LibXML->new();
$parser->recover(2);

my %latest_values;

get_equity_index_futures();
get_commodity_futures();
get_currencies();

my $dt = DateTime->now;
$dt->set_time_zone('Pacific/Auckland');

my @stmt_args = ();
for my $key (keys %latest_values) {
    $latest_values{$key} =~ s/,//g;
    push @stmt_args, $key, DateTime::Format::Pg->format_datetime($dt), $latest_values{$key};
}

$dbh->do(q[
    INSERT INTO latest_price(ticker, time, price)
    VALUES ] . join(', ', map {'( ?, ?, ? )'} keys %latest_values),
    undef,
    @stmt_args
);

exit;

sub get_equity_index_futures {
    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    $mech->get('http://www.bloomberg.com/markets/stocks/futures');

    if ($mech->success) {
        print "Retrieved equity index futures at ", $dt, "\n";

        local $SIG{__WARN__} = sub {};
        my $dom = $parser->parse_html_string($mech->content);

        $latest_values{SPX}    = find_future($dom, "S&P 500");
        $latest_values{EURO50} = find_future($dom, "DJ EURO STOXX 50");
        $latest_values{FTSE}   = find_future($dom, "FTSE 100");
        $latest_values{ASX200} = find_future($dom, "SPI 200");
    }
}

sub get_commodity_futures {
    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    $mech->get('http://www.bloomberg.com/markets/commodities/futures');

    if ($mech->success) {
        print "Retrieved commodity futures at ", $dt, "\n";

        local $SIG{__WARN__} = sub {};
        my $dom = $parser->parse_html_string($mech->content);

        $latest_values{GOLD}   = find_future($dom, "GOLD 100 OZ FUTR");
        $latest_values{SILVER} = find_future($dom, "SILVER FUTURE");
        $latest_values{OIL}    = find_future($dom, "WTI CRUDE FUTURE");
        $latest_values{SUGAR}  = find_future($dom, "SUGAR #11 (WORLD)");
    }
}

sub get_currencies {
    my $dt = DateTime->now;
    $dt->set_time_zone('Pacific/Auckland');

    $mech->get('http://www.bloomberg.com/markets/currencies/europe-africa-middle-east');

    if ($mech->success) {
        print "Retrieved Europe, Africa and Middle East currencies at ", $dt, "\n";

        local $SIG{__WARN__} = sub {};
        my $dom = $parser->parse_html_string($mech->content);

        $latest_values{EURUSD} = find_future($dom, "EUR-USD");
        $latest_values{GBPUSD} = find_future($dom, "GBP-USD");
    }

    $mech->get('http://www.bloomberg.com/markets/currencies/asia-pacific');

    if ($mech->success) {
        print "Retrieved Asia Pacific currencies at ", $dt, "\n";

        local $SIG{__WARN__} = sub {};
        my $dom = $parser->parse_html_string($mech->content);

        $latest_values{AUDUSD} = find_future($dom, "AUD-USD");
        $latest_values{NZDUSD} = find_future($dom, "NZD-USD");
    }
}

sub find_future {
    my ($dom, $ticker) = @_;
    return $dom->findvalue(sprintf('//td[contains(., "%s")]/following-sibling::td[1][@class="value"]', $ticker));
}
