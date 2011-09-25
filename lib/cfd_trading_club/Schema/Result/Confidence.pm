package cfd_trading_club::Schema::Result::Confidence;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 NAME

cfd_trading_club::Schema::Result::Confidence

=cut

__PACKAGE__->table("confidence");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'confidence_id_seq'

=head2 name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 value

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "confidence_id_seq",
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "value",
  { data_type => "integer", is_nullable => 1 },
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
  { "foreign.conf_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-09-25 19:50:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:V5+zoWiG9hwVh1wi+0Ysqw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
