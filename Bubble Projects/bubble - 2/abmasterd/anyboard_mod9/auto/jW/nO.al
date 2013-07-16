# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5458 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nO.al)"
sub nO {

my ($self, $aK,  $par, $gD, $fE, $ofrom, $oto, $ex_upload_cnt, $privusr, $xE, $attachfid) = @_;
my $gO = $self->{name};
my $cgi        = $self->{cgi}; 
my $fC        = $self->fC();
my $lhtml;
my $req_body = $self->{rR}? "false": "true";

my $gM = $abmain::ab_id0;
$gM = $self->{fTz}->{name} || $ENV{REMOTE_USER} if not $gM;
my $mf= undef;
$mf=$self->gXa($gM) if $gM ne "";

my $use_fancy = 0 && $self->{try_wysiwyg} && $mf->{fancyhtml};

if($mf && not $mf->{fancyhtml}) {
	$self->{fTz}->{use_fancy} = 'no';
}

my $cUaA = ($abmain::agent =~ /MSIE\s+3/);
my $cVaA = ($abmain::agent =~ /MSIE\s*(5|6)/i) && ($abmain::agent =~ /win/i) && ($abmain::agent !~ /opera/i);
$cVaA = 0 if not $use_fancy;
$cVaA = 0 if $abmain::gJ{plainform};

my $fbg;
$fbg  = qq(bgcolor="$self->{xM}") if $self->{xM};

$lhtml = <<fK if not $cUaA;
<script language="javascript">
<!--
var kH=false;
//-->
</script>

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

if(f.name.value.length > $self->{sO}) {
 alert("Name too long");
 return false;
}

if(f.subject.value.length > $self->{qJ} ) {
 alert("subject must be less than $self->{qJ} characters");
 return false;
}

if(f.body.value.length > $self->{qK} ) {
 alert("Message body must be less than $self->{qK} characters");
 return false;
}

if(f.iSz && f.iSz.checked) {
	return confirm("Are you sure you want to send email to all users?");
}

return true;
}

function xLa(form) {
 var str=form.body.value;
 var tit = form.subject.value; 
 nwin = window.open("", "code_", "width=640,height=400,menubar=no,location=no,toolbar=no,scrollbars=yes,status=no,resizable=yes");
 nwin.document.write("<html><body><h1>"+tit+"</h1>"+str);
 if(form.img.value.length>10) 
 	nwin.document.write('<br/><img src="'+form.img.value+'"><br/>');
 if(form.url.value.length>10) {
 var utit = form.url_title.value;
 if(utit==null||utit=="") utit=form.url.value;
 	nwin.document.write('<br/>$self->{qEz} <a href="'+form.url.value+'">'+utit+"</a>");
 }
 nwin.document.write("</body></html>");
 nwin.document.close();
}

//-->
</script>
fK

my $nlim="";
if($self->{rUz} && $self->{sO}){
 $nlim = qq(maxlength="$self->{sO}");
}

my $slim="";
if($self->{rUz} && $self->{qJ}){
 $slim = qq(maxlength="$self->{qJ}");
}

my $r_name = $self->{fTz}->{name};
my $is_adm = $r_name eq $self->{admin} || $self->{moders}->{$r_name};
my $enct;
$enct = qq(ENCTYPE="multipart/form-data") if $self->{take_file} && ($is_adm || not $self->{oWz}); 
my $form_start = qq(<form name="postmsg" $enct method="POST" action="$cgi");

my $dAaA="";
$dAaA = "this.body.fancy='body';" if $cVaA;
unless ($cUaA) {
$form_start .= qq@
 onSubmit= "this.name.required=true; this.subject.required = true; this.body.required = $req_body; $dAaA return kH?eW(this):true; "
 onReset= "return confirm('Really want to reset the form?'); "
@;
}

$form_start .= qq(>
 <input type="hidden" name="abc" value="hV">
 <input type="hidden" name="attachfid" value="$attachfid">
 <input type="hidden" name="cmd" value="sA">
 				@{[$abmain::cYa]}
)
;

$par = "0" if !$par;
$aK = "0" if !$aK;

my $mes = $par? $self->{uI} : $self->{uH}; 

if($attachfid ne "") {
	$mes .= " (step 1) ";

}

$form_start .= qq(
 <input type="hidden" name="fu" value="$par">
 <input type="hidden" name="zu" value="$aK">
 ) if $par >0;

