# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 350 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/deletesubdir.al)"
sub deletesubdir{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	if(not $input->{confirm}) {
		sVa::error("inval", "You must check the confirmation box");
	}
	my $e = $docd->remove_subdir($input->{filename});
	if($e) {
		$input->{msg}="<h1>Folder deleted ($input->{filename})</h1>";
	}else {
		$input->{msg} = $docd->{_error} .qq!<br>!;
	}
	$self->fVaA($input);
}

# end of eUaA::deletesubdir
1;
