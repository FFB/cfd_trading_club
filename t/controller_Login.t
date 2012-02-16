use strict;
use warnings;
use Test::More;


use Catalyst::Test 'cfd_trading_club';
use cfd_trading_club::Controller::Login;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
