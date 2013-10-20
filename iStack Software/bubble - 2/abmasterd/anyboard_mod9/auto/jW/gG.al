# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6070 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gG.al)"
sub gG {
 my ($self, $cG, $is_root, $cSaA) = @_;
 my ($gD, $fE, $fT, $iH, $hF);

 $self->eMaA( [qw(other_header other_footer)]);

 my $sV;
 if($cG>0) {
	  $sV = $self->pO($cG);
	  abmain::error('inval', "Can not find message") unless $sV;
 ($gD, $fT, $iH, $hF)
 = ($sV->{wW}, $sV->{hC}, 
	         abmain::dU('S', $sV->{mM}, 'oP'),
 $self->jA($cG)
	        );
 $sV->load($self, 1);
	   $fE = $sV->{body}
 }

 my $cgi        = $self->{cgi}; 
 my $fC        = $self->fC();

 $fE =~ s/<br ab>//gi;
 $fE =~ s/<p ab>/\n\n/gi;
 $fE =~ s/^\n?<font[^>]*>//;
 $fE =~ s#</font>$##gi;

my $nameline;
my $uname = $self->{fTz}->{name};
my $isadm=   $self->{moders}->{$uname} || $uname eq $self->{admin} || $is_root;
my $nohtmlchk = ($sV->{xE} & $jW::FNOHTML)?' CHECKED':"";
my $plc=qq(class="PFTDL");
my $prc=qq(class="PFTDR");

my $mf= undef;
$mf=$self->gXa($uname) if $uname ne "";
my $use_fancy = 0 && $mf->{fancyhtml} && $self->{try_wysiwyg};

if($mf && not $mf->{fancyhtml}) {
	$self->{fTz}->{use_fancy} = 'no';
}

my $xstyle ;
$xstyle = abmain::htmla_code() if $self->{try_wysiwyg};

if($self->{fWz}) {
 if($uname ne $fT && not $isadm){
 sVa::hCaA "Location: $self->{cgi_full}?@{[$abmain::cZa]}cmd=kPz;pat=".abmain::wS($fT), "\n\n";
 }
 $nameline= qq(<tr><td $plc>$self->{sH}</td><td $prc><b>$self->{fTz}->{name}</b></td></tr>);
}else {

 $nameline=
 qq(<tr><td $plc>$self->{sH}</td><td $prc><input type="text" name="name" value="$fT"> 
\&nbsp;\&nbsp;$self->{rW}: <input type="password" name="passwd" value=""></td></tr>);
}

 abmain::error('inval', "The message is too old to be modified or deleted")
 if $self->{nCz}>0 && (time()-$sV->{mM}) > $self->{nCz}*3600 && !$isadm;

sVa::gYaA "Content-type: text/html\n\n";
print  qq( 
<html><head> <title>Modify $gD ($cG)</title>
$xstyle
$self->{sAz}
$self->{other_header}
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

if(f.subject.value.length > $self->{qJ} ) {
 alert("subject must be less than $self->{qJ} characters");
 return false;
}

if(f.body.value.length > $self->{qK} ) {
 alert("Message body must be less than $self->{qK} characters");
 return false;
}

return true;
}

//-->
</script>

<a href="$fC">$self->{name}</a>

<HR>
);

my $threadline="";

$threadline =qq(, <input type="checkbox" name="thread" value="1"> including followups) if $isadm;
my $scat_line;
if($self->{allow_subcat} && $self->{catopt}=~ /=/ && $sV->{aK} == $cG) {
 my $selmak;
 if($isadm) {
	  $selmak = aLa::bYa(['scat', $self->{scat_use_radio}?'radio':'select',  join("\n", $self->{catopt}, $self->{hBa})]);
 }else {
	  $selmak = aLa::bYa(['scat', $self->{scat_use_radio}?'radio':'select',  $self->{catopt}]);
 }
 my $sels = $selmak->aYa($sV->{scat});
	my $sp ='&nbsp;';
 $scat_line = qq!<tr><td $plc>$sp$self->{cat_word}</td><td $prc>$sels \&nbsp; check to change<input type="checkbox" name="changescat" value=1> </td></tr>!;
}

