package Blog::Controller::Pages;
use Moose;
use CatalystX::Syntax::Action;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

action begin : Chained('../begin') PathPart('pages') CaptureArgs(0) { }

action resume : Chained('begin') Args(0) { }

action about :Chained('begin') Args(0) { }

action admin :Chained('begin') Args(0){ 
    if ( !$ctx->user_exists ) {
        $ctx->response->redirect($ctx->uri_for('/'));
    }
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

