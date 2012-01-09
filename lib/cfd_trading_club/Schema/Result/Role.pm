package cfd_trading_club::Schema::Result::Role;

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

cfd_trading_club::Schema::Result::Role

=cut

__PACKAGE__->table("role");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'role_id_seq'

=head2 rolename

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "role_id_seq",
  },
  "rolename",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("role_rolename_key", ["rolename"]);

=head1 RELATIONS

=head2 user_roles

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "cfd_trading_club::Schema::Result::UserRole",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2012-01-08 21:52:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eq7d2KpA/4PSzWaqjNLePA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
