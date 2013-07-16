#!/usr/bin/perl
package WANScaler::HTTPLibrary;
use LWP::UserAgent;
use HTTP::Request;
use Data::Dumper;
use Time::HiRes qw(gettimeofday);
use Exporter;
our @ISA = ('Exporter');
our @EXPORT = qw($http_err);
my $http_err = undef;

sub get {
	my $package = shift;
    my $url = shift;
    my $ua = LWP::UserAgent->new;
    $ua->agent("Mozilla/0.1 ");
	# Create a request
 	my $req = HTTP::Request->new(GET => $url);
    my @time1 = gettimeofday;
    my $res = $ua->request($req);
    my @time2 = gettimeofday;
    # Check the outcome of the response
    my $result = {};
	if ($res->is_success) {
        my $time = $time2[0]-$time1[0]+($time2[1]-$time1[1])/1000000;
	  	$size = length($res->content);
        $result = {'TIME'=>$time, 'SIZE'=>$size};
	} else {
	  $http_err = $res->status_line, "\n";
	}
    print Dumper($result);
    return $result;
}
1;