package cfd_trading_club::Schema::Result::Prediction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 NAME

cfd_trading_club::Schema::Result::Prediction

=cut

__PACKAGE__->table("prediction");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'prediction_id_seq'

=head2 p_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 time

  data_type: 'timestamp with time zone'
  is_nullable: 0

=head2 est_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 conf_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "prediction_id_seq",
  },
  "p_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "time",
  { data_type => "timestamp with time zone", is_nullable => 0 },
  "est_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "conf_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 est

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::Estimate>

=cut

__PACKAGE__->belongs_to(
  "est",
  "cfd_trading_club::Schema::Result::Estimate",
  { id => "est_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 user

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "cfd_trading_club::Schema::Result::User",
  { id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 conf

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::Confidence>

=cut

__PACKAGE__->belongs_to(
  "conf",
  "cfd_trading_club::Schema::Result::Confidence",
  { id => "conf_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 p

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::Predictor>

=cut

__PACKAGE__->belongs_to(
  "p",
  "cfd_trading_club::Schema::Result::Predictor",
  { id => "p_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-09-25 19:50:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:J3MclTWAeQazVw3M/CZr8g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
