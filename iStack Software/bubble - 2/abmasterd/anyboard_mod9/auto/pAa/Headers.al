# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 242 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/Headers.al)"
sub Headers
{
	my $me = shift;
	my $gP = shift;
	my $header = '';
	my $s = $me->{SOCK};
	my $mail = {};;

	$me->Debug() and print "TOP $gP 0\n";
	print $s "TOP $gP 0", $me->EOL;
	$_ = <$s>;
	$me->Debug() and print;
	chop;
	/^\+OK/ or $me->nIa("Bad return from TOP: $_") and return '';
	/^\+OK (\d+) / and $mail->{size} = $1;
	
 my $lkey ="";
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		/^([^:]+):\s+(.*)$/ and $mail->{ucfirst(lc($1))}=$2 and $lkey=ucfirst(lc($1));
		/^\s+(\S+)/ and $lkey and $mail->{$lkey} .=$_;
		$mail->{header} .= $_;
	} until /^\.\s*$/;

 for(keys %$mail) {
		$mail->{$_} = dZz::pLa($mail->{$_});
 }
	return $mail;
} 

# end of pAa::Headers
1;
