# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 542 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fSaA.al)"
sub fSaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	my $path = $input->{oldfilename};
	if($input->{filepermission} eq "") {
		$input->{filepermission} ="0644";
	}
	my $free = $self->getFreeSpace();
	if(not $docd->tZa($path, $input->{file1}->[1], oct($input->{filepermission}), $free)) {
		sVa::error("sys", "$path, $!");
	}
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();

	print "File replaced";
	print qq(<center>$sVa::close_btn</center>);
 my $kQz=$docd->{kQz};
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);

 	print $self->{footer};
}

# end of eUaA::fSaA
1;
