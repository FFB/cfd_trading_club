package cfd_trading_club::Schema::Result::Predictor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

cfd_trading_club::Schema::Result::Predictor

=cut

__PACKAGE__->table("predictor");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'predictor_id_seq'

=head2 ticker

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 open_time

  data_type: 'time with time zone'
  is_nullable: 0

=head2 close_time

  data_type: 'time with time zone'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "predictor_id_seq",
  },
  "ticker",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "open_time",
  { data_type => "time with time zone", is_nullable => 0 },
  "close_time",
  { data_type => "time with time zone", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 predictions

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::Prediction>

=cut

__PACKAGE__->has_many(
  "predictions",
  "cfd_trading_club::Schema::Result::Prediction",
  { "foreign.p_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-09-30 14:24:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rIUlRVOM6ip3ece0xFqqfw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
