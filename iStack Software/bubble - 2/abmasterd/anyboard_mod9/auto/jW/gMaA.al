# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7513 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gMaA.al)"
sub gMaA {
 my ($self) = @_;
 
 my $imgurl="$self->{cgi}?@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};

 return qq(
<form action="$abmain::jT" method="GET" style="display:inline">
<input type=hidden name="svp" value="$abmain::fvp">
<input type=hidden name="cmd" value="searchfs">
<table class="SEARCHFORM">
<tr><td><input type=text size=12 name=tK class="searchfield"></td><td><input align="middle" type=image alt="Go" name="Search" src="$imgurl" border="0"></td></tr></table></form>);
}

# end of jW::gMaA
1;
