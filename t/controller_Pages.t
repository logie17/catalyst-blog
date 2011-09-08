use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Blog';
use Blog::Controller::Pages;

ok( request('/pages')->is_success, 'Request should succeed' );
done_testing();
