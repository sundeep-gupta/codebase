# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1770 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/rTa.al)"
sub rTa{
 my ($msg, $logo) = @_;
 return qq(
<table bgcolor="black" width="62%" border="0" align="center" height='300'>
<tr><td width="100%" bgcolor="#808080"> <font color="#FFFF00" size="2"><b>$logo</b></font></td></tr>
 <tr>
 <td height="250" align="center" bgcolor="#E6E6E6">
 <center>
 <table border="0" cellspacing="0" bgcolor="#808080">
 <tr>
 <td>
 <table border="0" width="100%" cellspacing="1" cellpadding="3">
 <tr>
 <td bgcolor="#DCDCDC" align="right"><center>
 $msg
 </center></td>
 </tr>
 </table>
 </td>
 </tr>
 </table>
 </center>
</td>
</tr>
<tr>
<td bgcolor="#808080" align="right">
<b><font size="2" color="#FFFF00">$logo</font></b>
</td>
</tr>
</table>
);

}

# end of sVa::rTa
1;
