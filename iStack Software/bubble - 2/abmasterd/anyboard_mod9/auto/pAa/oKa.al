# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package pAa;

#line 273 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/pAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/pAa/oKa.al)"
sub oKa{

	my $me = shift;
	my $gP = shift;
	my %mail=();
	my $s = $me->{SOCK};
 $mail{gHz} = [];
	
	$me->Debug() and print "RET $gP\n";
	print $s "RETR $gP", $me->EOL;
	$_ = <$s>;
	$me->Debug() and print;
	chop;
	/^\+OK/ or $me->nIa("Bad return from RETR: $_") and return 0;
	/^\+OK (\d+) / and $mail{bytelen} = $1;
	

 my $lkey ="";
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		/^([^:]+):\s+(.*)$/ and $mail{ucfirst(lc($1))}=$2 and $lkey=ucfirst(lc($1));
		/^\s+(\S+)/ and $lkey and $mail{$lkey} .=$_;
		$mail{header} .= $_;
 push @{$mail{gHz}}, $_;
 $mail{size} += length($_);
	} until /^\s*$/;
 for(keys %mail) {
		$mail{$_} = dZz::pLa($mail{$_});
 }

 my @barr;
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		unless(/^\.\s*$/) {
 	push @{$mail{gHz}}, $_;
 }
	} until /^\.\s*$/;

	return %mail;
 
} 

# end of pAa::oKa
1;
