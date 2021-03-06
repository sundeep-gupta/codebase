###############################################################################
# MailMembers.pl                                                              #
###############################################################################
# YaBB: Yet another Bulletin Board                                            #
# Open-Source Community Software for Webmasters                               #
# Version:        YaBB 2.1                                                    #
# Released:       November 8, 2005                                            #
# Distributed by: http://www.yabbforum.com                                    #
# =========================================================================== #
# Copyright (c) 2000-2005 YaBB (www.yabbforum.com) - All Rights Reserved.     #
# Software by: The YaBB Development Team                                      #
#              with assistance from the YaBB community.                       #
# Sponsored by: Xnull Internet Media, Inc. - http://www.ximinc.com            #
#               Your source for web hosting, web design, and domains.         #
###############################################################################

$mailmembersplver = 'YaBB 2.1 $Revision: 1.4 $';
if ($action eq 'detailedversion') { return 1; }

if ($iamguest) { &admin_fatal_error("$ml_txt{'223'}"); }

LoadLanguage("Main");

$reused = 0;

sub Mailing {
	if ($iamguest) { &admin_fatal_error("$ml_txt{'223'}"); }
	$yymain .= qq~

	<table border="0" width="100%" cellspacing="1" cellpadding="3" class="bordercolor">
	<tr>
		<td width="100%" valign="middle" class="titlebg">
		<span style="float: left;">
		<img src="$imagesdir/register.gif" alt="" border="0" style="vertical-align: middle;" /><b> $admintxt{'19'}</b>
		</span>
		<span style="float: right;">
		<form action="$adminurl?action=mailinggrps" method="post" name="mailgrps" style="display: inline">
			<input type="submit" value="$amv_txt{'53'}" />
		</form>
		</span>
		</td>
	</tr>
	</table>
	<script language="JavaScript1.2" src="$ubbcjspath" type="text/javascript"></script>
	<form name="adv_membermail" action="$adminurl?action=mailing2" method="POST" style="display: inline" onsubmit="return checkIfChecked(this); return submitproc()">

	<div class="windowbg2" style="width: 100%; border: 1px #cccccc solid;">
	<div class="windowbg2" style="float: left; width: 44%; height: 260px; margin: 1%; border: 1px #cccccc solid;">
	<table border="0" width="98%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
        <tr>
           <td align="left" width="100%"><b>$amv_txt{'40'}</b><br /><span class="small">$amv_txt{'46'}</span></td>
        </tr>
        <tr>
           <td align="left" width="100%">
	~;
	my $grpselect;
	my $groupcnt = 0;
	foreach (sort { $a cmp $b } keys %Group) {
		unless($_ eq "Moderator") {
			($title, $dummy) = split(/\|/, $Group{$_}, 2);
			$grpselect .= qq~\n<option value="$_"> $title</option>~;
			$groupcnt++;
		}
	}
	foreach (sort { $a <=> $b } keys %NoPost) {
		($title, $dummy) = split(/\|/, $NoPost{$_}, 2);
		$grpselect .= qq~\n<option value="$_"> $title</option>~;
		$groupcnt++;
	}
	foreach (sort { $b <=> $a } keys %Post) {
		($title, $dummy) = split(/\|/, $Post{$_}, 2);
		$grpselect .= qq~\n<option value="$title"> $title</option>~;
		$groupcnt++;
	}
	if ($groupcnt > 12) { $groupcnt = 12; }
	$yymain .= qq~
	<select name="field1" size="$groupcnt" multiple="multiple" style="width: 100%; font-size: 11px;">
	$grpselect
	</select>
	</td>
	</tr>
<script language="JavaScript1.2" type="text/javascript">
<!--
	document.write('<tr>');
	document.write('<td class="windowbg2" align="left" valign="top"><b>$amv_txt{"42"}: </b><input type="checkbox" name="check_all" value="1" class="windowbg2" style="border: 0; vertical-align: middle;" onclick="javascript: if (this.checked) selectCheckAll(true); else selectCheckAll(false);" /></td>');
	document.write('</tr>');
//-->
</script>
	</table>
	</div>
	~;

	unless ($groupcnt == 0) {

		$yymain .= qq~
	<div class="windowbg2" style="float: left; width: 50%; height: 260px; margin: 1%; border: 1px #cccccc solid;">

	<table border="0" width="98%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
        <tr>
           <td align="left" width="100%"><b>$amv_txt{'1'}:</b></td>
        </tr>
        <tr>
           <td align="left" width="100%"><input type="text" value="" size="40" name="emailsubject" style="width: 100%" /></td>
        </tr>
        <tr>
           <td align="left" width="100%"><b>$amv_txt{'2'}:</b></td>
        </tr>
        <tr>
           <td align="left" width="100%"><textarea cols="38" rows="9" name="emailtext" style="width:100%"></textarea></td>
        </tr>
        <tr>
		<td align="left" width="100%"><span class="small">$amv_txt{'39'}</span></td>
        </tr>
	</table>
		<input type="hidden" name="reused" value="$reused" />
	</div>

	<div class="windowbg2" style="float: left; width: 44%; margin: 1%; margin-top: 0; margin-bottom: 0; border: 0;">
	<table border="0" width="98%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
	<tr>
	<td class="windowbg2" align="left" valign="top"><b>$amv_txt{'49'}:</b></td>
	</tr>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 50%; margin: 1%; margin-top: 0; margin-bottom: 0; border: 0;">
	<table border="0" width="98%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
	<tr>
	<td class="windowbg2" align="left" valign="top"><b>$amv_txt{'47'}:</b></td>
	</tr>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 44%; height: 115px; margin: 1%; border: 1px #cccccc solid;">
	<table border="0" width="98%" height="100%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
	<tr>
	<td class="windowbg2" align="left" valign="top">
		<span class="small">$amv_txt{'50'}</span>
	</td>
	</tr>

	~;
		if (-e "$vardir/yabbaddress.csv") {
			$yymain .= qq~
		<tr>
		<td class="windowbg2" align="center" valign="top">
		<input type="button" value="$amv_txt{'51'}" style="width: 125px; font-size: 9" onclick="MailListWin('$adminurl?action=mailing3')">
		</td>
		</tr>
		~;
		}

		$yymain .= qq~

	</table>
	</div>
<script language="JavaScript1.2" type="text/javascript">
<!--
	function MailListWin(FileName,WindowName) {
		WindowFeature="resizable=no,scrollbars=yes,menubar=yes,directories=no,toolbar=no,location=no,status=no,width=400,height=400,screenX=0,screenY=0,top=0,left=0"
		newWindow=open(FileName,WindowName,WindowFeature);
		if (newWindow.opener == null) { newWindow.opener = self; }
		if (newWindow.focus) { newWindow.focus(); }
	}
// -->
</script>

	<div class="windowbg2" style="float: left; width: 50%; height: 115px; margin: 1%; border: 1px #cccccc solid; overflow: auto;">
	~;
		if (-e ("$vardir/maillist.dat")) {
			fopen(FILE, "$vardir/maillist.dat");
			@maillist = <FILE>;
			fclose(FILE);
			$yymain .= qq~
		<table border="0" width="99%" cellspacing="0" cellpadding="3" align="center" class="windowbg2">
		~;
			foreach $curmail (@maillist) {
				chomp $curmail;
				($otime, $osubject, $otext, $osender) = split(/\|/, $curmail);
				&LoadUser($osender);
				$thetime = &timeformat($otime);

				$jsubject = $osubject;
				$jtext    = $otext;
				&ToJS($jsubject);
				&ToJS($jtext);

				$yymain .= qq~
			<tr>
				<td class="windowbg2" align="left" valign="middle">
					<input type="radio" name="usemail" value="$otime" class="windowbg2" style="border: 0; vertical-align: middle;" onclick="showMail('$jsubject', '$jtext', '$otime');" />
				</td>
				<td class="windowbg2" align="left" valign="top"><span class="small">$thetime<br />${$uid.$osender}{'realname'}</span></td>
				<td class="windowbg2" align="left" valign="top"><span class="small">$osubject</span></td>
				<td class="windowbg2" align="left" valign="middle"><a href="$adminurl?action=deletemail;delmail=$otime"><img src="$imagesdir/admin_rem.gif" border="0" alt="del" /></a></td>
			</tr>
			~;
			}
			$yymain .= qq~
		</table>
		~;
		}
		$yymain .= qq~
	</div>

	<div class="windowbg2" style="float: left; width: 44%; margin: 1%; margin-top: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
	<td align="center">
		<input type="submit" name="convert" value="$amv_txt{'49'}" style="width: 100%;" />
	</td>
	</tr>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 50%; margin: 1%; margin-top: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
	<td align="center">
		<input type="submit" name="mailsend" value="$amv_txt{'41'}" style="width: 100%;" />
	</td>
	</tr>
	</table>
	</div>

<div style="clear: both;"></div>
</div>

</form>

<script language="JavaScript1.2" type="text/javascript">
<!--
function selectCheckAll(tchecked) {
	for(var x = 0; x < document.adv_membermail.field1.options.length; x++) document.adv_membermail.field1.options[x].selected = tchecked;
}

function showMail(thesubject, thetext, thetime) {
	thetext=thetext.replace(/\<br \\/\>/g, "\\n");
	document.adv_membermail.emailsubject.value = thesubject;
	document.adv_membermail.emailtext.value = thetext;
	document.adv_membermail.reused.value = thetime;
}
//-->
</script>
	~;
	}

	$yytitle     = "$admin_txt{'6'}";
	$action_area = "mailing";
	&AdminTemplate;
	exit;
}

