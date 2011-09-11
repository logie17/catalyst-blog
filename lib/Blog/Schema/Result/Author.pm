package Blog::Schema::Result::Author;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 NAME

Blog::Schema::Result::Author

=cut

__PACKAGE__->table("author");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 250

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "first_name",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "last_name",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 250 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 250 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 entries

Type: has_many

Related object: L<Blog::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "Blog::Schema::Result::Entry",
  { "foreign.author" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-09-10 15:07:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f+LLFAmONnbAt1OMUmsVGw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
