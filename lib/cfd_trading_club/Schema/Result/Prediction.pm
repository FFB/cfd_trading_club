package cfd_trading_club::Schema::Result::Prediction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

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

=head2 ticker

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 time

  data_type: 'timestamp with time zone'
  is_nullable: 0

=head2 direction

  data_type: 'direction'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "prediction_id_seq",
  },
  "ticker",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "time",
  { data_type => "timestamp with time zone", is_nullable => 0 },
  "direction",
  { data_type => "direction", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 ticker

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::Ticker>

=cut

__PACKAGE__->belongs_to(
  "ticker",
  "cfd_trading_club::Schema::Result::Ticker",
  { id => "ticker" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "cfd_trading_club::Schema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-01-08 21:52:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TkZuQETgI2Lvt+2I3iz/zw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;

1;