$form_start .= qq(<input type="hidden" name="scat" value="$self->{gPa}">) if $self->{gPa} ne "";
my $def_subj;
my ($sS, $password_line,  $fJa);
my $fcol = $self->{msg_form_cols};
my $ncol = $fcol;
my $ncol2 = int ($fcol-12)/2;
my $sp ='&nbsp;';
my $sp3 ='&nbsp;' x 3;
if($par>0) {
 my $jK = "$self->{sJ}:";
 $def_subj = "$jK $gD" unless $self->{no_carry_subj};
 $def_subj =~ s/($jK )+/$jK /g if $self->{qNz};
}

if($self->{fWz} || $self->{http_auth_only}) {
 my $cn = $self->{fTz}->{name} || $ENV{REMOTE_USER};
 $sS = "<b>$cn</b>";
 $sS .= qq(<input type="hidden" name="name" value="$cn">);
} else {

 if($self->{gBz} || $self->{gAz}) {
 $sS = qq@
	  <input type="text" name="name" $nlim size="$ncol2" value="$gM">
 @;
 $sS .= qq!\&nbsp;\&nbsp;<a href="$cgi?@{[$abmain::cZa]}cmd=yV">$self->{sK}</a>! if $self->{gBz};
	  $password_line = qq(<input type="password" name="passwd" size="$ncol2">);
 }else {
 $sS = qq(<input type="text" name="name" value="$gM" size="$ncol">$sp);
 }
}

if($self->{kWz}) {
 $fJa = "";
 if($self->{select_priv} && not $par) {
		my @usrs = $self->sKa();
		my @es;
		my $i=0;
		for (@usrs) { 
			$i ++;
			my $chked;
			if($par>0 && lc($_) eq lc($ofrom)) {
				$chked ="selected";
 }elsif (lc($_) eq lc($privusr) ) {
				$chked ="selected";
 }
			push @es, qq@<input type="checkbox" name="to" $chked value="$_" onclick="(document.all? document.all.priv$i: document.getElementById('priv$i')).style.backgroundColor=(this.checked?'#99ccff':'');"><span id="priv$i">$_</span>@;
		}
		$fJa = sVa::qAa( vals=>\@es, ncol=>4, width=>"100%");
 }else {
 	if($par >0) {
 	$fJa = qq(<input type="text" name="to" value="$ofrom">) if $ofrom && $oto;
 	}else {
 	   $fJa = qq(<input type="text" name="to" size="$ncol" value="$privusr">);
 	}
 }
}

my $plc=qq(class="PFTDL");
my $prc=qq(class="PFTDR");
my $dXz="";
if($par >0 && $self->{dWz}) {
 	$dXz =qq(<input type="checkbox" name="dWz" value="1"><small>$self->{hRz}</small>);
 $dXz .= "\&nbsp;" x 4;
}

if($par > 0) {
	$dXz .=qq(<input type="hidden" name="oauthor" value="$ofrom">);
}

if($self->{kWz}) {
 if($par >0) {
		if($ofrom && not $oto) {
			if($xE & $jW::FTAKPRIVO) {
				$dXz .=qq(<input type="hidden" name="priv_reply" value="$ofrom"> Your reply will be private<br/>); 
 }else {
				$dXz .=qq(<input type="checkbox" name="priv_reply" value="$ofrom"> $self->{priv_reply_word} ); 
 }
 }
		$dXz .= "\&nbsp;" x 2;
 }
 $dXz .= qq(<input type="checkbox" name="take_priv_only" value="1"><small>$self->{priv_reply_only_word}</small>) if not $oto; 
 $dXz .= "\&nbsp;" x 2;
}

if($self->{dUz}) {
 $dXz .=qq(<input type="checkbox" name="dUz" value="1"><small>$self->{hSz}</small>);
 $dXz .= "\&nbsp;" x 4;
}

if($self->{allow_no_reply}) {
 $dXz .=qq(<input type="checkbox" name="allow_no_reply" value="1"><small>$self->{hTz}</small>);
}

$dXz .= "<p>" if $dXz;
if($self->{hBz} && $par >0) {
 $fE =~ s/<br ab>//gi;
 $fE =~ s/<p ab>/\n\n/gi;
 $fE =~ s/^/:=/gm;
}else {

 $fE ="";
}

$fJa = qq#<tr $fbg><td $plc>$sp$self->{to_word}</td><td $prc>$fJa</td></tr># if $fJa;
$password_line = qq#<tr $fbg><td $plc>$sp$self->{rW}</td><td $prc>$password_line</td></tr># if $password_line;

