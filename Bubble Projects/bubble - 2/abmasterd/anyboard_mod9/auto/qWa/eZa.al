# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package qWa;

#line 238 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/qWa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/qWa/eZa.al)"
sub eZa{
 my($self) = @_;
	my $mf = new aLa('idx', \@qWa::sitesearch_cfgs, $self->{cgi});
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
	$mf->yQa('GET');
 print $mf->form();
 print "</body></html>";
}

# end of qWa::eZa
1;
