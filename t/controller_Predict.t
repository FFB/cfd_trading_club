use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'cfd_trading_club' }
BEGIN { use_ok 'cfd_trading_club::Controller::Predict' }

ok( request('/predict')->is_success, 'Request should succeed' );
done_testing();
