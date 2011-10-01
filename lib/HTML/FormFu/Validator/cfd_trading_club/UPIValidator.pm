package HTML::FormFu::Validator::cfd_trading_club::UPIValidator;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};

    my $matched = $c->model('DB::User')->search({upi => $value})->count;

    $self->{message} = "UPI already in use";

    return ($matched > 0) ? 0 : 1;
}

1;
