# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 238 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aWaA.al)"
sub aWaA{
 my $where= shift;
 $where = lc($where);
 $where =~ s/where/_by/gi;
 $where =~ s/(\s|=|\?)+/_/g;
 $where =~ s/_+$//g;
 return $where;
}

# end of zDa::aWaA
1;
