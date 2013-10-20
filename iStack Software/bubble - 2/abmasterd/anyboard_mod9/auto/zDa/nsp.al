# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 247 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/nsp.al)"
sub nsp{
 my $str = shift;
 $str =~ s/\s+/ /g;
 $str =~ s/^\s+//;
 $str =~ s/\s+$//;
 return $str;
}

# end of zDa::nsp
1;
