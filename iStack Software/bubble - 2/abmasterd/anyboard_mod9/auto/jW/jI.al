# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7328 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jI.al)"
sub jI {
my ($self, $jF, $gA, $cmd_desc, $iB, $yG, $yQ, $zC, $cookstr) = @_;
my $gO = $self->{name};
my $cgi        = $self->{cgi}; 
my $fC    = $self->fC();

my $t = time();

$self->{__cfg_header} = $self->{other_header};
$self->{__cfg_footer} = $self->{other_footer};
$self->eMaA( [qw(__cfg_header __cfg_footer _banner_html)]);

sVa::gYaA "Content-type: text/html\n";
if($cookstr) {
	print $cookstr, "\n";
}else {

	print "Set-Cookie: test_cook=a$t; path=/\n\n";
}

my @dR=($self->{cbgcolor0}, $self->{cbgcolor1});
#my @dR=("#ffffff", "#b0e1e5");

# <small>@{[$self->dOz]}</small>

print <<hN;
<html><head><title>$cmd_desc ($gO)</title>\n$self->{sAz}
$self->{__cfg_header}
<script>
function ab_preview2(ele) {
 var str=ele.value;
 nwin = window.open("", "code_", "width=640,height=400,menubar=no,location=no,toolbar=no,scrollbars=yes,status=no,resizable=yes");
 nwin.document.write("<html><body>"+str);
 nwin.document.write("</body></html>");
 nwin.document.close();
	nwin.focus();
}

//-->
</script>
$abmain::mC
$self->{_banner_html}
<center><h4 class="AB-form-prompt">$cmd_desc</h4></center>
hN

print abmain::oWa();

my $method = $self->{xWz} || 'POST';
my $reset_alert=qq[onReset= "return confirm('Really want to reset the form?'); "];

if($iB) {
 print qq(<form action="$cgi" name="$gA" method="$method" target=cwin $reset_alert>);
}else {

 print qq(<form action="$cgi" name="$gA" method="$method" $reset_alert>);
}

print @{[$abmain::cYa]};
$self->{forum_header}=undef;
$self->{forum_footer}=undef;
$self->{forum_layout}=undef;
$self->{other_header}=undef;
$self->{other_footer}=undef;
$self->{msg_footer}=undef;
$self->{msg_header}=undef;

print qq(<table cellspacing="0" border="0" cellpadding="0" align="center" width="90%" bgcolor="#000000"><tr><td>\n);
print qq(<DIV class="ABCONFLIST">\n);
print qq(<table border="0" cellspacing="1" cellpadding="2" align="center" width="100%">);

my $plc=qq(class="PFTDL");
my $prc=qq(class="PFTDR");

my $hiddenstr="";
my ($p, $k, $i);
my @fields=();
foreach (@{$jF}) {
$p = $_;
next if not $p;
$k = $p->[0]; 
next if not $k; ##-- set key to undef form skipping
next if($p->[1] eq 'fixed'); ##-- not modifiable

if($p->[1] eq 'head') {
 my $h = $p->[2];
 print qq(<tr align="left" bgcolor="$self->{cfg_head_bg}"><td colspan="2">\&nbsp;<br/><font $self->{cfg_head_font}><b>$h</b></font></td></tr>);
 next;
}

my ($t, $a, $d) = ($p->[1], $p->[2], $p->[3]);
my $v;
if(defined($zC->{$k})) {
 $v = $zC->{$k};
}elsif (defined($p->[5])) {

 $v = $p->[5];
}else {

 if($self->{$k} ne "") {
 	$v = $self->{$k};
 }else {
 $v =  $p->[6];
 }
}

$v="" if $t eq 'password';

if($t eq 'hidden') {
 $hiddenstr .= qq(<input type="hidden" name="$k" value="$v">);
 next;
}

my $col = $dR[$i%2];
my $oe = (0 == $i%2) ? 'E': 'O';
$i++;
my $ot = $t;
print qq(<tr );
print qq(bgcolor=$col) if $col;
print qq(><td width="35%" ${plc}$oe" valign="top">$d</td><td ${prc}$oe");
if($t eq 'color') {
	print qq( bgcolor="$v" id="cfg_color_$k");
 $t = "text";
} 

$t= "text" if($t eq 'icon');
$t= "text" if($t eq 'perlre');
print qq(>);

my $cVaA = ($abmain::agent =~ /MSIE\s*(5|6)/i) && ($abmain::agent =~ /win/i) && ($abmain::agent !~ /opera/i);
if($t eq 'const') {
 print "<b>$v</b>";
}elsif($t eq "htmltext") {

 print qq(<textarea $a name="$k">$v</textarea><br/>);
 if(not $cVaA) {
 	print abmain::cUz("javascript:ab_preview2(document.forms.$gA.$k)", "Preview");
 }else {
 	print sVa::hFa("$self->{cgi}?htmlviewcmd=view;xZa=$k", "<small>Preview</small>");
 }
	
}elsif($t eq "textarea") {

 print qq(<textarea $a name="$k">$v</textarea>);
}elsif($t eq "select") {

 print &$a($k, $v);
}elsif($t eq "date") {

 print abmain::wCz($k, $v); 
}else {

 	print qq(<input type="$t" $a name="$k");
	if( $t eq "checkbox" ) {
 		print " checked" if $v;
	} else{
 	       print qq( value='$v');
	}
	if($ot eq 'color') {
 print qq! onblur="(document.all? document.all.cfg_color_$k: document.getElementById('cfg_color_$k')).style.backgroundColor=this.value;"!;
	}
 print ">";
}

	print "\&nbsp;$v" if $p->[1] eq 'icon';
	print "\&nbsp;Warning: pattern seems incorrect " if $v && $p->[1] eq 'perlre' && 'the quick brown fox' =~ /$v/;
	print "</td></tr>\n";
	push @fields, $k unless $t eq 'const';
}

my $sU="return true;";
if($iB) {
#   $sU="hB('cwin'); return true;";
 $sU="return true;";
}

my   $fs = join("-", @fields);
$self->{cfg_bot_bg} = "#cccccc" if not $self->{cfg_bot_bg};
print qq(
<tr bgcolor="$self->{cfg_bot_bg}"><td>
 $hiddenstr
 <input type="hidden" name="cmd" value="$gA">
 <input type="hidden" name="by" value="$yQ">
 <input type="hidden" name="xcfgfs" value="$fs">
 <input type=reset value="$self->{qT}" class="buttonstyle">  </td>
<td> <input type="submit" value="$self->{rI}" class="buttonstyle">  </td>
</tr>
) if !$yG;

print qq(
</table>
</DIV>
</td></tr></table>
</form>
<p style="margin-right: 5%; align=right">
<center>@{[$self->dOz]}</center>
</p>
$self->{__cfg_footer}
);
}

# end of jW::jI
1;
