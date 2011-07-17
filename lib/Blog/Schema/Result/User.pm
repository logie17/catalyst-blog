package Blog::Schema::Result::User;

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

Blog::Schema::Result::User

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 full_name

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "full_name",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 250 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Blog::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Blog::Schema::Result::Comment",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-07-16 22:45:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mb1OwmkjLESvoOC4t0Aolw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
