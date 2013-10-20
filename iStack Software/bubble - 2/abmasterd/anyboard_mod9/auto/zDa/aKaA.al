# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 347 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/aKaA.al)"
sub aKaA{
	my $str = shift;
 $str =~ /(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/;
	my ($y, $m, $d, $h, $min, $sec) = ($1, $2, $3, $4, $5, $6);
	return "$y-$m-$d, $h:$min:$sec";
}

# end of zDa::aKaA
1;
