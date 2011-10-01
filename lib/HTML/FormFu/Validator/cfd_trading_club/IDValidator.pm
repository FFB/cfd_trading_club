package HTML::FormFu::Validator::cfd_trading_club::IDValidator;
use strict;
use warnings;
use base 'HTML::FormFu::Validator';

sub validate_value {
    my ( $self, $value, $params ) = @_;
    my $c = $self->form->stash->{context};

    my $matched = $c->model('DB::User')->search({student_id => $value})->count;

    $self->{message} = "Student ID already in use";

    return ($matched > 0) ? 0 : 1;
}

1;
