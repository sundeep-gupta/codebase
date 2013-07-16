# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1275 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/glTabCode.al)"
sub glTabCode{
 my $mode = shift;
 if($mode eq 'list') {
		return sVa::qAa(@_);
 }else {
		return sVa::gridTabCode(@_);
 }
}

# end of sVa::glTabCode
1;
