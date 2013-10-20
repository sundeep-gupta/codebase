# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 2853 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/kZz.al)"
sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
 next if $_ eq "";
 $root =~ s#/*$#/# if not $_  =~ /^\?/;
 $_ =~ s#^/*##;
 $root .= $_; 
 }
 return $root;
}

# end of abmain::kZz
1;
