# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4204 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wGz.al)"
sub wGz{
 my $self=shift;
 my $menusrc=$self->{cgi}. "?cmd=menu.js";
 return qq(<script LANGUAGE="JavaScript1.2" SRC="$menusrc"></script>);
 return qq(<script LANGUAGE="JavaScript1.2" SRC="http://eagle.netbula-lan.com/~yue/menu.js"></script>);
}

# end of jW::wGz
1;
