package cfd_trading_club::Schema::Result::FinalPrediction;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('final_predictions');

__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(q[
    SELECT p.period, p.ticker, p.direction
    FROM (
        SELECT ticker, period, MAX(time) as maxtime
        FROM prediction
        WHERE user_id = ?
        GROUP BY ticker, period
    ) AS x
    INNER JOIN prediction p
        ON x.ticker   = p.ticker
        AND x.maxtime = p.time
        AND x.period  = p.period
]);

__PACKAGE__->add_columns(
  "period",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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
