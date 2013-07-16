# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 248 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/eWa.al)"
sub eWa{
	my ($self) = @_;
	sVa::error("dM", "Wrong login/password") if(not $self->eVa()) ;
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->load($self->{siteidxcfg});
 if(not $mf->{siteidx_url0}) {
		$mf->dNa('siteidx_url0', $self->{homeurl});
 }
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print $mf->form();
 print "</body></html>";
}

# end of qWa::eWa
1;
