# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2460 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yO.al)"
sub yO{
 my ($self, $cG) = @_;
 my $aline;
 {
 	my $aB = $self->gN($cG);
	local $/;
	undef $/;
 	open pK, "<$aB" or return "<!--missing data file for message $cG-->";
	$aline = <pK>;
 	close pK;
 }   
 return $aline;
}

# end of jW::yO
1;
