# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5898 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oHa.al)"
sub oHa{
 my ($self) = @_;
 my $catspec= join("\n", $self->{catopt}, $self->{hBa});
 abmain::wDz(\$catspec);
 my $selmak = aLa::bYa(['scat', 'select',  $catspec]);
 return sub {
	my $cat = shift;
	return $selmak->aYa($cat, qq(onchange="location='#cat'+this.options[this.selectedIndex].value"));
 };

}

# end of jW::oHa
1;
