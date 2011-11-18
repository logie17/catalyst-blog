package Blog::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Blog::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;

    my $username = $c->request->params->{username};
    my $password = $c->request->params->{password};

    if ( $c->request->method eq 'POST' ) {
        if ($username && $password) {
            if ($c->authenticate({ username => $username,
                                   password => $password  } )) {
                $c->response->redirect($c->uri_for('/'));
                return;
            } else {
                $c->stash(error_msg => "Bad username or password.");
            }
        } else {
            $c->stash(error_msg => "Empty username or password.")
                unless ($c->user_exists);
        }
    }

    # If either of above don't work out, send to the login page
    $c->stash(template => 'login.tt');
}


=head1 AUTHOR

Logan Bell

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
