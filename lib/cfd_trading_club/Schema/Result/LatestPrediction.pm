package cfd_trading_club::Schema::Result::LatestPrediction;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('latest_predictions');

__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q[
    SELECT p.ticker, p.direction
    FROM (
        SELECT id, MAX(time) as maxtime
        FROM prediction
        WHERE user_id = ?
            AND time >= ?
        GROUP BY ticker, id
    ) AS x
    INNER JOIN prediction p
        ON x.id = p.id
]);

__PACKAGE__->add_columns(
  "ticker",
  {
    data_type      => "text",
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "direction",
  { data_type => "direction", is_nullable => 0 },
);

return 1;
