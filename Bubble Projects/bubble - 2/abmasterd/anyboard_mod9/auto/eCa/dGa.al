# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 747 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dGa.al)"
sub dGa {
	my ($shared, $url, $parent, $level) = @_;
	my $req = $shared->{req};
	if($shared->{fetched}->{$url}) {
		#DEBUG "Skip visited URL $url\n";
		return;
	}
	#DEBUG "Got " , scalar(keys %{$shared->{fetched}}), " urls\n";

	$shared->{fetched}->{$url} = 1;
	my $content;

	if(not $eCa::use_lwp) {
		$req->eNa($url);
		$content = join("", $req->dEa());
	}else {
		$content = get($url);
		if(not $content) {
			$req->{cur_status}= 400;
		}else {
			$req->{cur_status}= 200;
		}
		$req->{dYa} = $url;
	}
	my $status =  $req->{cur_status};
	if ( $status != 200 && int($status/100) !=3 ) {
		my $nA = $shared->{deadlinksfh};
		my $url = $req->{dYa};
		print $nA $status, "\t",
			$url, "\t", $parent, "\n";
		DEBUG  "Error $status", "\t",
			$url, "\tIn ", $parent, "\n";
		return;	
	};
	my $len = length($content);
	$req->finish();
	my $content_ref = \$content;
	dLa($shared, $url, $req->{eTa}->{'last-modified'}, $$content_ref);
	if ($shared->{level} && $level >= $shared->{level}){
		DEBUG "Reached max fetch level $level\n";
		return;
	}
	$$content_ref =~ s/<!--.*?-->//gs;	
	my $discard;
	my @links = $$content_ref =~/(?:href|\ssrc)=([^>\s]+)/ig; 
	my $count = 0;
	my $exclude_re = $shared->{url_exclude};
	my $exclude_re2 = $shared->{url_exclude2};
	my $dYa = $req->{dYa};
	my $eQa = $shared->{_cur_host};
	if ($shared->{max_entry} && $shared->{filecount} > $shared->{max_entry}) {
		DEBUG "Reached max fetch count $shared->{max_entry}\n";
		return;
	}
	DEBUG scalar(@links), " links found ($len bytes)\n";
	for(@links) {
		s/\"|\'//g;
		next if m/^(ftp|mailto|gopher|news|javascript|ldap):/;	
		m/^(\w+):/;	
		next if $1 && lc($1) ne 'http';
		if ($_ =~ /^$exclude_re$/o) {
			#DEBUG "Exclude URL $_\n";
			next;
		}
		if ($_ =~ /$exclude_re2/o) {
			#DEBUG "Exclude2 URL $_\n";
			next;
		}
		s/#.*$//;
		next if not $_;
		my $link = dDa::eAa($dYa, $_);
		$count++;
		if($shared->{fetched}->{$link}) {
			#DEBUG "Skip fected URL $_\n";
			next;
		}
 		my ($service, $host, $page, $oE) = &dDa::dKa($link);
		if (($host !~ $eQa) && ($eQa !~ $host))  {
			#DEBUG "Skip remote URL $link\n";
			next;
		}
		dGa($shared,$link, $url, $level +  1); 
	}
}

1;
1;
# end of eCa::dGa
