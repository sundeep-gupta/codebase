# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 313 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/vK.al)"
sub vK {
 my ($self, $iS, $gV)=@_;



 my $in = $self->{fI};

 if($iS->{aO}) {
 $in = ($iS->{dyna_out}?-1: 0);
 } elsif ($iS->{lJ} || $gV){
 $in = ($iS->{iDa})? -1 : $self->{aK};
 }
 return $in;
}

# end of lB::vK
1;
