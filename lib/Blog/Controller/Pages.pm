package Blog::Controller::Pages;
use Moose;
use CatalystX::Syntax::Action;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

action begin : Chained('../begin') PathPart('pages') CaptureArgs(0) { }

action resume : Chained('begin') Args(0) {
    $ctx->stash( template => 'resume.tt' );
}

action about :Chained('begin') Args(0) {
    $ctx->stash( template => 'about.tt' );
}

__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Blog::Controller::Pages - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

