# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 454 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fBaA.al)"
sub fBaA {
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 my $kQz=$docd->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::edit_file_form, $self->{cgi});
	$af->aAa($input);
	if($af->{filenocr}) {
		$af->{filecontent} =~ s/\r//g;
	}
	my $free = $self->getFreeSpace();
	my $e = $docd->tZa($af->{filename}, $af->{filecontent}, oct($af->{filepermission}), $free);
	if(not $e) {
		print "Error: $docd->{_error}";
	}else{
		print $af->form(1);
	}
	print qq(<center>$sVa::close_btn</center>);
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);
 	print $self->{footer};
}

# end of eUaA::fBaA
1;
