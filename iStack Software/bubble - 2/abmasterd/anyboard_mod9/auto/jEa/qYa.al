# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 145 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/qYa.al)"
sub qYa{
 my ($delf, $ids, $opts) =@_;
 return if not @$ids;
 local *TBF;
 open TBF, ">>$delf" or sVa::error("sys", $opts->{kG}. "($!: $delf)");
 print TBF join ("\n", @$ids), "\n";
 close TBF;
}

# end of jEa::qYa
1;
