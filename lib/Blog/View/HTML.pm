package Blog::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION  => '.tt',
    render_die          => 1,
    INCLUDE_PATH        => [ Blog->path_to( 'root', 'src' ) ],
    WRAPPER             => 'wrapper.tt',
);

=head1 NAME

Blog::View::HTML - TT View for Blog

=head1 DESCRIPTION

TT View for Blog.

=head1 SEE ALSO

L<Blog>

=head1 AUTHOR

Logan Bell

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
