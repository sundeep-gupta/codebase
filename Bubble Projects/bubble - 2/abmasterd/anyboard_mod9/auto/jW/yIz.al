# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1244 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yIz.al)"
sub yIz {
 my($self, $vf, @jS) = @_;
 for my $c (@jS) {
 $self->{$c} = $vf->{$c} if $vf->{$c} ne "";
 }
}

# end of jW::yIz
1;
