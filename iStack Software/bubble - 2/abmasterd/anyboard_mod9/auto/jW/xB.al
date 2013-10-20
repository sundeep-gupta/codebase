# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9825 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/xB.al)"
sub xB{
 my ($self, $cG, $data)=@_;
 my $cA = $self->gN($cG);
 open(kE, "$post_filter>$cA" ) || abmain::error($!. ": $cA");
 print kE $data;
	 close kE;
}

# end of jW::xB
1;
