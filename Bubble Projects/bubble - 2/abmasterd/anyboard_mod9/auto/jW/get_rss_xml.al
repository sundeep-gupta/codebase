# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8431 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/get_rss_xml.al)"
sub get_rss_xml {
	my ($self, $input) = @_;
	$self->cR();
	my $rssfile = $self->nDz('rss');
	my $sday = $input->{sday};
	my $eday = $input->{eday};
	my $fN = $input->{fN};
	my $rssfile2 = "$rssfile-$sday-$eday.xml";
	my $mtime = (stat($rssfile2))[9];
	my $rgen= (time() - $mtime) > 120;
	my $iN = $sday > 0? time() - 3600*24*$sday: 0;
	my $etime =  time() - 3600*24*$eday;
	local *F;
	if($rgen) {
 	my $lck = jPa->new($rssfile, jPa::LOCK_EX());
		my $str = $self->gen_rss_xml({iN=>$iN, etime=>$etime, fN=>$fN});
		open F, ">$rssfile2" or abmain::error('sys', "$rssfile2:$!");
		print F $str;
		close F;
	}
	open F, "<$rssfile2";
	print "Content-type: text/xml\n\n";
	print <F>;
	close F;
}

# end of jW::get_rss_xml
1;
