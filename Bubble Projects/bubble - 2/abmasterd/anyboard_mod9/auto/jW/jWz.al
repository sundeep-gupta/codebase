# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2026 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jWz.al)"
sub jWz {
 my($self, $pgno, $ofp) = @_;
 $pgno ="" if not $pgno;
 return $self->{eD} .  $pgno.$ofp.$self->dIz();
}

# end of jW::jWz
1;