my $lCz="";
if($self->{allow_mood}) {
 $lCz ='&nbsp;&nbsp;';
 for(@abmain::lAz) {
 next if $_->[1] ne 'icon';
 next if not $self->{$_->[0]};
 $lCz .= qq(<input type="radio" name="mood" value="$_->[0]">$self->{$_->[0]}\&nbsp;\&nbsp;);
 }
 $lCz .= qq(\&nbsp;\&nbsp;<input type="radio" name="mood" value="">);
 $lCz = qq(<tr $fbg><td $plc>$sp$self->{mood_word}</td><td $prc>$lCz</td></tr>);
}

my $sub_line;
if($self->{oCz} && $par >0) {
 $self->{nJz} = $def_subj;
}

if(not $self->{nJz}) {
 $sub_line = qq!
 <tr $fbg><td $plc>$sp$self->{rN}</td>
	<td $prc><input type="text" name="subject" value="$def_subj" $slim size="$ncol">$sp</td>
 </tr>!;
}else {

 $sub_line = qq!<tr $fbg><td $plc>$sp$self->{rN}</td><td $prc><input type="hidden" name="subject" value="$self->{nJz}">$self->{nJz}</td></tr>!;
}

my $scat_line;
if($self->{allow_subcat} && $self->{catopt}=~ /=/ && $self->{gPa} eq "") {
	my $selmak;
 if($is_adm) {
	  $selmak = aLa::bYa(['scat', $self->{scat_use_radio}?'radio':'select',  join("\n", $self->{catopt}, $self->{hBa})]);
 }else {
	  $selmak = aLa::bYa(['scat', $self->{scat_use_radio}?'radio':'select',  $self->{catopt}]);
 }
 my $sels = $selmak->aYa();
	my $sp ='&nbsp;';
 $scat_line = qq!<tr $fbg><td $plc>$sp$self->{cat_word}</td><td $prc>$sels</td></tr>!;
}

my $html_ok="";

if(not $self->{qV}) {
 $html_ok = qq(<small>HTML tags are not allowed in message body.</small>);
}else {

 $html_ok = qq!<small>HTML tags allowed in message body.</small> \&nbsp; 
 <a href="javascript:xLa(document.forms.postmsg)"><small>Browser view</small></a>
 $sp3 <input type="checkbox" name="no_html" value="1"> <small>Display HTML as text.</small>!;
}

my $noti_line="";
$noti_line = qq(<tr $fbg><td $plc>$sp$self->{lJa}</td><td $prc>$dXz</td></tr>) if $dXz;
my $cYaA =qq(<textarea COLS="$fcol" ROWS=$self->{pform_rows} name="body" id="htmlbody" wrap=soft>$fE</textarea><br/>$html_ok);
$cYaA = sVa::xOa('body', $fE, $self->{xM}, $self->{pform_rows}*24) if $cVaA;

$lhtml .=qq(
<style type="text/css">
.xAa { cursor: hand;}
</style>
);

$lhtml .=qq(\n<script src="$self->{cgi}?cmd=xQa&xZa=body"></script>\n) if $cVaA;

my $email_line = "";
if($self->{take_email}) {
 $email_line = qq(
 <tr $fbg><td $plc>$sp$self->{qC}</td><td $prc> 
 <input type="text" name="email" value="@{[$self->{auto_fill}?$self->{fTz}->{email}:""]}" size="$ncol">$sp</td></tr>
 );

}

$lhtml .= <<iE;
<table bgcolor="#000000" width=$self->{pform_tb_width} cellpadding=0 cellspacing=0 border="0" align="center"><tr><td>
 <table $self->{pform_tb_attr} width=100% class="PostMessageForm">
$form_start
<tr bgcolor="$self->{cfg_head_bg}"><td><a href="javascript:history.go(-1)"><font $self->{cfg_head_font}>Back</font></a></td><td align="center"><font $self->{cfg_head_font}>$mes</font></td></tr> 
 <tr $fbg><td $plc><br/>$sp$self->{sH}</td><td $prc><br/>$sS</td> </tr>
 $password_line
 $fJa
 $email_line
 $sub_line
 $scat_line
 $lCz
 $noti_line
 <tr $fbg>
 <td valign=top $plc><br/>$sp$self->{rF}
 </td> 
 <td $prc>
	$cYaA
 </td>
 </tr>
iE

my $adm_pass = $is_adm && $self->{qCz};

