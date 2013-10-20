# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 331 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fYaA.al)"
sub fYaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	my $kQz = $self->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $e = $docd->eXaA($input->{subdir}, oct($input->{permission}) || 0755);
	if(not $e) {
		sVa::error('sys', $docd->{_error});
	}else {
		print "Folder created!";
	        my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
		print qq(<script>opener.location="$url";</script>);
		print qq(<center>$sVa::close_btn</center>);
	}
 	print $self->{footer};
}

# end of eUaA::fYaA
1;
