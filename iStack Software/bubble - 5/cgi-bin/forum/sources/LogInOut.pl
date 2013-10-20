###############################################################################
# LogInOut.pl                                                                 #
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

$loginoutplver = 'YaBB 2.1 $Revision: 1.4 $';
if ($action eq 'detailedversion') { return 1; }

LoadLanguage("LogInOut");

$serveros = "$^O";
$regstyle = "";

sub Login {
	my $shared_login;
	$sharedLogin_title = "$loginout_txt{'34'}";
	$shared_login      = &sharedLogin;
	$yymain .= qq~$shared_login~;

	$yytitle = "$loginout_txt{'34'}";
	&template;
	exit;
}

sub Login2 {
    &fatal_error("$loginout_txt{'37'}") if ($FORM{'username'} eq "");
    &fatal_error("$loginout_txt{'38'}") if ($FORM{'passwrd'}  eq "");
    $FORM{'username'} =~ s/\s/_/g;
    $username = $FORM{'username'};
    unlink "$memberdir/$username.pre"                                             if (-e "$memberdir/$username.pre" && -e "$memberdir/$username.vars");
    &fatal_error("$prereg_txt{'1'}")                                              if (-e "$memberdir/$username.pre" && $preregister); 
    &fatal_error("$loginout_txt{'240'} $loginout_txt{'35'} $loginout_txt{'241'}") if ($username !~ /^[\s0-9A-Za-z#%+,-\.:=?@^_]+$/);
    &fatal_error("$loginout_txt{'337'}")                                          if ($FORM{'cookielength'} !~ /^[0-9]+$/);

    # Need to do this to get correct case of username,
    # for case insensitive systems. Can cause weird issues otherwise
    my $username = &MemberIndex("check_exist", $username);

	if (-e ("$memberdir/$username.dat") || -e ("$memberdir/$username.vars")) {
		&LoadUser($username);
		my $spass     = ${$uid.$username}{'password'};
		my $cryptpass = &encode_password("$FORM{'passwrd'}");

		# convert non encrypted password to MD5 crypted one
		if ($spass eq $FORM{'passwrd'} && $spass ne $cryptpass) {

			# only encrypt the password if it's not already MD5 encrypted
			# MD5 hashes in YaBB are always 22 chars long (base64)
			if (length(${$uid.$username}{'password'}) != 22) {
				${$uid.$username}{'password'} = $cryptpass;
				&UserAccount($username, "update");
				$spass = $cryptpass;
			}
		}
	
		
		if ($spass ne $cryptpass) {
			$username = "Guest";
			$yymain.= $spass." and $cryptpass";
        &template;
        exit;
			&fatal_error("$loginout_txt{'39'}");
		} else {
			$realname     = ${$uid.$username}{'realname'};
			$realemail    = ${$uid.$username}{'email'};
			$iamadmin     = ${$uid.$username}{'position'} eq 'Administrator' ? 1 : 0;
			$iamgmod      = ${$uid.$username}{'position'} eq 'Global Moderator' ? 1 : 0;
			$sessionvalid = 1;
		}
	} else {
		$username = "Guest";
		&fatal_error("$loginout_txt{'39'}");
	}
	$iamguest = $username eq 'Guest' ? 1 : 0;
	if ($FORM{'cookielength'} == 1) { $ck{'len'} = 'Sunday, 17-Jan-2038 00:00:00 GMT'; }
	else { $ck{'len'} = "\+$FORM{'cookielength'}m"; }
	$password = &encode_password("$FORM{'passwrd'}");
	${$uid.$username}{'session'} = &encode_password($user_ip);
	chomp ${$uid.$username}{'session'};
	&UserAccount($username, "update", "lastonline");
	&UpdateCookie("write", "$username", "$password", "${$uid.$username}{'session'}", "/", "$ck{'len'}");

	if ($maintenance && !$iamadmin) { $username = 'Guest'; &fatal_error($loginout_txt{'774'}); }
	&LoadIMs;
	&banning;
	&WriteLog;
	$yySetLocation = qq~$scripturl~;
	&redirectexit;
}

sub Logout {
	# Write log
	fopen(LOG, "$vardir/log.txt");
	my @entries = <LOG>;
	fclose(LOG);
	fopen(LOG, ">$vardir/log.txt", 1);
	$field = $username;
	foreach $curentry (@entries) {
		$curentry =~ s/\n//g;
		($name, $value) = split(/\|/, $curentry);
		if ($name ne $field) { print LOG "$curentry\n"; }
	}
	fclose(LOG);
	if ($action ne "profile2") { &UserAccount($username, "update", "lastonline"); }
	&UpdateCookie("delete");

	$username           = 'Guest';
	$iamguest           = '1';
	$iamadmin           = '';
	$iamgmod            = '';
	$password           = '';
	@settings           = ();
	@immessages         = ();
	$yyim               = "";
	$realname           = '';
	$realemail          = '';
	$ENV{'HTTP_COOKIE'} = '';
	$yyuname            = "";
	if (!$guestaccess) {
		$yySetLocation = qq~$scripturl?action=login~;
	} else {
		$yySetLocation = qq~$scripturl~;
	}
	&redirectexit;
}

sub sharedLogin {
	if ($action eq 'login' || $maintenance) {
		$border = qq~
		<div class="bordercolor" style="width: 100%; margin-bottom: 8px; margin-left: auto; margin-right: auto;">
	~;
		$border_with_title = qq~
		<div  style="width: 400px; margin-bottom: 8px; margin-left: auto; margin-right: auto;">
	~;
		$border_bottom = qq~</div>~;
	}

	if    ($Cookie_Length == 1)    { $clsel1    = " selected=\"selected\" "; }
	elsif ($Cookie_Length == 60)   { $clsel60   = " selected=\"selected\" "; }
	elsif ($Cookie_Length == 180)  { $clsel180  = " selected=\"selected\" "; }
	elsif ($Cookie_Length == 360)  { $clsel360  = " selected=\"selected\" "; }
	elsif ($Cookie_Length == 720)  { $clsel720  = " selected=\"selected\" "; }
	elsif ($Cookie_Length == 1440) { $clsel1440 = " selected=\"selected\" "; }
	if ($sharedLogin_title ne "") {
		$sharedlog .= qq~
		$border_with_title
		<table id="section" cellpadding="5" align="center">
		<tr><th colspan="2"><b>$sharedLogin_title</b></th></tr>
		~;
		if ($sharedLogin_text ne "") {
			$sharedlog .= qq~
			<tr><td colspan="2" align="left">$sharedLogin_text</td></tr>
			~;
		}
		$sharedlog .= qq~
		<tr><td colspan="2" valign="middle">
		~;
	} else {
		$sharedlog .= qq~
$border
		<table id="section" cellpadding="4" width="100%" align="center">
		<tr><th colspan="2" align="center"><b>$loginout_txt{'34'}</b></th></tr>
		<tr>
		<td width="5%" valign="middle" align="center">
		<img src="$imagesdir/login.gif" border="0" alt="" />
		</td>
		<td  valign="middle">
		~;
	}
	$sharedlog .= qq~
        <form action="$scripturl?action=login2" method="post">
		<tr>
		<td widh="40%" >
			$loginout_txt{'35'}:
			</td><td>
			<input type="text" name="username" size="15" style="width: 110px;" tabindex="1"$regstyle />
		</td></tr><tr><td widh="40%"  >
				$loginout_txt{'36'}:
				</td><td>
				<input type="password" name="passwrd" size="15" style="width: 110px;" tabindex="2" />
		</td></tr><tr><td widh="40%" >
			$loginout_txt{'497'}:
			</td><td>
				<select name="cookielength" style="width: 117px;" tabindex="3">
				<option value="1"$clsel1>$loginout_txt{'497c'}</option>
				<option value="60"$clsel60>1 $loginout_txt{'497a'}</option>
				<option value="180"$clsel180>3 $loginout_txt{'497b'}</option>
				<option value="360"$clsel360>6 $loginout_txt{'497b'}</option>
				<option value="720"$clsel720>12 $loginout_txt{'497b'}</option>
				<option value="1440"$clsel1440>24 $loginout_txt{'497b'}</option>
				</select>
		</td></tr><tr><td widh="40%" >
			<input type="button" value="$loginout_txt{'315'}"  onclick="location.href='$scripturl?action=reminder'" />			
			</td><td>
			<input type="submit" value="$loginout_txt{'34'}" tabindex="5" accesskey="l"  />
		</td></tr>
			
        </form>
       </td>
      </tr>
	</table>
$border_bottom
~;

	$sharedLogin_title = "";
	$sharedLogin_text  = "";
	return $sharedlog;
}

sub Reminder {
	if ($regcheck) {
		&validation_code;
	}
	$yymain .= qq~<br /><br />
<form action="$scripturl?action=reminder2" method="post">
<table border="0" width="400" cellspacing="1" cellpadding="3" align="center" class="bordercolor">
	<tr>
	<td class="titlebg">
	<span class="text1"><b>$mbname $loginout_txt{'36'} $loginout_txt{'194'}</b></span>
	</td>
	</tr><tr>
	<td class="windowbg">
	<span class="text1"><b> $loginout_txt{'35'} $maintxt{'377'} $loginout_txt{'33'}: </b></span>
	<input type="text" name="user"$regstyle /><input type="hidden" name="_session_id_" id="_session_id_" value="$sessionid" /><input type="hidden" name="regdate" id="regdate" value="$regdate" />
	</td>
	</tr>
~;

	if ($regcheck) {
		$yymain .= qq~
	<tr>
	<td class="windowbg">
	<span class="text1"><b>$floodtxt{'1'}: </b></span>
	$showcheck
	</td>
	</tr><tr>
	<td class="windowbg">
	<span class="text1"><b>$floodtxt{'3'}: </b></span>
	<span class="text1"><input type="text" maxlength="30" name="verification" id="verification" size="20" /></span>
	</td>
	</tr>
~;
	}
	$yymain .= qq~
	<tr>
	<td align="center" class="windowbg">
	<input type="submit" value="$loginout_txt{'339'}" />
	</td>
	</tr>
</table>
</form>
<br /><br />
~;
	$yytitle = "$loginout_txt{'669'}";
	&template;
	exit;
}

sub Reminder2 {
	# generate random ID for password reset.
	@chararray = qw(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);
	my $randid;
	for (my $i; $i < 8; $i++) {
		$randid .= $chararray[int(rand(61))];
	}
	my $user = $FORM{'user'};
	$user =~ s/\s/_/g;

	$userfound = 0;

	&ManageMemberinfo("load");
	while (($curuser, $value) = each(%memberinf)) {
		($curname, $curmail, undef, undef) = split(/\|/, $value);
		if ($user eq $curuser) {
			$userfound = 1;
			$sentto = $curuser;
			last;
		} elsif ($user eq $curmail) {
			$user      = $curuser;
			$userfound = 1;
			$sentto = $curmail;
			last;
		}
	}
	&fatal_error("$loginout_txt{'39'}") if (!$userfound);

	if ($regcheck) {
		&fatal_error("$floodtxt{'4'}") if ($FORM{'verification'} eq '');
		&fatal_error("$floodtxt{'3'} $loginout_txt{'241'}") if ($FORM{'verification'} !~ /\A[0-9A-Za-z]+\Z/);

		$lastvalue        = 13;
		$verificationtest = "";
		for ($n = 0; $n < length "$FORM{'regdate'}"; $n++) {
			$value = (substr("$FORM{'regdate'}", $n, 1)) + $lastvalue + 1;
			$letter = substr("$FORM{'_session_id_'}", $value, 1);
			$lastvalue = $value;
			$verificationtest .= qq~$letter~;
		}
		&fatal_error("$floodtxt{'4'}") if ($verificationtest ne $FORM{'verification'});
	}

	# get old userdata
	&UserCheck($user, "realname+email");

	if (-e "$memberdir/forgotten.passes") {
		require "$memberdir/forgotten.passes";
	}
	if (exists $pass{"$user"}) { delete $pass{"$user"}; }
	$pass{"$user"} = "$randid";

	fopen(FILE, ">$memberdir/forgotten.passes") || &fatal_error("$loginout_txt{'23'} forgotten.passes", 1);
	while (($key, $value) = each(%pass)) {
		print FILE qq~\$pass{"$key"} = '$value';\n~;
	}
	print FILE "1;";
	fclose(FILE);

	$subject = "$loginout_txt{'36'} $mbname: $user";
	&sendmail($usercheck{'email'}, $subject, qq~$loginout_txt{'711'} $usercheck{'realname'},\n\n$mbname\n\n$loginout_txt{'35'}: $user\n$loginout_txt{'130a'}$scripturl?action=resetpass;ID=$randid;user=$user\n\n$loginout_txt{'130'}~);

	$yymain .= qq~<br /><br />
<table border="0" width="400" cellspacing="1" cellpadding="3" align="center" class="bordercolor">
	<tr>
	<td class="titlebg">
	<span class="text1"><b>$mbname $loginout_txt{'36'} $loginout_txt{'194'}</b></span>
	</td>
	</tr><tr>
 	<td class="windowbg" align="center">
	<b>$loginout_txt{'192'} $sentto</b></td>
      </tr>
</table>
<br /><center><a href="javascript:history.back(-2)">$loginout_txt{'193'}</a></center><br />
~;
	$yytitle = "$loginout_txt{'669'}";
	&template;
	exit;
}

sub Reminder3 {
	$id   = $INFO{'ID'};
	$user = $INFO{'user'};

	if ($id !~ /[a-zA-Z0-9]+/) { &fatal_error("$loginout_txt{'240'} ID $loginout_txt{'241'}"); }
	if ($user !~ /\A[0-9A-Za-z#%+-\.@^_]+\Z/) { &fatal_error("$loginout_txt{'240'} User $loginout_txt{'241'}"); }

	# generate a new random password as the old one is one-way encrypted.
	@chararray = qw(0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z);
	my $newpassword;
	for (my $i; $i < 8; $i++) {
		$newpassword .= $chararray[int(rand(61))];
	}

	# load old userdata
	&LoadUser($user);

	# update forgotten passwords database
	require "$memberdir/forgotten.passes";
	if ($pass{$user} ne $id) { &fatal_error("$loginout_txt{'833'}"); }
	delete $pass{$user};
	fopen(FORGOTTEN, ">$memberdir/forgotten.passes") || &fatal_error("$loginout_txt{'23'} forgotten.passes", 1);
	while (($key, $value) = each(%pass)) {
		print FORGOTTEN qq~\$pass{"$key"} = '$value';\n~;
	}
	print FORGOTTEN "\n1;";
	fclose(FORGOTTEN);

	# add newly generated password to user data
	${$uid.$user}{'password'} = &encode_password($newpassword);
	&UserAccount($user, "update");

	$sharedLogin_title = qq~$mbname $loginout_txt{'36'} $loginout_txt{'194'}~;
	$sharedLogin_text = qq~<td>~;
	$sharedLogin_text .= qq~$loginout_txt{'835'}~;
	$sharedLogin_text .= qq~ <input type="text" name="newpass" value="$newpassword" readonly="readonly" style="font-weight: bold;" />~;
	$sharedLogin_text = qq~</td>~;
	&sharedLogin;
	$yymain .= qq~
		<div class="bordercolor" style="width: 400px; margin-bottom: 8px; margin-left: auto; margin-right: auto;">
		$sharedlog
		</div>
	~;

	$yytitle = "$loginout_txt{'836'}";
	&template;
	exit;
}

1;
