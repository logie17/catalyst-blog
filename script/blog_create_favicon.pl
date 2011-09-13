#! /usr/bin/env perl

use Gravatar::URL;
use LWP::UserAgent;

my $gravatar_url = gravatar_url(email => 'loganbell@gmail.com', size=>48);

my $ua = LWP::UserAgent->new;

if ( my $response = $ua->get($gravatar_url) ) {
    my $content = $response->decoded_content;

    open ( my $favico, ">", './root/favicon.ico') || die "Unable to open file: $!";

    print $favico $content;

    close $favico;
}

