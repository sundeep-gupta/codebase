# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 840 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gOa.al)"
sub gOa{
 my ($self, $user, $global) = @_;
 abmain::error("miss", "No data supplied") if not $user; 
 abmain::gOa($global?$abmain::master_cfg_dir: $self->{eD}, $user);
}

# end of jW::gOa
1;