sub Mailing2 {
	if ($iamguest) { &admin_fatal_error("$ml_txt{'223'}"); }
	if (!$FORM{"mailsend"} && !$FORM{"convert"}) { &admin_fatal_error($admin_txt{'1'}); }
	@convlist        = ();
	$tmpemailsubject = $FORM{"emailsubject"};
	$tmpemailtext    = $FORM{"emailtext"};
	if ($FORM{"mailsend"} && $FORM{"emailtext"} ne "") {
		$tmpemailsubject =~ s~\|~&#124~g;
		$tmpemailtext    =~ s~\|~&#124~g;
		$mailline = qq~$date|$tmpemailsubject|$tmpemailtext|$username~;
		&MailList($mailline);
	}
	(@mailgroups) = split(/\, /, $FORM{"field1"});
	&ManageMemberinfo("load");
	$i = 0;
	foreach $user (keys %memberinf) {
		($memrealname, $mememail, $memposition, $memposts, $memaddgrp) = split(/\|/, $memberinf{$user});

		if ($FORM{"mailsend"} && $FORM{"emailtext"} ne "") {
			$emailsubject = $FORM{"emailsubject"};
			$emailtext    = $FORM{"emailtext"};
			$emailsubject =~ s~\[name\]~$memrealname~ig;
			$emailsubject =~ s~\[username\]~$user~ig;
			$emailtext    =~ s~\[name\]~$memrealname~ig;
			$emailtext    =~ s~\[username\]~$user~ig;
		}

		$mailit = 0;
		foreach $element (@mailgroups) {
			chomp $element;
			if ($element eq $memposition) { $mailit = 1; }
			$memaddgrp =~ s/\, /\,/g;
			foreach $memberaddgroups (split(/\,/, $memaddgrp)) {
				chomp $memberaddgroups;
				if ($element eq $memberaddgroups) { $mailit = 1; last; }
			}
			if ($mailit) { last; }
		}
		if ($mailit && $FORM{"mailsend"}) {
			&sendmail($mememail, $emailsubject, $emailtext);
		} elsif ($mailit && $FORM{"convert"}) {
			if ($memrealname =~ /&#(\d{3,}?)\;/ig) { $memrealname = $user; }
			$convlist[$i] = qq~$memrealname\;$mememail\n~;
			$i++;
		}
	}
	undef %memberinf;
	if (@convlist) {
		fopen(ADDRESSLIST, ">$vardir/yabbaddress.csv", 1);
		print ADDRESSLIST "Name\;E-mail Address\n";
		print ADDRESSLIST @convlist;
		fclose(ADDRESSLIST);
	}

	$yySetLocation = qq~$adminurl?action=mailing~;
	&redirectexit;
}

sub Mailing3 {
	fopen(FILE, "$vardir/yabbaddress.csv");
	@addlist = <FILE>;
	fclose(FILE);
	print qq~Content-disposition: inline; filename=yabbaddress.csv\n\n~;
	foreach $curadd (@addlist) {
		chomp $curadd;
		print qq~$curadd\n~;
	}
}

sub MailingMembers {

	$sortmode = "";
	$selPos   = "";
	$selUser  = "";

	if ($FORM{'sortform'} eq "position") { $selPos = qq~ selected="selected"~; }
	else { $selUser = qq~ selected="selected"~; }

	if    ($INFO{'sort'}     ne "") { $sortmode = ";sort=" . $INFO{'sort'}; }
	elsif ($FORM{'sortform'} ne "") { $sortmode = ";sort=" . $FORM{'sortform'}; }

	if ($iamguest) { &admin_fatal_error("$ml_txt{'223'}"); }
	$yymain .= qq~

	<table border="0" width="100%" cellspacing="1" cellpadding="3" class="bordercolor">
	<tr>
		<td width="100%" valign="middle" class="titlebg">
		<span style="float: left;">
		<img src="$imagesdir/register.gif" alt="" border="0" style="vertical-align: middle;" /><b> $admintxt{'19'}</b>
		</span>
		<span style="float: right;">
		<b>$ml_txt{'1'}</b>
		<form action="$adminurl?action=mailinggrps" method="post" name="selsort" style="display: inline">
		<select name="sortform" style="font-size: 9pt;" onchange="submit()">
			<option value="username"$selUser>$ml_txt{'35'}</option>
			<option value="position"$selPos>$ml_txt{'87'}</option>
		</select>
		</form> &nbsp;
		<form action="$adminurl?action=mailing" method="post" name="mailgrps" style="display: inline">
			<input type="submit" value="$amv_txt{'40'}" />
		</form>
		</span>
		</td>
	</tr>
	</table>
	<script language="JavaScript1.2" src="$ubbcjspath" type="text/javascript"></script>
	<form name="adv_membermail" action="$adminurl?action=mailmultimembers;$sortmode" method="POST" style="display: inline" onsubmit="return checkIfChecked(this); return submitproc()">
	<input type="hidden" name="button" value="1" />

	<div class="windowbg2" style="width: 100%; border: 1px #cccccc solid;">

	<div class="windowbg" style="float: left; width: 44%; height: 260px; margin: 1%; border: 1px #cccccc inset; overflow: auto;">
	<table border="0" width="99%" cellspacing="0" cellpadding="3" class="windowbg">
	~;

	%TopMembers = ();

	&ManageMemberinfo("load");
	while (($membername, $value) = each(%memberinf)) {
		($memberrealname, undef, $memposition, $memposts) = split(/\|/, $value);
		$pstsort    = 99999999 - $memposts;
		$sortgroups = "";
		$j          = 0;

		if ($membername eq $username) {
			$sortgroups = "!!!";
		} else {
			if ($FORM{'sortform'} eq "position" || $INFO{'sort'} eq "position") {
				foreach my $key (keys %Group) {
					if ($memposition eq $key) {
						if    ($key eq "Administrator")    { $sortgroups = "aaa.$pstsort.$memberrealname"; }
						elsif ($key eq "Global Moderator") { $sortgroups = "bbb.$pstsort.$memberrealname"; }
					}
				}
				if (!$sortgroups) {
					foreach (sort { $a <=> $b } keys %NoPost) {
						if ($memposition eq $_) {
							$sortgroups = "ddd.$memposition.$pstsort.$memberrealname";
						}
					}
				}
				if (!$sortgroups) {
					$sortgroups = "eee.$pstsort.$memposition.$memberrealname";
				}

			} else {
				$sortgroups = $memberrealname;
			}
		}
		$TopMembers{$membername} = $sortgroups;
	}
	my @toplist = sort { lc $TopMembers{$a} cmp lc $TopMembers{$b} } keys %TopMembers;

	$memcount = @toplist;

	$b         = 0;
	$numshown  = 0;
	$actualnum = 0;

	while (($numshown < $memcount)) {
		$user = $toplist[$b];

		($memrealname, $mememail, $memposition, $memposts) = split(/\|/, $memberinf{$user});

		if ($user eq $username) { $bagcolor = "windowbg2"; }
		else { $bagcolor = "windowbg"; }
		if ($memrealname ne "") {

			$addel = qq~<input type="checkbox" name="member$actualnum" value="$user" class="windowbg" style="border: 0;" />~;
			$actualnum++;

			my $memberinfo = "$memposition";
			if ($memberinfo eq "Administrator") {
				($memberinfo, undef) = split(/\|/, $Group{"Administrator"}, 2);
			} elsif ($memberinfo eq "Global Moderator") {
				($memberinfo, undef) = split(/\|/, $Group{"Global Moderator"}, 2);
			} else {
				foreach my $key (sort { $a <=> $b } keys %NoPost) {
					if ($key eq $memberinfo) {
						($memberinfo, undef) = split(/\|/, $NoPost{$key}, 2);
					}
				}
			}

			$viewmembinfo = $memberinfo;
			&ToJS($memberinfo);
			$tmp_postcount = $memposts;
			$checkinfo     = $memberinfo;
			$checkinfo =~ s/\, /\'\|\'/g;
			$CheckingAll .= qq~"'$checkinfo'", ~;

			$linkuser = qq~<a href="$scripturl?action=viewprofile;username=$user"><b>$memrealname</b></a>~;

			$yymain .= qq~
			<tr>
			<td class="$bagcolor" align="center" valign="middle">$addel</td>
			<td class="$bagcolor" align="left" valign="middle">$linkuser - $viewmembinfo</td>
			</tr>~;
		}

		$numshown++;
		$b++;
	}
	undef @toplist;
	undef %memberinf;

	$yymain .= qq~
	</table>
	</div>
	~;

	unless ($memcount == 0) {
		if ($FORM{'sortform'} eq "") { $FORM{'sortform'} = $INFO{'sort'}; }
		if (!$FORM{'reversed'}) { $FORM{'reversed'} = $INFO{'reversed'}; }

		@groupinfo = ();
		$i         = 0;
		$z         = 0;

		($title, $dummy) = split(/\|/, $Group{"Administrator"}, 2);
		&ToJS($title);
		$groupinfo[$i] = $title;
		$i++;
		$grp_data = qq~"'$title'", ~;
		($title, $dummy) = split(/\|/, $Group{"Global Moderator"}, 2);
		&ToJS($title);
		$groupinfo[$i] = $title;
		$i++;
		$grp_data .= qq~"'$title'", ~;

		foreach (sort { $a <=> $b } keys %NoPost) {
			($title, $dummy) = split(/\|/, $NoPost{$_}, 2);
			&ToJS($title);
			$groupinfo[$i] = $title;
			$grp_data .= qq~"'$title'", ~;
			$i++;
			$z++;
		}

		$groupcnt = $i;
		$grp_data .= qq~""~;

		$yymain .= qq~
	<div class="windowbg2" style="float: left; width: 50%; height: 260px; margin: 1%; padding: 4px; border: 1px #cccccc solid;">

	<table border="0" width="100%" cellspacing="0" cellpadding="2" class="windowbg2">
        <tr>
           <td align="left" width="100%"><b>$amv_txt{'1'}:</b></td>
        </tr>
        <tr>
           <td align="left" width="100%"><input type="text" value="" size="40" name="emailsubject" style="width: 100%" /></td>
        </tr>
        <tr>
           <td align="left" width="100%"><b>$amv_txt{'2'}:</b></td>
        </tr>
        <tr>
           <td align="left" width="100%"><textarea cols="38" rows="9" name="emailtext" style="width:100%"></textarea></td>
        </tr>
        <tr>
		<td align="left" width="100%"><span class="small">$amv_txt{'39'}</span></td>
        </tr>
	</table>
		<input type="hidden" name="reused" value="$reused" />
	</div>

	<div class="windowbg2" style="float: left; width: 44%; margin: 1%; margin-top: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="3" class="windowbg2">
	<tr>
	<td class="windowbg2" align="left" valign="top"><b>$amv_txt{'42'}:</b></td>
	<td class="windowbg2" align="left" valign="top"><input type="checkbox" name="check_all" value="1" class="windowbg2" style="border: 0;" onclick="javascript: if (this.checked) selectCheckAllmemb(true); else selectCheckAllmemb(false);" /></td>
	</tr>
<script language="JavaScript1.2" type="text/javascript">
<!--

    document.write('<tr>');
    document.write('<td class="windowbg2" align="left" valign="top"><b>$amv_txt{'40'}</b><br /><span class="small">$amv_txt{'46'}</span></td>');
    document.write('<td class="windowbg2" align="left">');
    document.write('<select name="field1" size="$groupcnt" multiple="multiple" onchange="selectCheck()">');
	~;
		$i = 0;
		while ($i < $groupcnt) {
			$yymain .= qq~
	document.write('<option value="$i">$groupinfo[$i]</option>');
~;
			$i++;
		}
		$yymain .= qq~
    document.write('</select> ');
    document.write('</td></tr>');
//-->
</script>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 50%; margin: 1%; margin-top: 0; margin-bottom: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="3" class="windowbg2">
	<tr>
	<td class="windowbg2" align="left" valign="top"><b>$amv_txt{'47'}:</b></td>
	</tr>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 50%; height: 115px; margin: 1%; border: 1px #cccccc solid; overflow: auto;">
	~;
		if (-e ("$vardir/maillist.dat")) {
			fopen(FILE, "$vardir/maillist.dat");
			@maillist = <FILE>;
			fclose(FILE);
			$yymain .= qq~
		<table border="0" width="99%" cellspacing="0" cellpadding="3" class="windowbg2">
		~;
			foreach $curmail (@maillist) {
				chomp $curmail;
				($otime, $osubject, $otext, $osender) = split(/\|/, $curmail);
				&LoadUser($osender);
				$thetime = &timeformat($otime);

				$jsubject = $osubject;
				$jtext    = $otext;
				&ToJS($jsubject);
				&ToJS($jtext);

				$yymain .= qq~
			<tr>
				<td class="windowbg2" align="left" valign="middle">
					<input type="radio" name="usemail" value="$otime" class="windowbg2" style="border: 0; vertical-align: middle;" onclick="showMailmemb('$jsubject', '$jtext', '$otime');" />
				</td>
				<td class="windowbg2" align="left" valign="top"><span class="small">$thetime<br />${$uid.$osender}{'realname'}</span></td>
				<td class="windowbg2" align="left" valign="top"><span class="small">$osubject</span></td>
				<td class="windowbg2" align="left" valign="middle"><a href="$adminurl?action=deletemail;delmail=$otime"><img src="$imagesdir/admin_rem.gif" border="0" alt="del" /></a></td>
			</tr>
			~;
			}
			$yymain .= qq~
		</table>
		~;
		}
		$yymain .= qq~
	</div>


	<div class="windowbg2" style="float: left; width: 44%; margin: 1%; margin-top: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
	<td align="center">
		&nbsp;
	</td>
	</tr>
	</table>
	</div>

	<div class="windowbg2" style="float: left; width: 50%; margin: 1%; margin-top: 0; border: 0;">
	<table border="0" width="100%" cellspacing="0" cellpadding="0">
	<tr>
	<td align="center">
		<input type="submit" name="mailsend" value="$amv_txt{'41'}" style="width: 100%;" />
	</td>
	</tr>
	</table>
	</div>

<div style="clear: both;"></div>
</div>

</form>

<script language="JavaScript1.2" type="text/javascript">
<!--
mem_data = new Array ( $CheckingAll"" );
group_data = new Array ( $grp_data );

function selectCheckAllmemb(tchecked) {
	for(var x = 0; x < document.adv_membermail.field1.options.length; x++) document.adv_membermail.field1.options[x].selected = tchecked;
	for(var i = 1; i <= $actualnum; i++) document.adv_membermail.elements[i].checked = tchecked;
}

function selectCheck() {
var z = 1;
var grpcnt = 0;
grp_data = new Array ();

	for(x = 0; x < document.adv_membermail.field1.options.length; x++) {
		if (document.adv_membermail.field1.options[x].selected) {
			grp_data[grpcnt] = group_data[document.adv_membermail.field1.options[x].value];
			grpcnt++;
		}
	}

	if (grpcnt < document.adv_membermail.field1.options.length) { document.adv_membermail.check_all.checked = false; }

	for (var i = 0; i < $actualnum; i++) {
		var check = 0;
		for(x = 0; x < grpcnt; x++) {
			var limit = grp_data[x];
			var value = mem_data[i].split("|");
			var j = 0;
			while(value[j]) {
				if (value[j] == limit) { check = 1; x = grpcnt; }
				j++;
			}
		}
		if (check == 1) {document.adv_membermail.elements[z].checked = true;}
		else {document.adv_membermail.elements[z].checked = false;}
		z++;
	}
}

function checkIfChecked(theForm) {
	var nonechecked = true;
	for(var i = 1; i <= $actualnum; i++) {
		if (document.adv_membermail.elements[i].checked) nonechecked = false;
	}
	if (nonechecked) { alert("$amv_txt{'48'}"); return false }
	return true
}

function showMailmemb(thesubject, thetext, thetime) {
	thetext=thetext.replace(/\<br \\/\>/g, "\\n");
	document.adv_membermail.emailsubject.value = thesubject;
	document.adv_membermail.emailtext.value = thetext;
	document.adv_membermail.reused.value = thetime;
}
//-->
</script>
	~;
	}

	$yytitle     = "$admin_txt{'6'}";
	$action_area = "mailing";
	&AdminTemplate;
	exit;
}

sub ToJS {
	$_[0] =~ s~\;~&#059~g;
	$_[0] =~ s~\!~&#33~g;
	$_[0] =~ s~\(~&#40~g;
	$_[0] =~ s~\)~&#41~g;
	$_[0] =~ s~\-~&#45~g;
	$_[0] =~ s~\.~&#46~g;
	$_[0] =~ s~\:~&#58~g;
	$_[0] =~ s~\?~&#63~g;
	$_[0] =~ s~\[~&#91~g;
	$_[0] =~ s~\\~&#92&#92~g;
	$_[0] =~ s~\]~&#93~g;
	$_[0] =~ s~\^~&#94~g;
	$_[0] =~ s~\"~&#34~g;
	$_[0] =~ s~\'~&#96~g;
}

1;
