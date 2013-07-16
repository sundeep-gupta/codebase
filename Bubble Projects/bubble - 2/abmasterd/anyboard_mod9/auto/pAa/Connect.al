# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 176 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Connect.al)"
sub Connect
{
	my ($me, $host, $oE) = @_;

	$host and $me->Host($host);
	$oE and $me->Port($oE);

	my $s = $me->{SOCK};
	if (defined fileno $s) {
	
		$me->Close;
	}

	socket($s, PF_INET, SOCK_STREAM, getprotobyname("tcp") || 6) or
		$me->nIa("could not open socket: $!") and
			return 0;
	connect($s, sockaddr_in($me->{PORT}, $me->{ADDR}) ) or
		$me->nIa("could not connect socket [$me->{HOST}, $me->{PORT}]: $!") and
			return 0;

	select((select($s) , $| = 1)[0]); 

 my $msg;
	defined($msg = <$s>) or $me->nIa("Could not read") and return 0;
	chop $msg;
	$me->nIa($msg);
	$me->State('AUTHORIZATION');

	if($me->nHa() and $me->Pass) {
 $me->nAa;
 return 0 if($me->State() =~ /^TRANS/);
 if($main::pop_logon_retry_time >0 && $me->nIa() =~ /busy/i){
 $me->Close();
 sleep($main::pop_logon_retry_time);
 $main::pop_logon_retry_time=0;
 $me->Connect();
 }
 }

}

# end of pAa::Connect
1;
