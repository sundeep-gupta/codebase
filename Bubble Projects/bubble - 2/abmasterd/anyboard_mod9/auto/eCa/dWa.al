# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 716 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dWa.al)"
sub dWa {
	my ($shared, $url) = @_;
	my $req = new dDa;
	my %fetched = ();
	$shared->{req} = $req;
	$shared->{fetched} = \%fetched;
	my $jWa = $shared->{kFa};
	$jWa =~ s/(\.db)?$/\.deadlinks/;
	open DL, ">".$jWa;
	$shared->{deadlinksfh} = \*DL;
	$req->dIa(\%fetched);
	$req->dXa("text/");
	$req->{user_agent} = "Mozilla/4.0 (MSIE 6)";
	DEBUG "Spiding $url\n";
 	my ($service, $host, $page, $oE) = &dDa::dKa($url);
	$shared->{_cur_host} = $host;
	if($eCa::use_lwp) {
		eval 'use LWP::Simple';
		if($@) {
			DEBUG "LWP::Simple: $@\n";
			return;
		}
	}
	dGa($shared, $url, "", 0);
	close DL;
	open DL, "<".$jWa;
	my @deads= <DL>;
	close DL;
	return @deads;
}

# end of eCa::dWa
1;
