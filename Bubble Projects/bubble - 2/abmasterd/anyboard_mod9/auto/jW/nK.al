# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6015 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nK.al)"
sub nK {
 my ($self) = @_;
 $self->eMaA([qw(other_header other_footer)]);
 my $cgi        = $self->{cgi}; 
 sVa::gYaA "Content-type: text/html\n";
 my $t=time;
 print "Set-Cookie: test_cook=a$t; path=/\n\n";
 print qq(
 <html><head>
$self->{sAz}
<meta http-equiv="Expires" content="0">
$self->{other_header}
 <table width=604 align="center" border="0" cellspacing=0 cellpadding=0 >
 <tr><td height=40>&nbsp;</td></tr>
 <tr><td>
 <form action="$cgi" METHOD="POST">
 				@{[$abmain::cYa]}
 <input type="hidden" name="cmd" value="login">
 <table width=604 align="center" border=1 cellspacing=0 cellpadding=6 >
 <tr><td>
 <table width=600 align="center" cellspacing=0 border =0 cellpadding="4" BGCOLOR="$self->{xM}">
 <tr rowspan=1><td colspan=2 align="center">
 <font size="+1" color=#000000><b>Administer $self->{name}</b></font>
	</td></tr>
 <tr ><td bgcolor="$self->{cfg_head_bg}" colspan=2 height=50 align="center">
 <font $self->{cfg_head_font} size="2"><b>Enter Admin Login Info</b></font>
	</td></tr>
 <tr><td height=20 colspan=2>&nbsp;</td></tr>
 <tr BGCOLOR="$self->{xM}"><td align="right">Name: </td><td align="left">
 <input type="text" name="fM" size="32" value="" ></td></tr>
 <tr BGCOLOR="$self->{xM}" align="center"><td align="right">Password: </td>
 <td align="left"><input type="password" name="oA" size="32" ></td></tr>
 <tr align="center"><td>&nbsp;</td><td height="40"> <input type="submit" class="buttonstyle" name=Send value=Login></td> 
 </tr>
 <tr><td valign=bottom align="left" width=200><small>If you have questions about AnyBoard(TM)
 , <a href="http://netbula.com/anyboard/">
	click this link for help.</a></small></td>
 <td valign=bottom align="right"><a href="http://netbula.com">Netbula LLC</td>
 </tr>
 </table>
 </td></tr>
 </table>
 </form>
 </td></tr>
 </table>
$self->{other_footer}
 );
}  

# end of jW::nK
1;