$gD =~ s/\"//g;

my $spellbtn="";
if($abmain::enable_speller) {
 print "\n", $abmain::spell_js, "\n";
	$spellbtn= '&nbsp;&nbsp;&nbsp;'.abmain::mRa("document.forms['postmsg']", "body");
}

my $dAaA="";
my $cWaA="";

my $cVaA = ($abmain::agent =~ /MSIE\s*(5|6)/i) && ($abmain::agent =~ /win/i);
$cVaA = 0 if not $use_fancy;
$cVaA = 0 if $cSaA;
my $cUaA = ($abmain::agent =~ /MSIE\s+3/);
$dAaA = "this.body.fancy='body';" if $cVaA;
unless ($cUaA) {
$cWaA = qq@
 onSubmit= "$dAaA return kH?eW(this):true; "
 onReset= "return confirm('Really want to reset the form?'); "
@;
}

my $sk ="";

if($self->{take_sort_key} || $isadm) {
 $sk = qq#<tr>
	<td $plc>$self->{sortkey_word}</td>
	<td $prc><input type="text" name="sort_key" size="20" value="$sV->{sort_key}"></td> </tr>
 #;
}

if($self->{take_key_words} || $isadm) {
 $sk .= qq#<tr>
	<td $plc>$self->{keywords_word}</td>
	<td $prc><input type="text" name="key_words" size="48" maxlength=255 value="$sV->{key_words}"></td> </tr>
 #;
}

my $inithtmla;
if($self->{try_wysiwyg} && $self->{fTz}->{use_fancy} ne 'no') {
	$inithtmla=qq!\n<script type="text/javascript" defer="1"> HTMLArea.replace("htmlbody");</script>\n!;
}

my $cYaA =qq(<textarea COLS="$self->{msg_form_cols}" ROWS=$self->{pform_rows} name="body" id="htmlbody" wrap=soft>$fE</textarea>);
$cYaA = sVa::xOa('body', $fE, $self->{xM}, $self->{pform_rows}*24) if $cVaA;

print qq(\n<script src="$self->{cgi}?cmd=xQa&xZa=body"></script>\n) if $cVaA;

my $cXaA = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$cG;cSaA=1", qq(<font $self->{cfg_head_font}>Modify message</font>) ) ;
print qq(
<form name="postmsg" action="$cgi" method="POST" $cWaA>
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="mW">
<input type="hidden" name="cG" value="$cG">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr} class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><th colspan=2 align="center"><font $self->{cfg_head_font}>$cXaA :  $gD </font></th></tr>
$nameline
<tr><td $plc>$self->{rN}</td><td $prc><input type="text" name="subject" size="$self->{msg_form_cols}" value="$gD"></td></tr>
$scat_line
<tr><td $plc><center>$self->{rF}</center></td>
<td $prc>
$cYaA
</center>
<br/><input type="checkbox" name="no_html" value="1"$nohtmlchk> <small>Display HTML as text.</small>
</td></tr>
<tr><td $plc>$self->{rT}$self->{rO}</td><td $prc> <input type="text" name="url" size="$self->{msg_form_cols}" value="$sV->{tP}"> </td> </tr>
<tr><td $plc>$self->{rT}$self->{sD}</td><td $prc><input type="text" name="url_title" size="$self->{msg_form_cols}" value="$sV->{rlink_title}"></td></tr>
$sk
<tr><td align="center" colspan="2">
 <input type="submit" class="buttonstyle" name="Modify" value="$self->{rI}">
 $spellbtn
 </td></tr>
</table>
</form>
$inithtmla
<br/>
<p>
)
if $self->{nCz} ==0 || (time()-$sV->{mM}) <$self->{nCz}*3600 || $isadm;

