# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 291 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/rA.al)"
sub rA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::edit_file_form, $self->{cgi});
	my $fn = $input->{filename};
	$af->dNa('filename', $fn);
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
 if($fn ne "") {
		my $p = $docd->gCaA($fn);
		local *F;
		local $/ =undef;
		open F, "<$p";
		my $d = <F>;
		close F;
		$af->dNa('filecontent', $d);
		$af->dNa('filepermission', sVa::get_unix_file_perm($p));
	}
	$af->gSaA('filepermission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

# end of eUaA::rA
1;
