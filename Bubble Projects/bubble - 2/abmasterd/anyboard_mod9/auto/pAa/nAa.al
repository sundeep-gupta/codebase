# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 217 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/nAa.al)"
sub nAa
{
	my $me = shift;
	my $s = $me->{SOCK};
	print $s "USER " , $me->nHa , $me->EOL;
	$_ = <$s>;
	chop;
	$me->nIa($_);
	/^\+/ or $me->nIa("USER failed: $_") and $me->State('AUTHORIZATION')
		and return 0;

	print $s "PASS " , $me->Pass(), $me->EOL();
	$_ = <$s>;
	chop;
	$me->nIa($_);
	/^\+/ or $me->nIa("PASS failed: $_") and $me->State('AUTHORIZATION')
		and return 0;
	/^\+OK \S+ has (\d+) /i and $me->Count($1);

	$me->State('TRANSACTION');

	$me->oMa() or return 0;

} 

# end of pAa::nAa
1;
