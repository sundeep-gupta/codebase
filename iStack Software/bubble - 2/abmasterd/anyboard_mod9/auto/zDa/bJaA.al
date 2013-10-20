# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 322 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bJaA.al)"
sub bJaA{
 my $t = shift;
 $t = time() if not $t;
 my @tms = localtime($t);
 my $mon_year=join("", sprintf("%02d", $tms[4]+1), 1900+$tms[5]);
 my $day = $tms[3];
 return wantarray? ($mon_year, $day) : $mon_year;
}

# end of zDa::bJaA
1;
