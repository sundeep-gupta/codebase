# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 6593 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aU.al)"
sub aU {
my ($self) = @_;
my $gO = $self->{name};
my $cgi        = $self->{cgi}; 
my $fC    = $self->fC();
my $mtdf   = abmain::wTz('mtd');
my $mtdf2   = $self->nDz('mtd');
my @mtd;
$self->nSa();

if( (-f $mtdf ) && (stat($mtdf))[9] > time() - 3600*72) {
 open F, "$mtdf";
 @mtd = <F>;
 close F;
}

if(-f $mtdf2) {
 open F, "$mtdf2";
 push @mtd, <F>;
 close F;
}

my $eQ= qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
);

my $rIa=abmain::cUz("$cgi?@{[$abmain::cZa]}cmd=admlogout", $self->{logout_word});

sVa::gYaA "Content-type: text/html\n";
print abmain::bC($hW, "$cI:$aN", '/'), "\n";

print <<"EOS";
<html><head><title>Administer $gO</title>
<style type="text/css">
INPUT {font-size: 10pt}
SELECT {font-size: 10pt}
BODY   {font-size: 10pt}
TABLE.CFG TD {background-color: $self->{xM} }
TABLE.CFG TH {background-color: $self->{cfg_head_bg}; color: #ffffff}
</style>
$self->{sAz}
</head>
<body bgcolor="$self->{cZz}" onload="if(document.forms.abconf) document.forms.abconf.pat.value=''">
$abmain::mC
<center> <h2>Administer @{[$self->dOz]}</h2>
[$rIa]<br/>
EOS

if(@mtd) {
 print qq(<table align="center" width="90%" border=2 bgcolor="$self->{bIz}" cellpadding="4">);
 print qq(<tr><td align="center"><h2><font $self->{quote_txt_font}>Message of the day</font></h2>), @mtd, "</td></tr>";
 print "</table>";
}

my @moders = keys %{$self->{moders}};
my $mod_sel=abmain::zSz("mod_name", \@moders);

my ($fbg, $fhbg);
$fbg = qq(bgcolor="$self->{xM}") if $self->{xM};
$fhbg = qq(bgcolor="$self->{cfg_head_bg}") if $self->{cfg_head_bg};

if ($uT eq "adm") {

#fU sections 
print qq!
<table class="CFG" align="center" width="90%" bgcolor="#ffffff" cellpadding="4" cellspacing="1">
<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Forum configurations</font></th></tr>
<tr $fbg> 
<form name="abconf" action="$cgi" method="POST">
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<td>
<input type="hidden" name="cmd" value="fU">
<input type="submit" class="buttonstyle" name="fU" value="Configure">
[ <input type="checkbox" name="basic_opts" value=1 > show basic options only ]
(<small>Select one or more sections below, then click on the Configure button</small>)
[<a href="javascript:kEz(document.forms[0], 1)"><small>Check all</small></a>\&nbsp;\&nbsp;
<a href="javascript:kEz(document.forms[0], 0)"><small>Uncheck</small></a>]<br/>
</td><td>
<font color="red">Important Tip</font>:
<small>There are hundreds of configuration options, if you cannot find a configure option. You can search configuration keys and values here
( For example, enter the word "time" (without the quotes" will display all entries which relates to time; another example, you find some color was set to #cccccc by looking at the HTML code, you want to change it,
the eaasiest way is to search for "cccccc", and you will find the options have this value, then you can change it.
)
:</small><br/><input type="text" size=10 name="pat" value="" style="font-size:10pt"> <input type="submit" name="srch" value="Search for configuration options" style="font-size:10pt"> 
</td></tr><tr><td colspan=2>
<table class="CFG"2 width="100%" cellspacing="1" cellpadding="3" bgcolor="#999999">
<tr $fbg>
! ;

my $ncol=6;
my($k, $fU);
my $i=0;
foreach $k(@abmain::forum_cfg_list) {
 $fU = $abmain::eO{$k};
 next if not $fU;
 print "</tr><tr $fbg>" if ($i>0 && 0==$i%$ncol);
 print qq(<td id="cfg_chk_$k">), $fU->[0], 
 qq(<input type="checkbox" name="by" value="$k" 
 onclick="(document.all? document.all.cfg_chk_$k: document.getElementById('cfg_chk_$k')).style.backgroundColor=(this.checked?'#99ccff':'');"
 onblur="(document.all? document.all.cfg_chk_$k: document.getElementById('cfg_chk_$k')).style.backgroundColor=(this.checked?'#99ccff':'');"
 >
 </td>);
 $i++;
}; 

print '<td>&nbsp;</td>' x ($ncol-$i%$ncol) if $i%$ncol;
print qq( </tr></table><br/>);
print sVa::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=macdefs", "View macro definitions", "macdef");
print qq(</td></form></tr>);

#eof fU table

my $sel_str=abmain::cMz();
my @cfg_secs = map {$_->[0]} values %abmain::qJa;
unshift @cfg_secs, "All";
my $mHz = abmain::zSz("cfg_sec", \@cfg_secs);

print qq|
<tr $fbg>
<form action="$cgi" method="POST" target=nwin>
 				@{[$abmain::cYa]}
<td width="50%">
<input type="hidden" name="cmd" value="kHz">
<input type="submit" class="buttonstyle" name="fU" value="Undo last configuration">
, <font color=red>check box to confirm</a>
<input type="checkbox" value="1" name="kIz">
</td>
</form>
<form action="$cgi" method="POST" target=nwin>
$abmain::cYa
<td width=50%>
<input type="hidden" name="cmd" value="preview_cfg">
<input type="submit" class="buttonstyle" name="fU" value="Preview main page">  
 with options for template:  $sel_str
</td>
</form>
</tr>
|
;

print qq|
<tr $fbg>
<form action="$cgi" method="POST" target=nwin>
<td colspan=2>
$abmain::cYa
<input type="hidden" name="cmd" value="cU">
<input type="submit" class="buttonstyle" name="fU" value="Reconfigure"> $mHz 
 section with options for template <b>$sel_str</b>, <font color=red>check box to confirm</font>
<input type="checkbox" value="1" name="kIz">
</td>
</form>
</tr>
|
;

print qq|
<tr $fbg>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;"> 
<td colspan=2>
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="subs_config">
Substitute a string in the configuration with another . This operation could be irreversible. Please check carefully.<br/>
<input type="submit" class="buttonstyle" name="scfg" value="Replace">  
<input type="text" name="old" size="32"> with <input type="text" name="new" size="32">, 
<font color=blue> preview only </font> <input type="checkbox" value="1" name="preview">,
<font color=red> check box to confirm</font> <input type="checkbox" value="1" name="kIz">
</td>
</form>
</tr>
|
;

print qq|
<tr $fbg>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;"> 
<td>
@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="save_config">
<input type="submit" class="buttonstyle" name="scfg" value="Save"> current configuration as a template named 
<input type="text" name="mFz" size="16">, <font color=red> check box to confirm</font>
<input type="checkbox" value="1" name="kIz">
</td>
</form>
<form action="$cgi" method="POST" target=pickf> 
<td>
@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="gGaA">
<input type="submit" class="buttonstyle" name="scfg" value="Define basic options"> 
</td>
</form>
</tr>
|
;

print "</table>";

#eof fU

};

print "<p>\n";
print qq@
<table class="CFG" align="center" width="90%" cellpadding="4" cellspacing="1">
<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Message management</font></th></tr>
<tr><td colspan=2>
$eQ
<input type="hidden" name="cmd" value="dT">
<input type="submit" class="buttonstyle" name=dT value="Delete"> message by 
( * Day range: from <input type="text" size=4 name="hIz" value=30> days ago, to <input type="text" size=4 name="hJz" value=0> days ago)
<table border=0 cellspacing="1" bgcolor="#aaaaaa" cellpadding=5>
<tr><td>
Topic<input type="radio" name="by" value="fI" checked>
Pattern(*) <input type="text" name=pat size=16 value="">
Depth(*) <input type="text" name=depth size=2 value="64">
</td><td>
Date <input type="radio" name="by" value="mM">
</td><td>
IP <input type="radio" name="by" value="pQ">
</td><td>
Author<input type="radio" name="by" value="hC">
</td>
<td bgcolor="#ffffcc">
Private messages only <input type="checkbox" name="sCz" value="1">
</td>
<td bgcolor="#eeeeff">
From Archive<input type="checkbox" name="darch" value="1">
</td>
</tr>
</table>
</form>
</td>
</tr>
@;

if ($uT eq "adm"  || $self->{vM}) {
print qq@
<tr><td colspan=2>
$eQ
<input type="hidden" name="cmd" value="uS">
<input type="submit" class="buttonstyle" name=uS value="Archive"> Message by: 
( * Day range: from <input type="text" size=4 name="hIz" value=30> days ago, to <input type="text" size=4 name="hJz" value=0> days ago)
<table border=0 cellspacing="1" cellpadding=5 bgcolor="#aaaaaa"><tr>
<td>Thread <input type="radio" name="by" value="fI" checked></td>
<td>Date <input type="radio" name="by" value="mM"></td>
<td>IP <input type="radio" name="by" value="pQ"></td>
<td>Author<input type="radio" name="by" value="hC"></td>
<td bgcolor="#ffffcc">
Exclude private messages<input type="checkbox" name="sCz" value="1" CHECKED>
</td></tr> </table>
</form>
</td></tr>
@;
}

if($self->{aWz}) {
print qq@
<tr>
<td bgcolor="#dddddd" colspan=2>
$eQ
<input type="hidden" name="cmd" value="bSz">
<input type="submit" class="buttonstyle" name=dT value="Approve Or Delete New Messages">, 
<input type="hidden" name="by" value="fI">match pattern(*) <input type="text" name=pat size=16 value="">
</form>
</td>
</tr>
@;
}

my $selmak;
$selmak = aLa::bYa(['scat', $self->{scat_use_radio}?'radio':'select',  $self->{catopt}."\n$self->{hBa}"]) if $self->{allow_subcat};
my $sels;
$sels  = "to category: ". $selmak->aYa() if $selmak;
my $dir = $self->{eD};
$dir =~ s#/[^/]+/?$#/#;
print qq|
<tr>
<td bgcolor="#dddddd" colspan=2>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;"> 
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="copythr">
<input type="hidden" name="hIa" value="">
Copy a thread from another forum (you can use this to dup a thread in the same forum too):<br/>
From forum at path: <input type="text" name=dir size=36 value="$dir"> (This forum is at $self->{eD})<br/>
Thread number <input type="text" name=thr>, <input type="checkbox" name=keepdate checked> Preserve posting time<br/>
<input type="submit" class="buttonstyle" name=copy value="Copy Thread"> $sels
</form>
</td>
</tr>
|;

print qq!<tr><td colspan=2>
<form action="$cgi" method="POST" target=nwin> 
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="lF">
<input type="submit" class="buttonstyle" name="fU" value="Regenerate"> main forum, and
<input type="checkbox" name=cO value="1">
 regenerate individual message pages, and 
<input type="checkbox" name=zA value="1"> Delete all files under posts directory first<br/>
( * Day range: from <input type="text" size=4 name="hIz" value="3650"> days ago, to <input type="text" size=4 name="hJz" value="0"> days ago)
(This operation may take long time to finish if there are many messages)
</form>
</td>
</tr>
!;

print qq!<tr><td colspan=2>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;"> 
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="nOz">
<input type="submit" class="buttonstyle" name="gQ" value="Validate index ">for 
<input type="radio" name="which" value="index"> Main Forum 
<input type="radio" name="which" value="arch"> Archive, 
<input type="checkbox" name=rmne value="1"> remove bogus entries 
</form>
</td>
</tr>
!
;

print qq@<tr><td width=50%>$eQ
<input type="hidden" name="cmd" value="cGz">
<input type="submit" class="buttonstyle" name="fU" value="Recover forum from data files"><br/>
Post IP information will be lost!
</form>
</td>
<td width=50%>$eQ
<input type="hidden" name="cmd" value="backup">
<input type="submit" class="buttonstyle" name="fU" value="Backup forum files">,<br/>
modified date from <input type="text" size=4 name="sday" value=365> days ago, to <input type="text" size=4 name="eday" value=0> days ago.
</form>
</td>
</tr>
@;

print qq@<tr><td colspan=2>$eQ
<input type="hidden" name="cmd" value="bRz">
<input type="submit" class="buttonstyle" name="fU" value="View List of Deleted Messages"> 
Posting date from <input type="text" size=4 name="hIz" value=365> days ago, to <input type="text" size=4 name="hJz" value=0> days ago
</form>
</td>
</tr>
@;
print qq@<tr><td colspan=2>$eQ
<input type="hidden" name="cmd" value="convertfromw3b">
<input type="submit" class="buttonstyle" name="fU" value="Convert from wwwboard"> 
Enter \$Basedir setting in wwwboard: <input type="text" size=20 name="w3bbasedir">.<br/> 
<font color=red>All existing messages will be deleted, check box to confirm</a>
<input type="checkbox" value="1" name="kIz">
</form>
</td>
</tr>
@;

print "</table>"; ##message man
print "<p>\n";

if ($uT eq "adm" || $self->{mod_can_dopoll}) {

my $posel = $self->wKz();
print qq|
<table class="CFG" align="center" width="90%" cellpadding="4" cellspacing="1">
<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Poll management</font></th></tr>
<tr>
$eQ
<td width="50%">
<input type="hidden" name="cmd" value="rHz">
<input type="submit" class="buttonstyle" name="scfg" value="Add a poll">
</td>
</form>
$eQ
<td width=50%>
<input type="hidden" name="cmd" value="rHz">
<input type="submit" class="buttonstyle" name="scfg" value="Modify poll">  
$posel
</td>
</form>
</tr>
<tr> 
$eQ
<td width=50%>
<input type="hidden" name="cmd" value="rWz">
<input type="submit" class="buttonstyle" name=scfg value="Reset poll">
$posel
</td>
</form>
$eQ
<td width=50%>
<input type="hidden" name="cmd" value="rVz">
<input type="submit" class="buttonstyle" name=scfg value="Delete poll">
$posel
, <font color=red>confirm deletion</font>
<input type="checkbox" value=1 name=kIz>
</td>
</form>
</tr>
|
;

print qq|
<tr>
$eQ
<td colspan=2>
<input type="hidden" name="cmd" value="xLz">
<input type="submit" class="buttonstyle" name=scfg value="View voting details for poll">   
$posel
</td>
</form>
</tr>
|
;
print "</table>"; ##poll
}

print "<p>\n";

print qq(<table class="CFG" align="center" width="90%"  cellpadding="4" cellspacing="1">);
print qq(<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>File upload and email testing</font></th></tr>);

if ($uT eq "adm" ) {

my $enct = qq(ENCTYPE="multipart/form-data");
print qq|
<tr>
<td colspan=2>
<form $enct action="$cgi" method="POST">
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="upload">
<input type="submit" class="buttonstyle" name="fU" value="Upload file"> 
<input type=file name=attachment size=40><br/> to forum directory,
<font color=red>check box to overwrite existing file</font>
<input type="checkbox" value=1 name=conf_over>
</form>
</td>
</tr>

<tr>
<td colspan=1>
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="chmod">
<input type="submit" class="buttonstyle" name="fU" value="Change File Permission"> Filename <input type="text" name="xO">, 
UNIX Permission <input type="text" name="perm" value="0777"> 
<br/>
If the forum files are not owned by your FTP login, then you can use this command to change their permissions.
</form>
</td>
<td colspan=1 width="50%">
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;"> 
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="fetchu">
<input type="submit" class="buttonstyle" name="fU" value="Fetch URLs to Forum"><br/> 
This command allows you to fetch multiple web objects, such as HTML pages, images, etc, to the forum.
Since this operation is performed at the server, it should be much faster than downloading the files to your PC.
</form>
</td>
</tr>

|
;
}

print qq@<tr>
<td>$eQ
<input type="hidden" name="cmd" value="iJz">
<input type="submit" class="buttonstyle" name="fU" value="Send test email message"> from <b>$self->{notifier}</b> to <b>$self->{admin_email}</b>
</form>
</td>
<td>$eQ
<input type="hidden" name="cmd" value="qSa">
<input type="submit" class="buttonstyle" name="fU" value="Retrieve messages from POP3 server"><br/>
When you have enabled the post messages by email feature, AnyBoard automatically retrieves messages from the POP3 server.
Use this to manually retrieve the messages.
</form>
</td>
</tr>
@;

print "</table>"; ## misc

print "<p>\n";
print qq(<table class="CFG" align="center" width="90%" cellpadding="4" cellspacing="1">);
print qq(<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Login records</font></th></tr>);

print qq@<tr><td colspan=2>$eQ
<input type="hidden" name="cmd" value="zG">
<input type="submit" class="buttonstyle" name="fU" value="View records for">  
<select name=whom> <option value=adm selected> Administrators Login 
<option value=kQz> User Login
<option value=failpost>Posting Failure 
<option value="tellusr">Recommendations
</select><br/>
(Pattern(*) <input type="text" name=pat size=16 value="">,
From <input type="text" size=4 name="hIz" value=1> days ago, to <input type="text" size=4 name="hJz" value=0> days ago) 
</form>
</td>
</tr>
@;

print qq|<tr><td colspan=2>
<form action="$cgi" method="POST" target=ncwin>
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="chatdigest">
<input type="submit" class="buttonstyle" name="fU" value="Get Chat Digest">  
(Pattern(*) <input type="text" name=pat size=16 value="">,
From <input type="text" size=4 name="hIz" value=1> days ago, to <input type="text" size=4 name="hJz" value=0> days ago) 
</form>
</td>
</tr>
|;

print "</table>";

print "<p>\n";
print qq(<table class="CFG" align="center" width="90%"  cellpadding="4" cellspacing="1">);
print qq(<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>User management</font></th></tr>);
if ($uT eq "adm"  || $self->{vN}) {
print qq!
<tr>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;">
<td width=50%>
@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="cQ">
<input type="submit" class="buttonstyle" name=gQ value="Delete user"> 
<input type="text" name=gJz size=16 value="">
<input type="checkbox" name=qD value="1"> Ban it 
</td>
</form>
!
;

print qq!
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;">
<td width=50%>
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="admregform">
<input type="submit" class="buttonstyle" name=gQ value="Modify user"> 
<input type="text" name=kQz size=16 value="">
</td>
</form>
</tr>
!
;

print qq!
<tr>
<form action="$cgi" method="POST">
<td width=50%>
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="exportu">
<input type="submit" class="buttonstyle" name=gQ value="Export user database"> 
<br/>Save data to a text file
</td>
</form>
!
;
my $enct = qq(ENCTYPE="multipart/form-data");
print qq!
<form action="$cgi" $enct method="POST"  target=nwin onsubmit="hB('nwin', this); return true;">
<td width=50%>
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="importu">
<input type=file name="ulistfile"><br/>
<input type="submit" class="buttonstyle" name=gQ value="Import user database">
<br/>
The user database file must be one previously exported or have the right format.
</td>
</form>
</tr>
!
;
}

print qq!
<tr>
<td colspan=2>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;" > 
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="iPz">
<input type="submit" class="buttonstyle" name=gQ value="Change "> User 
<input type="text" name=gJz size=16 value="">'s password to 
<input type="text" name=iNz size=16 value="">, email to
<input type="text" name=email size=16 value=""><br/>
 (* create if not exist <input type="checkbox" name=create value="1">)
</form>
</td>
</tr>
!
;

print qq!
<tr>
<td colspan=2>
<form action="$cgi" method="POST" target=nwin onsubmit="hB('nwin', this); return true;" > 
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
<input type="hidden" name="cmd" value="setall2type">
<input type="submit" class="buttonstyle" name=gQ value="Set "> all users to type ${\(&$abmain::user_type_sel("fMz", "E"))}
</form>
</td>
</tr>
!
;

print qq!
<tr>
<td colspan=2>
<form action="$cgi" method="POST">
 				@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="rU">
<input type="submit" class="buttonstyle" name=show value="Manage"> users that match pattern(*) 
<input type="text" name=pat size=16 value=""><br/>
Type: ${\(&$abmain::user_type_sel("fMz", "---"))}, Status: ${\(&$abmain::user_stat_sel("ustat", "---"))}<br/>
Registration day range(*): from <input type="text" size=4 name="hIz" value=365> days ago, to <input type="text" size=4 name="hJz" value=0> days ago;
Only if in notification list <input type="checkbox" name="innoti" value="1">.
</form>
</td>
</tr>

<tr>
<td colspan=2>
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="hYz">
<input type="submit" class="buttonstyle" name=show value="Show"> users' email addresses, that match
 pattern(*) <input type="text" name=pat size=16 value="">, 
<input type="checkbox" name=full value="1"> show names also(*), 
<input type="checkbox" name=valid value="1"> only if validated (*),<br/>
 Registration day range(*): from <input type="text" size=4 name="hIz" value=365> days ago, to 
<input type="text" size=4 name="hJz" value=0> days ago,<br/>
Only if in notification list <input type="checkbox" name="innoti" value="1">.
Send vcards to this email address <input type="text" name=vcardrecip size=48>
</form>
</td>
</tr>
!;

print "</table>";
print "<p>\n";
if ($uT eq "adm") {
print qq(<table class="CFG" align="center" width="90%" cellpadding="4" cellspacing="1">);
print qq(<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Database management</font></th></tr>);
print qq@
<tr>
<td>
$eQ
<input type="hidden" name="_aefcmd_" value="wIa">
<input type="submit" class="buttonstyle" name=chpass value="Manage databases"><br/>
This is for creating and designing powerful web forms and manage the submitted data.
You can create forms with any type of HTML form elements, including file upload entries.
You can arbitrarily layout the forms and data views.
You can control the access to the forms and the submitted data to be public or restricted.
You can also attach the forms to forum message postings, 
and you can specify a specific set of forms must be used when replying to a form,
allowing you to have limited WorkFlow design capability.
With SQL database support enabled, you also create SQL tables from the form definitions.
Please refer to the manual for more details.
</form>
</td>
</td>
<td>
<form action="$cgi" method="GET" target=_fm>
$abmain::cYa
<input type="hidden" name="docmancmd" value="fVaA">
<input type="submit" class="buttonstyle" value="Manage files"><br/>
This is a powerful file management tool that allows you to browse, view, edit, download, upload, create files on the server.
Please make sure that you do not accidentally modify or delete the AnyBoard system files, especially those dot files, such as .forum_cfg . 
</form>
</td>
</td>
</tr></table>
@;

print "<p>";

print qq(<table class="CFG" align="center" width="90%" cellpadding="4" cellspacing="1">);
print qq(<tr><th colspan=2 $fhbg><font $self->{cfg_head_font}>Administrator and moderator management</font></th></tr>);
print qq@
<tr><td width=50%>
$eQ
<input type="hidden" name="cmd" value="vJ">
<input type="submit" class="buttonstyle" name=chpass value="Change Admin Login and Password">
</form>
</td> <td width=50%>
$eQ
<input type="hidden" name="cmd" value="iKz">
<input type="submit" class="buttonstyle" name=addmod value="Add moderator">
<input type="text" size=10 name=mod_name value=""> (Enter an ID then submit)
</form>
</td></tr>

<tr><td width=50%>
$eQ
<input type="hidden" name="cmd" value="iLz">
<input type="submit" class="buttonstyle" name=addmod value="Delete moderator">
$mod_sel
</form>
</td><td width=50%>
$eQ
<input type="hidden" name="cmd" value="uP">
<input type="submit" class="buttonstyle" name=chpass value="Modify moderator properties for">  $mod_sel
</form>
</td>
</tr>
</table>
@;

}

my @err = $self->hDaA();
if(@err) {
	print "<h1>Permission error: the following directories are not writable</h1>";
	print join("<br/>", @err);
}

print qq@
<p> <font color="#888888" size=-1>
 Server Name: ${\($abmain::dB)}<br/>
 Operating System: $^O <br/>
 Perl Version:     $] <br/>
 AnyBoard Version: $abmain::VERSION
</font>
</center>
</body></html>
@;
#CGI UID:     ${\((getpwuid($<))[0] || "unknown")} <br/>
#CGI EUID:     ${\((getpwuid($>))[0] || "unknown")} <br/>

}

# end of jW::aU
1;
