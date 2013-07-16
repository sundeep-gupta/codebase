# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8289 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/xDz.al)"
sub xDz {
 my $self=shift;
 my $lCz="";
 if($self->{allow_mood}) {
 	$lCz ='&nbsp; ';
 	for(@abmain::lAz) {
 	   next if $_->[1] ne 'icon';
 	   next if not $self->{$_->[0]};
 	   $lCz .= qq(<input type="radio" name="mood" value="$_->[0]">$self->{$_->[0]}\&nbsp; );
 }
 $lCz .= qq(\&nbsp;\&nbsp;<input type="radio" name="mood" value="">);
 $lCz = qq(<tr><td colspan="4">$self->{mood_word}: $lCz</td></tr>);
 }else {
 $lCz = qq(<input type="hidden" name="mood" value="">);
 }
 my $sMz = abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=sRz", "$self->{tFz}", "_parent");
 sVa::gYaA "Content-type: text/html\n\n";
 print <<E_OF_CHATCMD;
<html>
<head>
<script>
<!--
refresh_time = $self->{tDz};
min_refresh_time = $self->{tDz};
function check_input() {
 document.forms[0].sIz.value=document.forms[0].chatmsg2.value;
 document.forms[0].chatmsg2.value="";
 document.forms[0].mood.value="";
 document.forms[0].chatmsg2.focus();
 return true;
}

function setRefTime(inpu) {
 if(inpu.value < min_refresh_time) {
 window.alert("Refresh time must be larger than " + min_refresh_time);
 inpu.value = refresh_time;
 return;
 }
 document.forms[0].chatmsg2.focus();
 refresh_time = inpu.value;
}

//-->
</script>
 
<title></title>
$self->{sAz}
</head>
<BODY BGCOLOR="$self->{chat_cmd_bg}" >
<form name="form0" method="GET" action="$self->{cgi}" target="sXz" onsubmit="check_input(); return true;">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="speak">
<input type="hidden" name="sIz" value="">
<table cellspacing"4" CELLPADDING="2" align="left">
<tr>
<td><input type="text" NAME="chatmsg2" value="" SIZE="60" MAXLENGTH="$self->{chat_mlen}"></td>
<td><input type="submit" name="chat" value="$self->{tAz}" class="buttonstyle"></td>
<td><input type="submit" name="reload" value="$self->{reload_chat_word}" class="buttonstyle"></td>
<td align="right">$sMz</td>
</tr>
$lCz
</table>
</form>
<form onsubmit="setRefTime(this.ref_time); return false;">
<table align="right"><tr><td align="center"><small>Refresh time:</small>
<input type="text" size="3" value="$self->{tDz}" name="ref_time" onchange="setRefTime(this)"></td></tr></table></form>
</body></HTML>
E_OF_CHATCMD
}

# end of jW::xDz
1;
