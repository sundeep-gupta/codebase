# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 999 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wG.al)"
sub wG {
 my ($self, $n, $gIz) = @_;
 $self->fZz($n);
 if($self->{gFz}->{lc($n)}->[5] != $gIz) {
 	 &abmain::error('inval', "Invalid activation information");
 }else {
 $self->aG(lc($n), @{$self->{gFz}->{lc($n)}}[0, 1, 3], 
 $self->{user_init_stat}||'A', 0, @{$self->{gFz}->{lc($n)}}[6..9]);
 }
}

# end of jW::wG
1;
