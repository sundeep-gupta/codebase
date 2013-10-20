# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 19 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/new.al)"
sub new
{
	my $name = shift;
	my $user = shift;
	my $pass = shift;
	my $host = shift || "pop";
	my $oE = shift || getservbyname("pop3", "tcp") || 110;
	my $debug = shift || 0;

 my $me = bless {
		DEBUG => $debug,
		SOCK => $name . "::SOCK" . $fhcnt++,
		SERVER => $host,
		PORT => $oE,
		USER => $user,
		PASS => $pass,
		COUNT => -1,
		SIZE => -1,
		ADDR => "",
		STATE => 'DEAD',
		MESG => 'OK',
		EOL => "\r\n",
	}, $name;

	$me->nHa($user) ; $me->Pass($pass);
	if ($me->Host($host) and $me->Port($oE)) {
		$me->Connect();
	}

	$me;

}

# end of pAa::new
1;
