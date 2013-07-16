# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 508 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/upload.al)"
sub upload{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	my $cPz;
	my $e;
	if($input->{filepermission} eq "") {
		$input->{filepermission} ="0644";
	}
	my $free = $self->getFreeSpace();
 	for(values %$input) {
		next if not ref($_) eq 'ARRAY';
		$cPz = $_->[0];
		$e = $docd->tZa($cPz, $_->[1], oct($input->{filepermission}), $free);
		$free -= length($_->[1]);
		last if not $e;
 	}

 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();

	if($e) {
		print "Files uploaded";
	}else {
		print $docd->{_error};
	}
	print qq(<center>$sVa::close_btn</center>);
 my $kQz=$docd->{kQz};
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);

 	print $self->{footer};
}

# end of eUaA::upload
1;
