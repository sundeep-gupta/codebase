# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2600 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/nXa.al)"
sub nXa{
 my $name = shift;
 if(defined $name) {
 	$abmain::ab_id1 = $abmain::ab_id0;
 	$abmain::ab_id0 = $name;
 }
 $abmain::ab_track= join('.', time(), abmain::bW($ENV{'REMOTE_ADDR'})) if not $abmain::ab_track;
 return join('<', $abmain::ab_id0, $abmain::ab_id1, $abmain::ab_track);
}

# end of abmain::nXa
1;
