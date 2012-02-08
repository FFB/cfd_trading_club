package cfd_trading_club::Schema::Result::Period;

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

cfd_trading_club::Schema::Result::Period

=cut

__PACKAGE__->table("period");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 start_time

  data_type: 'timestamp'
  is_nullable: 0

=head2 end_time

  data_type: 'timestamp'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "start_time",
  { data_type => "timestamp", is_nullable => 0 },
  "end_time",
  { data_type => "timestamp", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 period_results

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::PeriodResult>

=cut

__PACKAGE__->has_many(
  "period_results",
  "cfd_trading_club::Schema::Result::PeriodResult",
  { "foreign.period_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 predictions

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::Prediction>

=cut

__PACKAGE__->has_many(
  "predictions",
  "cfd_trading_club::Schema::Result::Prediction",
  { "foreign.period" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-02-08 09:19:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9C8fV93DHMlKjxu6rDj3Ag


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
