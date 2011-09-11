#! /usr/bin/env perl

use Gravatar::URL;

my $gravatar_url = gravatar_url(email => 'loganbell@gmail.com');

print $gravatar_url;

