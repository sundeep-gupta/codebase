# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 317 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fNaA.al)"
sub fNaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("mkdir", \@eUaA::create_subdir_form, $self->{cgi});
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
	$af->gSaA('permission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

# end of eUaA::fNaA
1;
