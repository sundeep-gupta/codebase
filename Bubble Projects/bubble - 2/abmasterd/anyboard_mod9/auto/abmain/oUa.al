# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2610 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oUa.al)"
sub oUa {
 my $is_exit= shift || "0";
 $bYaA->new(abmain::wTz('actlog'), {schema=>"AbActivityLog"})->iSa(
 [abmain::dU('LONG', time(), 'oP'), $ENV{REMOTE_ADDR}, $ENV{PATH_INFO}, $ENV{QUERY_STRING}, $$, $is_exit,  $ENV{PATH_INFO},  $abmain::ab_track, $abmain::ab_id0, $abmain::gJ{cmd}, $ENV{HTTP_REFERER}]
 );
}

# end of abmain::oUa
1;
