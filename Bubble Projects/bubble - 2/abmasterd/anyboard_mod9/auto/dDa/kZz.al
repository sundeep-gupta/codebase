# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 160 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/kZz.al)"
sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
	last if not $_;
 $_ =~ s#^/?##;
 $root =~ s#/*$#/#;
 $root .= $_; 
 }
 return $root;
}

# end of dDa::kZz
1;
