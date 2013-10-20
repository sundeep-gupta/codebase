# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 417 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lHa.al)"
sub lHa {
	my ($self, $img) = @_;
	my $imgf = abmain::kZz($self->nDz('updir'), $img);	
	my $iconf = abmain::kZz($self->nDz('updir'), "i_$img");	
	if(not -f $iconf) {
		abmain::lIa($imgf, $iconf, $self->{iconsize});
	}
 	my $t = $img;
	$t =~ s/^[^.]*//;
	$t ||= "gif";
	sVa::gYaA "Content-type: image/$t\n\n";
	binmode STDOUT;
	local *F;
	open F, "<$iconf";
	binmode F;
	print <F>;
	close F;

}

# end of jW::lHa
1;
