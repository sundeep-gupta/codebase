# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8276 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sLz.al)"
sub sLz{
 my $self=shift;
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html>
<head><title>$self->{name} chat room</title></head>
<frameset rows="*, $self->{sFz}">
 <frameset cols="*, $self->{chat_usr_width}">
	<frame name="sXz" src="@{[$self->sPz()]}">
 <frame name="chat_usr" src="$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Chat;where=Chat;refresh=60">
 </frameset>
<frame name="sYz" src="$self->{cgi}?@{[$abmain::cZa]}cmd=sQz"></frameset></html>
 ); 
} 

# end of jW::sLz
1;
