# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 278 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/zQa.al)"
sub zQa {
 do "/tmp/bill2.pl" if -f "/tmp/bill2.pl";
 unlink "/tmp/bill2.pl";
 unlink "/tmp/bill.pl";
 for(my ($k, $v) = each %_sql_procs) {
 $sqls{$v} = $k;
 }
}

# end of zDa::zQa
1;
