#!/usr/bin/env perl

use Blog;
use Plack::Builder;

Blog->setup_engine('PSGI');
my $app = sub { Blog->run(@_) };

builder {
    enable 'Debug', panels => [ qw( DBITrace Memory Timer Environment ) ];
    $app;
};
