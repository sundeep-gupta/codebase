# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6491 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lO.al)"
sub lO {
 my ($self) = @_;
 my $cgi        = $self->{cgi}; 

 sVa::gYaA "Content-type: text/html\n\n";
 print qq(
 <html><title>Logon Forum Admin</title>
 <form action="$cgi" method="POST">
 @{[$abmain::cYa]}
 <input type="hidden" name="cmd" value="login">
 <table border="0"><th>Logon with UNIX login</th>
 <tr><td> \&nbsp;</td> </tr>
 <tr><td>User Name:</td><td><input type="text" name=uname size=16></td></tr>
 <tr><td>password:</td><td><input type="password" name=passwd size=16></td></tr>
 <tr><td align="center"><input type="submit" class="buttonstyle" name="Login" value="Login"></td><tr>
 </table>
 </form>
 </body>
 </html>
 );
}

# end of jW::lO
1;
