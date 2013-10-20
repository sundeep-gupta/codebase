# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1889 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wNz.al)"
sub wNz {
 my ($self, $ok, $kQz, $file) = @_;
 my $gDz = $ok? "OK": "<font color=red>FAIL</font>";
 $gDz = $ok if $self->{yLz} eq 'POST';
 my $cook = $abmain::ab_track;
 if ($self->{yLz} eq 'POST') {
	$gDz = $ok;
 $cook .= '@'.$abmain::agent;
 }
 chmod 0600, $file;
 $kQz = $abmain::ab_id0 if not $kQz;
 $bYaA->new($file, {schema=>"AbLoginLog", index=>2, paths=>$self->zOa('login') })->iSa(
 [$kQz, $gDz, time(), abmain::lWz(), $cook]
 );
 chmod 0000, $file;
}

# end of jW::wNz
1;
