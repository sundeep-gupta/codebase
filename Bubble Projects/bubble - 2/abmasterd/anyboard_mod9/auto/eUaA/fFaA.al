# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 424 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fFaA.al)"
sub fFaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 my $kQz=$docd->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::confirm_delfile_form, $self->{cgi});
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
	my $fn = $input->{filename};
	$af->dNa('filename', $fn);
	print $af->form();
 	print $self->{footer};
}

# end of eUaA::fFaA
1;
