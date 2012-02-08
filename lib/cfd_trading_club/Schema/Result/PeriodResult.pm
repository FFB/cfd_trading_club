package cfd_trading_club::Schema::Result::PeriodResult;

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

cfd_trading_club::Schema::Result::PeriodResult

=cut

__PACKAGE__->table("period_result");

=head1 ACCESSORS

=head2 period_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ticker

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 direction

  data_type: 'direction'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "period_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ticker",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "direction",
  { data_type => "direction", is_nullable => 0 },
);

=head1 RELATIONS

=head2 period

Type: belongs_to

Related object: L<cfd_trading_club::Schema::Result::Period>

=cut

__PACKAGE__->belongs_to(
  "period",
  "cfd_trading_club::Schema::Result::Period",
  { id => "period_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-02-08 09:19:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0i1bGQIK1FLOEFIqVLdQeQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
