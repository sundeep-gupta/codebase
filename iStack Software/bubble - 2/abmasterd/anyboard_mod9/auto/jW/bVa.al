# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3204 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bVa.al)"
sub bVa{
	my ($self, $gJz) = @_;
	my $mf = $self->gXa(lc($gJz));
	$mf->zQz($self->{cgi});
	my $mpic=qq(<img src="$self->{cgi}?@{[$abmain::cZa]}cmd=mimg;kQ=$gJz">);
	$mf->cBa($self->{cfg_head_bg}, $self->{cbgcolor0}, $self->{cbgcolor1}, $self->{cfg_bot_bg});
	$mf->zOz();
	$mf->aCa(['email', "text", "", "Email address"]);
	$mf->aCa(['userid', "text", "", "Email address"]);
	$self->{mplayout} =~ s/MEMBER_PIC/$mpic/g;
	$mf->bSa($self->{mplayout});
 print $mf->form(1, [qw(birthday birthmonth)]);

}

# end of jW::bVa
1;