if($self->{xL} || $adm_pass) {
$lhtml .= <<FORM_PART3;
 <tr $fbg>
	<td $plc>$sp$self->{rT}$self->{rO}</td>
	<td $prc>
	  <input type="text" name="url" size="$ncol" value="http://">
	</td>
 </tr>
 <tr $fbg>
	<td $plc>$sp$self->{rT}$self->{sD}</td>
	<td $prc>
	  <input type="text" name="url_title" size="$ncol">
	</td>
 </tr>
FORM_PART3

}

if($self->{xA} || $adm_pass) {
 $lhtml .= qq#<tr $fbg>
	<td $plc>$sp$self->{sC}$self->{rO}</td>
	<td $prc><input type="text" name="img" size="$ncol" value="http://"></td> </tr>
 #;
}

if($self->{take_sort_key} || $adm_pass) {
 my $k = time();
 $lhtml .= qq#<tr $fbg>
	<td $plc>$sp$self->{sortkey_word}</td>
	<td $prc><input type="text" name="sort_key" size="$ncol" value="$k"></td> </tr>
 #;

}

if($self->{take_key_words} || $adm_pass) {
 my $k = time();
 $lhtml .= qq#<tr $fbg>
	<td $plc>$sp$self->{keywords_word}</td>
	<td $prc><input type="text" name="key_words" size="$ncol" maxlength=128></td> </tr>
 #;

}

my $maxf = $abmain::max_upload_file_size/1024;
$maxf = $self->{upfile_max} if( ($self->{upfile_max} > 0 && $self->{upfile_max} < $maxf ) || not $maxf) ;
$maxf = "" if not $maxf;

$fcol = $ncol - 10;
if ($self->{take_file} && ($is_adm || not $self->{oWz})) {
 my $szlim="";
 if($maxf) {
	my $m = int($maxf *1024);
	$szlim= qq(<input type="hidden" name="MAX_FILE_SIZE" value="$m">);
 }
 $lhtml .= qq# <tr $fbg>
	<td $plc>$sp$self->{gQz} <small>(&lt;$maxf kb)</small></td>
	<td $prc>$szlim<input type=file name="attachment" size="$fcol"></td> </tr>
 #;
 my $i;
 for($i=1; $i<=$ex_upload_cnt; $i++) {
 	$lhtml .= qq# <tr $fbg>
	<td $plc>$sp$self->{gQz} <small>(&lt;$maxf kb)</small></td>
	<td $prc><input type=file name="attachment$i" size="$fcol"></td> </tr>
 #;
 }	
}

my $spellbtn="";
if($abmain::enable_speller) {
	$spellbtn= '&nbsp;'.abmain::mRa("document.forms['postmsg']", "body").'&nbsp;&nbsp;';
}

my $pbt= $attachfid eq ""? $self->{qN} : $self->{continue_button_word};

my $wP= qq#<input type="submit" class="buttonstyle" value="$pbt">\&nbsp;\&nbsp;\&nbsp$spellbtn#;
my $wK= qq#<input type=reset class=buttonstyle  value="$self->{qM}">#;
my $iRz="";
if($is_adm){
 $iRz=qq@\&nbsp;\&nbsp;<input type="checkbox" name="iSz" value="1"><small>$self->{iQz}</small>@;
 $iRz .=qq@\&nbsp;\&nbsp;<input type="checkbox" name="reportboss" value="1"><small>$self->{jAa}</small>@;
}

my $distline="";
if($self->{oXz} && ($is_adm || not $self->{nTz})) {
 $distline = qq(<tr $fbg><td colspan=2 align="center" $plc>
 <input type="checkbox" name="repredir" value="1">Redirect replying author to related link
 <input type="checkbox" name="repmailattach" value="1">Mail replying author with attachment file</td></tr>
 );
}

if(not ($self->{xS} && $self->{xH})) {
 $lhtml .= qq(
	<tr $fbg><td align="left" $plc>$sp $wK </td>
 <td align="center" $prc> $wP $iRz </td> </tr>);
}else {

 $lhtml .= qq(<tr $fbg> 
 <td align="left" $plc>$sp $wK </td>
 <td align="center" $prc>$wP
 $iRz
 <input type="checkbox" name="notify" value="1"><small>$self->{bTz}</small></td>
 </tr>);
}

$lhtml .= qq($distline </form></table></td></tr></table>); 
$lhtml .= qq(<script> document.forms[0].abc.value=navigator.appName;</script>) unless $cUaA;

return $lhtml;

}

# end of jW::nO
1;
