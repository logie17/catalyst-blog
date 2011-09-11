package Blog::Controller::Root;
use Moose;
use CatalystX::Syntax::Action;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

action begin : Chained('/') PathPrefix CaptureArgs(0) {
}

action default_landing : Chained('begin') PathPart('') Args(0) { 
    $ctx->stash( entries  => [ $ctx->model('DB::Entry')->all ] );
    $ctx->stash( template => 'index.tt' );
}

sub end : ActionClass('RenderView') {}


__PACKAGE__->meta->make_immutable;

1;

=head1 NAME

Blog::Controller::Root - Root Controller for Blog

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=head2 default

Standard 404 error page

=head2 end

Attempt to render a view, if needed.
