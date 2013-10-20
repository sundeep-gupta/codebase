# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/fRaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package fRaA;

#line 26 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/fRaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/fRaA/eTaA.al)"
sub eTaA {
	my ($self, $input) = @_;
	my $xZa = $input->{xZa};
	
my $dAaA="";
my $cWaA="";
my $jT = $self->{cgi};

my $cVaA = ($self->{agent} =~ /MSIE\s*(5|6)/i) && ($self->{agent} =~ /win/i) && ($self->{agent} !~ /opera/i);
my $cSaA = $input->{cSaA};
$cVaA = 0 if $cSaA;

my $cUaA = ($self->{agent} =~ /MSIE\s+3/);
$dAaA = "this.message.fancy='message';" if $cVaA;
unless ($cUaA) {
$cWaA = qq@
 onSubmit= "$dAaA return kH?eW(this):true; "
 onReset= "return confirm('Really want to reset the form?'); "
@;
}

my $str=qq(\n<script src="$jT?cmd=xQa&xZa=message"></script>\n) if $cVaA;
 $str .= qq(
<style type="text/css">
.xAa { cursor: hand;}
</style>
);
	
$str .= <<"EOF_JS_JS";
 <script language="JavaScript1.1">
<!--
kH = true;
function eW(f) {
for(var i=0; i< f.elements.length; i++) {
 var e = f.elements[i];
 if(e.type=="text" || e.type=="textarea") {
	if(e.fancy) {
		oAa(e.fancy);
	}
 if(e.required && (e.value == null || e.value =="")){
 alert(e.name+" field is required");
 return false;
 	}
 }
}

return true;
}

function cp_val() {
	wVa('message');
	copyValueFrom(opener.document.all.$xZa, 'message');
}

function copyback() {
	copyValueTo('message', opener.document.all.$xZa);
	opener.focus();
	window.close();
}

//-->
</script>

EOF_JS_JS

	my $cYaA =qq(<textarea name="message" cols=70 rows=12 class="inputfields" wrap=soft></TEXTAREA>);
	$cYaA = sVa::xOa('message', "", "#6699cc", 16*24, $self->{icon_loc} ) if $cVaA;
	
	print "Content-type: text/html\n\n";
	print "<html>";
	if($xZa ne "") {
		print qq(<body>);
	}else {
		print qq(<body>);
	}
	print $str;
 	print qq!<form name="aecompose" action="javascript:copyback()" $cWaA>!;
	print qq(<table width=95%  border=0 align=center cellspacing=0 cellpadding=1 bordercolorlightcolor="#000000" bordercolordark="#ffffff>");
	print qq(<tr><td bgcolor="#6699cc">$cYaA</td></tr>);
	print qq(<tr><td align=center><input type=submit name=Send value="Copy HTML Code" class="buttonstyle"></td></tr>);
	print qq(</form>);
	print qq!<script>window.onload=cp_val;</script>!;
	print qq(</body></html>);
	
}

1;
1;
# end of fRaA::eTaA
