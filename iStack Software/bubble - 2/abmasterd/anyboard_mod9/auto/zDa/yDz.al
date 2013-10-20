# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 221 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/yDz.al)"
sub yDz{
	my ($str, $len) = @_;
 my $abs = substr($str, 0, $len);
 $abs =~ s/\s+\S+$//;
	$abs .= "..." if $len < length($str);
 return $abs;
}

# end of zDa::yDz
1;
