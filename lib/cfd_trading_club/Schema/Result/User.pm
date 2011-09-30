package cfd_trading_club::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

cfd_trading_club::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 username

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 password

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 upi

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 student_id

  data_type: 'integer'
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 first_name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 last_name

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 mobile

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 degree

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 major

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 year

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 experience

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
    sequence          => "users_id_seq",
  },
  "username",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "password",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "upi",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "student_id",
  { data_type => "integer", is_nullable => 0 },
  "email",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "first_name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "last_name",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "mobile",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "degree",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "major",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "year",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "experience",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("users_upi_key", ["upi"]);
__PACKAGE__->add_unique_constraint("users_email_key", ["email"]);
__PACKAGE__->add_unique_constraint("users_username_key", ["username"]);
__PACKAGE__->add_unique_constraint("users_student_id_key", ["student_id"]);

=head1 RELATIONS

=head2 predictions

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::Prediction>

=cut

__PACKAGE__->has_many(
  "predictions",
  "cfd_trading_club::Schema::Result::Prediction",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<cfd_trading_club::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "cfd_trading_club::Schema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-09-30 14:24:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OgmFMfeO+7MOpbY8Dy3TzA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