if($self->{bGz} || ($self->{allow_del_priv} && $sV->{to})) {
print qq(
<form action="$cgi" method="POST">
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="bFz">
<input type="hidden" name="cG" value="$cG">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr}  class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><td colspan=2><font $self->{cfg_head_font}>Delete message: <b>$gD</b></font></td></tr>
<tr><td>$nameline</td></tr>
<tr><td colspan=2>
<input type="submit" class="buttonstyle" name="Delete" value="Delete">\&nbsp;\&nbsp; message $cG
$threadline
</td></tr></table>
</form>
<p>
)
if $self->{nCz} eq  ""  || (time()-$sV->{mM}) <$self->{nCz}*3600 || $isadm;

}

if($is_root || $isadm ) {

 my $mf = new aLa('idx', \@abmain::iBa, $abmain::jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'));
 my $fcat = $self->pJa."="."Forum News\n";
 $mf->{newscatopt}= $fcat .$mf->{newscatopt} if $is_root || $abmain::forum_admin_roll;
 my $selmak = aLa::bYa(['newscat', 'select',  $mf->{newscatopt}]);
 my $selstr = $selmak->aYa();

print qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="oFa">
<input type="hidden" name="cG" value="$cG">
<input type="hidden" name="aK" value="$sV->{aK}">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr} class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><th colspan=2><font $self->{cfg_head_font}>Add message to rotating news</font></th></tr>
<tr><td $plc>Subject</td><td $prc><input type="text" size="64" name="subject" value="$gD"></td></tr>
<tr><td $plc>News category</td><td $prc>$selstr</td></tr>
<tr>
<td colspan="2">
<input type="submit" class="buttonstyle" name="add" value="Add it!">
</td></tr></table>
</form>
<p>
);

}

print qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="oSa">
<input type="hidden" name="user" value="$sV->{hC}">
<input type="hidden" name="pQ" value="$sV->{pQ}">
<input type="hidden" name="track" value="$sV->{track}">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr} class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><th colspan=2><font $self->{cfg_head_font}>Block The Author(by track only)</font></th></tr>
<tr><td $plc>Name</td><td $prc>$sV->{hC}</td></tr>
<tr><td $plc>Address</td><td $prc>$sV->{pQ}</td></tr>
<tr><td $plc>Track</td><td $prc>$sV->{track}</td></tr>
<tr><td colspan=2>
<input type="submit" class="buttonstyle" name="block" value="Block it!">
</td></tr></table>
</form>
<p>
) if $isadm || $is_root;

print qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="lPa">
<input type="hidden" name="bpos" value="1">
<input type="hidden" name="cG" value="$cG">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr} class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><th colspan=2>
<select name=action>
<option value="1"> Collapse 
<option value="0"> Expand
</select> 
<font $self->{cfg_head_font}><b>$gD</b></font></th></tr>
<tr><td colspan=2>
<input type="submit" class="buttonstyle" name="submit" value="Process message">\&nbsp;\&nbsp; $cG
</td></tr></table>
</form>
<p>

) if $self->{allow_usr_collapse};

#collpase/expand : first bit
#open /close: second bit

print qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="lLa">
<input type="hidden" name="cG" value="$cG">
<input type="hidden" name="bpos" value="2">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}"  $self->{pform_tb_attr} class="PostMessageForm">
<tr bgcolor="$self->{cfg_head_bg}"><th colspan=2>
<select name="action">
<option value="1"> Close 
<option value="0"> Open 
</select> 
<font $self->{cfg_head_font}>
 thread <b>$gD</b>
</font>
</th></tr>
<tr><td colspan=2>
<input type="submit" class="buttonstyle" name="submit" value="Process message">\&nbsp;\&nbsp; $cG
</td></tr></table>
</form>
<p>
) if ($sV->{aK} == $cG && $self->{allow_usr_collapse});
print qq(
$self->{other_footer}
);

}

# end of jW::gG
1;
