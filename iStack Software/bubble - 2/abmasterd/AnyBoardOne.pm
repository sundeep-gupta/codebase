#nothing here

package sUa;

sub yGz {
 eval 'use AutoSplit';
 my ($xO, $xRa, $outfile, $altf, $no_auto) = @_;

open F, "<$xO" or error("Can't open script $xO: $!");
my @arr = <F>;
close F;

if (not -d $xRa) {
 	mkdir $xRa, 0755 or error("Can't make dir $xRa: $!");
}
my $xTa = kZz($xRa, "auto");
if (not -d $xTa) {
	mkdir $xTa, 0755 or error("Can't make dir $xTa: $!");
}

my $all= join("", @arr);

error('inval', "Can't split the code") if not $all =~ /#IF_AUTO/; 

study $all;

print "Content-type: text/html\n\n";
print "<html><body><h1>Splitting the script, check for errors!!</h1><pre>";

$all =~ s/^.*##SUB_LIST.*$//gm;
$all =~ s/^zV$//gm;
$all =~ s/^.*'zV'.*$//gm;
$all =~ s/^bAz$//gm;
$all =~ s/^.*'bAz'.*$//gm;

	$all =~ s/^#IF_AUTO\s+//gm;

$all =~ s/ABMODDIR/"$xRa"/g;

my @aRz = split /(^package\s+[^\n]+;\s*$)/m, $all;
my $main = shift @aRz;
while(@aRz) {
 my $pak = shift @aRz;
 my $code = shift @aRz;
 $code =~ s/^BEG_AUTO_FUNC.*?^BEG_AUTO_FUNC//sm;
 $pak =~ /package\s+(.*);/;
 my $pkn = $1;
 my $pk = kZz($xRa, "$pkn.pm");
 open F, ">$pk";
 print F $pak, "\n", $code;
 close F;
 print "Saving modules $pkn.pm\n";
 AutoSplit::autosplit("$pk", "$xTa");
 print "Split modules $pkn.pm\n";
if($no_auto) {
 $code =~ s/^__END__$/\n/mg;
}else {
 $code =~ s/\n__END__.*/\n/s;

}
 open F, ">$pk";
 print F $pak, "\n", $code;
 close F;
} 

my $use_alt=0;
if($outfile && open (F, ">$outfile")) {
}else {
 $outfile = $altf;
 open F, ">$outfile" or error("On open $outfile: $!");
 $use_alt = 1;
}
print F $main;
close F;
chmod 0755, $outfile;
print "</pre>";
print "The script has been split into smaller files.<br/>";
print qq(<hr/><a href="javascript:history.go(-1)">Go back</a></body></html>);

}
sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
	last if not $_;
 $_ =~ s#^/?##;
 $root =~ s#/*$#/#;
 $root .= $_; 
 }
 return $root;
}

sub error{
	my ($msg)= @_; 
	print "Content-type: text/html\n\n";
	print "<html><body><font color=red>$msg</font></body></html>";
	exit(0);
}
1;

__END__
package abmain;
use vars qw($AUTOLOAD $aZz %zW);
use vars qw($iS $EDITION $VERSION $fvp);
use vars qw($fix_top_dir $fix_top_url $fix_cgi_url $rbaseurl);
use vars qw(
 $hUz $dB $bS $eD $pL $dJz $agent $jT
 $agent $jH $js $ecref @error_cfg $user_stat_sel
 $user_type_sel $mBz %mCa $err_filter $dLz %mail_status
 $wH %mail $vV
 $thread_sort_sel $lEz $lFz $uE $uJ
 $uF $img_top $rules_url %gJ %hI $bWz $license_key
 %fPz $mC $oG $cAz
 $oC $master_dbdef_dir $uG $TZ
 $bYaA
);

sub sVa::hCaA(@);
sub sVa::gYaA(@);

#IF_AUTO use lB;
#IF_AUTO use jW;
#IF_AUTO use jFa;
#IF_AUTO use jEa;
#IF_AUTO use dZz;
#IF_AUTO use jPa;
#IF_AUTO use hDa;

sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8};

sub hOa{
	require bNa;
	require aLa;
	require hDa;
	require eCa;
	require qWa;
	require dDa;
}

 
sub abmain::plug_in{
 my $seq = time() - 932854598;
 return abmain::mNa($seq);
}

#IF_AUTO use AutoLoader 'AUTOLOAD';

sub lTz { 

unshift @INC, "$abmain::ab_install_dir/lib";

$SIG{ALRM} = \&abmain::oYa;
eval 'alarm(60*60)' if $abmain::use_alarm;

$jW::use_tmp=0; 
$jW::use_glob=0; 
$abmain::func_cnt =0;

umask 022;

if("" eq $ENV{'REQUEST_METHOD'}) {
 if($ENV{GATEWAY_INTERFACE} =~ /^CGI-Perl/ || exists $ENV{MOD_PERL}) {

 }else {
 	 &error('sys',"Script was called with unsupported REQUEST_METHOD: $ENV{'REQUEST_METHOD'}.") 
 }
}
undef %abmain::gJ;
undef %abmain::hI;
undef %jW::locks;
undef %abmain::mCa;
undef %abmain::fPz;
undef %{$abmain::iS} if $abmain::iS;
undef $abmain::iS if $abmain::iS;
undef $jW::hW;
$jW::max_mno=0;
$jW::jUz =0;
$abmain::jH=0;

unless ($abmain::bypass_loadfix) {
	fCa();
}

if($abmain::use_sql) {
	require zGa;
}elsif($abmain::use_dbf) {
	require DBFileDB;
}

$bYaA = $abmain::use_sql? "zGa": ($abmain::use_dbf?"DBFileDB":"jEa");

&pR; 
&lL;
&bF();

if ($abmain::no_pathinfo && not $fix_top_dir) {
		$fix_top_dir = $ENV{DOCUMENT_ROOT};
}

&dO();

&kP();

&hUa();

$SIG{INT} = \&abmain::oYa;
$abmain::start_time = time();

$abmain::cZa="";
$abmain::cYa="";

if($abmain::no_pathinfo) {
	$abmain::cZa ="fvp=$abmain::fvp;";
	$sVa::cYa = $abmain::cYa=qq(<input type="hidden" name="fvp" value="$abmain::fvp">);
	$sVa::fvp=$abmain::fvp;
}

if($abmain::gJ{pvp}) {
 	$abmain::fix_top_dir = $abmain::master_cfg_dir;
	$abmain::cZa ="pvp=$fvp;";
	$sVa::pvp=$abmain::pvp=$abmain::gJ{pvp};
	$sVa::cYa = $abmain::cYa=qq(<input type="hidden" name="pvp" value="$fvp">);
	$abmain::no_pathinfo = 1;
	$abmain::off_webroot=1;
}

$abmain::debug=1 if($abmain::gJ{debug}) ;

$abmain::abcmd = $abmain::gJ{cmd};

if ($abmain::no_pathinfo && $abmain::fvp) {
	abmain::error("sys", "Misconfiguration in script: fix_top_dir must be set!") if not $fix_top_dir;
	abmain::error("sys", "Incorrect configuration in script: fix_top_dir $fix_top_dir must exist!") if not -d $fix_top_dir;
}

if($abmain::abcmd eq 'vL') {
	oLa();
}

%abmain::fast_commands= (
 get => ['GET', \&jL, 'ADM'],
 geta => ['GET', \&kAz, 'ADM'],
 retr => ['GET', \&iLa, 'ADM'],
 newsjs=>['GET',   \&oJa],
 speak=>['POST', \&sUz],
 macdefs=>['GET', \&gEaA],
);

unless ($abmain::fast_commands{$abmain::abcmd} || $abmain::abcmd eq 'vL') {
	abmain::hYa();
#IF_AUTO hOa();
}

$abmain::yDa=time();
eval 'use POSIX qw(strftime);';
eval 'sub strftime {"no strftime"}' if $@;
$iS = new jW(eD=>$abmain::eD, cgi=>$abmain::jT, cgi_full=>$abmain::dLz, pL=>$abmain::pL, rbaseurl=>$abmain::rbaseurl); 

if($abmain::gJ{_aefcmd_} ne "") {
	run_formmagic(); 
	abmain::iUz(); 
}

if($abmain::gJ{pwsearchcmd} ne "") {
	bZaA(); 
	abmain::iUz(); 
}

if($abmain::gJ{htmlviewcmd} ne "") {
	run_html_view();
	abmain::iUz(); 

}

if($abmain::gJ{docmancmd} ne "") {
	run_docman(); 
	abmain::iUz();
}
my $mT = $abmain::fast_commands{$abmain::abcmd} || $abmain::bK{$abmain::abcmd};
my $bdcall = $jW::bK{$abmain::abcmd};

abmain::oUa() if $abmain::oUa;
if($mT) {
 my $bPaA = $mT->[1];
 &$bPaA;
#x1
#x1
 &abmain::iUz();
}elsif($bdcall) {
	my $c= $bdcall->[0];
	$iS->$c(\%abmain::gJ);
	abmain::iUz(); 

}elsif($abmain::dC ne 'POST') {
 if(not -w $abmain::master_cfg_dir) {
		abmain::wLz();
 		&abmain::iUz();

 }
	if($abmain::fvp) {
 		sVa::hCaA "Location: ", $iS->fC(), "\n\n";
	}else {
		fBa();
	}
 	&abmain::iUz();
}else {
 my $dbstr = join("<br>", "cmd", $abmain::gJ{cmd}, "QS", $ENV{QUERY_STRING}) if $abmain::debug;
 error('sys', qq(Disabled command. The function is disabled in this edition of AnyBoard. Please see <a href="http://netbula.com/anyboard/license.html">AnyBoard Licenses</a> for more information . $dbstr) );
 &abmain::iUz();
} 
} 

sub run_formmagic {
	require rNa;

	$iS->cR();
	my $bRaA = $iS->wPa();	
	my $cmd = $gJ{_aefcmd_};
	my $bPaA = $rNa::bK{$cmd};
	if(not $bPaA) {
		$bRaA->tJa();
	}else {
		my $hR = $bPaA->[0];
	   	if ($bPaA->[1] eq 'REG' && not ($bRaA->eVa() || $iS->{fTz}->{reg}) ){
	   		$bRaA->tJa();
 }elsif($bPaA->[1] eq 'ADM' && not $bRaA->eVa()){
	   		$bRaA->tJa();
 }
		$bRaA->$hR(\%abmain::gJ);
	}

}

sub bZaA{
	require qWa;

	my $bRaA = abmain::bVaA();	 
	my $cmd = $gJ{pwsearchcmd};
	my $bPaA = $qWa::bK{$cmd};
	if(not $bPaA) {
		$bRaA->tJa();
	}else {
		 my $hR = $bPaA->[0];
		 if($bPaA->[1] eq 'ADM' && not $bRaA->eVa()){
	   		$bRaA->tJa();
		 }
		 $bRaA->$hR();
	}

}

sub run_docman{
	require eUaA;

	$eUaA::cQaA = $abmain::img_top;

	if(-f $iS->nCa()) {
		$iS->cR();
	}else {
	}

	my $docman= $iS->fCaA($gJ{kQz});	
	$docman->setPath($gJ{dir});
	my $cmd = $gJ{docmancmd};

	my $bPaA = $eUaA::bK{$cmd};
	if(not $bPaA) {
		$docman->tJa();
	}else {
	       my $hR = $bPaA->[0];
	       unless (($cmd eq 'fDaA' || $cmd eq 'fVaA') && $gJ{dir} =~ m|^/?public|i) {
	   		if ($bPaA->[1] eq 'REG' && not ($docman->eVa() || $iS->{fTz}->{reg}) ){
	   			$docman->tJa();
				return;
 	     }elsif($bPaA->[1] eq 'ADM' && not $docman->eVa()){
	   			$docman->tJa();
				return;
 	     }
 }
	       $docman->$hR(\%abmain::gJ);
	}

}

sub run_html_view{
	require fRaA;
	my $bRaA = abmain::dZaA();
	my $cmd = $gJ{htmlviewcmd};
	my $bPaA = $fRaA::bK{$cmd};
	my $hR = $bPaA->[0];
	$bRaA->$hR(\%abmain::gJ);
}



BEGIN{
#x1
$abmain::rules_url="http://www.netbula.com/anyboard/license.html"; 
$abmain::dfa =qq(face="Verdana"); #default font attribute
#x1
#x1
#x1
#x1
$EDITION ="Free"; 
#x1
$VERSION="10.0.0 $EDITION";
#x1
#x1
$abmain::jQz = '(([\w\-\+]+(?:\.[\w\-\+]+)*)\@([\w-]+(?:\.[\w-]+)*))'; # where full=$1, user=$2, domain=$3
$abmain::close_btn =qq(<form><input type=button name=x value="Close window" onclick="window.close()"></form>);

@jW::org_info_tags= qw(ORG_NAME ORG_URL ORG_LOGO ORG_CONTACT_INFO ORG_ADDRESS ORG_COPYRIGHT
ORG_HELP_INFO ORG_SERVICE_INFO ORG_ABOUT_INFO ORG_NEW_INFO ORG_PRODUCTS_INFO
ORG_SALES_INFO ORG_PARTNER_INFO
ORG_TOP_NAV_BAR ORG_TOP_BANNER ORG_BOTTOM_NAV_BAR
ORG_BOTTOM_BANNER
ORG_LEFT_BAR ORG_RIGHT_BAR
);

@jW::gLa=qw(POSTLNK FINDLNK OVERVIEWLNK PREVLNK NEWESTLNK REGLNK LOGINLNK OPTLNK 
ADMLNK GOPAGEBTN MAINLNK ARCHLNK CHATLNK RELOADLNK MYFORUMLNK STATSLNK WHOLNK 
TAGSLNK QSRCHLNK DBLNK FPOSTLINK 
LINKSLNK MEMBERLNK SURVEYLNK EVELNK
USERCPANELLINK PAR_LINKS FORUMNAME
ALL_FORUMS_LIST
FORUM_AD
FORUM_TOP_BANNER
FORUM_BOTTOM_BANNER
FORUM_MSG_AREA
FORUM_DESC_FULL
QSEARCHBOX
);

push (@jW::gLa, @jW::org_info_tags);

@jW::idx_tags=qw(REGLNK LOGINLNK ADMLNK MAINLNK ARCHLNK CHATLNK MYFORUMLNK 
MEMBERLNK POSTLNK SURVEYLNK EVELNK FORUMNAME LINKSLNK STATSLNK WHOLNK TAGSLNK QSRCHLNK DBLNK FPOSTLINK USERCPANELLINK);

@jW::mbar_tags=qw(ORIG_MSG_STR POST_BY_WORD RE_WORD MSG_REF_LNK 
MSG_AUTHOR_ORIG MSG_AUTHOR_STR MSG_DATE REPLY_MSG_LNK TOP_MSG_LNK PREV_MSG_LNK NEXT_MSG_LNK FORUM_LNK MBAR_WIDTH MBAR_BG MBAR_ATTRIB
MSG_TOP_BAR TOPMBAR_BODY_SEP MSG_TITLE MSG_MOOD_ICON MSG_BODY MSG_IMG MSG_ATTACHMENTS AUTHOR_AVATAR AUTHOR_SIGNATURE MSG_RLNK MSGBODY_BBAR_SEP
MSG_BOTTOM_BAR
MSG_ATTACHED_OBJ_MOD
MSG_ATTACHED_OBJ
SIBLING_MSG_LINKS
PARENT_LEVEL_MSG_LINKS
CHILDREN_MSG_LINKS
MSG_PATH_LINKS
MODIFIED_STR
AUTHOR_PROFILE_LNK  EDIT_MSG_LNK CURRENT_PAGE_LNK RECOMMEND_MSG_LNK ALERT_ADM_LNK MAIL_USER_LNK
RATE_MSG_LNK UP_MSG_LNK WHERE_AMI_LNK  VIEW_ALL_LNK
FORUMNAME
);
@jW::dyna_tags=qw(LOGIN_USER PRIVATE_MSG_ALERT LOCAL_USER_LIST GLOABL_USER_LIST MSG_READERS ALL_FORUMS_LIST);
$abmain::bRaA='-=ab=-';
}
BEGIN {

$abmain::cN = ".violation";
$abmain::catidx= ".catidx";
$abmain::cH ="alias";

my $word_rx = '[\x21\x23-\x27\x2A-\x2B\x2D\w\x3D\x3F]+';
my $user_rx = $word_rx .'(?:\.' . $word_rx . ')*';
my $dom_rx = '\w[-\w]*(?:\.\w[-\w]*)*'; 
my $ip_rx = '\[\d{1,3}(?:\.\d{1,3}){3}\]';
$abmain::uD = '((' . $user_rx . ')\@(' . $dom_rx . '|' . $ip_rx . '))';

$abmain::pW=<<'XXX1';
M"D-O<'ER:6=H="A#*2P@3F5T8G5L82!,3$,L(#$Y.3@L($%L;"!2:6=H=',@
M4F5S97)V960N"E1H92!!;GE";V%R9"AT;2D@0G5L;&5T:6X@0F]A<F0@<WES
M=&5M(&ES('!R;W1E8W1E9`IB>2!54R!A;F0@26YT97)N871I;VYA;"!C;W!Y
M<FEG:'0@;&%W<RX*56YA=71H;W)I>F5D('5S92!O<B!D:7-T<FEB=71I;VX@
M;V8@06YY0F]A<F0H=&TI(&ES('-T<FEC=&QY('!R;VAI8FET960L"G9I;VQA
M=&]R<R!W:6QL(&)E('!R;W-E8W5T960N(%1O(&]B=&%I;B!A(&QI8V5N<V4@
M9F]R('5S:6YG($%N>4)O87)D*'1M*2P@"G!L96%S92!R96=I<W1E<B!A="!!
M;GE";V%R9"!H;VUE('!A9V4@870@:'1T<#HO+VYE=&)U;&$N8V]M+V%N>6)O
%87)D+PH`

XXX1

$abmain::pV =<<'XXX2';
>675E($1O;F=X:6%O("AY9'A`;F5T8G5L82YC;VTI

XXX2
$abmain::dS="X";


%abmain::cP = (
miss=>[	"Missing required field",
	"You did not fill in one or more required fields in the form submission.", 
	"Go back and complete the information and then resubmit."],

iK=>["Field too long",
	"One of the fields exceeded the limit.",
	"Go back, reduce the field length and then resubmit."],

oO=>["Rule violation",
	"You violated the rules imposed by this forum!",
	"Please read the rules again and cooperate. Thank you!"],

inval =>["Input rejection", "The information or command you sent was rejected",
 qq(<a href="javascript:history.go(-1)">Go back</a> to the previous page and make corrections.<br>Please see the detailed error message for explanation.)],    
deny    => ["Access denied!", "Sorry!", "Sorry!"],

dM => ["Fail to authenticate!", 
	"Missing or invalid authentication information.", 
	"Provide the correct authentication info and retry."],

iT=> ["No cookie!", 
	"Your browser did not send the expected cookie!", 
	"Get a browser that supports Cookies and enable Cookies" ],

'sys'=>	["System error", 
	"Error caused by incorrect setup, incorrect permission setting, etc.", 
	"Notify webmaster with the detailed error message."
	],
);

@abmain::pP=(
[loginfo =>"head", "Enter Name And Password To Login"], 
[kQ => "text", qq(size="40"), "Name", ""],
[nC => "password", qq(size="40"), "Password", ""],
[rem_upass =>"checkbox", qq(value="1"), "Remember my password", 0],
);

@abmain::fix_cfgs=(
[fix_info =>"head", "Configure AnyBoard to use fixed parameters or SQL Database"], 
[fix_use_cfg=> "checkbox", '1=Yes', "Check this box to use the fixed parameters . If this box is not checked, then the settings below won't be applied.", "0"],
[fix_top_url=>'text', qq(size="40"), "Full URL of the top level web directory", ""],
[fix_top_dir=>'text', qq(size="40"), "Physical directory path corresponding to the URL above.", ""],
[fix_off_web => "checkbox", '1=Yes', "Check this if the above directory is not under the web directory and not directly accessible via browser", "0"],
[fix_cgi_url=>'text', qq(size="40"), "Full URL of the AnyBoard CGI program.", ""],
[fix_no_pathinfo=> "checkbox", '1=Yes', "Check this box to not use PATHINFO at all", "1"],
[allow_del_board=> "checkbox", '1=Yes', "Allow master admin to delete Board from browser", "1"],
[fix_info2 =>"head", "Global settings"], 
[gforbid_words=>'text', qq(size="40"), "Forbidden word pattern banned across all boards", ""],
[gpost_password=>'text', qq(size="30"), "Common posting password", ""],
[fix_info2 =>"head", "Configure SQL database options"], 
[dbi_drivers =>"const", "", "Available DBI drivers"], 
[fix_use_sql=> "checkbox", '1=Yes', "Check this box to use SQL database (you must make sure that you have created the AnyBoard DB)", "0"],
[fix_dbdsn=> "text", qq(size="48"), "Database DBI DSN", ""],
[fix_dbuser=> "text", qq(size="40"), "Database user", ""],
[fix_dbpassword=> "password", qq(size="40"), "Database password", ""],
[kUa=>"hidden"],
[yBa=>"hidden"],
[cmd=>"hidden", "", "", "lZa"],
);

$abmain::cEaA =
qq(1a2ac71a3ac73c7cc75b4cc78cbbab3fc73d6a8b3cc73abbc73aabc73a1ac71cbcc74dadc72d1debdac7bb2fc73acac73afbc752c7ac7cc7fb9c2d4dc75d2e0cfec74c7c0cfec7dc8a9bdfc78c7e9bbfc7bc4e8cbbc75bbaac7cc7cb8c8cbbc78c7e4bbcc7eb9b8cbbc72d4dab3fc7ac9b3d3cc74b3d0c4bc71b8d0dbec75d2e1d9fc7ac7cc78c7eabecc7cb0b6c4ec7cbba6c4e);
};

sub sys_error{
 my ($et, $em) = @_;
 print "Content-type: text/plain\n\n";
 print "System error: $em";
 abmain::iUz();
}

sub bC {
 my($name, $val, $path, $exp) = @_;
 if($exp) {
 	return "Set-Cookie: $name=$val; expires=$exp; path=$path\n";
 }else {
 	return "Set-Cookie: $name=$val; path=$path\n";
 }
}

sub bF {
 my($name, $val);
 foreach (split (/;\s*/, $ENV{'HTTP_COOKIE'})) {
 ($name, $val) = split /=/;
 $abmain::fPz{$name}=$val;
 }
}

sub mRz {
 my $str = shift;
 my($name, $val);
 foreach (split (/\&/, $str)) {
 ($name, $val) = split /:/;
 $abmain::mNz{$name}=$val;
 }
}

sub aRa {
 my ($aKa, $aIa) = @_;
 return sub {
 my ($id, $aOa) = @_;
 	my $str = qq(<select name="$id">);
 my ($sel, $dv);
 for(@$aIa) {
 	$sel = "";
 	$sel ="SELECTED" if $aOa && $aOa eq $_;
 $dv = $aKa->{$_};
 	$str .= qq(<option value="$_" $sel>$dv);
 }
 	$str .=qq(<option value="" SELECTED>----) if $aOa eq '---';
 	return $str."</select>";  
 }
}
sub dO {
 my($in) ;
 my ($name, $value) ;
 my @eRz;
 @abmain::lWa=();
 my %mDa=();

 &error('sys',"Script was called with unsupported REQUEST_METHOD $ENV{'REQUEST_METHOD'}.") 
 if ( not defined($ENV{'REQUEST_METHOD'})); 

 if ( ($ENV{'REQUEST_METHOD'} eq 'GET') ||
 ($ENV{'REQUEST_METHOD'} eq 'HEAD') ) {
 $in= $ENV{'QUERY_STRING'} ;
	$in =~ s/;/&/g;
 $abmain::dC="GET";
 } elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
 length($ENV{'CONTENT_LENGTH'})
 || &error('sys', "No Content-Length sent with the POST request.") ;
 my $len = $ENV{'CONTENT_LENGTH'};
 my $cnt=0;
#x1
 $abmain::dC="POST";
 my $buf;
 binmode STDIN;
 if ($ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 while($len>0) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt <= 0 || not $cnt;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
 }elsif($ENV{'CONTENT_TYPE'}=~ m#^multipart/form-data#i) {

 while($len>0) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt <= 0 || not $cnt;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
 my @plines = split /^/m, $in;
 
 my $lRa = new dZz(\@plines);
 $lRa->{head}->{'content-type'} = $ENV{'CONTENT_TYPE'}; 
 $lRa->bVz();
 $lRa->eBz();
 for my $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 if($abmain::do_untaint) {$val =~ /(.*)/s; $val = $1;}
 if (length($ent->{eFz})>0) {
 	    	      $ent->{eFz} =~ s/%([0-9a-fA-F][0-9A-Fa-f])/chr(hex($1))/ge ;
 $ent->{eFz} =~ s/(\s+|`|\|)/_/g;
 $ent->{eFz} =~ s/\x1a/_/g;
 $abmain::mCa{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
		      $abmain::gJ{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 } else {
 	              $abmain::gJ{$name} .= "\0" if defined($abmain::gJ{$name}); 
		      $val =~ s/\x1a//g;
 	              $abmain::gJ{$name} .=  $val;
 }
 if(not $mDa{$name}) {
		    	push @abmain::lWa, $name;
			$mDa{$name}=1;
		    }
 }
 
 }else {
		print STDERR "Unhandled content-type\n";
 }
 }
 if ($abmain::dC eq 'GET'  || $ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 	foreach (split('&', $in)) {
 	    s/\+/ /g ;
 	    ($name, $value)= split('=', $_, 2) ;
 	    $name=~ s/%([0-9a-fA-F][0-9A-Fa-f])/chr(hex($1))/ge ;
 	    $value=~ s/%([0-9A-Fa-f][0-9a-fA-F])/chr(hex($1))/ge ;
 if($abmain::do_untaint) {$name=~ /(.*)/s; $name=$1; $value =~ /(.*)/s; $value = $1;}
 	    $abmain::gJ{$name}.= "\0" if defined($abmain::gJ{$name}) ; 
 	    $abmain::gJ{$name}.= $value ;
 if(not $mDa{$name}) {
		    	push @abmain::lWa, $name;
			$mDa{$name}=1;
	    }
 	}
 }
 if(exists $abmain::gJ{tK}) {
		$abmain::gJ{tK} =~ s/</\&lt;/g;
		$abmain::gJ{tK} =~ s/>/\&gt;/g;
 }
}

sub kP {
 my $oE = $ENV{SERVER_PORT};
 $abmain::dB = $ENV{SERVER_NAME};
 $ENV{PATH_INFO} =~ s/\/index\.html$/\//;
 $ENV{PATH_TRANSLATED} =~ s/\/index\.html$/\//;
 $abmain::bS = $ENV{PATH_INFO};
 $hUz = $dB;
 $hUz =~ s/^www\./\./;
 $hUz = "domain=$hUz;";
 my $prog = $0;
 $prog =~ s/\\/\//g;
 if($bS =~ /$prog(.*)/) {
 $bS = $1;
 }

 $bS =~ s!^$abmain::pathinfo_cut!! if $abmain::pathinfo_cut;
 $bS =~ s/$abmain::bRaA.*//;

 if ($abmain::no_pathinfo) {
 	$abmain::fvp = $abmain::gJ{pvp} || $abmain::gJ{fvp};
	$bS = "";
 }else {
	$abmain::fvp = $abmain::gJ{pvp} || $bS;
 }

 $abmain::fvp =~ s#/?$#/# if $abmain::fvp ne "";

 if($^O =~ /win/i) {
 	$ENV{PATH_TRANSLATED} =~ s!\\!/!g ;
 	$ENV{SCRIPT_NAME} =~ s!\\!/!g ;
 }
 $eD = $ENV{PATH_TRANSLATED};
 $eD=~ s!$abmain::bRaA/[^\/]+!!;
 if($abmain::gJ{pvp}) {
 	$abmain::fix_top_dir = $abmain::master_cfg_dir;
 }
 if($fix_top_dir) {
 $eD=abmain::kZz($fix_top_dir,$abmain::fvp);
 }
 $bS =~ s/`|\s+|;//g;
 $eD =~ /(.*)/; $eD = $1;
 $bS =~ /(.*)/; $bS =$1;
 my $proto = lc((split /\//, $ENV{SERVER_PROTOCOL})[0]); 
 $proto="https" if $ENV{HTTPS} && lc($ENV{HTTPS}) ne 'off';
 $dJz = $proto."://$dB";
 $rbaseurl = "";
 if($oE != 80 && $oE != 443) {
 $dJz .= ":$oE";
 }
 if ($fix_top_url) {
 $dJz = $fix_top_url;
 }else {
 $rbaseurl=abmain::kZz("/", $abmain::fvp);
 }
 $pL = abmain::kZz($dJz, $abmain::fvp);
 if($fix_cgi_url) {
 $jT = abmain::kZz($fix_cgi_url,$bS);
 	$dLz = $jT;
 	$abmain::lGa = $fix_cgi_url;
 } else{
 	$jT = abmain::kZz($ENV{SCRIPT_NAME}, $bS);
 	$dLz = abmain::kZz($dJz, $jT);
 	$abmain::lGa = abmain::kZz($dJz, $ENV{SCRIPT_NAME});
 }
 #$jT = $dLz;
 #$jT = $dLz if $^O =~ /win/i;
 abmain::error('sys', "Invalid script name") if "$dLz $ENV{SCRIPT_NAME}" !~ /anyboard/i;
 $abmain::orig_url = $jT;
 $abmain::orig_url .= '?'.$ENV{QUERY_STRING} if ($ENV{'REQUEST_METHOD'} eq 'GET');
 $abmain::agent = $ENV{'HTTP_USER_AGENT'};
 if($ENV{HTTP_X_FORWARDED_FOR}){
 	$ENV{REMOTE_ADDR}= $ENV{HTTP_X_FORWARDED_FOR};
 }

}

sub nF {
 $bYaA->new(sVa::kZz($eD, $abmain::cN), {schema=>"AbViolationLog"})->iSa(
 [time(), $abmain::ab_id0, $abmain::ab_id1, $abmain::ab_track, $jH, $ENV{'REMOTE_ADDR'},$abmain::gJ{'name'},$jW::fO,$abmain::js]
 );
}

#IF_AUTO 1;
#IF_AUTO __END__
#x1
sub hYa { 

return if $abmain::cfg_inited;
$abmain::cfg_inited = 1;

%abmain::user_stats=(
B => "Banned: cannot login, cannot post",
C => "Disabled: cannot login, cannot post",
V => "Validated: pending approval, cannot post",
A => "Active Member"
);

%abmain::thread_sorters =(
yTz=>"Last post time in the thread",
zCz=>"Average post time in the thread",
mM=>"First post time in the thread",
hC=>"Author name",
wW=>"Topic",
fI =>"Message sequence number",
size=>"Message size",
mood=>"Message emotion",
sort_key=>"Message sort key"
);
@abmain::cat_tags=qw(AB_CAT_DESC AB_CAT_NAME AB_CAT_NEWS AB_CAT_GUIDE AB_SUGGEST_CAT_LNK AB_CREATE_CAT_LNK AB_CAT_FORUM_LIST AB_VIEW_CAT_LIST_LNK
AB_CREATE_FORUM_LNK AB_SUB_CAT_LIST AB_MODIFY_CAT_LNK
);

@abmain::months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

%abmain::user_types=(
A =>"A: can't post",
B =>"B: access restricted",
C =>"C: post moderated",
D =>"D: not in use",
E =>"E: full access",
F =>"F: not in use",
);

@abmain::error_cfg=([e_info =>"head", "Error message"]);

for(keys %abmain::cP) {
 $ecref = $abmain::cP{$_};
 push @error_cfg, [$_."_e0", "text", qq(size="40"), $ecref->[0]. "(short)", $ecref->[0]];
 push @error_cfg, [$_."_e1", "text", qq(size="40"), $ecref->[0]. "(description)", $ecref->[1]];
 push @error_cfg, [$_."_e2", "text", qq(size="40"), $ecref->[0]. "(suggestion)", $ecref->[2]];
};

@abmain::core_cfgs=();

@abmain::forum_org_info_cfgs=(
[global_info =>"head", "Organization Information"], 
[ab_org_name =>"text", qq(size="40"), "Organization name (ORG_NAME)"],
[ab_org_url=>"text", 'size="40"', "Organization home URL (ORG_URL)"],
[ab_org_logo=>"htmltext", qq(rows="4" cols="40"), "Organization logo HTML code (OR_LOGO)"],
[ab_org_contact_info=>"textarea", qq(rows="3" cols="40"), "Organization contact information (ORG_CONTACT_INFO)"],
[ab_org_address=>"textarea",  qq(rows="3" cols="40"), "Organization address (ORG_ADDRESS)"],
[ab_org_copyright=>"textarea", qq(rows="3" cols="40"), "Organization copyright notice (ORG_COPYRIGHT)"],
[ab_org_help_info=>"htmltext", qq(rows="3" cols="40"), "Organization site help information link (ORG_HELP_INFO)"],
[ab_org_service_info=>"htmltext", qq(rows="3" cols="40"), "Organization customer service information link (ORG_SERVICE_INFO)"],
[ab_org_about_info=>"htmltext", qq(rows="3" cols="40"), "Organization about us information link (ORG_ABOUT_INFO)"],
[ab_org_news_info=>"htmltext", qq(rows="3" cols="40"), "Organization news information link (ORG_NEWS_INFO)"],
[ab_org_search_box=>"htmltext", qq(rows="3" cols="40"), "Organization search box HTML (ORG_SEARCH_BOX)"],
[ab_org_products_info=>"htmltext", qq(rows="3" cols="40"), "Organization products information link (ORG_PRODUCTS_INFO)"],
[ab_org_sales_info=>"htmltext", qq(rows="3" cols="40"), "Organization sales information link (ORG_SALES_INFO)"],
[ab_org_partner_info=>"htmltext", qq(rows="3" cols="40"), "Organization partner information link (ORG_PARTNER_INFO))"],
[ab_org_top_nav_bar=>"htmltext", qq(rows="3" cols="40"), "Organization site page top navigation bar (ORG_TOP_NAV_BAR))"],
[ab_org_left_bar=>"htmltext", qq(rows="3" cols="40"), "Organization site page left side bar (ORG_LEFT_BAR))"],
[ab_org_right_bar=>"htmltext", qq(rows="3" cols="40"), "Organization site page right side bar (ORG_RIGHT_BAR))"],
[ab_org_bottom_nav_bar=>"htmltext", qq(rows="3" cols="40"), "Organization site page bottom navigation bar (ORG_BOTTOM_NAV_BAR))"],
[ab_org_top_banner=>"htmltext", qq(rows="3" cols="40"), "Organization site page top banner (ORG_TOP_BANNER))"],
[ab_org_bottom_banner=>"htmltext", qq(rows="3" cols="40"), "Organization site page bottom banner (ORG_BOTTOM_BANNER))"],
);

push @abmain::core_cfgs, qw(ab_org_name ab_org_url ab_org_logo ab_org_copyright);
@abmain::rC = (
["forum_cfg", "head", "Forum Name And File Extension"], 
["name", "text", qq(size="60"), "Name of the Forum", "Forum Powered By AnyBoard"], 
[forum_desc =>"htmltext", qq(rows="3" cols="48"), "Forum Description", ""],
[forum_desc_full=> "htmltext", "rows=6 cols=48 wrap=soft", "Forum detail description",], 
[forum_idx=>"text", "", "Forum sort key used for the ablist command. Forum name will be used if this is not set.", ""],
[forum_logo=>"icon", qq(size="40"), "Logo HTML of the forum", qq(<img src="$abmain::img_top/idea.gif">)],
[forum_cat =>"text", qq(size="20"), "Category index of the forum (must match the one of the index defined in master admin)", "A"],
["no_list_me", "checkbox", qq(value="1"), "Do NOT list this forum", "0"], 
["no_list_moders", "checkbox", qq(value="1"), "Do NOT show moderators of this forum", "0"], 
[iGz=> "text", qq(size="40"), "License key", ""],
["aC", "text", qq(size="60"), "File name of the main forum page", "index.html"], 
[idx_file =>"text", qq(size="60"), "Name of the group interface page", "gindex.html"],
[links_file =>"text", qq(size="60"), "Name of the links page", "links.html"],
["pollidxfile", "text", qq(size="60"), "File name of the poll index page", "index.html"], 
["ext",  "text", 'size="10"', "Extension of other HTML files, such as html, shtml", "html"],
["txt_encoding",  "text", 'size="10"', "Text encoding", "iso-8859-1"],
["passd",  "text", 'size="60"', "Absolute path to password directory, if different from default", ""],
["seqdir",  "text", 'size="60"', "Absolute path to sequence number directory, if different from default", ""],
);

push @abmain::core_cfgs, qw(name forum_desc forum_desc_full forum_logo forum_cat);

@abmain::aclist= keys %abmain::user_stats;
@abmain::utlist= keys %abmain::user_types;
@abmain::tslist= keys %abmain::thread_sorters;
$user_stat_sel = abmain::aRa(\%abmain::user_stats, \@abmain::aclist);
$user_type_sel = abmain::aRa(\%abmain::user_types, \@abmain::utlist);
$thread_sort_sel = abmain::aRa(\%abmain::thread_sorters, \@abmain::tslist);

@abmain::eT = (
["pol_info", "head", "Forum Control Policy"], 
[mFa=>"checkbox", qq(value="1"), "Make forum page dynamic", 0],
[dyna_forum=>"checkbox", qq(value="1"), "Make all pages dynamic, no direct HTML page access (CPU intensive)", 0],
[publish_ulist=>"checkbox", qq(value="1"), "Publish active user list", 1],
#x1
#x1
["short_reg_form", "checkbox", qq(value="1"), "Use short user registration form", "1"], 
["random_seq", "checkbox", qq(value="1"), "Randomize message sequence numbers", "0"], 
["force_cookie", "checkbox", qq(value="1"), "Require posters to enable Cookies", "0"], 
["xC", "checkbox", qq(value="1"), "Display aliases of the author", "1"], 
["yJz", "checkbox", qq(value="1"), "Do NOT display administrator aliases", "1"], 
["auto_fill", "checkbox", qq(value="1"), "Auto fill E-mail address", "1"], 
[gOz=>"checkbox", qq(value="1"), "Do NOT show link to forum on login and register form.", "0"],
[gBz => "checkbox", qq(value="1"), "Allow users to register with name and password.", "1"],
[gAz => "checkbox", qq(value="1"), "Enforce user password registration. User must be authenticated to post message", "0"],
[ask_on_reg=> "checkbox", qq(value="1"), "User must answer the following question correctly to register.", "0"],
[reg_question=>"text",  qq(size="60"), "Question to ask on registration.", "Which forum software is the best?"],
[reg_answer=>"text", qq(size="60"), "Answer to the question above", "AnyBoard"],
["inval_ans_err", "textarea", "", "Error message when registering user does not answer question correctly", "You did not correctly answer the question"],
[redir_typed=>"text", qq(size="40"), "Redirect user of type D to the following URL when posting", ""],
[redir_typef=>"text", qq(size="40"), "Redirect user of type F to the following URL when posting", ""],
[force_http_auth => "checkbox", qq(value="1"), "Poster must be authenticated by http server", "0"],
[http_auth_only => "checkbox", qq(value="1"), "Always use http server authenticated REMOTE_USER as Poster name", "0"],
[bUz=> "checkbox", qq(value="1"), "Do not share user and password among different forums", "0"],
#x1
#x1
#x1
[local_control=> "checkbox", qq(value="1"), "When users are shared among different forums, enable local control ", "0"],
[record_rhost=> "checkbox", qq(value="1"), "Record posters' hostname besides IP address", "0"],
#x1
[no_moder_priv=> "checkbox", qq(value="1"), "Do NOT moderate private messages", "1"],
#x1
#x1
[fBz=> "checkbox", qq(value="1"), "CC validation e-mail to admin", "0"],
[mWz=> "checkbox", qq(value="1"), "Allow user to request new password back by email", "1"],
["jDz",  "text", qq(size="60"), "List of forbidden email patterns separated by |", "\@free_email.com|\@junk_mail.com"],
["allowed_emails",  "text", qq(size="60"), "List of allowed email patterns separated by |", ""],
[enable_login => "checkbox", qq(value="1"), "Enable user login. Once logged in, user does not need to enter user name again", "1"],
[tHa => "checkbox", qq(value="1"), "Require user to login first to post message", "0"],
#x1
#x1
#x1
[allow_body_search=> "checkbox", qq(value="1"), "Allow user to search message body (CPU intensive)", "0"],
[allow_umail=> "checkbox", qq(value="1"), "Allow user to send emails to each other", "1"], 
["forbid_names",  "text", qq(size="60"), "List of forbidden names separated by |", "TEST"],
[sF =>"text", "size=16", "Disallow user after this many violations", "4"],
#x1
[vAz=> "text", '', "Minimum interval between posting stats generation (in seconds)", "7200"],
[kXz=> "checkbox", qq(value="1"), "Delete uploaded file when automatic purge ", "1"],
#x1
#x1
#x1
[pH => "checkbox", qq(value="1"), "Log errors", "0"],
[qG=> "checkbox", qq(value="1"), "Enable file locking for maximum system integrity. Use this feature if your system supports it", "1"],
[disk_quota=>"text", "", "Maximum disk usage in MB (unit is MB)", "500"],
);

push @abmain::core_cfgs, qw(gBz gAz aWz require_email_nv rH enable_login tHa);
push @abmain::core_cfgs, qw(forbid_words filter_words xD lDz upfile_ext eJ);

@abmain::tL=(
["pol_info", "head", "Forum Posting Restriction "], 
["enable_voting", "checkbox", qq(value="1"), "Enable poll function", "1"],
["gMz", "checkbox", qq(value="1"), "Allow only admin or moderator to post new message", "0"],
#x1
#x1
#x1
#x1
["eJ", "checkbox", qq(value="1"), "Disallow posting. Freeze the forum", "0"],
["gL", "checkbox", qq(value="1"), "Disable followup.", "0"],
["fW", "checkbox", qq(value="1"), "Disable message link threading. Show message links linearly", "0"],
["forbid_words", "perlre", qq(size="60"), "List of forbidden words and patterns, separated by | (or any Perl RE)", "dirtyword1|dirtyword2"],
["filter_words", "perlre", qq(size="60"), "List of filtered words/patterns which will be silently replaced by blanks, separated by | (or any Perl RE)", ""],
["xD", "perlre", qq(size="60"), "List of blocked IP addresses, separated by | (or a general RE)", ""],
["allowed_ips", "perlre", qq(size="60"), "List of allowed IP addresses, separated by | (or a general RE)", ""],
#x1
#x1
#x1
[scare_msg=> "htmltext", qq(rows="4" cols="60" wrap="soft"), "Warning message when forbidden words are detected", qq(<font color="red" size="+1"><b>If you continue to use forbidden language, you will be disallowed from this forum. </font>)],
[scare_adm_msg=> "htmltext", 'rows=4 cols=48 wrap=soft', "Warning message when failed admin login is detected", qq(<font color="red" size="+1"><b>This area is restricted. Try to gain unauthorized access is unlawful !!!!</b></font>\n)],
[qV => "checkbox", qq(value="1"), "Allow HTML in message body", "1"],
[mKz => "checkbox", qq(value="1"), "Strip HTML tags in message body", "0"],
[no_carry_subj=> "checkbox", qq(value="1"), "Do NOT carry subject line over in reply", "0"],
[qNz=> "checkbox", qq(value="1"), "Collapse multiple REs", "1"],
[hBz=> "checkbox", qq(value="1"), "Quote original text when reply", "0"],
[xL=>"checkbox", qq(value="1"), "Allow user to add link URL", "1"],
[oPz=>"checkbox", qq(value="1"), "Do not show related link in message", "0"],
[xA=>"checkbox", qq(value="1"), "Allow user to add image", "0"],
[take_email=>"checkbox", qq(value="1"), "Allow user to input e-mail address", "0"],
[take_sort_key=>"checkbox", qq(value="1"), "Allow admin to set sort key for messages", "0"],
[take_key_words=>"checkbox", qq(value="1"), "Allow user to set key words for messages", "0"],
[qCz=>'checkbox', qq(value="1"), "Allow admin to add links, even if it is generally disabled", "0"], 
[take_file=>"checkbox", qq(value="1"), "Enable file uploading", "1"], 
#x1
#x1
#x1
[pIz=>"checkbox", qq(value="1"), "Do not show uploaded files in message", "0"],
[oLz=>"checkbox", qq(value="1"), "Do not allow read access to uploaded files", "0"],
[qDz=>"checkbox", qq(value="1"), "Allow overwrite uploaded files", "0"],
[auto_rename_file=>"checkbox", qq(value="1"), "Automatically rename uploaded file if a file with the same name exists", "1"],
[rL => "checkbox", qq(value="1"), "Allow user to modify message after posting", "1"],
[link_edit => "checkbox", qq(value="1"), "Link user name on the index page to modify message page", "1"],
[allow_usr_collapse=> "checkbox", qq(value="1"), "Allow user to collapse or close their threads", "1"],
#x1
[gZz => "checkbox", qq(value="1"), "Message can be modified only if posted by registered user", "1"],
[bGz=> "checkbox", qq(value="1"), "Allow user to delete message after posting", "0"], 
[allow_del_priv=> "checkbox", qq(value="1"), "Always allow user to delete his private message", "1"],
#x1
[rR => "checkbox", qq(value="1"), "Allow message body to be empty", "1"],
[allow_no_reply => "checkbox", qq(value="1"), "Allow user to disallow replies to his posts", "1"],
[oCz => "checkbox", qq(value="1"), "Fix subject to Re: old subject", "0"],
[zP=> "checkbox", qq(value="1"), "Allow user to rate the posts", "1"],
[rate_low=> "text", "", "Lowest rate", "-5"],
[rate_high=> "text", "", "Highest rate", "5"],
[rTz=> "text", "", "Offset rate display by (so fraction will show up as 1)", "0.3"],
[rRz=> "checkbox", qq(value="1"), "Only registered user can rate", "0"],
[rate_wt_reg=> "text", qq(size="4"), "Rate weight of registered users", "1"],
[rate_wt_adm=> "text", qq(size="4"), "Rate weight of administrator", "5"],
[bLz=> "text", "", "Show rating only after this many votes", "2"],
[min_rate=> "text", "", "Do not display posts with rating lower than", "0"],
[rYz=> "text", "", "Hide low rating posts only after this many votes", "2"],
[qJ => "text", "", "Maximum length of message subject", "160"],
[xVz => "text", "", "Truncate subject displayed on main index to this many characters", "160"],
[sO => "text", "", "Maximum length of author name", "40"],
[name_hacks=> "text", qq(size="60"), "Auto Posting Names(seprate by ,)", "admin"],
[rUz=>"checkbox", qq(value="1"), "Limit text field length to the allowed length", "1"],
[qK => "text", "", "Maximum length of message body", "64000"],
[yR => "checkbox", qq(value="1"), "Allow duplicated subject from same IP", "0"],
[yN => "text", "", "Minimum time interval between two posts from the same IP (unit is second)", "10"],
[max_match_cnt=> "text", "", "Maximum number of matches returned from a search", "500"],
#x1
#x1
[hQaA=>"checkbox", qq(value="1"), "Auto delete user's old posts if all time posting limit above is exceeded", "0"],
#x1
#x1
[max_extra_uploads=> "text", "", "Maximum number of additional files to be uploaded in a post", "5"],
#x1
[yU=>"text", "size=8", "E-mail Admin if 20 messages arrive within less than this many seconds", "0"],
[qR=>"checkbox", qq(value="1"), "Allow user to view configurations of the forum", "0"],
["rule_file"=> "text", qq(size="60"), "Physical path (not URL) to the forum usage agreement file", ""],
["rules"=> "htmltext", 'rows=8 cols=48', "OR: Forum usage rules", ""],
);

@abmain::eWz =(
[jQ => "head", "Forum Font Configuration"], 
[topic_font=>"text", qq(size="40"), "Font attribute of the subject of the top message", $abmain::dfa],
[eSz=>"text", qq(size="40"), "Font attribute of the message subject", $abmain::dfa],
[fEz=>"text", qq(size="40"), "Font attribute of the author name", $abmain::dfa],
[author_font_msg=>"text", qq(size="40"), "Font attribute of the author name inside message", $abmain::dfa],
[reg_author_font=>"text", qq(size="40"), "Font attribute of registered author", qq($abmain::dfa color="#000099")],
[fCz=>"text", qq(size="40"), "Font attribute of the posting date in message list", $abmain::dfa],
[date_font_msg=>"text", qq(size="40"), "Font attribute of the posting date in message body", $abmain::dfa],
[eVz=>"text", qq(size="40"), "Font attribute of the posting size", $abmain::dfa],
[eTz=>"text", qq(size="40"), "Font attribute of the visit count", $abmain::dfa],
[followcnt_font=>"text", qq(size="40"), "Font attribute of the followups count", $abmain::dfa],
[fHz=>"text", qq(size="40"), "Font attribute of the message body", $abmain::dfa],
[quote_txt_font=>"text", qq(size="40"), "Font attribute of quoted text", qq($abmain::dfa color="#222233")],
[abs_font=>"text", qq(size="48"), "Font attribute of the message abstract", qq(size=1)],
[fDz=>"text", qq(size="40"), "Font attribute of the forum name on the nav bar", $abmain::dfa],
[msg_cnt_font=>"text", qq(size="40"), "Font attribute of the message counter on the nav bar", qq(size=1)],
[eYz=>"text", qq(size="40"), "Font attribute of the message title (in message file)", qq(face="Verdana" size="+1")],
[cRz=>"text", qq(size="40"), "Font attribute of admin name when posting", "color=red $abmain::dfa"],
[moder_font=>"text", qq(size="40"), "Font attribute of moderator name when posting", "color=#cc0000 $abmain::dfa"],
[user_fonts=>"textarea", "rows=6 cols=48", "Font attribute of selected user names, in the format: user=font_attribute, one on each line.  ",  qq(user1=color="red"\nuser2=color="red" face="Arial")],
[user_fonts_url=>"text", qq(size="60"), "URL of user name font attribute file, this must be a text file in the format described above.", qq(http://)],
[user_subj_fonts=>"textarea", "rows=6 cols=48", "Font attribute of subjects by selected user names, in the format: user=font_attribute, one on each line.  ",  qq(user1=color="red"\nuser2=color="red" face="Arial")],
[cfg_head_font =>'text', qq(size="40"), "Font attribute of the heading in config forms", qq(size="2" face="Verdana" color="#000000")],
[lab_font =>'text', qq(size="40"), "Default font attribute of the labels", qq(color="#000000" face="Verdana" size="1")],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

@abmain::group_setting = qw(
[displayinfo=>"head", "Group settings"],
["auto_fill", "checkbox", qq(value="1"), "Auto fill E-mail address", "1"], 
[record_rhost=> "checkbox", qq(value="1"), "Record posters' hostname besides IP address", "0"],
[allow_body_search=> "checkbox", qq(value="1"), "Allow user to search message body (CPU intensive)", "0"],
[allow_umail=> "checkbox", qq(value="1"), "Allow user to send emails to each other", "1"], 
[sF =>"text", "size=16", "Disallow user after this many violations", "4"],
[take_file=>"checkbox", qq(value="1"), "Enable file uploading", "1"], 
#x1
[rL => "checkbox", qq(value="1"), "Allow user to modify message after posting", "1"],
#x1
[qDz=>"checkbox", qq(value="1"), "Allow overwrite uploaded files", "0"],
[topic_font=>"text", qq(size="40"), "Font attribute of the subject of the top message", $abmain::dfa],
[eSz=>"text", qq(size="40"), "Font attribute of the message subject", $abmain::dfa],
[fEz=>"text", qq(size="40"), "Font attribute of the author name", $abmain::dfa],
[author_font_msg=>"text", qq(size="40"), "Font attribute of the author name inside message", $abmain::dfa],
[fHz=>"text", qq(size="40"), "Font attribute of the message body", $abmain::dfa],
[eYz=>"text", qq(size="40"), "Font attribute of the message title (in message file)", qq(face="Verdana" size="+1")],
);
@abmain::lAz =(
[jQ => "head", "Emotion Icon Configuration "], 
[allow_mood => "checkbox", qq(value="1"), "Allow showing mood", "1"],
[sm_happy=>"icon", qq(size="60"), "Happy smiley", qq(<img src="$abmain::img_top/smile.gif" alt="Smile">)],
[sm_sad=>"icon", qq(size="60"), "Sad", qq(<img src="$abmain::img_top/sad.gif" alt="Sad">)],
[sm_scream=>"icon", qq(size="60"), "Screaming", qq(<img src="$abmain::img_top/yuk.gif" alt="Yell">)],
[sm_angry=>"icon", qq(size="60"), "Angry", qq(<img src="$abmain::img_top/angry.gif" alt="Angry">)],
[sm_laugh=>"icon", qq(size="60"), "Laughing", qq(<img src="$abmain::img_top/question.gif" alt="Question">)],
[sm_kiss=>"icon", qq(size="60"), "Kiss", qq(<img src="$abmain::img_top/idea.gif" alt="Idea">)],
[sm_x1=>"icon", qq(size="60"), "Mood +1", qq(<img src="$abmain::img_top/agree.gif" alt="Agree">)],
[sm_x2=>"icon", qq(size="60"), "Mood +2", qq(<img src="$abmain::img_top/disagree.gif" alt="Disagree">)],
[sm_x3=>"icon", qq(size="60"), "Mood +3", ''],
[sm_x4=>"icon", qq(size="60"), "Mood +4", ''],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

push @abmain::core_cfgs, qw(allow_mood sm_happy sm_sad sm_scream sm_angry sm_laugh sm_kiss);

#[show_menu=>"checkbox", qq(value="1"), "Display popup menu", "0"],

@abmain::cSa =(
[jQ => "head", "Message Category Configuration "], 
[allow_subcat=> "checkbox", qq(value="1"), "Enable message category", "0"],
[no_null_subcat=> "checkbox", qq(value="1"), "User must select a category", "1"],
[show_cat_jump=> "checkbox", qq(value="1"), "Display jump box for categories", "1"],
[grp_subcat=> "checkbox", qq(value="1"), "Group messages by category", "1"],
[scat_font=>"text", qq(size="48"), "Font attribute of the message category", $abmain::dfa],
[scat_tb_attr=>"textarea", "rows=2 cols=48", "Additional table attribute of the category heading",qq(border="0" bgcolor="#ffffcc")],
[scat_use_radio=> "checkbox", qq(value="1"), "Use radio buttons instead of select box for category choices. This is necessary if you want to use html code such as IMG TAG in labels.", "0"],
[catopt=>"textarea", qq(rows="16" cols="48"), "User category choices, one per line, in the format index=label. Categories will be listed in ascending order of indexes.","", undef, "=Select Category\nB=General Discussions\nC=Questions"],
[hBa=>"textarea", qq(rows="16" cols="48"), "Additional categories choices restricted to administrator, one per line, in the format index=label. These categories will be combined with the categories above. Their indices cannot overlap.","", undef, "1=Announcements\nx=AnyBoard Usage "],
[scat_fix=>"text", "", "Category index for messages without a category, such as old messages", ""],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

push @abmain::core_cfgs, qw(allow_subcat scat_font scat_tb_attr catopt);

@abmain::cRa=(
[jQ => "head", "Form Mail Configuration"], 
[fm_instruct=>'const', "", "Instruction", qq!AnyBoard can be used to process any web forms, including forms with file-upload fields, and save or email the result back to you. 
To use it, set the ACTION of your form to http://your-domain/your-cgi-dir/anyboard.cgi/iGa/, and add a hidden field named
"cmd" with value equals "procform"<br>(&lt;input type="hidden" name="cmd" value="procform"&gt;)!],
[cNa=> "checkbox", qq(value="1"), "Enable web form processing", "1"],
[formreferer_match=>"text", qq(size="48"), "HTTP referer must match this pattern", ""],
[cLa=> "checkbox", qq(value="1"), "User must login AnyBoard to use the form mail", "0"],
[cVa=>"textarea", "cols=48 rows=2", "E-mail(s) of the recipient(s)", ""],
[cWa=>"text", qq(size="40"), "Directory to store uploaded files ( if not set uploaded files will be discarded )", ""],
[cMa=>"textarea", "cols=48 rows=6 wrap=soft", "Header of the form submission confirmation page", "<html><body>"],
[cPa=>"textarea", "cols=48 rows=6 wrap=soft", "Footer of the form submission confirmation page", "</body></html>"],
);

@abmain::forum_style_cfgs=(
[jQ => "head", "Forum Style"], 
[try_wysiwyg=> "checkbox", qq(value="1"), "Enable WYSIWYG HTML editing for IE browser", "1"],  
[sAz=> "textarea", "rows=8 cols=48 wrap=soft ", "Forum style code", 
qq(<STYLE type="text/css">
<!--
H1 {font-size: 20pt; text-align: center}
TH {font-size: 11pt; font-family: "Arial, Helvetica, sans-serif"}
HTML, BODY, TD {font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"}
UL {list-style: disc}
DIV.ABMEMBERLIST TD {font-size: 8pt; color: #003300; font-family: "Arial, Helvetica, sans-serif"}
DIV.ABMSGBODY {font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"}
DIV.ABCONFLIST TD{font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"}
A:hover { color: #007FFF; text-decoration: underline; background-color: #ffee00;}
.ABMSGLIST, .ABMSGBODY, .PFTDL, .PFTDR, .CHATAREA {font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"}

/*The message area */
.ABMSGAREA {font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"; text-align: center}

/*Table of the navigation bar*/
TABLE.NAV A{color:#000000; font-weight:900; text-decoration: none}

/*Left TD of the configuration forms */
TD.PFTDL {background-color: #666666; color: #ffffff}

/*Table contains configuration form */
TABLE.CFG { background-color: #000000; border-width: 1; border-color: #666666; border-style: solid; }

/*Header of the row-column data table */
TD.RowColTableHeader {font-size: 12pt; font-family:Verdana; font-weight: bold; }
TD.RowColTableSubHeader {font-size:12pt; font-family:Arial; font-weight: bold; }

/*Bottom TD of the row-column data table */
TD.RowColTableCaption {background-color: #dddddd}

/*Table contains the even numbered threads*/
TABLE.ThreadTable0 {border:0}

/*Table contains the odd numbered threads*/
TABLE.ThreadTable1 {border:0}

/*Row for the message header */
TR.MsgRowHeader {background-color: #000044; color: #ffcc00; font-family: Verdana; font-weight:bold; font-size:14px}
TR.MsgRowHeaderBottom {background-color: #000044; color: #ffcc00; font-family: Verdana; font-weight:bold}

/*Table that contains the post message form */
TABLE.PostMessageForm { border-width:1; border-color: #666666; border-style: solid; }

/*Table that contains the polls */
TABLE.PollsTable{ border-width:1; border-color: #666666; border-style: solid; }

/*Text prompt on the configuration forms */
.AB-form-prompt { font-family: Arial; font-size: 14pt; }

/*The span that contains chat user name*/
.ChatUserName {}

/*The span that contains one line of chat message*/
.ChatMessageLine {}

-->
</STYLE>
)],
#x1
#x1
[nolink_nt=> "checkbox", qq(value="1"), "Do not link to empty message on index page", "1"],
[xYz=>"textarea", "rows=1 cols=48 wrap=soft", "Additional attribute for the message links", qq(STYLE="text-decoration: none")],
[xXz=>"textarea", "rows=1 cols=48 wrap=soft", "Additional attribute for the author name links", ""],
[yAz=>"textarea", "rows=1 cols=48 wrap=soft", "Additional attribute for the related link inside a message", ""],
[xZz=>"textarea", "rows=1 cols=48 wrap=soft", "Additional attribute for the user added link inside a message", ""],
[tz_offset=>"text",  "size=4", "Offset time display by this many hours (can be negative)", "0"], 
[lJ => "checkbox", qq(value="1"), "Inline followup messages", "0"],
[aO => "checkbox", qq(value="1"), "Inline all messages (like a guest book)", "0"],
[mJ => "checkbox", qq(value="1"), "Thread inline message text", "0"],
["flat_tree", "checkbox", qq(value="1"), "Flatten the message threads", "0"],
[no_show_poster=> "checkbox", qq(value="1"), "Do NOT display author name on index page", "0"],
[no_show_time=> "checkbox", qq(value="1"), "Do NOT display posting time on index page", "0"],
[top_abstract_len=> "text", '', "Maximum length of abstract of top level topic ( set to 0 to disable )", "0"],
[auto_href_abs=> "checkbox", qq(value="1"), "Auto link URLs in the abstract", "1"],
[read_more_abs=> "checkbox", qq(value="1"), "Show read more link at the end of abstract", "1"],
[abs_begin => "textarea", qq(rows="4" cols="60"), "HTML code before the abstract", qq(<div style="margin-left: 3mm; margin-right:3mm">)],
[abs_end=> "text", qq(size="48"), "HTML code after the abstract", qq(...</div>)],
[collapse_age=>"text",  "size=4", "Collapse threads older than this many hours", "24000"], 
[hG=>"text", "", "Depth of links on main page", ""],
[no_links_inmsg=>"checkbox", qq(value="1"), "Do not show links to replies inside message", "0"],
[yVz => "select", $thread_sort_sel, "Sort threads by", "mM"],
[revlist_topic => "checkbox", qq(value="1"), "List threads in ascending order ( older thread on TOP if time is used for sorting )", "0"],
[revlist_reply => "checkbox", qq(value="1"), "List old replies first", "1"],
[use_square=>"checkbox", qq(value="1"), "Use square for unordered list", "0"],
[no_li=>"checkbox", qq(value="1"), "Do not use list item for threaded messages", "0"],
[lVz=>"checkbox", qq(value="1"), "Do not use unorder list to thread messages, use spacers for indentation", "0"],
[lUz=>"text", qq(size="60"), "Indentation spacer before message links if is not used", "<font color=#ffffff>-----</font>"],
[mAz=>"checkbox", qq(value="1"), "Align message links ( subject, name, date ) in columns", "0"],
[qLz=>"text", qq(size="60"), "Attribute of the subject column", qq(width="60%")],
[qMz=>"text", qq(size="60"), "Attribute of the name column", qq(width="15%" bgcolor="#eeeeff")],
[qPz=>"text", qq(size="60"), "Attribute of the date column", qq(width="25%" align=right bgcolor="#ffffcc")],
[align_col_new=>"checkbox", qq(value="1"), "Align message attributes with the following row layout, this setting allows great flexibility and override the settings above ", "0"],
[msg_row_layout=>"textarea", "rows=8 cols=70", "Layout of the message row. AnyBoard will wrap your layout with a TR element , so the layout must consist of TD tags. Available macros:<br>".join("<br>", @lB::msg_macs),
qq(
<td width="20">MSG_STAT_TAG</td>
<td width="20" bgcolor="#cccccc">MSG_MOOD</td>
<td><MSG_SPACER>MSG_LINK<MSG_FLAGS></td>
<td bgcolor="#cccccc">MSG_POSTER</td> 
<td>MSG_REPLY_CNT</td>
<td>MSG_RATE_LNK</td>
<td nowrap bgcolor="#cccccc">MSG_SIZE</td>
<td nowrap>MSG_TIME</td>
)
],
[msg_row_header=>"textarea", "rows=8 cols=70", "Layout of the message row header. Make sure this matches the row layout", 
qq(
<td width="40" colspan=2></td>
<td>Subject</td>
<td title="Who started this message">Originator</td> 
<td title="Number of replies">Replies</td>
<td title="Average rating">Rating</td>
<td title="Size of the message">Size</td>
<td title="When was the message posted">Time</td>
)
],
[msg_row_header_bottom=>"checkbox", qq(value="1"), "Add message row header at the bottom", "0"],
[sub_top_bottom=>"checkbox", qq(value="1"), "Put new followups of messages on previous page at the end", "0"],
[hEz=>"checkbox", qq(value="1"), "Always show the full thread", "0"],
[yBz=>"checkbox", qq(value="1"), "Try to group followups", "1"],
[show_msgnos4top=>"checkbox", qq(value="1"), "Show message number for top level topic", "0"],
[show_msgnos4sub=>"checkbox", qq(value="1"), "Show message number for followups", "0"],
[bOz=>"checkbox", qq(value="1"), "Show subject in bold text", "0"],
[jCa=>"checkbox", qq(value="1"), "Show dates in numeric format", "1"],
[bKz=>"checkbox", qq(value="1"), "Show dates in short format", "0"],
[day_date=>"checkbox", qq(value="1"), "Show dates in shortest format (month day)", "0"],
[posix_date=>"checkbox", qq(value="1"), "Show dates in POSIX strftime format below (this takes highest precedence)", "0"],
[posix_df=>"text", qq(size="60"), "strftime date format (see manual for formatting options)", '%Y-%m-%d %H:%M'],
[rM=>"checkbox", qq(value="1"), "Show size of message body", "1"],
[yUz=>"checkbox", qq(value="1"), "Show modification time for modified messages", "1"],
[bJz=>"checkbox", qq(value="1"), "Show number of followups to a message", "1"],
[gSz=>"checkbox", qq(value="1"), "Indicate on main page whether the user is registered", "0"],
[xJ=>"checkbox", qq(value="1"), "Indicate if there is an image link in message", "1"],
[show_has_attach=>"checkbox", qq(value="1"), "Indicate if there is an attachment in message", "1"],
[show_has_lnk=>"checkbox", qq(value="1"), "Indicate if there is linked URL in message", "1"],
[show_rate_link_main=>"checkbox", qq(value="1"), "Show rate message link on main index page", "1"],
[dAa=>"checkbox", qq(value="1"), "Display rate after subject instead of date", "0"],
[gNz=>"checkbox", qq(value="1"), "Do not show author's email address in message", "0"],
#x1
[compute_forum_list=>"checkbox", qq(value="1"), "Show links to other forums", "0"], 
[fFz=> "text", "", "Show message which has more than this many visits as hot", "100"],
[redir_onread=> "text", "", "Use redirection on reading messages", "0"],
[iWa=>"checkbox", qq(value="1"), "Do not show navigate and command bar at top", "0"], 
[rV=>"checkbox", qq(value="1"), "Show navigate and command bar at bottom", "1"],
[show_plugin=>"checkbox", qq(value="1"), "Show plugin banner", "1"],
[banner_freq=> "text", "", "Show one banner for this many threads", "10"],
[kF=> "text", "", "Show message less than this many minutes old as new ", "60"],
[adopt_orphan=> "checkbox", qq(value="1"), "Adopt orphan message", "1"],
[bPz=> "checkbox", qq(value="1"), "Add link to URL in the message", "1"],
[qH=> "checkbox", qq(value="1"), "Replace newline with \&lt;br\&gt;", "1"],
[pZz=>"checkbox", qq(value="1"), "Show original message on reply page", "1"],
[xP=>"checkbox", qq(value="1"), "Indent the followup links or texts", "0"],
[iW => "text", '', "Number of message links per page", "32"],
[dDz=>"checkbox", qq(value="1"), "Use frame interface", "0"],
[reverse_frame=>"checkbox", qq(value="1"), "Reverse frame positions", "0"],
[dAz =>"text", qq(size="40"), "Frame set attribute", qq(COLS="40%, *")],
[uE =>"text", qq(size="40"), "URL of the welcome page", "http://netbula.com/anyboard/"],
[display_info2 => "head", "More configurations"], 
[pform_tb_width=>"text", "", "Width of table enclosing the post message form", qq(75%)],
[pform_tb_attr=>"textarea", qq(rows="3" cols="48"), "Additional attributes for the table enclosing the post message form", qq(cellspacing=1 cellpadding=2 align="center")],
[msg_form_cols=>"text", "", "Number of columns of the textarea in the post message form", "64"],
[pform_rows => "text", "", "Number of rows in the post form", "16"],
[rP =>"textarea", qq(rows="3" cols="48"), "Separator between topics", ""],
[sn_sep =>"text", qq(size="60"), "Separator between subject and author name( in non-aligned mode )", " --- "],
[nd_sep =>"text", qq(size="60"), "Separator between author name and posting date( in non-aligned mode )", "("],
[ds_sep =>"text", qq(size="60"), "Separator after posting date ( in non-aligned mode )", ")"],
[dsz_sep =>"text", qq(size="60"), "Separator in front of message size", " ("],
[szo_sep =>"text", qq(size="60"), "Separator between size and the rest", ") "],
[fc_tag => "text", qq(size="60"), "Tag after followups count",  ""],
[topic_tag => "text", qq(size="60"), "Leading TAG in front of topic, such as a folder icon", qq(<img src="$abmain::img_top/folder.gif">)],
[closed_tag => "text", qq(size="60"), "Leading TAG in front of a closed topic", qq(<img src="$abmain::img_top/dark_folder.gif" alt="This thread is closed">)],
[sub_topic_tag => "text", "", "Leading TAG in front of sub topic showing on top", "|__"],
[hSa => "checkbox", qq(value="1"), "Link the TAG in front of sub topic to Top thread", "1"],
[path_list_sep=> "htmltext", "rows=2 cols=48 wrap=soft", "HTML between message path links", " &gt;&gt; "],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

push @abmain::core_cfgs, qw(sAz tz_offset lJ aO hG yVz  
align_col_new msg_row_layout msg_row_header dDz dAz iW);

#[cfg_head_bg =>'color', "", "Background color of the heading in config forms", "#a8a8a8"],
@abmain::forum_color_cfgs=(
[jQ => "head", "Forum Colors & Borders"], 
[cfg_head_bg =>'color', "", "Background color of the heading in config forms", "#6699cc"],
[cfg_bot_bg =>'color', "", "Background color of the submit area in config forms", "#efefee"],
[new_msg_color=> "color", "", "Text color for the date of new messages", "#008800"],
[mod_msg_color=> "color", "", "Text color for the date of newly modified messages", "#990000"],
[cbgcolor0 => "color", qq(size="48"),  "Background color of configure form Entry", "#efefef"],
[cbgcolor1 => "color", qq(size="48"),  "Background color of next configure form Entry", "#ffffff"],
[qP => "color", qq(size="48"), "Background color of topic header,  can be set to empty", "#e5e5d1"],
[qQ => "color", qq(size="48"), "Background color of next topic header",  "#efefef"],
[sM => "color", qq(size="48"), "Text color of topic header",  "#000000"],
[sN => "color", qq(size="48"), "Text color of next topic header", "#000000"],
[sP => "color", qq(size="48"),  "Background color of followups ", "#ffffff"],
[sQ => "color", qq(size="48"),  "Background color of followups of next topic", "#ffffff"],
[padsize => "text", "",  "Size of the space around message links", "2"],
[bdsize => "text", "",  "Width of the border around message links (0 is OK)", "0"],
[lZz => "text", "",  "Width of the border within message links (0 is OK)", "0"],
[bdcolor => "color", qq(size="48"),  "Color of the borders", ""],
[usebd=>"checkbox", qq(value="1"), "Add border around data listing tables", "1"],
[gridtab=>"checkbox", qq(value="1"), "Chessboard table", "0"],
[bIz => "color", qq(size="48"),  "Background color of quoted text ( when replying )", "#e5e5d1"],
[follow_bg => "color", qq(size="48"),  "Background color of the followup links in message", ""],
[xM => "color", qq(size="48"),  "Background color of the post message form", qq(#cccccc)],
[msg_bg=> "color", qq(size="48"),  "Background color of the information pages", "#e5e5d1"],
[cZz => "color", qq(size="48"),  "Background color of the command forms", "#e5e5d1"],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

@abmain::forum_tag_cfgs=(
[jQ => "head", "Tag transformation"], 
[forum_tag_trans=>"textarea", "rows=28 cols=48", "Text transformation table, one per line, in the format text=replacement. Clear off to disable.", qq!:)=<img src="$abmain::img_top/smile_rotate.gif" border="0">!],
[kMa =>"checkbox", qq(value="1"), "Transform subject", "1"],
[kNa=>"textarea", "rows=28 cols=48", "Text transformation table used inside messages only.", ""],
[avatar_trans=>"textarea", "rows=16 cols=60", "Avatars table, one per line, in the format id=img . Clear off to disable.", 
qq!barney_rubble=<img src="$abmain::img_top/ava_barney_rubble.gif">
bart=<img src="$abmain::img_top/ava_bart.gif">
biz_man=<img src="$abmain::img_top/ava_biz_man.gif">
blonde=<img src="$abmain::img_top/ava_blonde.gif">
brutus=<img src="$abmain::img_top/ava_brutus.gif">
duck=<img src="$abmain::img_top/ava_duck.gif">
felix_cat=<img src="$abmain::img_top/ava_felix_cat.gif">
garfield=<img src="$abmain::img_top/ava_garfield.gif">
gentleman=<img src="$abmain::img_top/ava_gentleman.gif">
girl=<img src="$abmain::img_top/ava_girl.gif">
girl_big_eye=<img src="$abmain::img_top/ava_girl_big_eye.gif">
huckleberryhound=<img src="$abmain::img_top/ava_huckleberryhound.gif">
inspector=<img src="$abmain::img_top/ava_inspector.gif">
penguin=<img src="$abmain::img_top/ava_penguin.gif">
poo_bear=<img src="$abmain::img_top/ava_poo_bear.gif">
popeye=<img src="$abmain::img_top/ava_popeye.gif">
red_nose=<img src="$abmain::img_top/ava_red_nose.gif">
sylvester=<img src="$abmain::img_top/ava_sylvester.gif">
tweetybird=<img src="$abmain::img_top/ava_tweetybird.gif">
white_rabbit=<img src="$abmain::img_top/ava_white_rabbit.gif">
young_man=<img src="$abmain::img_top/ava_young_man.gif">
!],
);

@abmain::fetch_url_cfg=(
[jQ => "head", "Download remote web objects to server"], 
[urls=>"textarea", "rows=28 cols=60", "URLs to download, one per line"],
);

@abmain::search_member_form=(
[jQ => "head", "Search members"], 
[pat=> "text", qq(size="40"), "Match pattern"], 
[any=>"label", "", "Registration day range", qq(From <input type="text" size="4" name="hIz" value="7"> days ago, to <input type="text" size=4 name="hJz" value="0"> days ago)],
[cmd=>'hidden', "", "", "kPz"],
[regmatch=>'hidden', "", "", "1"],
);
@abmain::tG=(
[jQ => "head", "Forum Presentation"], 
[display_info1 => "head", "Forum Index Page"], 
[forum_header=> "hidden", "rows=6 cols=48 wrap=soft", "Forum header HTML, starting from \&lt;html\&gt;", ""],
[forum_banner=> "htmltext", "rows=6 cols=48 wrap=soft", "Forum banner HTML above the Top nav bar", 
qq(<p align="right"><LOGIN_USER><br><LOCAL_USER_LIST><br><PRIVATE_MSG_ALERT></p>)],
[forum_bottom_banner=> "htmltext", "rows=8 cols=48", "Forum bottom banner.", qq(<p align=right style="margin-right:5%">Powered by <a href="http://netbula.com/anyboard/">AnyBoard</a></p>)],
[forum_layout =>"hidden", "", "Forum index page layout"],
[forum_layout_new =>"htmltext", qq(rows="16" cols="48"), "Forum index page layout (must contain macro FORUM_MSG_AREA)", 
qq(
<html>
<head>
</head>
<body>

<!---begin-->

<center>FORUM_AD</center>
FORUM_TOP_BANNER<br>
<center>
FORUM_DESC_FULL
FORUM_MSG_AREA
</center>
FORUM_BOTTOM_BANNER

<!---end-->

</body>
</html>
)],
[cWz=> "htmltext", "rows=6 cols=48 wrap=soft", "HTML between TOP navigation bar and message list",""],
[cYz=>"text", "", "Width of the message link area", "90%"],
[cXz=> "htmltext", "rows=6 cols=48 wrap=soft", "HTML between message list and bottom navigation bar ( if present )", ""],
[forum_footer=> "hidden", "rows=8 cols=48", "Forum footer HTML.", ''],

[display_info2 => "head", "Other Pages"], 
[form_banner=> "textarea", "rows=6 cols=48 wrap=soft", "Post form banner HTML"],
[regform_banner=> "textarea", "rows=8 cols=48", "Banner HTML of registration page"],
[loginform_banner=> "textarea", "rows=8 cols=48", "Banner HTML of login page"],

[other_page_layout=> "htmltext", "rows=16 cols=48 wrap=soft", "HTML template of other pages (must contain macro PAGE_CONTENT)", 
qq(<html>
<head></head>
<body bgcolor="#ffffff">
PAGE_CONTENT
</body>
</html>
)],

[other_header=> "hidden", "", "Header HTML of other pages, starting from \&lt;/head\&gt;\&lt;body\&gt;"],
[other_footer=> "hidden", "", "Footer HTML of other pages, ending with \&lt;/body\&gt; \&lt;/html&gt;", ""],

[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

push @abmain::core_cfgs, qw(forum_header forum_banner cYz forum_bottom_banner forum_layout
forum_footer form_banner regform_banner loginform_banner other_header other_footer);
push @abmain::core_cfgs, qw(msg_header msg_banner msg_footer message_page_layout);

@abmain::forum_msg_cfgs=(
[jQ => "head", "Individual Message Page Layout"], 
[msg_banner=> "htmltext", "rows=16 cols=48 wrap=soft", "Message banner HTML, below the message header", qq(
<p align="right"><LOGIN_USER><br><PRIVATE_MSG_ALERT><LOCAL_USER_LIST><br><MSG_READERS></p>
)],
[msg_header=> "hidden", "", ""],
[msg_footer=> "hidden", "", ""],
[msg_template=> "htmltext", "rows=16 cols=48 wrap=soft", "Message template HTML(must contain macro PAGE_CONTENT", 
qq(<html>
<head>
<meta http-equiv="Expires" content="0">\n</head>
<body bgcolor="#ffffff">
PAGE_CONTENT
</body></html>)
],
[msg_sep1=>"textarea", qq(rows="4" cols="48"), "Separator between TOP message bar and message body (TOPBAR_BODY_SEP)", ""],
[msg_sep2=>"textarea", qq(rows="4" cols="48"), "Delimiter at the end of message body (MSGBODY_BBAR_SEP)", "<br>"],
[mbar_macros=>'const', "", "Available macros", join("<br>", @jW::mbar_tags, @jW::org_info_tags)],
[message_page_layout=>"htmltext", "rows=12 cols=48 wrap=soft", "Message content area template",
qq(
MSG_TOP_BAR TOPMBAR_BODY_SEP 
<table width="100%" cellpadding="3" cellspacing="1">
<tr><td bgcolor="#e5e5d1" width="20%" valign="top">
POST_BY_WORD: MSG_AUTHOR_STR<br>
AUTHOR_AVATAR<br>
MSG_DATE<br>
<hr size="1" noshade />
AUTHOR_PROFILE_LNK MAIL_USER_LNK EDIT_MSG_LNK<br>
</td><td valign="top">
MSG_BODY MSG_IMG MSG_ATTACHMENTS<br>
MSG_ATTACHED_OBJ<br>
MSG_ATTACHED_OBJ_MOD<br>
AUTHOR_SIGNATURE <br>MSG_RLNK <br>
MODIFIED_STR
</td></tr></table>
MSGBODY_BBAR_SEP
MSG_BOTTOM_BAR
)],
[message_attachment_layout=>"htmltext", "rows=4 cols=48 wrap=soft", "Message attachment layout (MSG_ATTACHMENTS)",
qq(<table border="1"><tr bgcolor="#aaaaaa"><th><font color="#ffffff">Uploaded file</font></th></tr><tr><td>UPLOADED_FILES</td></tr></table>)],
[iWz=>"checkbox", qq(value="1"), "Add bottom navigation bar at the end of message", "1"],
[yXz=>"checkbox", qq(value="1"), "Show simple rate form at the end of message", "0"],
[ySz=>"checkbox", qq(value="1"), "Show link to current page at the end of message", "1"],
[show_user_profile=>"checkbox", qq(value="1"), "Show link to user profile", "1"],

[jQ => "head", "Message Navigation Bars"], 
[orig_msg_str=>"textarea", qq(rows="8" cols="65" wrap="soft"), "Original message string (ORIG_MSG_STR)", qq(RE_WORD: MSG_REF_LNK -- MSG_AUTHOR_ORIG)],
[mbar_width => "text", "size=8",  "Width of the navigation bar inside message body (MBAR_WIDTH)", "100%"],
[bgmsgbar => "color", qq(size="48"),  "Background color of navigation bar inside message (MBAR_BG)", "#e5e5d1"],
[zBz => "text", qq(size="48"),  "Other attributes of the navigation bar table inside message body (MBAR_ATTRIB)", qq(cellpadding=0 cellspacing=0)],
[mbar_layout => "htmltext", qq(rows="8" cols="65" wrap="soft"), "Layout of the top navigation bar inside message (MSG_TOP_BAR)",
qq(<table MBAR_WIDTH MBAR_BG MBAR_ATTRIB>
<tr bgcolor="#006699">
<td colspan="2" align="center" width="70%"><font color="#e5e5d1">MSG_TITLE</font></td>
<td>MSG_MOOD_ICON</td><td align="right" valign="top"><img src="$abmain::img_top/curve_ur.gif" border="0"></td></tr>
<tr><td width="55%">ORIG_MSG_STR</td> 
<td align="center" width="12%">REPLY_MSG_LNK</td>
<td align="center" width="12%">TOP_MSG_LNK</td>
<td align="center" width="12%">FORUM_LNK</td></tr>
</table>
)],
[mbbar_layout => "htmltext", qq(rows="10" cols="65" wrap="soft"), "Layout of the bottom navigation bar inside message (MSG_BOTTOM_BAR)",
qq(<table MBAR_WIDTH MBAR_BG MBAR_ATTRIB>
<tr>
<td width="40%" align=left>REPLY_MSG_LNK | RECOMMEND_MSG_LNK | ALERT_ADM_LNK</td>
<td>RATE_MSG_LNK</td>
<td>
VIEW_ALL_LNK
WHERE_AMI_LNK
UP_MSG_LNK
TOP_MSG_LNK
</td>
<td align=right>
PREV_MSG_LNK | NEXT_MSG_LNK | CURRENT_PAGE_LNK
</td>
</tr>
</table>
)],

[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);
@abmain::tU=(
[text_info => "head", "Label Text"], 
[cat_word=>"text", qq(size="48"), "Text for Message category", "Message category"],
[nt_word=>"text", qq(size="48"), "Tag at the end of message subject for no content messages", "(no text)"],
[vEz => "text", qq(size="48"), "Text for Recommend",  "Recommend"],
[alert_word => "text", qq(size="48"), "Text for Alert",  "Alert"],
[reload_word => "text", qq(size="48"), "Text for Reload",  "Reload"],
[reload_chat_word=> "text", qq(size="48"), "Text for Refresh Chat",  "Refresh"],
[links_word => "text", qq(size="48"), "Text for Links link",  "Links"],
[usercp_word => "text", qq(size="48"), "Text for User Control Panel",  "User Panel"],
[tags_word => "text", qq(size="48"), "Text for Tags link",  "Tags"],
[stats_word => "text", qq(size="48"), "Text for posting stats link",  "Stats"],
[online_stats_word => "text", qq(size="48"), "Text for who's online link",  "Who.."],
[online_users_lab => "text", qq(size="48"), "Text for online users",  "Online users"],
[readers_lab => "text", qq(size="48"), "Text for readers of a message",  "The following users have read the message:"],
[gochat_word => "text", qq(size="48"), "Text for chat link",  "Chat"],
[survey_word => "text", qq(size="48"), "Text for poll",  "Poll"],
[members_word => "text", qq(size="48"), "Text for members",  "Members"],
[db_word => "text", qq(size="48"), "Text for databases",  "Databases and Forms"],
[events_word => "text", qq(size="48"), "Text for Events",  "Events"],
[uH=> "text", qq(size="48"), "Label for Post Message. ( You can use IMG TAGS ) ",  "New Post"],
[post_form_word=> "text", qq(size="48"), "Label for Post A Form. ( You can use IMG TAGS ) ",  "New Form Post"],
[uI => "text", qq(size="48"), "Text for Post Reply",  "Post Reply"],
[edit_word => "text", qq(size="48"), "Text for edit",  "Edit"],
[sK=> "text", qq(size="48"), "Label for Register",  "Register"],
[fKz=> "text", qq(size="48"), "Label for Login",  "Login"],
[logout_word=> "text", qq(size="48"), "Label for Logout",  "Logout"],
[sJ=> "text", qq(size="48"), "Text for Re",  "Re"],
[aPz=> "text", qq(size="48"), "Text for Star used in rating",  "*"],
[required_word=> "text", qq(size="48"), "Label to signify that a field is required",  qq(<font color="#cc0000"><sup>*</sup></font>)],
[notread_word=> "text", qq(size="48"), "Text for New Private Msg",  " <font color=#00aa00>New</font>"],
[minus_word=> "text", qq(size="48"), "Text for Minus used in rating",  "-"],
[zQ=> "text", qq(size="48"), "Text for Rate",  "Rate"],
[gPz=>"text",  qq(size="48"), "Label for registered user", q(<sup><small>&reg;</small></sup>)],
[kMz=>"text",  qq(size="48"), "Label for Author profile", qq(Author Profile)],
[mail_word=>"text",  qq(size="48"), "Label for Mail author", qq(Mail author)],
[bQz=>"text", qq(size="48"), "Text for the label that indicates image presence", "<b><font color=red size=-1>img</font></b>"],
[attach_tag_word=>"text", qq(size="48"), "Text for the label that indicates attachments", "<b><font color=red size=-1>file</font></b>"],
[lnk_tag_word=>"text", qq(size="48"), "Text for the label that indicates link presence", "<b><font color=red size=-1>link</font></b>"],
[aUa=>"text", qq(size="48"), "Text for the label that indicates message is collapsed", '<b><font color=red size=-1>more</font></b>'],
[sE => "text", qq(size="48"), "String for Posted by",  "Posted by"],
[qN => "text", qq(size="48"), "Text for post button",  " Post!"],
[continue_button_word => "text", qq(size="48"), "Text for continue button",  " Continue"],
[qM => "text", qq(size="48"), "Text for reset button",  " Reset"],
[rI => "text", qq(size="48"), "Text for Submit",  " Submit!"],
[qT => "text", qq(size="48"), "Text for Reset",  " Reset"],
[qC=> "text", qq(size="48"), "Text for E-Mail label",  "E-Mail"],
[sH=> "text", qq(size="48"), "Text for name label",  "Name"],
[to_word=> "text", qq(size="48"), "Text for To label",  "Private Recipients (separate multiple names by comma)"],
[rW=> "text", qq(size="48"), "Text for password label",  "Password"],
[rN=> "text", qq(size="48"), "Text for subject",  "Topic"],
[mood_word=> "text", qq(size="48"), "Text for Mood",  "Feeling"],
[rK=> "text", qq(size="48"), "Text for message",  "Message"],
[rF=> "text", qq(size="48"), "Text for message body",  qq(<br><center>M<br>E<br>S<br>S<br>A<br>G<br>E</center>)],
[rT => "text", qq(size="48"), "Text for Link",  "Link "],
[read_more_word => "text", qq(size="48"), "Text for Read more",  "more..."],
[qEz => "text", qq(size="48"), "Text for Related link",  "Related link: "],
[rO=> "text", qq(size="48"), "Text for URL",  "URL "],
[sD=> "text", qq(size="48"), "Text for Title",  "Title"],
[sB=> "text", qq(size="48"), "Text for Original",  "Original "],
[lJa=>"text", qq(size="48"), "Text for reply options", "Reply options"],
[hRz=>"text", qq(size="48"), "Text for notify author", "Notify original author"],
[hSz=>"text", qq(size="48"), "Text for notify myself", "Notify me on response"],
[priv_reply_word=>"text", qq(size="48"), "Text for reply private", "Private reply"],
[priv_reply_only_word=>"text", qq(size="48"), "Text for all replies are private", "All replies are private"],
[hTz=>"text", qq(size="48"), "Text for disallow replies to my message", "Disallow replies"],
[sC => "text", qq(size="48"), "Text for Image",  "Image "],
[sortkey_word => "text", qq(size="48"), "Text for sort key",  "Sort key"],
[keywords_word => "text", qq(size="48"), "Text for sort key",  "Key words"],
[gQz => "text", qq(size="48"), "Text for Upload",  "Attachment"],
[tF => "text", qq(size="48"), "Text for main forum link",  "Forum"],
[qKz => "text", qq(size="48"), "Text for forum archive link",  "Archive"],
[kRz => "text", qq(size="48"), "Text for user private forum link",  "Private Msg"],
[qLa=>"htmltext", qq(rows="3" cols="48"), "Text alerting about new private message", qq(<font color="#cc000">New private message</font>)],
[cp_word => "text", qq(size="48"), "Text for current page link",  "Current page"],
[iVz => "text", qq(size="48"), "Text for link to the original message",  "Original"],
[next_msg_word => "text", qq(size="48"), "Text for link to the next message",  "Next"],
[prev_msg_word => "text", qq(size="48"), "Text for link to the previous message",  "Previous"],
[top_word => "text", qq(size="48"), "Text for link to the Top message",  "Top of thread"],
[where_ami_word => "text", qq(size="48"), "Text for link to the Where am I page",  "Where am I?"],
[view_all_word=> "text", qq(size="48"), "Text View All",  "View All"],
[jRz=> "text", qq(size="48"), "Text for You were here ",  "<font size=+1 color=red>You were here!</font>"],
[tE=>"text", qq(size="48"), "Text for link to earlier messages", "Previous"],
[back_word=>"text", qq(size="48"), "Text for link to previous page", "Back"],
[tB=>"text", qq(size="48"), "Text for overview", "Overview"],
[full_view_word=>"text", qq(size="48"), "Text for Full View", "Full view"],
[tC=>"text", qq(size="48"), "Text for Find", "Find"],
[gfind_word=>"text", qq(size="48"), "Text for cross forum search", "Quick search"],
[tD=>"text", qq(size="48"), "Text for Options", "Options"],
[tA=>"text", qq(size="48"), "Text for newest message link", "Newest"],
[qE=>"htmltext", qq(rows="4" cols="48"), "Text for Followups", qq(<p><table cellpadding=3 bgcolor="#e5e5d1" border="0" width=100%>\n<tr><td><font SIZE="2" FACE="Arial" color="#000000"><b>Replies to this message</b></td></tr></table><br>)],
[wV=>"text", qq(size="48"), "Text for Admin", "Admin"],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

#} #end of BEGIN

#sub wAz{

#BEGIN {

@abmain::root_login_cfgs=(
[rlinf=>"head", "Login AnyBoard Site Administration"],
[root_name => "text", qq(size="40"), "Master Admin Login ID", ""],
[root_passwd => "password", qq(size="40"), "Master Admin Password", ""],
[cmd=>"hidden", "", "", "loginroot"]
);
@abmain::del_news_cfgs=(
[rlinf=>"head", "Delete news"],
[newscat=> "text", qq(size="40"), "News category ID", ""],
[newsurl=> "text", qq(size="40"), "News URL", ""],
[cmd=>"hidden", "", "", "delnews"]
);

@abmain::dN =(
[create_info =>"head", "Create Master Administrator Login"], 
[aF => "text", qq(size="40"), "Master Admin Login ID ( master admin is the one who creates forums )", ""],
[oU => "password", qq(size="40"), "Master Admin Password", ""],
[bBz => "password", qq(size="40"), "Retype Password", ""],
#x1
#x1
#x1
[iGz=> "text", qq(size="40"), "License key", "", "AnyBoardIsTheBest"],
['-'=> "hidden", qq(size="40")],
);

@abmain::iBa=(
[create_info =>"head", "Configure AnyBoard Lead Page And News"], 
[lead_header=> "textarea", 'rows=8 cols=48 wrap=soft', "Header of the lead page from &lt;html&gt;", qq(<html><body><p align="left" style="margin-left: 5%"><b>AnyBoard Powered Forums</b></p>)],
[lead_footer=> "textarea", 'rows=8 cols=48 wrap=soft', "Footer of the lead page ending with &lt;/html&gt;", qq(<p align=right style="margin-right: 5%"><a href="/">Back to Home Page</a></p></body></html>)],
[desc_bef=> "textarea", 'rows=4 cols=48 wrap=soft', "HTML code before forum description"],
[desc_af=> "textarea", 'rows=4 cols=48 wrap=soft', "HTML code after forum messages"],
[inc_last=> "checkbox", '1=Yes', "Include abstract of last topic from forums", "1"],
[news_word=> "text", qq(size="40"), "Label for forum news", "<b>Hot topics</b><br>"],
[inc_news=> "checkbox", '1=Yes', "Include news from forums", "1"],
[news_cols=> "text", qq(size="4"), "Number of news columns", "1"],
[news_cnt=> "text", qq(size="4"), "Number of news displayed", "5"],
[short_view=> "checkbox", '1=Yes', "Short view", "0"],
[add_border=> "checkbox", '1=Yes', "Add border to list table", "0"],
[fcatopt=>"textarea", "rows=8 cols=48", "Forum category choices, one per line, in the format index=label. Categories will be listed in ascending order of indexes.", "A=General Disucssions\nB=Support Question"],
[newscatopt=>"textarea", "rows=8 cols=48", "News category choices, one per line, in the format index=label. Categories will be listed in ascending order of indexes.", "=General news\nB=Press releases"],
[newsiconopt=>"textarea", "rows=8 cols=48", "News category leading icons, one per line, in the format index=icon_html.", "=<img src=/abicons/idea.gif>\nB=*"],
[newstabattr=> "color", "", "Attribute of the table that contains the news", qq(bgcolor="#99ccff")],
@abmain::forum_org_info_cfgs,
[cmd=>"hidden", "", "", "lOa"],
);

@abmain::gDa=(
[banner_info=>"head", "HTML Code"],
[banner_tit=>"text", qq(size="48"), "Title of the banner", ""],
[banner_txt=>"textarea", "rows=16 cols=48 wrap=soft", "Text of the banner", ""],
[banner_id=>"hidden", "", "Banner id", ""],
[cmd=>"hidden", "", "", "mBa"],
);
@abmain::ab_code_cfgs=(
[banner_info=>"head", "Perl Code"],
[perlcode=>"textarea", "rows=16 cols=48 wrap=soft", "PERL code", ""],
[cmd=>"hidden", "", "", "mAa"],
);

@abmain::forum_grp_cfgs =(
[create_info =>"head", "Create a new forum group"], 
[fgrp_name=> "text", qq(size="60"), "Group name", ""],
[fgrp_id=> "text", qq(size="60"), "Group ID ( a unique identifier, no spaces, no special characters )", ""],
[fgrp_desc=> "textarea", 'rows=4 cols=48 wrap=soft', "Group description", ""],
[fgrp_admin=> "password", qq(size="40"), "Group administrator login ID", ""],
[fgrp_passwd => "password", qq(size="40"), "Password", ""],
[fgrp_passwd2 => "password", qq(size="40"), "Retype Password", ""],
);

@abmain::lQa =(
[root_info=>"head", "General Manager Info"], 
[root_name => "text", qq(size="40"), "Login", ""], 
[root_passwd => "password", qq(size="40"), "Password", ""], 
[cat_info=>"head", "Category Management"], 
[cat_dir=> "text", qq(size="60"), "Directory name", ""],
[cat_name=> "text", qq(size="60"), "Category name", ""],
[cat_sortkey=> "text", qq(size="60"), "Category sort key", "aaa"],
[cat_list=> "checkbox", qq(value="1"), "List forums in this category", "1"],
[cat_istop=> "checkbox", qq(value="1"), "This is a top category", "0"],
[cat_makeboard=> "checkbox", qq(value="1"), "Allow making boards here", "0"],
[cat_inherit=> "checkbox", qq(value="1"), "Inherit parent layout", "1"],
[cat_inhe_guide=> "checkbox", qq(value="1"), "Inherit parent guide", "1"],
[cat_intf=>"head", "HTML layout info"], 
[cat_header=>"textarea", "rows=4 cols=60 wrap=soft", "Category page header", qq(</head><body bgcolor="#ffffff">)],
[cat_sepx=>"textarea", "rows=4 cols=60 wrap=soft", "Separator below back links", qq(<hr size=1 noshade>)],
[cat_desc=>"htmltext", "rows=12 cols=60 wrap=soft", "Category description", ""],
[cat_news=>"htmltext", "rows=12 cols=60 wrap=soft", "News for this category", ""],
[cat_guide=>"htmltext", "rows=8 cols=60 wrap=soft", "Guide for this category", ""],
[cat_sub_head=>"text", qq(size="60"), "Label for sub categories", "Categories"],
[cat_cr_forum_head=>"text", qq(size="60"), "Label for create new forum", "Create New Forum For This Category"],
[cat_cr_cat_word=>"text", qq(size="60"), "Label for create category", "Create category"],
[cat_mod_cat_word=>"text", qq(size="60"), "Label for modify category", "Modify category"],
[cat_cr_f_word=>"text", qq(size="60"), "Label for create forum", "Create new forum"],
[inc_last=> "checkbox", '1=Yes', "Include abstract of last topic from forums", "1"],
[cat_show_admin=> "checkbox", '1=Yes', "Show administrator of the listed forums", "1"],
[cat_view_cat_word=>"text", qq(size="60"), "Label for view all categories", "View All Categories"],
[cat_footer=>"textarea", "rows=4 cols=60 wrap=soft", "HTML code at the end of page", "</body></html>"],
[cat_macros=>'const', "", "Available macros", join("<br>", @abmain::cat_tags)],
[cat_layout=>"htmltext", "rows=24 cols=60 wrap=soft", "Category body layout", 
qq!<table width=70% align=left border="0" cellpadding=3>
<tr>
<td bgcolor="#cccc99"><font size=+2>AB_CAT_NAME</font></td><td>
AB_CAT_DESC</td>
<td width="20%" rowspan=2 valign="top" bgcolor="#cccc99">
AB_CAT_GUIDE<br>
<hr>
AB_CREATE_FORUM_LNK<br>
AB_VIEW_CAT_LIST_LNK<br>
AB_CREATE_CAT_LNK<br>
AB_MODIFY_CAT_LNK<br>
</td>
</tr>
<tr><td valign=top bgcolor="#9999cc">
AB_SUB_CAT_LIST<br>
</td>
<td bgcolor="#FFFFee">
AB_CAT_NEWS
<hr noshade>
AB_CAT_FORUM_LIST
</td></tr>
</table>
!],
[btn_preview=>"submit", qq(value="Preview"), "Click to preview", ""],
);

@abmain::kDz= (
[del_info=>"head", "Delete Forum"], 
[aF => "text", qq(size="40"), "Master Admin Login", ""],
[oU => "password", qq(size="40"), "Master Password", ""],
[forum_vpath =>"text", qq(size="40"), "Forum Directory Name", "myboard"],
[hQz=> "checkbox", qq(value="1"), "Deleted forum cannot be recovered, are you sure that you want to delete the forum?", "0"],
);

$lEz=q(86474707a3f2f2e656472657c616e236f6d6f216e69726f6162746f2);
$lFz=q(86474707a3f2f216e69726f6162746e2e65647f2367696d22696e6f2c6f676f6f537e2367696);

$uE=pack("h*", $lEz);
$uF=pack("h*", $lFz);

@abmain::mSz=(
[loginfo =>"head", "Request password by email"], 
[kQ => "text", qq(size="40"), "Enter login id", ""],
[email=>"text", qq(size="40"), "Email address", ""]
);

@abmain::bO = (
[adm_info =>"head", "Modify Forum Administrator Login"], 
[admin => "text", qq(size="20"), "Admin Login", "admin"],
[admin_email => "text", qq(size="40"), "Admin E-mail Address. Make sure this is correct, so you can receive lost password", ""],
[oA => "password", 'maxlength=16', "Old Password", ""],
[mS => "password", 'maxlength="16"', "New Password", ""],
[dQz => "password", 'maxlength="16"', "Re-type New Password", ""],
[core_opts=>"hidden"],
);

$uJ=unpack("%16C*", $uE);

@abmain::vC = (
[mod_info =>"head", "Modify Forum Moderator Login"], 
[moderator => "text", qq(size="20"), "Moderator Name", "watcher"],
[moderator_email => "text", qq(size="40"), "Moderator E-mail Address", ""],
[vI => "password", 'maxlength=16', "Moderator Password", ""],
[vM => "checkbox", qq(value="1"), "Allow moderator to archive message", "1"],
[mod_can_dopoll=> "checkbox", qq(value="1"), "Allow moderator to manage polls", "1"],
[vN => "checkbox", qq(value="1"), "Allow moderator to delete user", "0"],
);

@abmain::vQ = (
["notify_info", "head", "Forum Notification Control"], 
[login_msg=> "htmltext", qq(rows="4" cols="60" wrap="soft"), "Message to display when user logins in", "Welcome back!"],
["post_welcome", "checkbox", qq(value="1"), "Post a welcome message when a new user registers", "1"], 
[welcome_subjs=> "textarea", qq(rows="4" cols="60" wrap="soft"), "Subjects of the welcome message, one per line. AnyBoard will randomly select one", "Please welcome a new member {USERNAME}!\n We have a new member! Please welcome {USERNAME}\n"],
[welcome_cat=> "text", qq(size="4"), "Category <b>index</b> of the welcome message", ""],
[welcome_msg=> "htmltext", qq(rows="4" cols="60" wrap="soft"), "Content of the welcome message", "{USERNAME}, Hope you enjoy this forum!"],
[welcome_email=> "textarea", qq(rows="4" cols="60" wrap="soft"), "Additional email text sent to new user", ""],
#x1
["cc_author", "checkbox", qq(value="1"), "E-mail the author a copy of his post", "0"], 
["xS", "checkbox", qq(value="1"), "Let user decide whether to send notification ( if enabled )","0"], 
["bTz",  "text", qq(size="60"), "Message telling user choose notification admin", "Notify admin by e-mail"],
["iQz",  "text", qq(size="60"), "Message telling admin choose to notify all users", "Notify all users"],
["jAa",  "text", qq(size="60"), "Message telling admin choose to report", "Report"],
["xG", "checkbox", qq(value="1"), "Include full message body in notification", "1"], 
["mJz", "checkbox", qq(value="1"), "Remove HTML tags in message body", "0"], 
["wQ", "checkbox", qq(value="1"), "Inform posters about notification email delivery status", "0"], 
["wN",  "text", qq(size="60"), "List of e-mail addresses to be notified, separated by comma", 'webmaster@your-domain.com'],
["iZa",  "text", qq(size="60"), "List of e-mail addresses to report by administrator, separated by comma", 'myboss@your-domain.com'],
#x1
["notifier",  "text", qq(size="60"), "E-mail address from which notification is sent. This is also used as the FROM address of validation email", 'webmaster@your-domain.com'],
["jBa",  "text", qq(size="60"), "Footer of the notification email", ''],
["dUz", "checkbox", qq(value="1"), "Allow user to choose to receive e-mail notification of responses", "0"], 
["dWz", "checkbox", qq(value="1"), "Allow responding author to send e-mail notification to original author", "1"], 
["cQz", "text", qq(size="60"), "SMTP server for sending email ( override system setting )", ""],
)
;

@abmain::forum_mbox_cfgs=(
["info", "head", "Forum Mailbox"], 
[takepop=>'checkbox', qq(value="1"), "Receive new posts from POP3 mailbox?", "0"],
[qFa=>"htext", qq(size="40"), "POP3 server host name", ""],
[qCa=>"htext", qq(size="20"), "POP3 user ID", ""],
[qDa=>"htext", qq(size="20"), "POP3 user password", ""],
);

@abmain::forum_mailback_cfgs=(
["mailback_info", "head", "Forum mail back control"], 
#x1
["nTz", "checkbox", qq(value="1"), "Enable file distribution function for admin only", "1"],
[mZz=> "checkbox", qq(value="1"), "Mail back only to e-mail addresses listed below", "0"], 
[nEz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "Mail back only if e-mail address is one of the following ( list one per line )", ""],
[pHz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "Message to e-mail back when user posts message", "Thank you!"],
[nAz=> "checkbox", qq(value="1"), "Include full message body in mail back", "0"], 
[nJz=>  "text", qq(size="40"), "Fixed subject", ""],
)
;

@abmain::forum_chat_cfgs =(
[jQ => "head", "Chat Room Configuration"], 
[enable_chat =>"checkbox", qq(value="1"), "Enable chat function", "1"], 
[hLa=>"checkbox", qq(value="1"), "Show last message on top", "1"],
[tEz => "color", "", "Background color for the message area", "#ffffff"],
[yOz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "HTML at the top of the message area", qq(
<style type="text/css">
DIV.CHATAREA { margin-left: 10px; margin-right:10px; background-color: #ffffff; }
</style>
)],
[yPz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "HTML above the message list"],
[yQz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "HTML below message list"],
[yNz=> "textarea", qq(rows="4" cols="60" wrap="soft"), "HTML at the bottom of the message area", ""],
[chat_cmd_bg => "color", "", "Background color for the input area", "#6699cc"],
[chat_usr_bg => "color", "", "Background color for the user list area", "#006699"],
[sOz => "text", qq(size="40"), "Font attribute of the message text", qq($abmain::dfa color="#000000" size=1)],
[sVz => "text", qq(size="40"), "Font attribute of the chat user name", qq($abmain::dfa color="#cc0000" size=1)],
[tDz => "text", qq(size="40"), "Minimum refresh interval for the chat page in seconds (should be > 5)", "15"],
[tBz=> "text", qq(size="40"), "Welcome message when a user enters", "USER_NAME entered the chat room, welcome!"],
[chat_sys_name => "text", qq(size="40"), "Chat system name", "AnyBoard"],
[sZz=> "text", qq(size="40"), "Notification message when a user leaves", "USER_NAME has left!"],
[sHz=> "text", qq(size="40"), "Separator between user name and message", ": "],
[yMz=> "text", qq(size="40"), "Separator between messages", ""],
[chat_mlen=> "text", qq(size="40"), "Maximum length of a message", "80"],
[chat_max_age=> "text", qq(size="40"), "Do not show messages older than this many seconds", "900"],
[chat_peek_msg=> "text", qq(size="40"), "Message when a user peeks", "Someone is peeking at the door!"],
[chat_no_peek_msg =>"checkbox", qq(value="1"), "Do not announce when someone is at the door", "1"],
[tCz=> "text", qq(size="40"), "Number of messages to display", "20"],
[sFz=> "text", qq(size="40"), "Height of the input frame", "100"],
[chat_usr_width=> "text", qq(size="40"), "Width of the user list", "80"],
[tAz=>"text", qq(size="40"), "Text for the Speak word",  "Speak"],
[tFz=>"text", qq(size="40"), "Text for the Leave word",  "Leave"],
);

@abmain::uTz =(
[jQ => "head", "Event Calendar Configuration"], 
#x1
[uIz=>"checkbox", qq(value="1"), "Allow users to add event", "1"],
[uSz=>"checkbox", qq(value="1"), "Users must be registered to add event", "0"],
[uKz=>"textrea", "rows=3 cols=60", "Attribute of the table enclosing the event detail", qq(border=3 bgcolor=#ffffcc cellspacing=0 cellpadding=5 width=70%)],
[uQz=> "color", qq(size="48"),  "Background color of an event attribute", "#dddddd"],
[uRz=> "color", qq(size="48"),  "Background color of next event attribute", "#ffffff"],
[eve_add_word=>"text", qq(size="60"), "Add event label", "Add new event"],
[tNz=>"text", qq(size="60"), "Event Time label", "Time"],
[uJz=>"text", qq(size="60"), "Event location label", "Location"],
[uDz=>"text", qq(size="60"), "Event status label", "Status"],
[uUz=>"text", qq(size="60"), "Event description label", "Activity"],
[uVz=>"text", qq(size="60"), "Event organizer", "Coordinator"],
[uCz=>"text", qq(size="60"), "Contact information label", "Contact info"],
[uGz=>"textarea", qq(rows="3" cols="60" wrap="soft"), "Event list label", "<h4><center>Event List</center></h4>"],
[uXz=>"textarea", qq(rows="3" cols="60" wrap="soft"), "Event details label", "<center><h4>Event details</h4></center>"],
[uLz=>"textarea", qq(rows="3" cols="60" wrap="soft"), "Separator between event details", "<hr width=50%>"],
[eve_page_top_banner=>"textarea", qq(rows="6" cols="60" wrap="soft"), "Event page top banner"],
[eve_page_bottom_banner=>"textarea", qq(rows="6" cols="60" wrap="soft"), "Event page bottom banner", ""],
);
@abmain::group_idx_cfgs =(
[jQ => "head", "Group index page Configuration"], 
[enable_grp_intf=>"checkbox", qq(value="1"), "Enable group interface", "1"], 
[idx_fset_attr =>"textarea", "rows=3 cols=48 wrap=soft", "Frame set attribute", qq(rows="50,*" border="0" marginwidth=0)],
[idx_tframe_attr =>"textarea", "rows=3 cols=48 wrap=soft", "Top frame attribute", qq(border="0" marginwidth=0)],
[idx_bframe_attr =>"textarea", "rows=3 cols=48 wrap=soft", "Bottom frame attribute", qq(border="0" marginwidth=0)],
[idx_tframe_head =>"textarea", "rows=6 cols=48 wrap=soft", "Header HTML of the top frame", qq(<html><body bgcolor="#ffffff" style="margin-top: 0; font-size: 10pt">)],
[idx_macros=>'const', "", "Available macros", join("<br>", @jW::idx_tags)],
[idx_nav_cfg =>"htmltext", "rows=8 cols=48 wrap=soft", "Group navigation configuration",
qq(<table border="0" cellspacing=0 cellpadding=5 bgcolor="#cccccc" width="100%" align=left><tr>
<td bgcolor="#ffffff"><b>FORUMNAME</b></td>
<td>MEMBERLNK</td><td>STATSLNK</td><td>REGLNK</td><td>LOGINLNK</td>
<td>MAINLNK</td><td>ARCHLNK</td><td>CHATLNK</td><td>SURVEYLNK</td>
<td> EVELNK </td>
<td> LINKSLNK </td>
<td>MYFORUMLNK</td><td bgcolor="#99ddff">ADMLNK</td>
</tr></table>
)
],
[idx_tframe_foot =>"textarea", "rows=6 cols=48 wrap=soft", "Footer HTML of the top frame", qq(</body></html>)],
);

@abmain::forum_bar_cfgs=(
[jQ => "head", "Forum Navigation Bars"], 
[gUa=>'const', "", "Available macros", join("<br>", @jW::gLa)],
[navbar_layout=> "textarea", "rows=8 cols=48 wrap=soft", "Layout of the navigation bar ( do not change this unless you are sure )", 
qq(<td align="center">GOPAGEBTN</td><td align="center">POSTLNK</td><td align="center">FINDLNK QSRCHLNK</td>
 <td align="center">TAGSLNK</td><td align="center">PREVLNK</td><td align="center">CHATLNK</td><td align="center">NEWESTLNK</td><td>ARCHLNK</td>
 <td align="center">REGLNK </td><td>LOGINLNK</td><td align="center">USERCPANELLINK</td><td align="center">OVERVIEWLNK</td><td align="center">DBLNK</td><td align="center">ADMLNK</td>)],
[navbar_ul=> "textarea", "rows=2 cols=48 wrap=soft", "Upper left TD of the navigation bar" ], 
[navbar_ur=> "textarea", "rows=2 cols=48 wrap=soft", "Upper right TD of the navigation bar" ], 
[navbar_bl=> "textarea", "rows=2 cols=48 wrap=soft", "Bottom left TD of the navigation bar", qq(<td valign=bottom align=left><img src="$abmain::img_top/curve_ll.gif"></td>)], 
[navbar_br=> "textarea", "rows=2 cols=48 wrap=soft", "Bottom right TD of the navigation bar", qq(<td valign=bottom align=right><img src="$abmain::img_top/curve_lr.gif"></td>)], 
[navbar_layouta=> "textarea", "rows=8 cols=48 wrap=soft", "Layout of the navigation bar for archived pages", q(<td>GOPAGEBTN</td><td>FINDLNK OVERVIEWLNK PREVLNK</td><td>NEWESTLNK MAINLNK</td>)],
[gobtn_url=> "text", qq(size="60"), "URL of the go button on navigation bar", ""], 
#x1
[dBz=>"checkbox", qq(value="1"), "Show forum name on nav bar", "0"],
[navbarbg => "color", qq(size="48"),  "Background color of the navigation bar", "#5a76a5"],
[navbarattr => "text", qq(size="48"),  "Other table attributes of the navigation bar", qq(border="0" cellspacing="0" class="NAV")],
[nNz => "color", qq(size="48"),  "Background color of the navigation bar on archive page", "#99ccff"],
[navbdsize => "text", "",  "Width of the border around navigation bar", "0"],
[navbdcolor => "color", qq(size="48"),  "Color of the navigation bar border", "#999988"],
[navbdpad => "text", "",  "Space around content in navigation bar", "0"],
);

@abmain::forum_return_cfgs=(
[text_info => "head", "Post confirmation configuration"], 
[return_header=> "textarea", "rows=8 cols=48", "HTML header for the post confirm page, start from \&lt;/head\&gt;\&lt;body\&gt;", qq(</head><body bgcolor="#ffffff">)],
[return_footer=> "textarea", "rows=8 cols=48", "HTML footer for the post confirm page, end with &lt;/body&gt;&lt;/html&gt;", qq(</body></html>)],
[pc_hcolor => "text", qq(size="48"), "Color of the heading on confirmation page",  "#006699"],
[pc_thx => "text", qq(size="48"), "Text for Thank you",  "Thank you, "],
[pc_msg=> "text", qq(size="48"), "Message to confirm post is added ",  "Your Message Has Been Added To "],
[pc_banner=> "textarea", qq(rows="4" cols="48"), "Banner on confirmation page",  ""],
[pc_msg2=> "text", qq(size="48"), "Informational message if moderation is off",  "You need to reload the main forum page to see your post!"],
[pc_msg2_moder=> "text", qq(size="48"), "Informational message if pre-moderation is on",  "Your message has been submitted for review!"],
[pc_goto => "text", qq(size="48"), "Text for Go to message",  "Go To Your message"],
[pc_edit => "text", qq(size="48"), "Text for Edit message",  "Edit Your message"],
[pc_date => "text", qq(size="48"), "Text for Added on date",  "Added on date"],
[pc_header => "text", qq(size="48"), "Header for message information",  "<font color=#ffffff>The following is the information about your message</font>"],
[pc_advise => "text", qq(size="48"), "Final advice",  "Please do not post the same message again."],
);
@abmain::qSz=(
[jQ => "head", "Add or Modify Poll"], 
[qQz=>"text", "size=16", "ID for the poll (no spaces)", ""],
[rFz=>"text", qq(size="48"), "Poll question", "", undef, qq(<font color=#ffffff>How do you like Anyboard?</font>)],
[qRz=>"textarea", "rows=6 cols=48", "Poll choices, one per line, in the format index=answer","", undef, "1=Very much\n2=Very very much\n3=It is the best!"],
[fVa=>"checkbox", qq(value="1"), "Make this a multiple choice poll", "0"],
[jQ => "head", "Optional Display Settings"], 
[polltabattr=>"text", qq(size="48"), "Attribute of the table that encloses the poll form", "", undef, qq(border="0" cellspacing=1 bgcolor="#e5e5d1")],
[pollrtabattr=>"text", qq(size="48"), "Attribute of the table that encloses the poll result", "", undef, qq(border="0" cellspacing=1 bgcolor="#e5e5d1")],
[pollhbg=>"color", qq(size="48"), "Background color of the title", "", undef, "#006699"],
[rNz=>"color", qq(size="48"), "Color of the proportional block", "", undef, "red"],
[pollvoteword=>"text", qq(size="48"), "Label for the vote button", "", undef, "Vote"],
[jQ => "head", "Optional Control Settings"], 
[rEz=>"checkbox", qq(value="1"), "User must logon to vote", "0"],
[qVz=>"checkbox", qq(value="1"), "Log domain information", "0"],
[rIz=>"checkbox", qq(value="1"), "Reject vote if domain reverse lookup fails", "0"],
[qWz=>"checkbox", qq(value="1"), "Reject duplicate votes from same IP", "1"],
[rBz=>"checkbox", qq(value="1"), "Inactivate this poll", "0"],
[polllisted=>"checkbox", qq(value="1"), "List this poll on poll index page (poll/index.html)", "1"],
[rDz=>"checkbox", qq(value="1"), "Check to confirm overwriting existing poll", "0"],
);
$abmain::lRz = qq(<script LANGUAGE="JavaScript1.1">\n<!--\n);
$abmain::js_end = qq(//-->\n</script>\n);

$abmain::kSz = <<'COOKIE_JS',

function mMz()
{
 var mPz = "";
 for(var prop in this) {
 if ((prop.charAt(0) == '_' && prop.charAt(prop.length-1)=='_')
		      || ((typeof this[prop]) == 'function')) 
 continue;
 if (mPz != "") mPz += '&';
 mPz += prop + ':' + escape(this[prop]);
 }
 var cookie = this.gHa + '=' + mPz;
 if (this._expiration_)
 cookie += '; expires=' + this._expiration_.toGMTString();
 if (this._path_) cookie += '; path=' + this._path_;
 if (this._domain_) cookie += '; domain=' + this._domain_;
 if (this._secure_) cookie += '; secure';
 
 this._document_.cookie = cookie;
}

function mQz()
{
 var mOz = this._document_.cookie;
 if (mOz == "") return false;
 
 var start = mOz.indexOf(this.gHa + '=');
 if (start == -1) return false;   
 start += this.gHa.length + 1;  
 var end = mOz.indexOf(';', start);
 if (end == -1) end = mOz.length;
 var mPz = mOz.substring(start, end);

 var a = mPz.split('&'); 
 for(var i=0; i < a.length; i++)  
 a[i] = a[i].split(':');

 for(var i = 0; i < a.length; i++) {
 this[a[i][0]] = unescape(a[i][1]);
 }
 return true;
}

function Cookie(document, name, hours, path, domain, secure)
{
 this._document_ = document;
 this.gHa = name;
 if (hours)
 this._expiration_ = new Date((new Date()).getTime() + hours*3600000);
 else this._expiration_ = null;
 if (path) this._path_ = path; else this._path_ = null;
 if (domain) this._domain_ = domain; else this._domain_ = null;
 if (secure) this._secure_ = true; else this._secure_ = false;
 this.store = mMz;
 this.load = mQz;
}

COOKIE_JS
@abmain::bB = (
[cF =>"head", "User Registration Information"], 
[kQ => "text", qq(size="40"), "User login you wish to use", ""],
[email    => "text", qq(size="40"), "E-Mail", ""],
[wO => "text", qq(size="40"), "Home Page URL", "http://"],
[wJ=>"text", qq(size="40" maxlength="32"), "Where are you", ""],
[xK=>"text", qq(size="40" maxlength="60"), "One sentence about yourself, interests, experience, etc.", ""],
[nC => "password", qq(size="40"), "Password", ""],
[bD => "password", 'size="40"', "Retype Password", ""],
[noshowmeonline=>"checkbox", qq(value="1"),  "Do not let others know if you are in the forum", "0"], 
[add2notifiee =>"checkbox", qq(value="1"),  "Receive new posts in email", "0"], 
);
 
@abmain::mailer_cfgs=(
[sm_info=>"head", "AnyBoard Mailer"],
[from=>"const", "size=32", "Sender"],
[to=>"text", "size=32", "Recipient"],
[subject=>"text", qq(size="40"), "Subject"],
[message=>"textarea", qq(rows="6" cols="50"), "Message"],
[attachment=>"file", qq(size="10"), "Attachment"],
[bccself=>"checkbox", "1=Yes",  "Bcc Self?"],
[cmd=>"hidden", "", "", "mailusr"],
);
@abmain::member_profile_cfgs = (
[mp_info =>"head", "Member Profile Information"], 
[realname=> "text", qq(size="40"), "Real Name (First, Last)", ""],
[company=> "text", qq(size="40"), "Company name", ""],
[email=>"hidden", "", "", ""],
[homepageurl=> "text", qq(size="48"), "Home page URL", "http://"],
[day_phone=> "text", qq(size="20"), "Day time phone number", ""],
[night_phone=> "text", qq(size="20"), "Night time phone number", ""],
[fax=> "text", qq(size="20"), "Fax number", ""],
[icqnumber=> "text", qq(size="40"), "ICQ Number", ""],
[icqnick=> "text", qq(size="40"), "ICQ Nickname", ""],
[address=> "textarea", qq(rows="5" cols="60" wrap="soft"), "Address", ""],
[gender=>'select', [male=>'Male', female=>'Female'], "Gender", ""],
[birthmonth=>'select', [map {$_, $_} @abmain::months], "Birth month", ""],
[birthday=>'select', [map {$_, sprintf("%02d", $_)} 1..31], "Birth day", ""],
[birthplace=> "text", qq(size="40"), "Birth place", ""],
[nationality=> "text", qq(size="40"), "Nationality", ""],
[agerange=>'select', [map { $_."0s", "${_}0-${_}9"} 0..15], "Age", "---"],
[occupation=> "text", qq(size="40"), "Occupation", ""],
[photourl=> "imgurl", qq(size="40"), "Photo URL", "http://"],
[photofile=> "file", qq(size="40"), "Photo image (upload file)", ""],
[avatar =>"radio", "", "Avatar", ""],
[signature=> "htmltext", qq(rows="4" cols="60" wrap="soft"), "Signature HTML code which will be appended to messages", ""],
[mystatement=> "htmltext", qq(rows="12" cols="60" wrap="soft"), "Free form personal statement (HTML allowed)", ""],
[ig_info =>"head", "Forum preferences"], 
[ignores=> "textarea", qq(rows="4" cols="60" wrap="soft"), "List of ignored users, separated by new line or |", ""],
[fancyhtml=>"checkbox", '1=Yes',  "Use WYSIWYG HTML editing (uncheck this if you can't enter text in the post message area)", "1"],  
[hG=>"text", "size=2", "Depth of links on main page", ""],
[yVz => "select", [%thread_sorters], "Sort threads by", ""],
[revlist_topic => "checkbox", '1=Yes', "List threads in ascending order ( older thread on TOP if time is used for sorting )", ""],
[revlist_reply => "checkbox", '1=Yes', "List old replies first", "1"],
[align_col_new=>"checkbox", "1=Yes", "Align message attributes in columns", ""],
[iW => "text", 'size="4"', "Number of message links per page", ""],
[userid=>"hidden", "", "", ""],
[cmd=>"hidden", "", "", "modmp"],
);

@abmain::mp_page_cfgs =(
[mp_ctrl_info=>"head", "Member Profile Page Configuration"], 
[mp_enabled=> "checkbox", qq(value="1"), "Enable extended member profile", "1"],
[mp_url=> "text", qq(size="50"), "Redirect user to this URL for profile submission ", ""],
[pstat_in_reginfo=> "checkbox", qq(value="1"), "Include posting stats in registration information page", "1"],
[mp_in_reginfo=> "checkbox", qq(value="1"), "Include extended profile in registration information page", "1"],
[mp_symbols=>'const', "", "Available variables", "<b>".join(' &nbsp;&nbsp;', "MEMBER_PIC", map{ "{".$_->[0]."}" } @abmain::member_profile_cfgs[1..21])."</b>"],
[mp_reqfields=>"textarea", qq(rows="3" cols="60" wrap="soft"), "Required fields for extended profile", "realname company"],
[mp_skipfields=>"textarea", qq(rows="3" cols="60" wrap="soft"), "Skipped fields for extended profile", "icqnumber icqnick address photourl nationality homepageurl fax night_phone gender birthmonth birthday birthplace photourl"],
[mplayout=> "htmltext", qq(rows="20" cols="60" wrap="soft"), "Layout of the extended profile",qq! 
<center>MEMBER_PIC
<br>
{realname} ( {userid} )
</center>
<table width=85% align="center" border=1 cellspacing=0 cellpadding=3>
<tr><th colspan=6 bgcolor="#eeeeee">Personal profile</th></tr>
<tr>
<td>Gender</td><td>{gender}</td>
<td>Birthday</td><td>{birthmonth} {birthday}</td>
<td>Age range</td><td>{agerange}</td>
</tr>
<tr>
<td>Nationality</td><td>{nationality}</td>
<td>Birth place</td><td>{birthplace}</td>
<td></td>
</tr>
<tr><th colspan=6 bgcolor="#eeeeee"><br>Contact information</th></tr>
<tr>
<td>Company</td><td>{company}</td>
<td>Occupation</td><td>{occupation}</td>
<td>Address</td><td>{address}</td>
</tr>
<tr>
<td>E-mail</td><td>{email}</td>
<td>ICQ Number</td><td>{icqnumber}</td>
<td>ICQ Nick</td><td>{icqnick}</td>
</tr>
<tr>
<td>Day phone</td><td>{day_phone}</td>
<td>Night phone</td><td>{night_phone}</td>
<td>Fax</td><td>{fax}</td>
</tr>
<tr><th colspan=6 bgcolor="#eeeeee"><br>Personal statement</th></tr>
<tr><td colspan=6 bgcolor="#ffffee">
{mystatement}
</td>
</tr>
</table>
!
],
[mpformlayout=> "textarea", qq(rows="8" cols="60" wrap="soft"), "Layout of the profile input form", ""],
[mpheader=> "textarea", qq(rows="8" cols="60" wrap="soft"), "Header HTML code starting from &lt;/head&gt;&lt;body&gt;", "</head><body>"],
[mpfooter=> "textarea", qq(rows="8" cols="60" wrap="soft"), "Footer HTML code ending with &lt;/body&gt;&lt;/html&gt;", "</body></html>"],
);
 
@abmain::gS = (
[create_info =>"head", "Master Administrator Login Info"], 
[aF => "text", qq(size="40"), "Master Admin Login", ""], 
[oU => "password", qq(size="40"), "Master Password", ""], 
[iGz=> "text", qq(size="40"), "License key", ""], 
[create_info =>"head", "New Forum Info"], 
[dQ =>"text", qq(size="40"), "Name of the new forum", "",  "My Anyboard Forum"],
[wR =>"text", qq(size="40"), "Forum virtual directory name", "", "anyboard9/forum"],
[new_forum_agree=> "checkbox", qq(value="1"), qq(I have read and agree to the <a href="$rules_url">license terms</a>), "0"],
[hU => "text", qq(size="40"), "New Forum Administrator's Login ID", "admin"],
[admin_email => "text", qq(size="40"), "Admin E-mail Address, must be valid", ""],
[admin_email2 => "text", qq(size="40"), "Retype Admin E-mail Address", ""],
);

@abmain::tM = (
[find_info =>"head", "Search Messages In Forum"], 
[tK=> "text", qq(maxlength="40"), "Search pattern separated by space.<br><small>If you want to search a single word, simply enter the word. To match multiple words, enter the words separated by spaces.</small>", ""],
[scat => "select", '', "Message category", ""],
[wT=> "checkbox", qq(value="1"), "Search in message body. ( If this is not checked, then only the message subject and author are used in the search)", "0"],
[yVz => "select", $thread_sort_sel, "Sort threads by", "mM"],
[aO=> "checkbox", qq(value="1"), "Include contents of all messages in result ", "0"],
[hKz=> "checkbox", qq(value="1"), "Match only those messages that contain images", "0"],
[find_range=> "const", '', "Posting day range (1 hour ~ 0.04 day)", "",  qq(From <input type="text" size="4" name="hIz" value="30"> days ago, to <input type="text" size="4" name="hJz" value=0> days ago.)],
);

@abmain::lFa= (
[iGz=> "text", 'maxlength=800', "Key", ""],
[cmd=>"hidden", "", "", "kOa"],
);

@abmain::tJz = (
[activate_info =>"head", "Activate Your Account"], 
[uname=> "text", qq(maxlength="40"), "User name", ""],
[vkey=> "text", qq(maxlength="40"), "Validation key", ""],
);

@abmain::del_conf_cfgs = (
[activate_info =>"head", "Please confirm operation"], 
[kIz=> "checkbox", qq(value="1"), "Confirm by checking the box and then submit", "0"],
);
@abmain::hPa = (
[hdr_info =>"head", "Recommend the page to a friend"], 
[re_subject=>"const", "", "Subject", ""], 
[friend_name=> "text", qq(size="60"), "Name of the friend", ""],
[friend_email=> "text", qq(size="60"), "Email address of the friend", ""],
[myname => "text", qq(size="60"), "Your name", ""],
[mycomments=> "textarea", qq(rows="3" cols="60" wrap="soft"), "Your comments", ""],
);

@abmain::gEa = (
[hdr_info =>"head", "Send an email"], 
[em_subject=>"text", qq(size="60"), "Subject", ""], 
[em_emails=> "textarea", qq(rows="10" cols="40"), "Send to email boxes", ""],
[em_all=>"checkbox", qq(value="1"), "Check to send to all users", "0"],
[em_merge=>"checkbox", qq(value="1"), "Check to send email one by one", "0"],
[myname => "text", qq(size="60"), "Your name", ""],
[myemail=> "text", qq(size="60"), "Your E-Mail", ""],
[mybcc=> "text", qq(size="60"), "BCC to", ""],
[mycomments=> "textarea", qq(rows="3" cols="60" wrap="soft"), "Your comments", ""],
);

@abmain::gZa = (
[hdr_info =>"head", "Alert admin about the page"], 
[re_subject=>"const", "", "Topic", ""], 
[comments=> "textarea", qq(rows="3" cols="60" wrap="soft"), "Your comments", ""],
);

@abmain::uHz = (
[eve_info =>"head", "Add An Event"], 
[eve_subject=> "text", qq(size="60"), "Subject of the event", ""],
[eve_start=> "time", '', "Start time", "" ],
[eve_end=> "time", '', "End time", "" ],
[eve_location=> "textarea", qq(rows="4" cols="60"), "Location", ""],
[eve_description=> "htmltext", qq(rows="4" cols="60"), "Description", ""],
[eve_status=> "textarea", qq(rows="2" cols="60" wrap="soft"), "Event status", ""],
[eve_org=> "text", qq(size="60"), "Event organizer", ""],
[eve_contact => "textarea", qq(rows="4" cols="60"), "Contact information", ""],
[eve_can_sign=> "checkbox", '1=Yes', "Allow users to sign up for this event", "1"],
[eve_author=> "hidden", '', "", ""],
);

@abmain::uMz =(
[jQ => "head", "Links Configuration"], 
[enable_links=>"checkbox", qq(value="1"), "Enable link submission function", "1"],
[lnk_usr_add=>"checkbox", qq(value="1"), "Allow users to add links", "1"],
[lnk_opt=>"textarea", qq(rows="16" cols="48"), "Link category choices, one per line, in the format index=label. Categories will be listed in ascending order of indexes.","", undef, "=Select Category\n1=AnyEMail\n2=AnyBoard\n3=AnyECard"],
[lnk_usr_must_reg=>"checkbox", qq(value="1"), "Users must be registered to add links", "0"],
[lnk_show_adm=>"checkbox", qq(value="1"), "Display admin command on links page", "0"],
[lnk_max_desc=>"text", qq(size="60"), "Maximum size of the link description", "512"],
[lnk_page_banner=>"textarea", qq(rows="6" cols="60" wrap="soft"), "Link page top banner", "<h1>Related links</h1>"],
[lnk_vsep=>"textarea", qq(rows="6" cols="60" wrap="soft"), "Separator above links", "<hr><br>"],
[lnk_page_bbanner=>"textarea", qq(rows="6" cols="60" wrap="soft"), "Link page bottom banner", "<hr>"],
[lnk_add_word=>"text", qq(size="60"), "Add link word", "Add a new link"],
[lnk_del_word=>"text", qq(size="60"), "Delete link word", "<small>Delete</small>"],
[lnk_adm_word=>"text", qq(size="60"), "Administer link word", "<small>Admin</small>"],
[lnk_sd_sep =>"text", qq(size="60"), "Separator between link title and description", "\&nbsp;-\&nbsp;"],
);

@abmain::uWz = (
[lnk_info =>"head", "Add A Link"], 
[lnk_subject=> "text", qq(size="60"), "Title of the link", ""],
[lnk_url=> "text", qq(size="60"), "URL", ""],
[lnk_description=> "textarea", qq(rows="3" cols="60"), "Brief description", ""],
[lnk_author=> "hidden", '', "", ""],
);

@abmain::commit_cfgs = (
[commit_info =>"head", "Sign up"], 
[commit_contact=> "textarea", 'rows=2 cols=60 maxlength=240', "Your Contact information", ""],
[commit_comment=> "textarea", 'rows=2 cols=60 maxlength=120', "Comments", ""],
);

@abmain::forum_cfg_list = qw(
xO 
forginfo
yC 
fpost 
zE 
fmsg
ftag
bfeel
freturn
fbar 
fcolor
ffont
yE
lBz
fcat
ffm
ferror
yI
fmbox
fgrp 
fmp
fmailback
fchat
feve 
flnk
);

%abmain::qJa =(
yC=>["Control", \@abmain::eT, 1],
fpost=>["Posting Policy", \@abmain::tL, 1],
zE=>["Presentation", \@abmain::tG, 1],
fmsg=>["Message Page", \@abmain::forum_msg_cfgs, 1],
ftag=>["Tags transformation ", \@abmain::forum_tag_cfgs, 1],
fbar => ["Navigation bar",\@abmain::forum_bar_cfgs, 1],
#x1
#x1
fcolor=>["Colors", \@abmain::forum_color_cfgs, 1],
bfeel=>["Style", \@abmain::forum_style_cfgs, 1],
yE=>["Label", \@abmain::tU, 1],
ffont=>["Fonts", \@abmain::eWz, 1],
ferror=>["Error", \@abmain::error_cfg, 1],
freturn=>["Confirmation", \@abmain::forum_return_cfgs, 1],
fchat=>["Chat", \@abmain::forum_chat_cfgs, 1],
lBz=>["Emotion icons", \@abmain::lAz, 1],
#x1
#x1
#x1
#x1
);

%abmain::gRz =(
xO=>["Name", \@abmain::rC, 1],
forginfo=>["Name", \@abmain::forum_org_info_cfgs, 1],
yI=>["Notification", \@abmain::vQ, 0],
#x1
#x1
);

$uG=2654;
%abmain::eO =(
xO=>["Name and File", \@abmain::rC, 1],
forginfo=>["Organization Info", \@abmain::forum_org_info_cfgs, 1],
yC=>["Control", \@abmain::eT, 1],
fpost=>["Posting Policy", \@abmain::tL, 1],
zE=>["Presentation", \@abmain::tG, 1],
bfeel=>["Style", \@abmain::forum_style_cfgs, 1],
fmsg=>["Message Page", \@abmain::forum_msg_cfgs, 1],
#x1
#x1
freturn=>["Confirmation", \@abmain::forum_return_cfgs, 1],
#x1
ferror=>["Error", \@abmain::error_cfg, 1],
fbar => ["Navigation bar",\@abmain::forum_bar_cfgs, 1],
fcolor=>["Colors", \@abmain::forum_color_cfgs, 1],
ffont=>["Fonts", \@abmain::eWz, 1],
lBz=>["Emotion icons", \@abmain::lAz, 1],
yE=>["Label", \@abmain::tU, 1],
ftag=>["Tags transformation ", \@abmain::forum_tag_cfgs, 1],
#x1
yI=>["Notification", \@abmain::vQ, 0],
#x1
fchat=>["Chat", \@abmain::forum_chat_cfgs, 1],
#x1
#x1
ffm=>["Form Mail", \@abmain::cRa, 1],
);

%abmain::bK = (
 delnewsform=>['BOTH', \&pVa],
 delnews=>['BOTH', \&mKa],
 listnews=>['BOTH', \&fXaA],
 nI=> ['BOTH', \&gH, 'ADM'],
 hOz=> ['BOTH', \&hMz, 'ADM'],
 searchfs =>['BOTH', \&qMa],
 lGz=> ['BOTH', \&lHz, 'ADM'], 
 list_cats=> ['BOTH', \&wOz, 'ADM'], 
 cFz=> ['BOTH', \&cEz, 'ADM'], 
 log =>['POST', \&mN],
 login =>['POST', \&iQ],
 admlogout =>['POST', \&yFz],
 admin=>['GET', \&fBa],
 loginroot=>['POST', \&eYa],
 gochat =>['POST', \&sKz],
 sRz =>['POST', \&sWz],
 sQz =>['POST', \&vZz],
 speak=>['POST', \&sUz],
 fetchu=>["GET", \&pMa], 
 fetch_urls=>["GET", \&gJa],
#x1
 bRa=>['GET', \&bRa],
 printallem=>['GET', \&pNa],
 gemailform=>['GET', \&gTa],
 hMa=>['GET', \&gQa],
 dW =>['POST', \&bP],
 bH =>['POST', \&oW],
 ulogout =>['POST', \&gIa],
 reqpassform=>['GET', \&mVz],
 reqpass=>['POST', \&mUz],
 form =>['BOTH', \&iO],
 follow =>['BOTH', \&fP],
 fU =>['POST', \&hQ, 'ADM'], 
 config =>['POST', \&cV, 'ADM'], 
 subs_config =>['POST', \&qUa, 'ADM'], 
 kHz =>['POST', \&kJz, 'ADM'], 
 cU =>['POST', \&iI, 'ADM'], 
 preview_cfg =>['POST', \&vSz, 'ADM'], 
 save_config =>['POST', \&mIz, 'ADM'], 
 rHz=>['POST', \&xOz, 'ADM'], 
 rCz=>['POST', \&rCz, 'ADM'],
 rVz=>['POST', \&rVz, 'ADM'], 
 rWz=>['POST', \&rWz, 'ADM'], 
 vote=>['POST', \&rGz, 'ADM'], 
 xLz=>['POST', \&xLz, 'ADM'], 
 sA =>['POST', \&hT],
 lF => ['POST', \&nU, 'ADM'], 
 vJz=>['GET', \&vJz],
 nOz => ['POST', \&nMz, 'ADM'],  
#x1
#x1
#x1
#x1
#x1
#x1
 dT => ['POST', \&bJ, 'ADM'], 
 hZz => ['GET', \&hZz, 'ADM'], 
 sinfo => ['GET', \&wLz, 'ADM'], 
 getpathinfo => ['GET', \&dJaA, 'ADM'], 
 iFz => ['GET', \&iFz, 'ADM'], 
 kPz=>['GET', \&kLz],
 uS => ['POST', \&wE, 'ADM'], 
 bSz => ['POST', \&aHz, 'ADM'], 
 vXz => ['GET', \&vXz], 
 tVz => ['GET', \&tVz], 
 wMz => ['GET', \&wMz], 
 gidx => ['GET', \&tMz], 
 tOz => ['GET', \&uAz], 
 jB => ['GET', \&oL], 
 vJ => ['GET', \&uO], 
 lKa =>['GET', \&lKa],
#x1
 iLz =>['POST', \&wSz, 'ADM'],
 uP=> ['GET', \&uK], 
 zG => ['GET', \&yS], 
 upload => ['POST', \&mGz], 
#x1
 bRz => ['GET', \&aEz], 
 bV => ['POST', \&uR],
 vG => ['POST', \&uU],
 yV => ['BOTH', \&lK], 
#x1
 admregform => ['BOTH', \&wHz], 
 delregform => ['BOTH', \&yEz], 
 qL => ['BOTH', \&oT],
 vFz => ['BOTH', \&wEz],
 mailform=> ['BOTH', \&nQa],
 mailusr=> ['BOTH', \&sQa],
 alertadmform => ['BOTH', \&gMa], 
 alertadm => ['BOTH', \&hVa],
 recommend => ['BOTH', \&xBz],
 eveform => ['BOTH', \&tWz],
 uNz => ['BOTH', \&wWz],
 tIz => ['BOTH', \&vIz],
 modeveform => ['BOTH', \&tKz],
 tZz => ['BOTH', \&tRz],
 addlnk => ['BOTH', \&uPz],
 uOz => ['BOTH', \&uFz],
 tUz => ['BOTH', \&wVz],
 tQz => ['BOTH', \&tLz],
 tTz => ['BOTH', \&wXz],
 tYz=>['BOTH', \&tSz],
 tXz=>['BOTH', \&xPz],
 vsl=>['BOTH', \&wIz],
 rA => ['BOTH', \&gG],
 zT => ['BOTH', \&aBz],
 zJ => ['BOTH', \&zO], 
#x1
#x1
#x1
 lLa=> ['BOTH', \&bHz], 
 init=> ['BOTH', \&gT],
 rinit=> ['BOTH', \&fDa],
 lYa=> ['BOTH', \&iCa],
 lZa=>['BOTH', \&fEa],
 lOa=>['BOTH', \&gWa],
#x1
#x1
 lSa=>['BOTH',  \&lSa],
 mAa=>['BOTH',  \&mAa],
 mBa=>['BOTH',  \&mBa],
 lVa=>['BOTH',  \&lVa],
 pBa=>['BOTH', \&pBa],
 iXa=>['BOTH', \&iXa],
 delf=> ['BOTH', \&jNz],
 lNa=> ['BOTH', \&hMz],
 lXa=> ['BOTH', \&gT],
 lQz=>['BOTH', \&wJz], 
 lOz=>['BOTH', \&xCz], 
 lNz=>['BOTH', \&xNz], 
 lMz =>['BOTH', \&vTz],       
 bDz => ['BOTH', \&bCz],
 gen_grp_form => ['BOTH', \&bXa],
 gfindform=>['BOTH', \&rEa], 
 lAa=>['BOTH', \&lAa],
 kOa=>['BOTH', \&kOa],
 upgradeab=>['BOTH', \&upgradeab],
 convertmdb=>['BOTH', \&convert_msg_db],
 create_group=> ['BOTH', \&fHa],
 fD => ['BOTH', \&hP],
 hPz => ['BOTH', \&hNz],
 myforum=>['BOTH', \&xSz],
 find =>['BOTH', \&hK],
 finda =>['BOTH', \&wC],
 renamep =>['BOTH', \&sPa, 'ADM'],
 reg    => ['POST',  \&lR],
#x1
#x1
#x1
 activate => ['POST',  \&vW], 
 gQ => ['POST', \&mL, 'ADM'],
#x1
#x1
#x1
#x1
 rU => ['POST', \&tH, 'ADM'],
 hYz => ['POST', \&hXz, 'ADM'],
 iJz =>['POST', \&iJz, 'ADM'],
 qSa=>['POST', \&yTa, 'ADM'],
 get => ['GET', \&jL, 'ADM'],
 geta => ['GET', \&kAz, 'ADM'],
 retr=>['GET', 'iLa'],
 mDz => ['GET', \&mEz],
 iYz=>['GET', \&iXz],
 oFa=>['POST', \&oFa], 
#x1
#x1
 xQa=>['GET', \&xNa], 
 mform=>["GET", \&bFa], 
 modmp=>["GET", \&bEa],
 viewmp=>["GET", \&bIa],
 mimg =>["GET", \&bUa],
 procform=>['BOTH', \&cQa],
 viewtags=>['BOTH', \&fNa],
 ablist=>['BOTH', \&fLa],
 copythr=>['BOTH', \&fPa],
 lHa =>['GET', \&lHa],
 yKa=>["GET", \&yKa],
 yEa=>["GET", \&yWa],
 );

} #end of iJa

sub oLa {

my $image_go=<<'image_go_END';
M1TE&.#EA(``@`,0?``,#`X2$@L7#H:2CG^3CP[2SF-/2LI24DO3SU41$.*RK
MF+JZNL[.SKR[G)R<F?[^^VAH8BHJ)104$3(R*GU\=%A83>/CX];6U<S+JNSH
MR]S;NXV-B_S[X!X>'CX^-?___R'Y!`'H`Q\`+``````@`"````7_X">.9&F>
M:*JN;.N66",+V(LVRK$=NNX4-=NGT7,8CP>'3O$2*#<[7M0Q0#H$K,(.:-!X
M#1C%CEKE85.*`<:K(1`R;H*W,58H'4&3S$M`<!X/?QP("'(&2@-V!TPP`ET:
M"("2DX%P!AMD2F<B!0$!!P1_E)0<''`,F`,#BR,8`4H!!J,+%!L6DH-R=JH.
M&R-:21L"E!0`'1(2N*8:&)AVPB(Y1AL%H@\6`!"`!P\7%1X#;I=D!PW12;T#
M&9$/"@`,%@P7#Q,>$`".AU1*!>=5&[$,"-P`0$$"`!(:`#B``0`%,*MX,2J`
M[L!#@08&.&Q0(2&`#08<8FBVKYP(`3M6EP58@`&,@0D`*DR0@*'#A`H`@(39
MMR%/DE4[P(P44"&"AX<&)P08B6%!%$;GJ!P(H,#E2*%,A=(04.!'"912+2I@
M2I;I5@%<KYR@$_;5UK)HT>(XL,F$F+84!L3=*T-!K3PH[DJ%4@N=$@J>H*X`
K9E@'E,>8ZK((`X4'CR<;]`HA@:-*+P7F5`#>?&(TZ=,O3(\VG4)UB1``.P``

image_go_END
my $vB=<<'uQ';
M1TE&.#EA&@`7`+,.`*".D%!3:E!GAFZ.W=SF\-+3W2@L0V2$K109'3)`5F1G
MTZ"KW3(LRCQ`T____P```"'Y!`'H`PX`+``````:`!<```2GT,E)J[TXZ\T[
M$,)"=!:1),(P'"0U($AZ#,DX$38&&/$\"#7*0O/JK0ZGW&"HXP52JX`A,%DP
M<A4"[#F0+'@`R8#1Q?!03,<"YF5<,0'$=&C;.0@#!2.==0X7"A(X>`H-#1EQ
M`2-6:81N6!0["05WADP%"IE[&7(V"PT*2TN%9!D`DQ-Y*@LJ>H&(.02AK*V@
9D!5\#K,->;RW&Z*]N21XJK\M."W*&1$`.P``

uQ

 if(not $abmain::gJ{img}) {
 $vB =~ s/\r\n/\n/g;
 $mBz = unpack("u*", $vB);
 undef $vB;
 }else {
 $image_go =~ s/\r\n/\n/g;
 $mBz = unpack("u*", $image_go);
 undef $image_go;
 }
 sVa::gYaA "Content-type: image/gif\n";
 print abmain::bC($abmain::cH, abmain::nXa(undef), '/', abmain::dU('pJ',24*3600*128));
 print "\n";
 binmode STDOUT;
 print $mBz;
 &abmain::iUz();
}
 ### spell checker

sub mRa {
 my %langs=( "en" , "English", "uk" , "British", "fr" , "French", "ge" , "German", "it" , "Italian",
 "sp" , "Spanish", "dk" , "Danish", "br" , "Brazilian", "nl" , "Dutch", "no" , "Norwegian",
 "pt" , "Portuguese", "se" , "Swedish", "fi" , "Finnish");
 my ($f, $msg) = @_;
 return qq!<input type="BUTTON" value= "SpellCheck" onclick= "doSpell($f.spelllang.options[$f.spelllang.selectedIndex].value, $f.$msg, document.location.protocol+'//'+document.location.host+'$abmain::spellcgi', true);"> 
 <select name=spelllang>!. join ("", map { qq(<option value="$_" @{[$_ eq 'en'? 'SELECTED':""]}>$langs{$_}) } sort keys %langs )."</select>";
}
sub htmla_code {
	my $img= $abmain::img_top;
return  qq!
<script>_editor_url="$img/htmlarea/";</script>
<script type="text/javascript" src="$img/htmlarea/htmlarea.js"></script>
<script type="text/javascript" src="$img/htmlarea/dialog.js"></script>
<script type="text/javascript" src="$img/htmlarea/lang/en.js"></script>
<style type="text/css">\@import url($img/htmlarea/htmlarea.css)</style>
!;
}
sub pEa{
 my $m = shift;
 my $who = join("-", caller);
 open LOGF, ">>/tmp/logm";
 print LOGF &jSz, ": $m\n";
 close LOGF;
}

sub iUz {
 my $code = shift;
 if($ENV{GATEWAY_INTERFACE} =~ /^CGI-Perl/ || exists $ENV{MOD_PERL}) {
 require Apache;
 $iS->lLz() if $iS;
 undef %{$iS};
 undef $iS;
 undef %gJ;
 undef %mCa;
 undef %fPz;
#x1
 $@=undef;
 }elsif($main::is_ithread) {
	die;
 }else {
 exit;
 }
}

sub pZa {
 if($ENV{GATEWAY_INTERFACE} =~ /^CGI-Perl/ || exists $ENV{MOD_PERL}) {
#x1
 }
}

sub zSz {
 my ($id, $varri, $aOa, $zJz) = @_;
 my $str = qq(<select name="$id">);
 my ($sel, $dv);
 for (@$varri) {
 $sel = "";
 $sel ="SELECTED" if $aOa && $aOa eq $_;
 if($zJz) {
 $dv = shift @$zJz;
 }else {
 $dv = $_;
 }
 $str .= qq(<option value="$_" $sel>$dv);
 }
 return $str."</select>";  
}
sub pQa{
 my ($hR) = @_;
 my $t1 =new Benchmark;
 push @abmain::ticks, "$hR: ".  timestr(timediff($t1, $abmain::t0));
 $abmain::t0 = $t1;
}

sub cUz {
 my ($url, $str, $tgt, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 $attr ||="";
 $attr =" $attr" if $attr;
 $attr =" $abmain::def_link_attr" if $abmain::def_link_attr;
 return qq(<a href="$url" target="$tgt"$attr>$str</a>) if $tgt;
 return qq(<a href="$url"$attr>$str</a>);
}

sub hFa{
 my ($url, $str, $popwin, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 $popwin="abnew" if not $popwin;
 return qq(<a href="$url" $attr onclick="newWindow(this.href, '$popwin', 0.6,0.6,'yes');return false;">$str</a>);
}

sub oPa {
 my ($str, $sep) = @_;
 $sep = "=" if not $sep;
 my ($k, $v, $pos);
 $pos = index $_, $sep;
 $k = substr $_, 0, $pos;
 $v = substr $_, $pos+1;
 return ($k, $v);
}

sub nPa {
 my $c = shift;
 open DF, ">>/tmp/abfuncs";
 print DF $c, "\n";
 close DF;
}

sub hUa{
 my $gEz = $abmain::fPz{fOz};
 my ($gJz, $fJz) = split/\&/, $gEz;
 $gJz = pack("h*", $gJz);
 ($abmain::ab_id0, $abmain::ab_id1, $abmain::ab_track) = (split /\</, $abmain::fPz{$abmain::cH})[0..2];
 $abmain::ab_id0 = $gJz if $gJz;
 @abmain::kQa =  abmain::lCa($abmain::lGa, $abmain::lEa[0]);
}

sub nXa{
 my $name = shift;
 if(defined $name) {
 	$abmain::ab_id1 = $abmain::ab_id0;
 	$abmain::ab_id0 = $name;
 }
 $abmain::ab_track= join('.', time(), abmain::bW($ENV{'REMOTE_ADDR'})) if not $abmain::ab_track;
 return join('<', $abmain::ab_id0, $abmain::ab_id1, $abmain::ab_track);
}

sub oUa {
 my $is_exit= shift || "0";
 $bYaA->new(abmain::wTz('actlog'), {schema=>"AbActivityLog"})->iSa(
 [abmain::dU('LONG', time(), 'oP'), $ENV{REMOTE_ADDR}, $ENV{PATH_INFO}, $ENV{QUERY_STRING}, $$, $is_exit,  $ENV{PATH_INFO},  $abmain::ab_track, $abmain::ab_id0, $abmain::gJ{cmd}, $ENV{HTTP_REFERER}]
 );
}

sub oYa {
 my $f = abmain::kZz($abmain::master_cfg_dir, $$);
 open F, ">$f.dmp";
 print F "ENV:\n";
 for(keys %ENV) {
	print F $_, "=", $ENV{$_}, "\n";
 } 
 print F "gJ:\n";
 for(keys %abmain::gJ) {
	print F $_, "=", $abmain::gJ{$_}, "\n";
 } 
 print F $abmain::start_time, "--", time();
 close F;
 abmain::error('sys', "time out");
}

sub oTa{
 my ($arrref, $val) = @_;
 my $pos;
 for($pos=0; ; $pos++) {
	return $pos if $arrref->[$pos] eq $val;
 }
 return -1;
}





sub lL {
$mC= qq@
<script language="javascript">
<!--
function hB(f,fm, w,h) {
 if(!w) w = 620; if(!h) h = 420; if(fm)fm.hIa.value=1;
 nw=window.open("", f, "width="+w+",height="+h+",menubar=no,toolbar=no,scrollbars=yes,resizable=yes"); 
 nw.document.write('<html><title>Waiting for response</title><body bgcolor="#eeeeee"><h1><font color="#000022">Waiting for response ...</font></h1></body></html>');
 return true;
}

function kEz(f, val) {
 for(var i=0; i< f.elements.length; i++) {
 var e = f.elements[i];
 if(e.type=="checkbox") e.checked = val; 
 }
}
//-->
</script>
@;

}
sub oWa {
return qq@
<script language="javascript">
<!--
var ab_newin=null;
function newWindow(nH, myname, w, h, scroll) {
w=(screen.width)?screen.width*w: 620;
h=(screen.height)?screen.height*h:420;
LeftPos=(screen.height)?screen.width-w-5:0;
TopPos=(screen.height)?5:0;
setting='';
settings='height='+h+',width='+w+',top='+TopPos+',left='+LeftPos+',scrollbars='+scroll+',resizable';
if(ab_newin==null || ab_newin.closed) {
	ab_newin=window.open(nH, myname, settings);
}else {
	ab_newin.location=nH;
}
ab_newin.opener = window;
ab_newin.focus();
}
//-->
</script>
@;

}
sub wTz {
 my ($which, $dir)=@_;
 return abmain::kZz($dir||$abmain::master_cfg_dir, $jW::hNa{$which});
}
sub pR {
 $oG = abmain::kZz($abmain::master_cfg_dir,"config");
 $cAz = abmain::kZz($abmain::master_cfg_dir,"forum_list");
 $bWz = abmain::kZz($abmain::master_cfg_dir,"default.conf");
 $oC = abmain::kZz($abmain::master_cfg_dir,$abmain::no_dot_file?"fYz":".fYz");
 $master_dbdef_dir = abmain::kZz($abmain::master_cfg_dir, 'dbdefs');
}
sub lKz{
 my ($p, $s) = @_;
 return "" if not $p;
 my @arr = ('a'..'z');
 if (!$s) {
 	$s = $arr[int (rand()*25)] . $arr[int rand()*25];
 $s = "ne";
 }else {
 $s = substr $s, 0, 2;
 $s = "ne";
 }
 return $abmain::no_crypt? abmain::fVz($p, 127*127): crypt($p, $s);
}
sub cTz {
 my $msg = shift;
 my ($tit, $cVz, $cookie, $doclose) = @_;
 sVa::gYaA "Content-type: text/html\n";
 print "$cookie\n" if $cookie;
 print "\n";
 print "<html><head>\n";
 $doclose = $abmain::gJ{hIa} if not $doclose;
 print qq(<meta http-equiv="refresh" CONTENT="2; URL=$cVz">) if $cVz && not $doclose;
 print $iS->{sAz}, "\n" if $iS && $iS->{sAz};
 print "\n";
 my $close_win;
 $close_win= qq(<script>\nsetTimeout('window.close()', 20000);\n</script>\n) if $doclose;
 print "<title>$tit</title>\n";
 if( $iS->{_loaded_cfgs} ) {
		$iS->eMaA([qw(other_header other_footer)]);
 }
 print $abmain::iS->{other_header};
 print qq(&nbsp;<p><p>);
 print $msg;
 print "<hr><br>", $abmain::close_btn if $doclose;
 print "<p><small>", abmain::cUz($cVz, "Redirecting to $cVz"), "</small>" if $cVz && not $doclose;
 print qq@<p><hr><a href="javascript:history.go(-1)"><small>back</small></a>@;
 print $close_win;
 print $abmain::iS->{other_footer};
}
sub yDz{
 my $str = shift;
 my $maxlen = shift;
 my $len = length($str);
 return $str if $len <= $maxlen;
 return substr($str, 0, $maxlen -3)."...";
}
sub kPz{
 my $cook;
 if(not $abmain::fPz{avis}){
 $cook = bC('avis', time, "/", dU('pJ', 60*3600*24));
 }
#x1
 cTz($msg, "Fetch profile", $iS->fC(), $cook);
}
sub error {
 my ($error, $kG, $suggest)  = @_;
 my $lU = $error;
 my $nT  = "Unknown";
 my $fG = "Notify webmaster";

 my $var = $abmain::cP{$error};
 if($var) {
 $lU = $var->[0];
 $nT = $var->[1];
 $fG  = $suggest || $var->[2];
 }

 my $header ="";
 $error =~ s#$err_filter#X#g if $err_filter;
 $kG =~ s#$err_filter#X#g if $err_filter;
 sVa::gYaA "Content-type: text/html\n";

 if($error eq 'forbid_words'){
 $jH = $jH +1;
 $header = bC($abmain::dS, $jH, "/", dU('pJ', 60*3600*24));
 $lU = qq(Did you say <font color="#cc0000"> $jW::fO </font>, $gJ{'name'} ??);
 $nT = "<center>$iS->{scare_msg}</center>\n";
 &nF;

 }elsif ($error eq 'nG'){
 $lU = "Unknown Server Error 7161";
 if($abmain::js ne 'hV') {
 $nT =qq@<script language="javascript"><!--
 var i=0;  
#x1
#x1
#x1
#x1
#x1
 //--> </script>@; 
 }
 }
 print $header;
 print "\n<html><head><title>Error: $kG</title>\n";
 if($abmain::iS) {
	if( $iS->{_loaded_cfgs} ) {
		$iS->eMaA([qw(other_header other_footer)]);
	}
	print $abmain::iS->{sAz}, "\n";
	print $abmain::iS->{other_header};
 }else {
 	print qq(</head><body bgcolor="$abmain::msg_bg">);
 }
 my @rows;
 
=item
 print qq(<table width="75%" align="center" border="0"><tr><td><h3>$kG</h3></td></tr></table><br>);
 print qq( 
<table align="center" border="0" cellpadding=0 cellspacing=0 width=75% bgcolor="#000000"><tr><td>
<table align="center" border="0" width=100% cellspacing=1 cellpadding=5>
<tr bgcolor="#aaaaaa"><th colspan=2><img src="$abmain::img_top/error.gif" align="left" alt="Error" hspace=5 vspace=4> <font color="#ffffff">$kG</font></th></tr> 
<tr bgcolor="#ffffff"><td>Error type</td><td> <b>$lU</b></td></tr> 
<tr bgcolor="#dddddd"><td>General description</td><td> $nT</td></tr> 
<tr bgcolor="#ffffff"><td>Suggested action</td><td>$fG</td></tr>
</td></tr></table>
</table>
);
=cut
 push @rows, [qq(<img src="$abmain::img_top/error.gif" align="left" alt="Error" hscape=4 vspace=4> <font color="#ffffff">$kG</font>)];
 push @rows, [qq(Error type), qq(<b>$lU</b>)];
 push @rows, [qq(General description), $nT ];
 push @rows, [qq(Suggested action), $fG];

 my $goback = qq(<a href="javascript:history.go(-1)">Go back</a>);
 my $gohome= qq(<a href="/">Home page</a);
 my $capt = join ('&nbsp;|&nbsp;', $goback, $gohome);

 if (ref($iS)) {
 	print sVa::fMa($iS->oVa(), rows=>\@rows, capt=>$capt);
 }else {
 	print sVa::fMa(sVa::oVa(), rows=>\@rows, capt=>$capt);
 }

 print "<p><p>\n";
 if($abmain::iS) {
	if($abmain::iS->{bXz}->{body} ne "") {
		print $abmain::iS->gDaA();
	}
	print $abmain::iS->{other_footer};
 if($abmain::iS->{yLz} eq 'POST') {
#		$abmain::iS->wNz($lU, $abmain::gJ{name}||$abmain::iS->{bXz}->{name}||$abmain::iS->{fTz}->{name}, $abmain::iS->nDz('failpostlog'));
	}
 }else {
 	print "</body></html>\n";
 }
 print "<!--", join("; ", caller(6)), "-->";
 &abmain::iUz();
 
}  
sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
 next if $_ eq "";
 $root =~ s#/*$#/# if not $_  =~ /^\?/;
 $_ =~ s#^/*##;
 $root .= $_; 
 }
 return $root;
}

 

sub oNa{
 if (not -d $abmain::master_cfg_dir) {
 	mkdir ($abmain::master_cfg_dir, 0777) or return;
 }
 my $cfgd =kZz($abmain::master_cfg_dir, "forum_cfg");
 if(not -d $cfgd) {
 	 mkdir ($cfgd, 0777) or return;
 }
 
 return nZa($abmain::master_cfg_dir);
}
sub nZa{
	my $dir = shift;
 	return if not -w $dir;
 	my $f = kZz($dir, time()."abt"); 
 my $w;
	local *F;
 	if((open F, ">$f") && print F time() ) {
		close F;
		$w = 1;
 	}
 	unlink $f if -f $f;
	return $w;
}
sub oEa{
 my ($dir, $foundarr, $match, $hO, $maxlev, $fN)=@_;
 return if $maxlev && $hO > $maxlev;
 $hO ++;
 opendir DIR, "$dir";
 my @entries = readdir DIR;
 closedir DIR;
 local *F;
 my @dirs = grep { -d "$dir/$_" && ! /^\.\.?$/  && /$match/i} @entries;

 for (@dirs) {
 my $thisd = kZz($dir, $_);
 oEa($thisd, $foundarr, $match, $hO, $maxlev);
 next if not -w $thisd;
 push @$foundarr, $thisd if nZa($thisd);;
 return if scalar(@$foundarr) > ($fN||10);
 }
}
sub nOa {
 my $header =<<'EOF_MH';
<html><head>
<STYLE type="text/css">
<!--
H1 {font-size: 20pt; text-align: center}
TH {font-size: 11pt; font-family: "Arial, Helvetica, sans-serif"}
HTML, BODY, TD {font-size: 10pt; font-family: "Arial, Helvetica, sans-serif"}
UL {list-style: disc}
A:hover { color: #007FFFF; text-decoration: underline; background-color: #ffee00;}
-->
</STYLE>
<body>
<table width=75% border="0" align="center"><tr><td>
<a href="http://netbula.com/anyboard">
<img src="http://netbula.com/images/ab.jpg" border="0"></a>
</td><td valign=middle align=right> <h2>AnyBoard Master Administration</h2></td></tr></table>
EOF_MH

 my $footer=<<'EOF_MH';
</body></html>
EOF_MH
 
 return ($header, $footer);

}
sub dJaA {
 sVa::gYaA "Content-type: text/plain\n\n";
 print "bS: $ENV{PATH_INFO}\n";
 print "path_translated:  $ENV{PATH_TRANSLATED}\n";
}

sub wLz {
 my $i=0;
 my @sendmail_guess= ('/usr/lib/sendmail', '/usr/sbin/sendmail', '/usr/ucblib/sendmail');
 sVa::gYaA "Content-type: text/html\n";
=item
 if(not $ENV{REMOTE_USER}) {
 	print "WWW-Authenticate: Basic realm=AnyBoard\n";
 	print "Status: 401 Unauthorized\n";
 }
=cut
 print "\n";
 
 print qq(<html><body>);
 return if $abmain::disable_sinfo;
 my (@rows, @rows2);
 my $pathchk;
 my $bS = $ENV{PATH_INFO};
 if($bS =~ /$ENV{SCRIPT_NAME}/) {
	$pathchk = "PATH_INFO looks bad.";
 }
 my $docroot_guess;
 if(1) {
	my $prog = $0;
	if ($prog =~ /^anyboard/i && $prog !~ m!/!) {
		$prog = kZz(nFa(), $prog);
	}
	$prog =~ s/\\/\//g;
	$prog =~ s/$ENV{SCRIPT_NAME}//g;
	$docroot_guess= $prog;
 }
 push @rows2,  ["PATH_INFO", $bS, "$pathchk If PATH_INFO is bogus, then you need to set the no_pathinfo variable in the script to 1"];
 my $test="";                  
 my $path = $ENV{PATH_TRANSLATED};
 $test = "<li>Not exist or not a dir!\n" if($path && not -d $path);
 $test .= "<li>Not writable!\n" if(-d $path && not -w $path);
 $test .= "<li>Not owned by CGI user!\n" if(-d $path && not -O $path);
 if($bS eq "/" && not -d $path){
	$test .= "<li>You must set \$abmain::fix_top_dir";
 }
 push @rows2, ["PATH", $ENV{PATH_TRANSLATED}, $test];
 $path = $abmain::master_cfg_dir;
 my $masterd_ok = 1;
 my $master_w = oNa();
 $test = "";
 if(not (-e $path && -d $path)) {
 	$test = "<li>Master configuration directory $path does not exist! You must manually create it first.\n";
	$masterd_ok =0;
 }elsif(not -d $path) {
 	$test = "<li>$path is not a directory! You need to create an empty directory and assign its path to \$master_cfg_dir. \n";
	$masterd_ok =0;
 }elsif( not $master_w ) {
 	$test .= "<li>$path is not writable! Please change the directory permission to make it writable, so Anyboard can create files under it.\n";
 $test .= "<li>Since this is a Windows system, you can't change permission yourself, you have to ask your ISP to change the directory permission to full control for the Iusr_.\n" if $^O =~ /win/i;;
 	my $uo = sVa::get_unix_file_owner($path);
 	my $uperm = sVa::get_unix_file_owner($path);
	if($uo) {
		$test .="<li>$path is owned by <b>$uo</b>, permission is $uperm";
	}
	my @darr=();
 oEa("..", \@darr, "", 0, 2);
 if(scalar(@darr)) {
		$test .= "<li>The following directories are writable:\n<pre>". join("\n", @darr[0..5]). "</pre>";
	}
	$masterd_ok =0;
 }
 if (-e $path && not -O $path) {
 	$test .= qq(<li><font color="#005555">Since $path is not owned by CGI user, you need to change directory permissions to 0777.</font>\n);
 }

 push @rows, ["<b>Master CFG</b>", $path,  $test];
 push @rows,  ["AnyBoard CGI URL", $abmain::lGa, "If this does not match the URL to the anyboard program, then you must to set the fix_cgi_url variable. You must provide this URL when obtaining a license key."];
 push @rows, [ "Working directory", $ENV{PWD}||nFa(), "If you are not sure about the full path of the web directory, this may give you a hint"];
 push @rows,  ["<b>CGI User</b><br>($<, $>)", eval {(getpwuid($>))[0] || "unknown" }, 
 "Is the CGI user the same as your shell or ftp login ID? If not, you need to create a web directory with permissions set to 0777, then create forums under it."];
 push @rows, ["Fixed parameters and SQL DB options", join("<br>", "fix_top_dir=".$abmain::fix_top_dir, 
			"fix_top_url=".$abmain::fix_top_url, "fix_cgi_url=".$abmain::fix_cgi_url,
 "no_pathinfo=".$abmain::no_pathinfo, 
 "loaded from fixcfg?=".$abmain::loaded_fix,
			"use SQL database?=".$abmain::use_sql
			),
			 "If no_pathinfo is set to 1, the three fix_ variables must be set. If PATHINFO is used, these are optional."];

 print sVa::fMa(rows=>\@rows, ths => [jW::mJa($iS->{cfg_head_font}, "Attribute", "Value", "Comments")], $iS->oVa());
 print "<br><center>";
 print abmain::cUz("$iS->{cgi}?@{[$abmain::cZa]}cmd=init", "<b>Guide me through the setup process!</b>");
 print "<p>";
 print "<p>\&nbsp;" x 4;

 push @rows2,  ["WEB site", $abmain::dB, "If this does not match your domain name, then you must to set the fix_ variables"];
 push @rows2,  ["PERL VERSION", $], ($]< 5.004)?qq(<font color="red">Needs upgrade</font>):""];
 push @rows2, ["Script Name", $ENV{SCRIPT_NAME}, ""];
 my $oner = sVa::get_unix_file_owner($0);
 my $perm = sVa::get_unix_file_perm($0);
 push @rows2, ["Script File", $ENV{SCRIPT_FILENAME}, 
 "Program file=$0 ($oner/$perm)<br>If you are not sure about the full path of the web directory, this may give you a hint (<b>$docroot_guess</b>)."];
 push @rows2,  ["Web Server Software", $ENV{SERVER_SOFTWARE}];
 push @rows2,  ["Operating system", $^O, ""];
 push @rows2,  ["DOCROOT", $ENV{DOCUMENT_ROOT}, "Web root directory"] if -d $ENV{DOCUMENT_ROOT};
 push @rows2,  ["AnyBoard Version", $abmain::VERSION, ""];
 my $sendmail_loc;
 for(@sendmail_guess) {
 $sendmail_loc = $_ if -x $_;
 }
 if($sendmail_loc) {
 	push @rows2, ["Found sendmail program", $sendmail_loc, "-t flag"];
 }

 print "<center><h3>Additional information</h3></center>";
 print sVa::fMa(rows=>\@rows2, ths => [jW::mJa($iS->{cfg_head_font}, "Attribute", "Value", "Comments")], $iS->oVa());

 if($abmain::gJ{env}) {
	my @rows;
	for my $k (sort keys %ENV){
		push @rows, [$k, $ENV{$k}];
		
	}
	push @rows, ["INC", join(":", @INC)];
 	print sVa::fMa(rows=>\@rows, ths => [jW::mJa($iS->{cfg_head_font}, "Variable", "Value") ], $iS->oVa());

 }
 print "</center></body></html>";
 print "<!--$abmain::yCa-->" if $abmain::gJ{all};
 abmain::fWa() if $master_w ;
}
sub nFa {
 my $cwd = eval 'use Cwd; getcwd();';
 
 if($^O=~/win/i && not $cwd) {
	$cwd = `chdir`;
 }else {
	$cwd = `pwd`;
 }
 $cwd =~ s/\s+$//;
 return $cwd;

}
sub cLz {
 my $name = shift;
 if($name) {
 return  abmain::kZz($abmain::master_cfg_dir,"$name.conf");
 }
 return $bWz;
}
sub hZz{
 abmain::cTz("<h1>$license_key</h1>");	
}
sub vKz {
 my ($dir, $ext) = @_;
 my @flist;
 if($jW::use_glob) {
	@flist= glob (abmain::kZz($dir, "*.$ext"));
 }else {
 	opendir DIRF, $dir or return; 
 	@flist = grep /\.$ext$/, readdir DIRF; 
 	closedir DIRF;
 }
 for(@flist) {
 $_ =~ s/\.$ext$//;
 $_ =~ s#^.*/##;
 }
 @flist;
}
sub gOa{
 my ($dir, $user)=@_;
 my $exfile =abmain::kZz($dir, ".kill");
 open(aXz, ">>$exfile") or abmain::error('sys', "On writing file $exfile: $!");
 print aXz "$user\n";
 close aXz;
}
sub vNz {
 return vKz($abmain::master_cfg_dir, 'conf');
}
sub cMz {
 my @jS = vNz();
 unshift @jS, 'Built-in';
 return zSz("cKz", \@jS);
}
sub gH {
 my $dVz = $iS->{eD};
 $dVz =~ s!\\!/!g if $^O =~ /win/i;
 $dVz =~ s#/[^/]+/?$##; #remove last dir component
 my $canmake = (abmain::lIz($dVz))[3];
 abmain::error('deny', "Can not make forum under $abmain::eD.") if not $canmake;  
 abmain::error('inval', "$dVz does not exist!") if ($abmain::no_nest_bdir && not -d $dVz);
 $iS->{admin}= $abmain::gJ{admin};
 $iS->{admin_email}= $abmain::gJ{admin_email};
 $iS->{name}=$abmain::gJ{name};
 $iS->{admin} =~ s/\t/ /g;
 $iS->{name} =~ s/\t/ /g;
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $pA = $abmain::gJ{pA};
 my $eD = $iS->{eD};
 $eD =~ s!\\!/!g if $^O =~ /win/i;
 $pA =~ s#/?$##;
 $eD =~ s#/?$##;
 $eD =~ s!$pA$!!;
 if(not -d $eD) {
	error('inval', "$eD does not exist!<br> It seems that the script needs custom configuration. You can logon master admin panel (".
			abmain::cUz($abmain::lGa, $abmain::lGa). ") ".
 "and fix the configurations by setting no_pathinfo to 1  and set the fixed directories and URLs. If it still does not work, submit an installation request to AnyBoard support ( http://netbula.com/anyboard/installreq.html )"
 );
	
 }
 error('dM', "Who are you?") if $iS->{oU} ne $abmain::gJ{kS}; 
 $abmain::top_virtual_dir =~ s!^/?!/!;
 error('inval', "New forum virtual path must start from $abmain::top_virtual_dir ($abmain::fvp)")
 if($abmain::fvp !~ /^$abmain::top_virtual_dir/);
 my @paths= $iS->eP($abmain::gJ{gF}, $iS->{name}, $iS->{admin}, $iS->{admin_email}, $abmain::gJ{cKz}, $abmain::gJ{iGz}||$iS->{iGz});
 $bYaA->new($abmain::cAz, {schema=>"AbMasterList"})->iSa(
 	[$iS->{name}, $iS->{admin}, $iS->{admin_email}, time(), $fvp, $abmain::gJ{gF}, $iS->{eD}, abmain::lWz()]
 );
 
 if($abmain::validate_admin_email) {
 abmain::cTz(abmain::cUz($iS->xIz(), $iS->{name}). " created.<br> Administrator password sent to $iS->{admin_email}");
 }else {
 sVa::hCaA "Location: $dLz?@{[$abmain::cZa]}cmd=login;fM=$iS->{admin}\n\n";
#       sVa::hCaA "Location: ", $iS->xIz(), "\n\n";
 }
}
sub pSa{
 my $k = pack("H*", $_[0]);
 return (split /:/, $k);	
}
sub nWa{
 unpack("%16C*", $_[1]).
 unpack("%16C*", $_[0]);
}
sub kTa{
 my($kSa,  $prog, $kRa, $kYa, $kVa, $kXa, $lBa,$lDa, $kZa) = @_;
 $kSa =~ s!^https?://!!i;
 my $str = lc($kSa.join("", reverse @_));
 my $chksm = unpack("%32C*", $str);
 return lc($prog.$kRa.$kYa.$chksm."$kVa${kXa}n$lBa$lDa$kZa");
}
sub lCa{
 my @arr = (split /(\d+)/, lc($_[1]))[0..2, 4,5,7..9]; 
 return  @arr if $_[1] eq kTa($_[0], @arr);
}
sub fWa{
 $abmain::off_webroot=1;
 $abmain::fix_top_dir = $abmain::master_cfg_dir;
 local $abmain::no_pathinfo =1;
 my $fvp = "main";
 my $eD = abmain::kZz($abmain::fix_top_dir, $fvp);
 my $iS = jW->new(eD=>$eD, cgi=>$abmain::jT, cgi_full=>$abmain::dLz);
 return if -f $iS->nDz('fU');
 $abmain::cZa ="pvp=$fvp\&";
 $abmain::cYa=qq(<input type="hidden" name="pvp" value="$fvp">);
 my @paths= $iS->eP("", "Master forum");
 $abmain::off_webroot=0;
}
sub mPa{
 eval 'use Win32::FileSecurity qw(MakeMask Get Set)';
 my ($file) = @_;
	sVa::gYaA "Content-type: text/html\n\n";
	print "<html><body><pre>";

	my $ph = pPa($file);
	for(keys %$ph) {
		print $_,"\n\t";
		print join ("\n\t", @{$ph->{$_}}), "\n\n";

	}	
	print "</pre></body></html>";
}
sub oIa{
 eval 'use Win32::FileSecurity qw(MakeMask Get Set)';
 $abmain::gcnt++;
 my $filea = MakeMask( qw( FULL ) );
 my $dira = MakeMask( qw( FULL GENERIC_ALL) );
 return if $abmain::gcnt >4;
 my ($dir, $kQz) = @_;
 opendir DIR, $dir or print "Fail open dir $dir\n";
 my @dirs = readdir DIR;
 closedir DIR;
 my %hash;
 foreach( @dirs) {
 s/\\$//;
	next if $_ eq  '.' || $_ eq '..';
 my $f = "$dir\\$_";
 Get( $f, \%hash ) ;
 if(-d $f) {
		$hash{$kQz} = $dira;
 	Set( $f, \%hash ) ;
		print "Set dir $f\n";
		oIa($f, $kQz);
 }else {
		$hash{$kQz} = $filea;
 	Set( $f, \%hash ) ;
		print "Set file $f\n";
 }
		
 }
}
sub pPa{
 my $f = shift;
 return unless -e $f ;
 my %hash;
 my @perms;
 my $phash = {};
 my ($name, $mask);
 if ( Get( $_, \%hash ) ) {
 while( ($name, $mask) = each %hash ) {
 EnumerateRights( $mask, \@perms) ;
	        $phash->{$name} = [@perms];
 }
	    return $phash;
 }
	return;
}
sub iLa {
 $iS->cR(undef, 1);
 $iS->iFa(dZz::fIa($gJ{vf}));
}
sub hMz {
 $iS->cR();
 $iS->cJ($abmain::oG, \@abmain::dN);
 my	($is_root, $root) = eVa() ;
 error('dM', "Who are you?") if $iS->{oU} ne $abmain::gJ{kS} && not $is_root;
 error('inval', "Forum virtual path must start from $abmain::top_virtual_dir")
 if(not $fvp =~ /^$abmain::top_virtual_dir/);
 my @paths= $iS->eP($abmain::gJ{gF});
 $bYaA->new("d".$abmain::cAz,{schema=>"AbMasterList"})-> iSa(
 [$iS->{name}, $iS->{admin}, $iS->{admin_email}, time(), $fvp, $abmain::gJ{gF}, $iS->{eD}],
 {noerr=>1} 
 );
 
 $iS->nSa(1);
 abmain::cTz("<b>$iS->{name} </b>has been deleted!");
}
sub mEz{
 return if $abmain::dC ne 'POST';
 my $x=$abmain::gJ{'iFz'} - log($abmain::gJ{'mCz'}+2);
 return if not ($x < 1e-4 && $x > -1e-4);
 open F, abmain::kZz($abmain::eD, $abmain::gJ{fU});
 sVa::gYaA "Content-type: text/plain\n\n", <F>;
 close F;
 abmain::iUz();
}
sub bYz {
 $iS->cR();
 $iS->aT('A');
 my $pt = time() - 3600*24*5;
 my $mcnt= $abmain::gJ{mcnt}||51;
 my $i;
 for($i=1; $i<$mcnt; $i++) {
 $pt += (1.5-rand())*3600*24*5/50;
 $pt = time() if $pt > time();
 my $seq = $pt %10000;
 $iS->cCz("Welcome $seq", "AnyBoard$i", "Hello$i", $pt);
 }
 $iS->aT();
 $iS->eG();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub lIz{
 my $catd = shift;
 my $catf = abmain::kZz($catd, $abmain::catidx);
 return ("", "", 1, 1) if(not -r $catf);
 my $iS = jW->new();
 $iS->cJ($catf, \@abmain::lQa);
 return ($iS->{cat_name}, $iS->{cat_desc}, $iS->{cat_list}, $iS->{cat_makeboard}, 
 $iS->{cat_news}, $iS->{cat_guide}, $iS->{cat_inherit}, $iS->{cat_inhe_guide}, $iS->{cat_sortkey});
}

 
sub vVz {
 my $cdir = shift;
 my $iS = jW->new();
 my $layout;
 my $guide;
 while(1) {
 my $catf = abmain::kZz($cdir, $abmain::catidx);
 $cdir =abmain::kZz($cdir, "..");
 last if not -f $catf;
 $iS->cJ($catf, \@abmain::lQa);
 if((not $layout) && ($iS->{cat_istop} || not $iS->{cat_inherit}) ) {
	$layout = $iS->{cat_layout};
 }
 if((not $guide) && ($iS->{cat_istop} || not $iS->{cat_inhe_guide})) {
	$guide = $iS->{cat_guide};
 }
 last if not ($iS->{cat_inherit} || $iS->{cat_inhe_guide}); 
 }
 return ($layout, $guide, $iS);
}
sub lPz {
 my $cdir = shift;
 my $dVz="";
 my $lstr;
 while(1) {
 $dVz .="../";
 my ($n, $d, $l, $m) = abmain::lIz(abmain::kZz($cdir, $dVz));
 last if not $n;
 $lstr = abmain::cUz($dVz, $n). "\&nbsp; =\&gt; $lstr ";
 }
 return $lstr;
}
sub pTa{
 my $f = abmain::wTz('forums');

 my $jKa = $bYaA->new($f, {schema=>"AbForumList"})->iQa({noerr=>1});
 return if not $jKa;

 my %fhash;
 my @forums=();
 local $_;
 while ($_ = pop @$jKa) {
	my ($eD, $pL,$cgi_full, $cat, $fvp) = @$_;
 next if $fhash{$eD};
 my $bPaA = [ $eD, $pL, $cgi_full, $cat, $fvp];
	$fhash{$eD} = $bPaA;
	push @forums, $bPaA;
 } 
 return (\@forums, \%fhash);
}
sub lHz{            
 my $pv = $abmain::gJ{pv};
 my $inbackg= $abmain::gJ{inbackg};
 my $idx = abmain::kZz($abmain::eD, "index.html");
 if( (-f $idx ) && (stat($idx))[9] > time() - 1200) {
 goto E_O_I if not $abmain::gJ{lF};
 } 
 opendir DIRF, $abmain::eD; 
 my @jXz = grep !/^\.\.?$/, readdir DIRF; 
 close DIRF;

 my $pstr = abmain::lPz($abmain::eD);

 my ($sdesc, $catdesc, $list, $makeb, $catnews, $catguide, $catinhe, $catinheg)=abmain::lIz($abmain::eD);

 
 my $all= $abmain::gJ{all};
 if(not ($sdesc || $all )) {
 abmain::error('inval', "Not found");
 }
 my @forums=();
 my @cats =();
 for(sort @jXz) {
 my $d = abmain::kZz($abmain::eD, $_);
 my $b = abmain::kZz($abmain::pL, $_);
 my $sd = $_;
 next if not -d $d;
 if(-f abmain::kZz($d, ".forum_cfg") and -f abmain::kZz($d, ".msglist") ) {
 push @forums, jW->new(eD=>$d, cgi=>kZz($dLz, $sd), pL=>$b);
 }elsif (-f abmain::kZz($d, ".catidx")){
 push @cats, [$sd, abmain::lIz($d)];
 }
 }

 @cats = sort { $a->[9] cmp $b->[9]} @cats;

 my $cidx = $abmain::catidx;
 $cidx .= "gYa" if $pv;
 $iS->{cat_istop} = 0;
 $iS->cJ(kZz($abmain::eD, $cidx), \@abmain::lQa);
 $iS->eYaA();
 my $istopcat = $iS->{cat_istop};

 my ($pl, $pg, $bd2) =  abmain::vVz($abmain::eD) if ($catinhe || $catinheg);
 $iS->{cat_layout} = $pl if $pl;
 $iS->{cat_guide} = $pg if $pg;
 $catguide = $iS->{cat_guide} if $catinheg;
 for my $k(keys %$bd2) {
		$iS->{$k} = $bd2->{$k} if $bd2->{$k} ne "";
 }

 my $gcatidx = abmain::wTz('catidx');
 $iS->cJ($gcatidx, \@abmain::lQa) if (-f $gcatidx);

 my %catdata = ();
 $catdata{AB_CAT_DESC} = $catdesc;
 $catdata{AB_CAT_NEWS} = $catnews;
 $catdata{AB_CAT_GUIDE}= $catguide;
 $catdata{AB_CAT_NAME}= $sdesc;

 my @buf=();
 push @buf, qq(<table border="0" cellspacing=0 cellpadding=0 width=100%>\n);
 push @buf, "<tr><td>$iS->{cat_sub_head}</td></tr>\n";
 my $i=0;
 
 for(@cats) {
 push @buf, &jW::nKz($abmain::bgs[$i%2], cUz(kZz($_->[0], "index.html"), $_->[1]) );
 #push @buf, &jW::nKz($bgs[$i%2], cUz(kZz($dLz, $_->[0], "?@{[$abmain::cZa]}cmd=lGz"), $_->[1]) );
 #push @buf, &jW::nKz($bgs[$i%2], cUz($_->[0], $_->[1]) );
 }
 push @buf, qq(</table>\n);

 $catdata{AB_SUB_CAT_LIST} = join("", @buf);
 @buf=();

 $catdata{AB_VIEW_CAT_LIST_LNK} =  abmain::cUz($dLz. "?@{[$abmain::cZa]}cmd=list_cats", $iS->{cat_view_cat_word});
 $catdata{AB_SUGGEST_CAT_LNK} = cUz($abmain::suggest_url, "Suggest a new category");
 $catdata{AB_CREATE_CAT_LNK} = abmain::cUz($dLz."?@{[$abmain::cZa]}cmd=lQz", $iS->{cat_cr_cat_word});

 if($makeb) {
 push @buf, $iS->{cat_cr_forum_head}, 
 cUz(kZz($dLz, "/?@{[$abmain::cZa]}cmd=init"), "$iS->{cat_cr_f_word} <b>$sdesc</b>"),"\n";
 push @buf, "<br><i><small>Forums are unlisted for this category</small></i>" if not $list;
 $catdata{AB_CREATE_FORUM_LNK} = join("", @buf);
 @buf=();
 }else {

 }
 
 my $fcnt = scalar(@forums);

 $jT =~ s#/$##;
 if($list && $fcnt) {
 # push @buf, "<h5>", scalar(@forums), " Active Forums. Public forums are listed below</h5>";
 my @ths= ("Channel name", "Messages count", "Creation time", "Admin") ;
 my @rows;
 my $t = time() - 3600*24*30;
 my @fis;
 for my $bdv (@forums) {
	      $bdv->cR();
	      my $fi = $bdv->lJz();
	      next if  (not $fi->{list} ) and not $all;
	      next if $fi->{lunixtime} < $t; 
	      $fi->{name} = "(no name)" if not $fi->{name};
 	      $fi->{lastmsg} = $bdv->nTa(1) if $iS->{inc_last}; 
	      push @fis, $fi;
 }
 @fis = sort { $a->{sort_idx} cmp $b->{sort_idx} } @fis;

 for my $fi (@fis) { 
	      my $lnk = abmain::cUz($fi->{xIz}, "<small>$fi->{name}</small>");
 	      $lnk .= qq(<hr width="100%" size="1" noshade><font size="2">$fi->{lastmsg}</font><br>) if $iS->{inc_last} && $fi->{lastmsg};
	      my $mcnt = "$fi->{mcnt} messages ";
	      $mcnt .= "($fi->{ltime})" if not $iS->{inc_last};
 push @rows, [
		$lnk,
	      	"<small>$mcnt</small>",
	      	"<small>". abmain::dU('SHORT', $fi->{cday}, 'oP')."</small>",
	      	$fi->{admin} 
 ];
 }
 my $colsel = [0,1,3];
 if(not $iS->{cat_show_admin}) {
	$colsel = [0, 1];
 } 
 push @buf, sVa::fMa(rows=>\@rows, ths=>\@ths, $iS->oVa(), width=>"100%", colsel=>$colsel);
 }elsif($list){
	push @buf, "<h5>No active forums</h5>";
 }
 $catdata{AB_CAT_FORUM_LIST} = join("", @buf);
 @buf = ();

 $catdata{AB_MODIFY_CAT_LNK} = abmain::cUz($dLz. "?@{[$abmain::cZa]}cmd=lNz", $iS->{cat_mod_cat_word});

 my @gHz=();
 push @gHz, qq(<html><head><title>$sdesc</title>\n);
 push @gHz, qq(\n$iS->{cat_header}\n);
 push @gHz, "$pstr  <b>$sdesc</b><br>", $iS->{cat_sepx} if not $istopcat;
 push @gHz, jW::mTa($iS->{cat_layout}, \@abmain::cat_tags, \%catdata);
 push @gHz, qq(<script src=").$dLz. "?@{[$abmain::cZa]}cmd=lGz&inbackg=1". qq(" language="JavaScript1.1"></script>);
 push @gHz, "$iS->{cat_footer}";

 my $pdata = join("", @gHz);

 $pdata = jW::mTa($pdata, \@jW::org_info_tags, $iS->{_org_info_hash});

 if($pv) {
 sVa::gYaA "Content-type: text/html\n\n",
 $pdata;
 return;
 }

 open F, ">$idx" or abmain::error('sys', "$!");
 print F $pdata;
 close F;
 open F, ">".abmain::kZz($abmain::eD, "_index.html") or abmain::error('sys', "$!");
 print F qq(<html><head><META HTTP-EQUIV=refresh CONTENT="0; URL=index.html">),
 qq(</head><body></body></html>);
 close F;

E_O_I:
 if($inbackg) {
 	sVa::gYaA "Content-type: application/x-javascript\n\nvar i=0;";
	return;
 }
 sVa::hCaA "Location: ", abmain::kZz($abmain::pL, "/index.html"),"\n\n";

}
sub bVaA{
	require qWa;
	my $isadm = eVa();
	my $bRaA = qWa->new({
			siteidx=>abmain::wTz('siteidx'), 
			siteidxcfg=>abmain::wTz('siteidxcfg'), 
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			img_top=>$abmain::img_top,
			homeurl=>$abmain::dJz,
			input=>\%abmain::gJ
	 });

	#return if(($abmain::yCa/9 != $abmain::kQa[4] && ($abmain::kQa[4])) && ($abmain::yAa+9*1024*1024) <$abmain::yDa);
	$bRaA->cFaA('master');
	$bRaA->bUaA("$jT?cmd=admin");
	if($isadm) {
		$bRaA->cJaA('master');
	}
	return $bRaA;
}

sub dZaA{
	require fRaA;
	my $bRaA = fRaA->new({
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			icon_loc=>"$abmain::img_top/formicons",
			homeurl=>$abmain::dJz,
			agent=>$abmain::agent
	 });

	return $bRaA;
}
sub vQz{            
 my ($dir, $jT) = @_;
 opendir DIRF, $dir; 
 my @jXz = grep !/^\.\.?$/, readdir DIRF;
 close DIRF;
 my ($sdesc, $catdesc, $list, $makeb, $catnews, $catguide, $catinhe, $catinheg)
 =abmain::lIz($dir);

 my @forums=();
 my @cats =();
 for(sort @jXz) {
 my $d = abmain::kZz($dir, $_);
 my $sd = $_;
 next if not -d $d;
 my $cgi = abmain::kZz($jT, $sd);
 if(-f abmain::kZz($d, ".forum_cfg") and -f abmain::kZz($d, ".msglist") ) {
 push @forums, new jW(eD=>$d, cgi=>$cgi );
 }elsif (-f abmain::kZz($d, ".catidx")){
 push @cats, vQz($d, $cgi);
 }
 }
 return [$sdesc, $jT, $list, [@cats], [@forums]];
}
sub wOz{            
 my $idx = abmain::kZz($abmain::eD, "_cindex.html");
 if( (-f $idx ) && (stat($idx))[9] > time() - 3600 ) {
 goto E_O_I if not $abmain::gJ{lF};
 } 

 my $pstr = abmain::lPz($abmain::eD);
 my $all = $abmain::gJ{all};

 my $cats = vQz($abmain::eD, $dLz);
 my @gHz;
 push @gHz, "<html><title> Category list under $cats->[0] </title><body bgcolor=#ffffff>",
 $pstr, "<hr>",
 "<h1>Category list ($cats->[0]) </h1>";
 my @cstack=($cats);
 my $cat;
 while( $cat = pop @cstack) {
 if(not $cat->[1]) {
 push @gHz, $cat->[0];
 next;
 }
 if($cat->[3]) {
 	push @cstack, ["\n</ul>\n"];
 	push @cstack, @{$cat->[3]};
 	push @gHz, "<ul>";
 }
 push @gHz, "\n<li>",
 abmain::cUz(abmain::kZz($cat->[1], "/?@{[$abmain::cZa]}cmd=lGz"), $cat->[0]);
 push @gHz, " <small>(", (int scalar(@{$cat->[4]}))." forums</small>) "; 
 }
 push @gHz, "<hr>$pstr          ";
 push @gHz, qq@<a href="javascript:history.go(-2)">$iS->{back_word}</a>@;
 push @gHz, "</body></html>";

 open F, ">$idx" or abmain::error('sys', "$!");
 print F @gHz;
 close F;

 open F, ">".abmain::kZz($abmain::eD, "cindex.html") or abmain::error('sys', "$!");
 print F qq(<html><head><META HTTP-EQUIV=refresh CONTENT="0; URL=),
 abmain::kZz($dLz, "/?@{[$abmain::cZa]}cmd=list_cats"), 
 qq("></head><body></body></html>);
 close F;

E_O_I:
 sVa::hCaA "Location: ", abmain::kZz($abmain::pL, "_cindex.html"),"\n\n";

}
sub cEz{
 my $mlistref = $bYaA->new($abmain::cAz, {schema=>"AbMasterList"})->iQa({noerr=> 1});

 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><title>Forum List </title><body><h1 align="center">List of Forums</h1>);
 my @ths = ("Name", "Messages", "Creation time", "Admin");
 $jT =~ s#/$##;
 my @rows;
 my $colsel;
 $colsel = [0, 1, 2] if not $abmain::gJ{all};
 for(@$mlistref) {
 my @fields = @$_;
 my $d = $fields[6] || $abmain::eD. $fields[4];
 next if( (not -d $d) && (not $abmain::gJ{all}));
 my $iS = new jW(eD=>$fields[6] || abmain::kZz($abmain::eD, $fields[4])); 
 next if not -r $iS->nCa();
 $iS->cR();
 my $fi = $iS->lJz();
 my $fvp = $fields[4];
 push @rows,
 	[
		abmain::cUz($abmain::no_pathinfo?"$jT?fvp=$fvp":"$jT$fvp", $fields[0]),
 		"$fi->{mcnt} messages ($fi->{ltime})",
 		abmain::dU('SHORT', $fields[3], 'oP'),
 	        $abmain::gJ{all}? abmain::cUz("mailto:@{[$fields[2]]}", $fields[1]):""
 ]; 
 }
 print sVa::fMa(rows=>\@rows, ths=>\@ths, $iS->oVa(), colsel=>$colsel);
 print "</body></html>";
}
sub qMa{
 my @fis;
 my $fvp_str_save = $abmain::cZa; 
 if(0 && $fvp && -f $iS->nCa()) {
	push @fis, $iS;
 }else {
 my ($fsref, $fshash) = abmain::pTa();
 my $fv = $abmain::gJ{svp};
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 next if $fv && $_->[4] && abmain::kZz("/", $fv, "/") ne abmain::kZz("/", $_->[4], "/");
 if($abmain::no_pathinfo) {
 	$abmain::cZa = "fvp=$_->[4]\&";
 }else {
 	$abmain::cZa = "";
 }
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 $iS->cR();
 next if $iS->{no_list_me} && not $abmain::gJ{all};
 push @fis, $iS;
 }
 }
 $abmain::cZa = $fvp_str_save; 
 my $t0 = time();
 my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $abmain::jT);
 $mf->zOz();
 $mf->sRa('pvhtml', 1);
 $mf->load(abmain::wTz('siteidxcfg'));
	sVa::gYaA "Content-type: text/html\n\n";
 my $multibyte =$mf->{siteidx_multibyte};

 my @files;
 my $i=0;
 my $line = $abmain::gJ{tK};
 my $search;
 my $err="";
 for my $iS (@fis) {
		my $f =  $iS->nDz('sdb');
		next if not -f $f;
		$search = eCa->new($f, 0);
		my $result;
		if ($line =~ /\band\b|\bor\b/i) {
			$result = $search->eIa($line,1);
		} else {
			$result = $search->query([split /\s+/, $line], $multibyte);
		}
		push @files, [$iS, $result->{files}] if int  @{ $result->{files} };
		$err .="<br>".$search->errstr() if $search->errstr();
 }
	
	print $mf->{siteidx_header};
 	print sVa::tWa();
 print qq(
<table width="82%" border="0" height="92" cellpadding="0" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$abmain::img_top/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$abmain::img_top/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$abmain::jT">
 <td width="42%" height="40" bgcolor="#CC9900" valign="middle"> 
	\&nbsp;
 <input type="text" class="inputfields" name="tK">
 <input type="hidden" value="searchfs" name="cmd">
 	$abmain::cYa
 <input class="buttonstyle" type="submit" value="Search" name="x">
 </td>
 </form>
 <td width="31%" height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>Search 
 powered by <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$abmain::img_top/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
);
	print $mf->{siteidx_banner};
	my $t = time() - $t0;
	my $k;
	my $method = 'file';
	for(@files) {
 
 my ($iS, $flist) = @$_;
	    my $topdir = $iS->{eD};
	    my $topurl = $iS->{pL};
 $abmain::cZa = $iS->{_fvp_str};
		my $filename;
		my $score;
		my $title;
		my $count = int  @$flist;
		print "<!--$t seconds -->\n";
		print "<ul>";
 my %shownf;
		for $k( sort { $b->{score} <=>  $a->{score} } @$flist) {
			$filename = $k->{filename};
			if($method eq 'file') {
				$filename =~ s/^$topdir//;
				$filename =~ s/^\///;
			}
			$score = $k->{score};
			my ($title, $abs, $chk, $sz, $lmt) = split("\t", $k->{title});
			$title =~ s/($line)/<b>$1<\/b>/ig;
			$abs=~ s/($line)/<b>$1<\/b>/gi;
			my $url = $iS->lMa($filename);
 next if $shownf{$url};
 $shownf{$url} = 1;
			$title= $url if not $title;
			print "<li> ", abmain::cUz($url, $title), qq(\&nbsp (score: $score)), qq(<br> );
 print $abs, " <b>....</b><br>";
			$sz = $sz /1024;
		        print qq(<font color="green" size="1">$url -- ), sprintf("%.2fK", $sz), "-- $lmt</font>";	
			print "</li><p>";
			
		}
		print "</ul>";
		print scalar(keys %shownf), " matches found -- ", abmain::cUz($iS->fC(), $iS->{name}),"\n"; 
		$abmain::cZa="";
	}
 	$abmain::cZa = $fvp_str_save; 
 if(not scalar(@files)) {
		print "No matches found.\n";

 }
	print "Error: ", $search->errstr, "\n" if $err;
 print "</td></tr></table>";

	print qq(
<table width="82%" border="0" height="92" cellpadding="1" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$abmain::img_top/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$abmain::img_top/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$abmain::jT">
 <td height="40" bgcolor="#CC9900" valign="middle">  \&nbsp;
 <input type="text" name="tK" class="inputfields">
 <input type=hidden value=searchfs name="cmd">
 	$abmain::cYa
 <input class="buttonstyle" type="submit" value="Next search" name=x>
 </td>
 </form>
 <td height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>
 <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$abmain::img_top/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
<p>&nbsp;</p>
);
	print $mf->{siteidx_footer};
}
sub rEa{
 my @fis;
 my @fps=();
 my ($h, $f);
 my $sf = aLa->new("sf", undef, $abmain::jT);
 $sf->zNz([inf=>"head", "Search forums"]);
 my $fvp_str_save = $abmain::cZa;
 if($fvp && -f $iS->nCa()) {
 $iS->cR();
	push @fps, "$fvp=$iS->{name}";
	push @fps, "="."All channels";
	$iS->eMaA([qw(other_header other_footer)]);
	$h = qq(<html><head> <title>Search</title> $iS->{sAz} $iS->{other_header});
	$f = $iS->{other_footer};
	$sf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
 }else {
 push @fps, "="."All channels";
 my ($fsref, $fshash) = abmain::pTa();
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 my $fv = $_->[4];
 if($abmain::no_pathinfo) {
 	$abmain::cZa = "fvp=$_->[4]\&";
 }else {
 	$abmain::cZa = "";
 }
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 $iS->cR();
 next if $iS->{no_list_me} && not $abmain::gJ{all};
 push @fps, "$fv=$iS->{name}";
 }
 my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $abmain::jT);
 $mf->zOz();
 $mf->load(abmain::wTz('siteidxcfg'));
 $h =  $mf->{siteidx_header};
 $f =  $mf->{siteidx_footer};
 }
 $abmain::cZa = $fvp_str_save; 
 $sf->zNz([tK=>"text", qq(size="20"), "Search word"]);
 $sf->zNz([svp=>"select", join("\n", @fps), "Forum"]);
 $sf->zNz([cmd=>"hidden", "", "command", "searchfs"]);
 sVa::gYaA "Content-type: text/html\n\n";
 print $h;
 print $sf->form();
 print $f;
 
}

sub fKa{
 my ($short, $cur) = @_;
 my $colsel;
 my ($fsref, $fshash) = abmain::pTa();
 my @fis;
 my $fvp_str_save = $abmain::cZa;
 my $mf = new aLa('idx', \@abmain::iBa, $jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'));
 my $selmak = aLa::bYa(['fcat', 'radio',  $mf->{fcatopt}]);
 my $maindir = sVa::kZz($abmain::master_cfg_dir, 'main', "/");

 for(@$fsref) {
 my $d = $_->[0];
 my $is_main=0;
 next if not -d $d;
 if($abmain::no_pathinfo) {
 	$abmain::cZa = "fvp=$_->[4]\&";
 }else {
 	$abmain::cZa = "";
 }
 if($maindir eq sVa::kZz($_->[0], "/") ) {
 	$abmain::cZa = "pvp=main\&";
	$is_main =1;
 }
 
 my $bdx = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $bdx->nCa();
 $bdx->cR();
 if($is_main) {
		$bdx->{_off_web}=1;
		$bdx->{_no_pi} =1;
 }
 my $fi = $bdx->lJz();
 next if $fi->{no_list} && not $abmain::gJ{all};
 $fi->{lastmsg} = $bdx->nTa() if $mf->{inc_last} ; 
 $fi->{newsmsg} = abmain::jDa($mf->{news_cnt}||6, $mf->{news_cols}, 0, undef, $bdx->pJa()) if $mf->{inc_news};
 push @fis, $fi;
 }
 my $bdx = new jW(eD=>abmain::kZz($abmain::master_cfg_dir, 'main'));
 $bdx->cR() if  -r $bdx->nCa();
 my @rows;
 my $fi;
 my $fcat;
 for $fi (sort { $a->{forum_cat} cmp $b->{forum_cat} || $a->{sort_idx} cmp $b->{sort_idx} } @fis) {
 if($fi->{forum_cat} && $fi->{forum_cat} ne $fcat) {
		$fcat = $fi->{forum_cat};
		push @rows, [[$selmak->bDa($fcat), 'head']];
 }
 my $msg;
 $msg = qq(<hr width="100%" size="1" noshade>$fi->{lastmsg}<br>) if $mf->{inc_last} && $fi->{lastmsg};
 if($fi->{newsmsg}) {
 	$msg .= $mf->{news_word}.$fi->{newsmsg} if $mf->{inc_news};
 }
 my @sums;
 my $admstr= $fi->{admin};
 if($fi->{moders} && not $fi->{nolistmoder}) {
	$admstr .= ",\t".$fi->{moders};
 }
 push @sums, ["Last update", $fi->{ltime}];
 push @sums, ["# Topics", "<b>$fi->{mcnt}</b>"];
 push @sums, ["Admin", $admstr];
 push @sums, ["Registration", $fi->{gAz}?"Required":"Not required"];
 push @sums, ["Created", $fi->{ctime}];
 my $summ = sVa::fMa(rows=>\@sums, usedb=>0, width=>"100%", tba=>"cellspacing=0 cellpadding=1");
 
 my $lnk =  abmain::cUz($fi->{fC}, $fi->{name}||"(no name)");
 if($fi->{fC} eq $cur) {
 $lnk =  $fi->{name}||"(no name)";
	    $lnk = qq(<b>$lnk</b>);
 }
 my $fl =  $lnk."<br>$mf->{desc_bef}$fi->{desc}$msg$mf->{desc_af}";
 if($short) {
 	push @rows, [$fl] 
 }else {
 	push @rows, [$fi->{icon}||'&nbsp', $fl, 
 $fi->{ltime}, "<b>$fi->{mcnt}</b>", $admstr
 ];
 }
	
 }
 $abmain::cZa = $fvp_str_save;
 my @ths = ('&nbsp', "Forum", "Last", "Topics", "Admin");
 @ths = jW::mJa($bdx->{cfg_head_font}, @ths);
 my $tcafunc = sub { my ($row, $col) = @_; 
 return qq(width="20%") if  $col==2;
 return qq(width="65%") if  $col==1;
 };
 if($short) {
	   return sVa::fMa(rows=>\@rows, $bdx->oVa(), usebd=>$mf->{add_border});
 }else {
 	my $colsel;
 	$colsel = [0,1,2] if ($mf->{short_view} && not $colsel);
 return sVa::fMa(rows=>\@rows, ths=>\@ths, $bdx->oVa(), usebd=>$mf->{add_border}, colsel=>$colsel);
 }
}
sub hAa{
 my($pattern, $admonly) = @_;
 my ($fsref, $fshash) = abmain::pTa();
 my @emails;
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 if(not $admonly) {
 	push @emails, [$iS->{pL}, $iS->hWz($pattern)];
 }else {
 	push @emails, [$iS->{pL}, $iS->{admin_email}];
 }
 }
 return wantarray? @emails : join (", ", map {$_->[1]} @emails);
}
sub mEa{
 my($pattern, $admonly) = @_;
 my ($fsref, $fshash) = abmain::pTa();
 my @forums;
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 push @forums, $iS->{pL};
 }
 return @forums;
}
sub pNa {
 my	($is_root, $root) = eVa() ;
 error('dM', "Who are you?") if not $is_root;
 my @emails = hAa();
 sVa::gYaA "Content-type: text/plain\n\n";
 my $tot =0;

 for(@emails) {
	print $_->[0], ":\n\n";
 my @ems = split(", ",  $_->[1]);
	$tot += scalar(@ems);
 print scalar(@ems), " email addresses\n";
 print join("\n", split ", ", $_->[1]);
 print "\n\n";
 }
 print "Total: $tot\n";
}
sub bCz{
 abmain::oNa();
 if(not -d $abmain::master_cfg_dir) {
 	abmain::error('inval', "Master config directory $abmain::master_cfg_dir does not exist!");
 }
 if(-e $abmain::oG) {
 	$iS->cJ($abmain::oG, \@abmain::dN);
 }
 abmain::error('inval', "Master admin exists") if ($iS->{aF});
 unless ($abmain::gJ{aF} && $abmain::gJ{oU}) {
 abmain::error('miss', "Missing master admin info");
 }
 abmain::error('inval', "Passwords cannot contain spaces") if $abmain::gJ{oU} =~ /\s/;
 abmain::error('inval', "Passwords cannot contain spaces") if $abmain::gJ{root_passwd} =~ /\s/;
 abmain::error('inval', "Passwords do not match") if $abmain::gJ{oU} ne $abmain::gJ{bBz};
 abmain::error('inval', "Passwords do not match") if $abmain::gJ{root_passwd} ne $abmain::gJ{root_passwd2};
 $iS->iA(\@abmain::dN);
 $iS->{oU} = abmain::lKz($iS->{eF}->{oU});
 $iS->{root_passwd} = abmain::lKz($iS->{eF}->{root_passwd});
 $oC =~ s#/$##;
 if(not -d $oC) {
 mkdir($oC, 0700) or abmain::error('sys', "Fail to create directory $oC: $!");
 }
 $master_dbdef_dir =~ s#/$##;
 if(not -d $master_dbdef_dir) {
 mkdir($master_dbdef_dir, 0700) or abmain::error('sys', "Fail to create directory $master_dbdef_dir: $!");
 }
 my $k = rand();
 $k =~ s/\.//;
 $iS->{'-'} = unpack("h*", time()."$k|$dB");
 $iS->cW($abmain::oG, \@abmain::dN);
 abmain::kPa("kUa", unpack("h*", $iS->{iGz}));
 abmain::kPa("yBa", unpack("H*", rand().'-'.time()));
 if(! -f $abmain::bWz) {
 	$iS->cW($abmain::bWz, \@abmain::tG, \@abmain::forum_style_cfgs);
 }
 $iS->{hide_flink}=1;
 abmain::fBa();
 #$iS->jI(\@abmain::gS, "fD", "Master admin $iS->{aF}/$gJ{oU} created, proceed to create new forum");
}
sub bXa {
 $iS->{hide_flink}=1;
 $iS->jI(\@abmain::forum_grp_cfgs, "create_group", "Create a forum group");
}
sub pMa{
 $iS->{hide_flink}=1;
 $iS->jI(\@abmain::fetch_url_cfg, "fetch_urls", "Download URLs");
}
sub dVaA {
	return (no_pathinfo=>$abmain::no_pathinfo, off_web=>$abmain::off_webroot); 
}

sub gJa{
	$iS->cR();
 	$iS->bI();
	my @urls = split /\s+/, $abmain::gJ{urls};
	sVa::gYaA "Content-type: text/html\n\n";
	print "<html><body><pre>";
 my $namec = $iS->{name_hacks};
	my @names = split /\s*,\s*/, $namec;
 my $nc = scalar(@names);
	my @flist;
	my $gDz = time()- 3600*1;
	for my $url (@urls) {
		if (not $url =~ m!https?://!i) {
			print "skip $url: unsupported protocol\n";
			next;
		}
		$url =~ m!/([^/]+)$!;
		my $f = $1 || "def.dat";
		$f =~ s/\s+/_/g;
		push @flist, $f;
		my $d = abmain::mGa($url);
		my $p = $iS->cPz($f);
		
		if(length($d) <=0) {
			print "skip $url: nothing to save\n";
			next;
 }
		$gDz += int(300*rand());
		if($d =~ /<html>/i) {
			$d =~ m!<title>(.*?)</title>!is;
			my $wW = $1;
			$d =~ m!<body.*?>(.*?)</body>!is;
			my $body = $1;
			abmain::wDz(\$body);
			$iS->auto_post($wW||"no subject", $names[int(rand()*1000) %$nc]||'admin', $body, $gDz); 
		}else {
			open F, ">$p" or next;
			binmode F;
			print F $d;
			close F;
		}
		print STDOUT $url, ": ", length($d), " bytes saved to $f\n";
		
 }
 	$iS->aT();
 	$iS->eG();
 print "</pre>";
	print $iS->eXz(join(" ", @flist), "<br>");
	print "</body><html>";
}
sub fHa{
 my $fgrp_id = $abmain::gJ{fgrp_id};
 my $fgrp_file = abmain::kZz($abmain::master_cfg_dir, $fgrp_id);

 abmain::error('miss', "Missing group id") if not $fgrp_id;
 abmain::error('inval', "Invalid group id, it must be alphanumeric") if  $fgrp_id =~ /\W/;
 abmain::error('inval', "$fgrp_id group exists, choose another id") if  -e $fgrp_file;

 unless ($abmain::gJ{fgrp_admin} && $abmain::gJ{fgrp_passwd}) {
 abmain::error('miss', "Missing admin info")
 }

 abmain::error('inval', "Passwords cannot contain spaces") if $abmain::gJ{fgrp_passwd} =~ /\s/;
 abmain::error('inval', "Passwords do not match") if $abmain::gJ{fgrp_passwd} ne $abmain::gJ{fgrp_passwd2};

 $iS->iA(\@abmain::forum_grp_cfgs);
 $iS->{fgrp_passwd} = abmain::lKz($iS->{eF}->{fgrp_passwd});
 $iS->cW($fgrp_file, \@abmain::forum_grp_cfgs);
 abmain::cTz("Created group $fgrp_id.<p>Please record the admin id password: $abmain::gJ{fgrp_admin}/$abmain::gJ{fgrp_passwd}");
}
sub hNz{
 $iS->iA(\@abmain::kDz);
 my $cgi = $jT;
 my $pA = $abmain::gJ{forum_vpath};
 my $aF = $iS->{aF};
 my $nN = $iS->{eF}->{oU};

 &abmain::error('miss', "Please check the box to confirm the operation") if not $abmain::gJ{hQz};
 if(not -e $abmain::oG){
 &abmain::error('deny', "Operation not allowed. Permission denied.");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 $nN = abmain::lKz($nN, $iS->{oU});
 if($iS->{aF} ne $abmain::gJ{aF} || 
 $iS->{oU} ne $nN) {
 error('dM', "Invalid login id or password");
 }
 my $t = time();
 my $fvp;
 if($abmain::no_pathinfo) {
	$fvp = qq(fvp=$pA\&); 
 }else {
	$cgi = abmain::kZz($cgi, $pA);
 }
 $cgi .= "?${fvp}cmd=hOz;kS=$nN;gF=rm;tm=$t";
 sVa::hCaA "Location: $cgi\n\n";
}
 
sub hP {
 $iS->iA(\@abmain::gS);
 my $cgi = $dLz;
 my $pA = $abmain::gJ{wR};
 my $dNz = $abmain::gJ{dQ};
 my $fM = $abmain::gJ{hU};
 my $admin_email = $abmain::gJ{admin_email};
 my $admin_email2 = $abmain::gJ{admin_email2};
 my $agree = $abmain::gJ{new_forum_agree};
 abmain::error('inval', "You must agree to the rules for creating a forum") if not $agree;
 abmain::error('inval', "Email address does not match") if $admin_email ne $admin_email2;
 

 my $iGz = $abmain::gJ{iGz};
 my $cKz = $abmain::gJ{cKz};
 my $aF = $iS->{aF};
 

 if(not -e $abmain::oG){
	 my @jS = abmain::oCa(\@abmain::dN);
 pop @jS;
 $iS->jI(\@jS, "bDz", "Create master admin first");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $nN = abmain::lKz($iS->{eF}->{oU}, $iS->{oU});

 if($iS->{aF} ne $abmain::gJ{aF} || 
 $iS->{oU} ne $nN) {
 error('dM', "Invalid login id or password"); 
 }
 my $fcnt = scalar(abmain::mEa());
 
 $pA =~ s#\s+#_#g; # disallow spaces in v path
 $pA =~ s/[%&+<=>"'`\n]//eg;
 $pA =~ s/\.\.//eg;
 my $cZa="";
 if($abmain::no_pathinfo) {
	my $fvp = abmain::kZz($gJ{fvp}, $pA);
	$cZa = "fvp=$fvp\&";
 } else {
 	$cgi = abmain::kZz($cgi,$pA);
 }
 #abmain::error() if $fcnt >= ($abmain::kQa[5] || (1+1)); 

 $dNz = abmain::wS($dNz);
 abmain::jJz(\$fM);
 $fM =~ s/\s+/\+/g;
 $iGz =~s /\s//g;
 if( not ($dNz =~ /\S/ && $fM =~ /\S/)) {
 abmain::error('miss', "Both new forum name and admin name must be provided");
 }
 $admin_email = abmain::xJz($admin_email);
 unless ($admin_email) {
 abmain::error('miss', "Missing E-mail address");
 }
 $cgi .= "?${cZa}cmd=nI;pA=$pA;admin=$fM;name=$dNz;kS=$nN;admin_email=$admin_email;cKz=$cKz;iGz=$iGz";
 sVa::hCaA "Location: $cgi\n\n";
}
sub xJz {
 my $str = shift;
 return $1 if($str =~ /$abmain::uD/o);
 return undef;
}
sub fVz{
 my ($str, $cnt) = @_;
 return unpack("%16C*", $str)%$cnt;
} 

sub yFz {
 	$iS->cR();
 $iS->{hRa} = 1;
 	$iS->bI();
	abmain::cTz("<center><h2>You have logged out of the admin panel<h2><p>".$iS->dRz()."</center>", "", undef,  abmain::bC($jW::hW, "", '/'));
}
sub iQ {
 $iS->lM();
}
sub sKz {
 $iS->cR();
 my $chatd = $iS->nDz('chat');
 if(not -d $chatd) {
 mkdir ($chatd, 0755) or abmain::error('sys', "Fail to create directory $chatd: $!");
 }
 $iS->sEz($iS->{chat_sys_name}, $iS->{chat_peek_msg}, 0) if not $iS->{chat_no_peek_msg};
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{tBz} =~ s/USER_NAME/$iS->{fTz}->{name}/g;
 $iS->sEz($iS->{chat_sys_name}, $iS->{tBz}. " (".dU('SHORT').")", 1, 'sm_happy');
 $iS->fSa($iS->{fTz}->{name}, "Chat");
 $iS->sLz();
}
sub iHa {
 $iS->cR();
 $iS->bI();
 $iS->nGa($abmain::gJ{hIz}, $abmain::gJ{hJz}, $abmain::gJ{pat});

}
sub sWz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{sZz} =~ s/USER_NAME/$iS->{fTz}->{name}/g;
 $iS->sEz($iS->{chat_sys_name}, $iS->{sZz}. " (".dU('SHORT').")", 1, 'sm_happy');
 $iS->fSa($iS->{fTz}->{name}, "Exit Chat");
 abmain::cTz("You have exited the chatroom", undef, undef, undef, 1);
}
sub vZz {
 $iS->cR();
 $iS->xDz();
}
sub sUz {
 $iS->cR(undef, 1);
 $iS->{tHa} = 1;
 $iS->tGz();
 $iS->sEz($abmain::gJ{reload}?"":$iS->{fTz}->{name}, $abmain::gJ{sIz}, 0, $abmain::gJ{mood});
 sVa::hCaA "Location:", $iS->sPz(), "\n\n";
 $iS->fSa($iS->{fTz}->{name}, "Chat");
}
sub oW {
 $iS->cR();
 $iS->kB();
}
sub gIa {
 $iS->cR();
 abmain::cTz("<center><h2>You have logged out $iS->{name}<h2><p>".$iS->dRz()."</center>", "", $iS->fC(),  abmain::bC('fOz', "", '/'));
}
sub mUz{
 $iS->cR();
 $iS->mTz($abmain::gJ{kQ}, $abmain::gJ{email});
}
sub mN {
 $iS->cR();
 $iS->{hRa}  = 1;
 if($iS->bI()){
 	$iS->aU();
 	return;
 }
 $iS->nK();
};
sub bP {
 my ($prompt_str) = @_;
 $iS->cR();
 $iS->{hide_flink}=1 if($iS->{gOz});
 my @jS = abmain::oCa(\@abmain::pP);
 if($abmain::gJ{qIz}) {
 push @jS, ['qIz', 'hidden', '', '','', $abmain::gJ{qIz}];
 }
 my $qIz= abmain::wS($gJ{qIz});
 my $tP= abmain::cUz("$iS->{cgi}?@{[$abmain::cZa]}cmd=yV;qIz=$qIz", $iS->{sK});
 my $rtag;
 $tP =~ s/<br>/ /gi;
 $rtag = "<br>[ If you are a new user: $tP ]" if $iS->{gBz};
 $prompt_str = "Login $iS->{name}" if not $prompt_str;
 $iS->{kQ} = $abmain::ab_id0;
 $iS->{_banner_html} = $iS->{loginform_banner};
 $iS->jI(\@jS, "bH", "$prompt_str \&nbsp;\&nbsp;\&nbsp;$rtag");
 $iS->yTa(1) if ($iS->{takepop} && (time()%3)==0);
}
sub fBa {
 	if(not -e $abmain::oG){
 	      $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	      abmain::iUz();
	}
	my $mf = new aLa('mlogin', \@abmain::root_login_cfgs, $jT);
	sVa::gYaA "Content-type: text/html\n\n";
	if(eVa()){
 		abmain::bOaA();
		return;
 }
 my ($h, $f) = abmain::nOa();
 print $h;
	$mf->setWidth('80%');
 print $mf->form();
 print $f;
	abmain::iUz();
}
sub pVa {
 	if(not -e $abmain::oG){
 	      $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	      abmain::iUz();
	}
	my $mf = new aLa('mlogin', \@abmain::del_news_cfgs, $jT);

	sVa::gYaA "Content-type: text/html\n\n";
 my ($h, $f) = abmain::nOa();
 print $h;
 print $mf->form();
 print $f;
}
sub eVa{
 my $gEz = $abmain::fPz{master_login};
 my ($gJz, $fJz) = split/\&/, $gEz;
 return if not ($gJz && $fJz);
 $gJz = pack("h*", $gJz);
 $fJz = pack("H*", $fJz);
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_name;
 my $root_pass;
 my $cryp_pass = abmain::lKz($fJz, $iS->{root_passwd});

 if($iS->{root_name} ne "") {
	 $root_name = $iS->{root_name};
	 $root_pass = $iS->{root_passwd};
 }else {
	 $root_name = $iS->{aF};
	 $root_pass = $iS->{oU};
 }
	
 if($root_name ne $gJz|| $root_pass ne $cryp_pass) {
		return;
 }
 return wantarray? (1, 'Server Admin') : 1;

}
sub eYa {
 my $fM = $abmain::gJ{root_name};
 my $admin_pass = $abmain::gJ{root_passwd};

 if(not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_name;
 my $root_pass;

 my $cryp_pass = abmain::lKz($admin_pass, $iS->{root_passwd});
 if($iS->{root_name} ne "") {
	 $root_name = $iS->{root_name};
	 $root_pass = $iS->{root_passwd};
 }else {
	 $root_name = $iS->{aF};
	 $root_pass = $iS->{oU};
 }
	
 if($root_name ne $fM || $root_pass ne $cryp_pass) {
	      error('dM', "Invalid login id or password");
 }
 
 my $uid_c = unpack("h*", $fM);
 my $cE = unpack("H*", $admin_pass);
 my $cVz;
 if($abmain::gJ{qIz}) {
 $cVz=qq(<META HTTP-EQUIV="refresh" CONTENT="0; URL=).$abmain::gJ{qIz}.'">';
 }
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC('master_login', "$uid_c\&$cE", '/'), "\n"; 
 abmain::bOaA();
 abmain::fWa() if not -d abmain::kZz($abmain::master_cfg_dir, "main");
 
}
sub bOaA {
 my ($h, $f) = abmain::nOa();
 my @rows;
 push @rows, [abmain::cUz("$jT?pvp=main", "Go to Master Forum", "_master"), "This is a special forum created automatically by AnyBoard under master_cfg_dir, with all pages being dynamic. Other forums are created differently in the web directory tree."] if -d abmain::kZz($abmain::master_cfg_dir, "main");
 push @rows, [abmain::cUz("$jT?cmd=init", "Create new AnyBoard forum", "create"), ""];
 push @rows, [abmain::cUz("$jT?cmd=delf", "Delete an AnyBoard forum", "delete"), ""];
 push @rows, [abmain::cUz("$jT?cmd=ablist", "List AnyBoard forums", "list"), "You can configure the lead page using the command below"];
 push @rows, [abmain::cUz("$jT?cmd=lYa", "Configure lead page", "configlead"), "You can organize forums in groups"];
 push @rows, [abmain::cUz("$jT?cmd=listnews", "List and manage news", "_blank"),
		"List and manage news by URL"];

 my $fmurl;
 if($abmain::no_pathinfo) {
 	$fmurl = "$jT?docmancmd=fVaA";
 }else {
 	$fmurl = "$jT/?docmancmd=fVaA";
 }

 push @rows, [abmain::cUz($fmurl, "Server File Explorer", "_blank"),
		"Manage files on the web server"];

 push @rows, [abmain::cUz("$jT?cmd=pBa;full=1", "Ad banner setup", "_ads"), "Banners or any well formed HTML code will be displayed in the forums"];

 push @rows, [abmain::cUz("$jT?pwsearchcmd=siteidxform", "Search engine setup", "_searchcfg"),
		"Create an index databases for multiple web sites, even if they are not AnyBoard related.<br>This function will also check for broken links."];

 push @rows, [abmain::cUz("$jT?pwsearchcmd=sitesearchform", "Search web site", "search"),
		"Search the index after it's been created using the function above. You can copy the search form to other pages"];

 push @rows, [abmain::cUz("$jT?cmd=gfindform", "Search forums", "search"),
		"Search forum index"];

 push @rows, [abmain::cUz("$jT?cmd=printallem", "Get All Emails", "_blank"),
		"Retrieve email addresses of all registered users"];

 push @rows, [abmain::cUz("$jT?cmd=gemailform", "Send Emails", "_blank"),
		"Send email to registered users or anyone else"];

 push @rows, [sVa::hFa("$jT?cmd=upgradeab", "Upgrade AnyBoard", "up"),
		"After updating the AnyBoardOne.pm file, you need to run this command to complete the upgrade."];

 push @rows, [sVa::cUz("$jT?cmd=lAa", "Enter license key", "_blank"),
		"Not needed for the free version. To get a license key, you must provide the AnyBoard CGI URL to the vendor."];
 push @rows, ["Examine system settings:<br>". abmain::cUz("$jT?cmd=sinfo;all=1", "with no PATHINFO", "sinfo"). '<br>'.
 		 abmain::cUz("$jT/?cmd=sinfo;all=1", "with PATHINFO=/", "sinfo"),
		"Supplying PATHINFO to a non-standard server may cause URL not found error, in this case, use the link below to set fix parameters."];
 push @rows, [abmain::cUz("$jT?cmd=rinit;dbchk=1", "Fix parameters and SQL DB options", "fixcfg"), "Use this to specify directory paths and SQL DB options".
		"<br>For non-standard servers, AnyBoard can NOT determine the URLs or directories automatically. Use this to fix for non-standard web server (such as Microsoft IIS) or mis-configured web servers (such as missing PATHINFO)"];
 push @rows, [sVa::hFa("$jT?cmd=createdb", "Create AnyBoard SQL Database", "crdb"),
		"Advanced user only, see manual for details."];
 print $h;
 print sVa::tWa();
 #$iS->{usebd} = 0;
 print sVa::fMa(ths=>["Site Admin Options", "Comments"], $iS->oVa(), rows=>\@rows);
 print qq(<p><center><a href="http://netbula.com/anyboard/">Visit AnyBoard Home</a></center>);
 print $f;
 
}
sub mVz{
 $iS->cR();
 $iS->{hide_flink}=1 if($iS->{gOz});
 abmain::error('deny') if not $iS->{mWz};
 $iS->jI(\@abmain::mSz, "reqpass", "");
}
sub yWa{
 $iS->cR();
 $iS->yHa();

}

sub iO {
 $iS->cR();
 if($iS->{eJ} eq "1" || $iS->{eJ} eq 'true') {
 abmain::error('deny', "Posting function is turned off for this forum");
 return;
 }
 
 if($abmain::gJ{attachfid} ne "") {
	$iS->{tHa} =1;
 }

 $iS->gCz();
 abmain::error('dM', "User does not have posting privilege")
 if($iS->{gAz} && $iS->{fTz}->{type} eq 'A');

 if($iS->{fTz}->{type} eq 'D') {
	my $url ;
	my $kQz=$iS->{fTz};
	if($iS->{redir_typed}) {
	 	$url = $iS->{redir_typed};
		$url .= 'usrname='.abmain::wS($kQz->{name});
		$url .= '&usrtype='.abmain::wS($kQz->{type});
		$url .= '&usremail='.abmain::wS($kQz->{email});
		$url .='&usrlocation='.$iS->{_fvp};
		$url .= '&locationname='.abmain::wS($iS->{name});
		$url .= '&usraction=post';
	      	sVa::hCaA "Location: $url\n\n";
		return;
	}

 }
 
 if($iS->{fTz}->{type} eq 'F') {
	my $url ;
	my $kQz=$iS->{fTz};
	if($iS->{redir_typef}) {
	 	$url = $iS->{redir_typef};
		$url .= 'usrname='.abmain::wS($kQz->{name});
		$url .= '&usrtype='.abmain::wS($kQz->{type});
		$url .= '&usremail='.abmain::wS($kQz->{email});
		$url .='&usrlocation='.$iS->{_fvp};
		$url .= '&locationname='.abmain::wS($iS->{name});
		$url .= '&usraction=post';
	      	sVa::hCaA "Location: $url\n\n";
		return;
	}

 }  

 abmain::error('inval', "Maximum number of attachment files is limited")
	if($abmain::gJ{upldcnt} > $iS->{def_extra_uploads} ); 
 if($abmain::gJ{attachfid} ne "") {
	$iS->{xL} =0;
	$iS->{xA} =0;
	$iS->{take_file} =0;
	$iS->{pform_rows} = 4;
 }
 my $ph = $iS->gU(undef, undef, $abmain::gJ{upldcnt}, $abmain::gJ{kQz}, $abmain::gJ{attachfid});
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC($abmain::cH, abmain::nXa($iS->{fTz}->{name}), '/', abmain::dU('pJ',24*3600*128));
 print "\n";
 print $ph;
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Form");
 $iS->yTa(1) if ($iS->{takepop} && (time()%3)==0);
} 

sub kPa{
 my ($k, $v) = @_;
	my $mf = new aLa('idx', \@abmain::fix_cfgs, $jT);
	$mf->zOz();
	$mf->load(abmain::wTz('fixcfg'));
 $mf->{$k} = $v;
	$mf->store(abmain::wTz('fixcfg'));
}

sub fCa{
	my $mf = new aLa('idx', \@abmain::fix_cfgs, $jT);
	$mf->zOz();
	$mf->load(abmain::wTz('fixcfg'));
	no strict 'refs';
	if($mf->{fix_use_cfg}) {
		$abmain::fix_top_url = $mf->{fix_top_url};
		$abmain::fix_top_dir = $mf->{fix_top_dir};
		$abmain::fix_cgi_url = $mf->{fix_cgi_url};
		$abmain::no_pathinfo = $mf->{fix_no_pathinfo};
		$abmain::allow_board_deletion = $mf->{allow_del_board};
		$abmain::off_webroot= $mf->{fix_off_web};
		$abmain::loaded_fix = "Yes";
	}
 if($mf->{fix_use_sql}) {
		$abmain::use_sql =1;
 }

	$zKa::dbdsn = $mf->{fix_dbdsn}; 
	$zKa::dbuser= $mf->{fix_dbuser}; 
	$zKa::dbpassword= $mf->{fix_dbpassword}; 
	$abmain::g_post_pw = $mf->{gpost_password};

 $abmain::lEa[0]= pack("h*", $mf->{kUa});
	$abmain::lEa[1]= $mf->{yBa};
	$abmain::yCa = abmain::fVz(pack("H*", $mf->{yBa}), 217*127)*9;
	$abmain::yAa = (split('-', pack("H*", $mf->{yBa})))[1];
	$abmain::gforbid_words = $mf->{gforbid_words};
	$abmain::cPaA = unpack("H*", $mf->{yBa}.$abmain::jT);
 	abmain::kPa("yBa", unpack("H*", rand().'-'.time())) if not $abmain::lEa[1];
	$abmain::yAa = time(); 
} 

sub fEa{
	abmain::error("dM", "Invalid login id or password") if(not eVa()) ;
	my $mf = new aLa('idx', \@abmain::fix_cfgs, $jT);
	$mf->aAa(\%abmain::gJ);
	if($mf->{fix_use_cfg}) {
		if($mf->{fix_no_pathinfo}) {
			abmain::error('inval',"Fix top directory must be set and must exist") if not -d $mf->{fix_top_dir};
 }
	        abmain::error('inval',"URLs must start with http://") 
 if not ($mf->{fix_top_url} =~ /^http/i && $mf->{fix_cgi_url} =~ /^http/i);
	}
	$mf->store(abmain::wTz('fixcfg'));
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
	print "<h1>Following values have been stored</h1>";
 print $mf->form(1);
 	print abmain::cUz("$jT?cmd=init", "Create new AnyBoard forum");
 print "</body></html>";
}

sub dDaA{
	abmain::error("dM", "Invalid login id or password") if(not eVa()) ;
	require eJaA;
	eval {
		eJaA::create_ab_tables();	
	};
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
	if(not $@) {
		print "<h1>Database created</h1>";
	}else {
		print "Error: $@";
	}
 print "</body></html>";
}
sub gWa{
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
	my $mf = new aLa('idx', \@abmain::iBa, $jT);
	$mf->aAa(\%abmain::gJ);
	$mf->store(abmain::wTz('leadcfg'));
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
	print "<h1>Following values have been stored</h1>";
 print $mf->form(1);
 print "</body></html>";
}
sub fDa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	if(not eVa()) {
		fBa();
 	  	abmain::iUz();
 }
	my $mf = new aLa('idx', \@abmain::fix_cfgs, $jT);
	my @dbs;
 if($abmain::gJ{dbchk}) {
	  eval {
		require zKa;
		my $dbi_hash= zKa::getDataSources();
		@dbs = keys %$dbi_hash;
	  };
 }
	$mf->zOz();
	$mf->load(abmain::wTz('fixcfg'));
	$mf->dNa('fix_top_url', $dJz) if not $mf->{fix_top_url};
	$mf->dNa('fix_cgi_url', $lGa) if not $mf->{fix_top_dir};
	$mf->dNa('dbi_drivers', scalar(@dbs)? join("<br>", map{"<li>$_"} @dbs): "No DBI drivers available");
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print $mf->form();
 print "</body></html>";
}
sub iCa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
	my $mf = new aLa('idx', \@abmain::iBa, $jT);
	$mf->zOz();
	$mf->{fix_top_url} = $dJz;
	$mf->load(abmain::wTz('leadcfg'));
	$mf->sRa('pvhtml', 1);
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 	print sVa::tWa();
	$mf->sRa('pvhtml', 1);
 print $mf->form();
 print "</body></html>";
}
sub lUa{
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $id = $abmain::gJ{id};
	my $mf = new aLa('idx', \@abmain::gDa, $jT);
	$mf->zOz();
	$mf->{fix_top_url} = $dJz;
	$mf->sRa('pvhtml', 1);
 if($id) {
		my $bf = abmain::wTz('bannerfile');
 	my $uNa = new hDa($bf);
		$mf->dNa("banner_id", $id);
		$uNa->kHa($id, $mf);
	}
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 	print sVa::tWa();
 print $mf->form();
 print "</body></html>";
}
sub lSa{
 my ($msg, $code) = @_;
 if(not -e $abmain::oG){
 	  $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 	  abmain::iUz();
	}
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
	my $mf = new aLa('code', \@abmain::ab_code_cfgs, $jT);
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print "<pre>\n$msg\n</pr>";
 
 $mf->dNa("perlcode", $code);
 print $mf->form();
 print "</body></html>";
}
sub mAa{
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $code = $abmain::gJ{perlcode};
	my $res = eval $code;
	lSa($@ || $res, $code);
}
sub mBa{
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
	my $mf = new aLa('idx', \@abmain::gDa, $jT);
	$mf->aAa(\%abmain::gJ);
	my $bf = abmain::wTz('bannerfile');
 my $uNa = new hDa($bf);
 my $id = $mf->{banner_id} || time();
	$mf->dNa("banner_id", $id);
	$uNa->kKa($id, time(),  $mf);
 $uNa->store() or abmain::error("sys", "On writing file $bf: $!");
	pBa("$mf->{banner_tit} $id added",0);
}
sub lVa{
	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $id = $abmain::gJ{id};
	my $bf = abmain::wTz('bannerfile');
 my $uNa = new hDa($bf);
	$uNa->jYa($id);
 $uNa->store() or abmain::error("sys", "Fail to open file $bf: $!");
	pBa("Entry $id deleted");
}
sub mNa{
	my $seq = shift;
	my $r = int (rand() * time());
	my $bf = abmain::wTz('bannerfile');

#IF_AUTO require hDa;

 my $uNa = new hDa($bf);
 my @ks = keys %{$uNa->{entry_hash}};
 my $klen = @ks;
	return if $klen ==0;
 my $idx = $ks[$r%$klen];
 my @vals = $uNa->mSa($idx);
 $vals[2] =~ s/{_seq_}/$seq/g;
	return $vals[2];
}
sub iXa{
	my $id = $abmain::gJ{id};
	my $bf = abmain::wTz('bannerfile');
 my $uNa = new hDa($bf);
 my @vals = $uNa->mSa($id);
 abmain::cTz($vals[2]);
}
sub pBa{
 my ($msg) = @_;
 my $full = $abmain::gJ{full};
#	abmain::error("dM", "Wrong login or password") if(not eVa()) ;
 my $id = $abmain::gJ{id};
	my $bf = abmain::wTz('bannerfile');
 my $uNa = new hDa($bf);
 my @rows;
 my $ent= $uNa->{entry_hash};
 for $id (sort keys %$ent) {
 my @row;
		my @vals = $uNa->mSa($id);
 shift @vals;
 push @row, 
 $vals[0].
 "<br>".abmain::cUz("$jT?cmd=lVa&id=$id", "Delete").
 "  ".abmain::cUz("$jT?cmd=lUa&id=$id", "Modify"), 
 $full? $vals[1]: abmain::cUz("$jT?cmd=iXa&id=$id", "View Detail", "_ban");
 push @rows, [@row];

 }
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print "<P align=right>",abmain::cUz("$jT?cmd=lUa", "Add New Banner"), "</P>";
	print "<center>$msg</center>";
 print sVa::fMa(ths=>["Title", "Code"], rows=>\@rows, $iS->oVa());
 print "</body></html>";
}
sub kOa{
	abmain::error("dM") if(not eVa()) ;
	my $mf = new aLa('lic', \@abmain::lFa, $jT);
	$mf->aAa(\%abmain::gJ);
	$mf->{iGz} =~ s/\s+//g;
	$mf->{iGz} =~ s/"//g;
	abmain::error('inval') if scalar((split /(\d+)/, $mf->{iGz})) <6;
 	abmain::kPa("kUa", unpack("h*", $mf->{iGz}));
	abmain::wLz();
}
sub upgradeab{
	if(not $abmain::gJ{force}) {
		abmain::error("dM") if(not eVa()) ;
	}
	my $PROJ="AnyBoard";

	my $onelib = "$abmain::ab_install_dir/${PROJ}One.pm";
	my $onelibex = "$abmain::ab_install_dir/ex.pm";
	my $autolib = "$abmain::ab_install_dir/anyboard_mod9";

	eval{
		require $onelib;
		sUa::yGz($onelib, $autolib, $onelibex);
	};
	abmain::error('sys', $@) if $@;
}
sub lAa{
	my $mf = new aLa('licentry', \@abmain::lFa, $jT);
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body><center>";
	print $abmain::lGa, "[".$abmain::lEa[1]."]</center>";
 print $mf->form();
	if(not eVa()) {
		my $l = sVa::cUz("$lGa?cmd=admin", "please login first");
		print "<p><center>You are not logged in, $l . </center>"; 
 }
 print "</body></html>";
}
sub hQ {
 $iS->cR();
 $iS->bI();
 my @all_cfgs;
 my $fU ;
 my @jS = split "\0", $abmain::gJ{by};
 my $pat = $abmain::gJ{pat};
 if($pat && not scalar(@jS)) {
	@jS = keys %abmain::eO;
 }
 for(@jS) {
 	     push @all_cfgs, @{$abmain::eO{$_}->[1]};
 }
 if($pat=~/\S/) {
 my $jGz = jW::jFz($pat);
 for(@all_cfgs) {
 $_->[0] = undef if (not &$jGz($_->[3])) && (not &$jGz($iS->{$_->[0]}));
 }
 } 
 if($abmain::gJ{basic_opts}) {
	$iS->gRaA();
 	for(@all_cfgs) {
	  unless($_->[1] eq 'head'){
	    next if not defined $_->[0];
 $_->[0] = undef if not $iS->{_core_opts}->{$_->[0]};
 }
 	}
 }
 $fU = \@all_cfgs;
 
 abmain::error('inval', "You must choose a valid config option") unless scalar(@all_cfgs) >0;
 $iS->jI($fU, "config", "Configure Anyboard ($iS->{name})", 1, 0, join("-", @jS));
}
sub yS {
 $iS->cR();
 $iS->bI();
 my $f;
 if($abmain::gJ{whom} eq 'adm' ) {
 $f =  $iS->nDz('admlog');
 }elsif($abmain::gJ{whom} eq 'kQz') {
 $f =  $iS->nDz('usrlog'); 
 }elsif($abmain::gJ{whom} eq 'tellusr') {
 $f =  $iS->nDz('telllog'); 
 }elsif($abmain::gJ{whom} eq 'failpost') {
 $f =  $iS->nDz('failpostlog'); 
 }
 my $linesref;
 
 chmod 0600, $f;
 $linesref = $bYaA->new($f, {schema=>"AbLoginLog", paths=>$iS->zOa('login') })->iQa({noerr=>1, kG=>"On open file"});
 chmod 0000, $f;
 
 my $sti = time() - $abmain::gJ{hIz}* 24 * 3600;
 $sti = -1 if not $abmain::gJ{hIz};
 my $eti = time() - $abmain::gJ{hJz}* 24 * 3600;
 my $pat = $abmain::gJ{pat};

 $iS->eMaA( [qw(other_header other_footer)]);
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>Log records </title>$iS->{other_header}<center><h2>Log Records</h2></center>);
 my $k=0;
 my @rows;
 local $_;
 while ($_ = pop @$linesref) {
 my @fields = @$_;
 last if $fields[2] < $sti;
 next if $fields[2] > $eti;
 next if ($pat && $fields[0]." ".$fields[3]  !~ /$pat/i );
 $fields[2] = abmain::dU('LONG', $fields[2], 'oP');
 push @rows, [@fields];
 }
 my @ths = jW::mJa($iS->{cfg_head_font}, "Who", "Status", "Time", "Origin", "Comments");
 print sVa::fMa(ths=>\@ths, rows=>\@rows, $iS->oVa());
 print "$iS->{other_footer}";
}
sub aEz {
 $iS->cR();
 $iS->bI();
 my $filter=undef;

 
 my $hIz = $abmain::gJ{hIz};
 my $hJz = $abmain::gJ{hJz}||0;
 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 $filter = sub {$_[0]->[5]>=$sti && $_[0]->[5] <= $eti;};

 my $df = $iS->nDz('dmsglist');
 my $linesref = $bYaA->new($df, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($df) })->iQa({noerr=>1, filter=>$filter});

 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>Deletion records </title>$iS->{other_header}<center><h1>Deleted messages</h1></center>);
 print "$iS->{other_header}";
 my @ths = jW::mJa($iS->{cfg_head_font}, "Subject", "Author", "IP", "Size", "Message#", "Time");
 my @rows;
 for(@$linesref) {
 my @fields = @$_;
 next if ($fields[5] < $sti || $fields[5] > $eti);  
 push @rows, [ $fields[3], $fields[4], abmain::pT($fields[7]), $fields[6],
 $fields[2], abmain::dU('LONG', $fields[5], 'oP')
 ];
 }
 print sVa::fMa(ths=>\@ths, rows=>\@rows, $iS->oVa());
 print "$iS->{other_footer}";
}
sub convert_msg_db {
 $iS->cR();
 $iS->bI();
 my $filter=undef;
 my $type_from= $abmain::gJ{fromdb} || 'jEa';

 abmain::error('inval', "From database must differ from current database") if $type_from eq $bYaA;
 eval "require $type_from";
 
 my $df = $iS->nDz('msglist');
 my $linesref = $type_from->new($df, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($df) })->iQa({noerr=>1, filter=>$filter});
 my $db = $bYaA->new($df, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($df) });
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><body>);
 print "Got ", scalar(@$linesref), " messages";
 $db->kEa($linesref);
 $iS->aT();
 $iS->eG();
 print "$iS->{other_footer}";
}
sub oQa {
	my ($dir, $dirn, $dirdesc, $eonly) = @_;
 if(not -d $dir) {
 abmain::cTz(
qq!<blockquote>
<h1>Checking setting for <i>$dirdesc</i> </h1>
<font color="red">$dirdesc does not exist</font><p>
$dirdesc was set to [ <b>$dir</b> ] in the Anyboard script ($0),
however, this directory does not exist on your web server. Please create a directory, 
make it writable (e.g., chmod 0777 directory_name), 
and assign its path to the $dirn variable in the script.<p>
<a href="$iS->{cgi}?@{[$abmain::cZa]}cmd=init">I have made the above changes, let me try again</a></blockquote>!, "Must create $dirdesc");
 abmain::iUz();
 }
 return if $eonly;
 if(not nZa($dir)) {
 abmain::cTz(
qq!<h1>Checking setting for <i>$dirdesc</i> </h1>
<blockquote><h1><font color="red">$dir is not writable</font></h1>
$dirdesc $dir is not writable by Anyboard.
Please change its permissions to make it writable <li>UNIX: chmod 0777 $dir; <li>Windows: ask your ISP to set access to full control by Iusr_ ).<p>
<a href="$iS->{cgi}?@{[$abmain::cZa]}cmd=init">I have made the above changes, try again</a></blockquote>!, "$dirdesc not  writable");
 abmain::iUz();
 }

}
sub gT {
 oQa($abmain::master_cfg_dir, '$abmain::master_cfg_dir', "Master configuration directory");
 
 $iS->{hide_flink}=1;
 if( not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 my $pit;
 
 my $rcl = abmain::cUz("$lGa?cmd=rinit", qq(<font size="1">Reconfigure settings</font>) );

 if(not $abmain::no_pathinfo) {
#	$pit = eSaA();
	if($bS eq "") {
		my $cl = sVa::cUz(sVa::kZz($lGa, "/")."?cmd=init", "please proceed with PATHINFO set to /");
		abmain::cTz("You are using PATHINFO, $cl .<p>If the link does not work at all, then you must set no_pathinfo to 1 and retry.<p> ($rcl)"); 
 	abmain::iUz();

 }
	my $path = $iS->{eD};
 if(not -d $path) {
		abmain::cTz("You are about to create forums under $path, but it does not exist.<br>You need to set the fix_top_dir variable.<br> ($rcl)"); 
 	abmain::iUz();
	}
	
 } 

 if ($abmain::no_pathinfo ) {
 	oQa($abmain::fix_top_dir, '$abmain::fix_top_dir', "Top AnyBoard web directory ($rcl)", 1);
 }

 my @jS = abmain::oCa(\@abmain::gS);
 push @jS, ["ignore","const", "","Forum configuration","",  abmain::cMz()];
 $jS[6]->[5]=$abmain::top_virtual_dir."/forum" if $abmain::top_virtual_dir;
 $iS->jI(\@jS, "fD", qq(Create new AnyBoard forum <img src="$uF">.\&nbsp;).
 abmain::cUz("$iS->{cgi}?@{[$abmain::cZa]}cmd=sinfo&all=1", "<small>Examine system setting</small>").
 '&nbsp;&nbsp;&nbsp;'.
 abmain::cUz("http://netbula.com/anyboard/installreq.html", qq(<font size="1">Installation request</font>) ).
 '&nbsp;&nbsp;&nbsp;'. $rcl
 );
} 
sub jNz {
 if( not -e $abmain::oG){
 &abmain::error('deny', "Operation not allowed");
 abmain::iUz();
 }
 $iS->jI(\@abmain::kDz, "hPz", "Delete forum $iS->{name}");
} 
sub wJz {
 if( not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 abmain::error('inval', "Parent directory does not exist") if not -d $iS->{eD};
 $iS->{hide_flink}=1;
 abmain::lIz($iS->{eD});
 $iS->{cat_name}="";
 $iS->{cat_desc}="";
 $iS->{cat_dir}="";
 $iS->jI(\@abmain::lQa, "lOz", "Create new category");
} 
sub xCz {
 $iS->iA(\@abmain::lQa);
 my $cgi = $jT;
 my $pA = $abmain::gJ{cat_dir};
 my $fM = $abmain::gJ{root_name};
 my $admin_pass = $abmain::gJ{root_passwd};

 if(not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_pass = abmain::lKz($iS->{eF}->{root_passwd}, $iS->{root_passwd});

 if($iS->{root_name} ne $abmain::gJ{root_name} || $iS->{root_passwd} ne $root_pass) {
 error('dM', "Invalid login id or password");
 }
 my $dir = abmain::kZz($iS->{eD}, $pA);
 abmain::error('inval', "Directory $dir exists") if -d $dir;
 mkdir $dir, 0755 or abmain::error('sys', "When create $dir: $!");
 $iS->{root_passwd}="";
 $iS->{root_name}="";
 $iS->cW(abmain::kZz($dir, ".catidx"), \@abmain::lQa);
 my $fvp = $abmain::fvp;
 my $cVz;
 if($abmain::no_pathinfo) {
	my $fvps = kZz($fvp, $pA);
 $cVz =  $dLz. "?fvp=$fvps;cmd=lGz;lF=1"; 
 }else {
 	$cVz =  kZz($dLz, "/$pA?cmd=lGz;lF=1"); 
 }
 sVa::hCaA "Location: $cVz\n\n";
}
sub xNz {
 $iS->{hide_flink}=1;
 $iS->cJ(abmain::kZz($iS->{eD}, ".catidx"), \@abmain::lQa);
 $iS->jI(\@abmain::lQa, "lMz", "Modify category");
} 
sub vTz{
 $iS->iA(\@abmain::lQa);
 my $cgi = $jT;
 my $pA = $abmain::gJ{cat_dir};
 my $fM = $abmain::gJ{root_name};
 my $admin_pass = $abmain::gJ{root_passwd};
 my $pv = $abmain::gJ{btn_preview} ne "";

 $iS->cJ($abmain::oG, \@abmain::dN);
 my $root_pass = abmain::lKz($iS->{eF}->{root_passwd}, $iS->{root_passwd});

 my ($is_root, $root) = eVa() ;
 unless ($is_root) {
 if($iS->{root_name} eq "" || $iS->{root_name} ne $abmain::gJ{root_name} || $iS->{root_passwd} ne $root_pass) {
 error('dM', "Invalid login id or password");
 }
 }
 my $cidx = abmain::kZz($iS->{eD}, ".catidx");
 $iS->{root_passwd}="";
 $cidx .="gYa" if $pv;
 $iS->{root_name}="";
 $iS->cW($cidx, \@abmain::lQa);
 my $fvp = $abmain::fvp;
 my $cVz;
 if($abmain::no_pathinfo) {
	my $fvps = $fvp;
 $cVz =  $dLz. "?fvp=$fvps;cmd=lGz;lF=1;pv=$pv"; 
 }else {
 	$cVz =  kZz($dLz, "?cmd=lGz;lF=1;pv=$pv"); 
 }
 sVa::hCaA "Location: $cVz\n\n";
}
sub tRz {
 $iS->cR();

 abmain::error('deny', "Event submission not enabled") if not $iS->{uZz};
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz}=1 if $iS->{uSz};
 $iS->tGz();
 $iS->{hZa}=1;
 $iS->{iPa}=1;

 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->aAa(\%abmain::gJ);

 my $eveid = $iS->iU();
 my $edir = $iS->nDz('evedir');
 if((not -d $edir) && -f $iS->nCa()) {
 mkdir $edir, 0755 or abmain::error('inval', "Fail to create directory $edir: $!");
 }
 abmain::error('inval', "End time must be later than start time") 
 if ($eveform->{eve_end} cmp $eveform->{eve_start}) <0;
 abmain::error('inval', "No subject supplied") if not $eveform->{eve_subject} =~ /\S+/;
 abmain::error('inval', "No description supplied") if not $eveform->{eve_description} =~ /\S+/;
 
 my $eveidx = abmain::kZz($edir, "event.idx");
 $eveform->{eve_subject} =~ s/\t|\n/ /g;
 $eveform->{eve_org} =~ s/\t|\n/ /g;
 $bYaA->new($eveidx, {schema=>"AbEveIndex", paths=>$iS->zOa('eve') })->iSa(
 [$eveid, $eveform->{eve_subject}, $eveform->{eve_start}, $eveform->{eve_org}, $iS->{fTz}->{name}, time(), undef]
 );  
 my $efile = abmain::kZz($edir, "$eveid.eve");
 $eveform->dNa('eve_author', $iS->{fTz}->{name});
 $eveform->store($efile);
 abmain::cTz("Added event $iS->{eve_subject}", "", ,"$iS->{cgi}?@{[$abmain::cZa]}cmd=tVz");
}
sub uPz{
 $iS->cR();
 abmain::error('deny', "Link submission not enabled") if not $iS->{enable_links};
 $iS->{_admin_only}=1 if not $iS->{lnk_usr_add};
 $iS->{gAz}=1 if $iS->{lnk_usr_must_reg};
 $iS->tGz();
 $iS->{iPa}=1;
 $iS->iA(\@abmain::uWz);
 my $lnkid = $iS->iU();
 $iS->{lnk_cat} = $abmain::gJ{lnkcat};
 
 $iS->{lnk_subject} =~ s/\t|\n/ /g;
 $iS->{lnk_description} =~ s/\t|\n/ /g;
 $iS->mXa(join(" ", $iS->{lnk_subject}, $iS->{lnk_url}), $iS->{fTz}->{name});
 my $url = jW::wYz(\$iS->{lnk_url});
 abmain::error('inval', "No valid URL provided") if not $url;
 abmain::error('inval', "No link title provided") if not $iS->{lnk_subject};
 my $len = length($iS->{lnk_description});
 abmain::error('iK', "Link title must be less than $iS->{qJ} bytes")
 if (length($iS->{lnk_subject}) > $iS->{qJ});
 abmain::error('iK', "Link description must be less than $iS->{lnk_max_desc} bytes ($len)")
 if ($len > $iS->{lnk_max_desc} || length($url) > $iS->{lnk_max_desc});
 $iS->{link_cat} = "";

 my $lf = $iS->nDz('links');
 $bYaA->new($lf, {schema=>"AbLinks", paths=>$iS->dHaA($lf) })->iSa(

 [$lnkid, $iS->{lnk_subject}, $url, $iS->{lnk_cat}, $iS->{fTz}->{name}, time(), $iS->{lnk_description}, abmain::lWz()]
 );
 open EIDX2, ">".abmain::kZz($iS->{eD}, $iS->{links_file}) or abmain::error('sys', "On open file: $!");
 $iS->wBz(\*EIDX2, $iS->{lnk_show_adm});
 close EIDX2;
 abmain::cTz("Added link <b>$iS->{lnk_subject}</b>!","", "$iS->{cgi}?@{[$abmain::cZa]}cmd=wMz");
}
sub wVz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz} =1 if $iS->{uSz};
 $iS->tGz();
 my $edir = $iS->nDz('evedir');
 my $eveidx = abmain::kZz($edir, "event.idx");
 my $name = $iS->{fTz}->{name};
 my $eveid = $abmain::gJ{eveid};

 my $db = $bYaA->new($eveidx, {schema=>"AbEveIndex", paths=>$iS->zOa('eve') });

 my $row = $db->kCa($eveid);
 abmain::error('inval', "Event not found") if not $row;
 my ($eid, $esub, $etime, $eorg, $eauthor)= @$row;
 if (lc($name) ne lc($eauthor)) {
		abmain::error('deny', "Only the author of the event can modify it")
 unless ($iS->{admin_ed} && (lc($name) eq lc($iS->{admin}) || $iS->{moders}->{$name}));
 }
 $db->jLa([$eveid]);
 my $efile = abmain::kZz($edir, "$eveid.eve");
 unlink $efile;
 abmain::cTz("Deleted event <b>$esub</b>!","", "$iS->{cgi}?@{[$abmain::cZa]}cmd=tVz");
}

 
sub uFz{
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{lnk_usr_add};
 $iS->{gAz} =1 if $iS->{lnk_usr_must_reg};
 $iS->tGz();
 my $lnkidx = $iS->nDz('links');
 my $name = $iS->{fTz}->{name};
 my $lnkid = $abmain::gJ{lnkid};

 my $db= $bYaA->new($lnkidx, {schema=>"AbLinks", paths=>$iS->dHaA($lnkidx) });

 my $row = $db->kCa($lnkid);
 abmain::error('inval', "Link not found") if not $row;
 my ($lid, $lsub, $lurl, $lcat, $lauthor, $ltime, $desc, $addr)= @$row;
 if (lc($name) ne lc($lauthor)) {
		abmain::error('deny', "Only the author of the link can modify it")
 unless ($iS->{admin_ed} && (lc($name) eq lc($iS->{admin}) || $iS->{moders}->{$name}));
 }
 $db->jLa([$lnkid]);
 abmain::cTz("Deleted link <b>$lnkid</b>!","", "$iS->{cgi}?@{[$abmain::cZa]}cmd=wMz");
}

 

sub wXz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz}=1 if $iS->{uSz};
 $iS->tGz();
 my $edir = $iS->nDz('evedir');
 my $eveidx = abmain::kZz($edir, "event.idx");
 my $name = lc($iS->{fTz}->{name});
 my $eveid = $abmain::gJ{eveid};

 $iS->{hZa}=1;
 $iS->{iPa}=1;

 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->aAa(\%abmain::gJ);

 abmain::error('inval', "End time must be later than start time")
 	if ($eveform->{eve_end} cmp $eveform->{eve_start}) <0;
 abmain::error('inval', "No subject supplied") if not $eveform->{eve_subject} =~ /\S+/;
 abmain::error('inval', "No description supplied") if not $eveform->{eve_description} =~ /\S+/;
 
 my $db = $bYaA->new($eveidx, {schema=>"AbEveIndex", paths=>$iS->zOa('eve') });
 my $row = $db->kCa($eveid);
 abmain::error('inval', "Event not found") if not $row;
 my ($eid, $esub, $etime, $eorg, $eauthor, $ct, $modt)= @$row;
 if (lc($name) ne lc($eauthor)) {
		abmain::error('deny', "Only the author of the event can modify it")
 unless ($iS->{admin_ed} && (lc($name) eq lc($iS->{admin}) || $iS->{moders}->{$name}));
 }
 $db->jXa( [[$eid, $eveform->{eve_subject}, $eveform->{eve_start}, $eveform->{eve_org}, $eauthor, $ct, time()]]);

 my $efile = abmain::kZz($edir, "$eveid.eve");
 $eveform->store($efile);
 abmain::cTz("Modified event <b>$esub</b>!".$eveform->form(1), "", "$iS->{cgi}?@{[$abmain::cZa]}cmd=tVz");
}

 

sub rCz {
 $iS->cR();
 $iS->bI();
 abmain::jJz(\$abmain::gJ{qQz});
 $iS->iA(\@abmain::qSz);
 my $pid = $iS->{qQz};
 abmain::error('inval', "Poll id must be alphanumeric") if $pid =~ /\W/ || $pid eq "";
 my $qUz = $iS->nDz('qUz');
 if((not -d $qUz) && -f $iS->nCa()) {
 mkdir $qUz, 0755 or abmain::error('inval', "Fail to create directory $qUz: $!");
 }
 my $fIz = $iS->qZz($pid);
 abmain::error('inval', "Poll already exists!") if -f $fIz && not $iS->{rDz};
 $iS->cW($fIz, \@abmain::qSz);
 my $vstr = $iS->qXz($pid);
 open F, ">".$iS->qTz($pid);
 print F abmain::rLz($vstr);
 close F;
 open F, ">".$iS->xQz($pid);
 $iS->eMaA( [qw(other_header other_footer)]);
 print F "<html><head><title>Polls</title>$iS->{other_header}$vstr$iS->{other_footer}";
 close F;
 my $urls ;
 $urls .= "Poll JavaScript: ". $iS->lMa(abmain::kZz('polls', "$pid.js"));
 $urls .= "<br>Poll page: ". $iS->lMa(abmain::kZz('polls', "$pid.$iS->{ext}"));
 $urls .= "<br>Poll result JavaScript: ". $iS->lMa(abmain::kZz('polls', "${pid}_res.js"));
 $urls .= "<br>Poll result page: ". $iS->lMa(abmain::kZz('polls', "${pid}_res.$iS->{ext}"));
 my $idxjs= $iS->lMa(abmain::kZz('polls', 'index.js'));
 my $idx= $iS->lMa(abmain::kZz('polls', $iS->{pollidxfile}||"index.html"));
 $urls .= "<br>Poll index script: $idxjs";
 $urls .= "<br>Poll index page: $idx";
 $iS->rPz();
 $urls .= qq(<p><script src="$idxjs"></script>);
 abmain::cTz($vstr."<p> <form><textarea rows=10 cols=48>$vstr</textarea></form><p>$urls", "Poll added!");
}
sub rVz {
 $iS->cR();
 $iS->bI();
 abmain::error('inval', "Must check box to confirm deletion, all poll data will be lost!") 
	if  not $abmain::gJ{kIz};
 abmain::jJz(\$abmain::gJ{qQz});
 my $pid = $abmain::gJ{qQz};
 my $fIz = $iS->qZz($pid);
 my $pjs = $iS->qTz($pid);
 my $pd = $iS->rJz($pid);
 my $phtm = $iS->xQz($pid);
 my $idxjs = $iS->lMa(abmain::kZz('polls', 'index.js'));
 my $idx = $iS->lMa(abmain::kZz('polls', $iS->{pollidxfile}||"index.html"));
 my $files;
 my @files = ($fIz, $pjs, $phtm, $idxjs, $idx, $pd);
 for(@files) {
 unlink $_ and $files .= " $_";
 }
 $iS->rPz();
 abmain::cTz("<p> Poll $pid deleted!<br>Deleted files: $files");
}
sub rWz {
 $iS->cR();
 $iS->bI();
 abmain::jJz(\$abmain::gJ{qQz});
 my $pid = $abmain::gJ{qQz};
 $iS->iA(\@abmain::qSz);
 my $pd = $iS->rJz($pid);
 unlink $pd or abmain::error('sys', "Fail to unlink $pd: $!");
 $iS->rAz($pid);
 $iS->rPz();
 abmain::cTz("<p> Poll $pid has been reset!");
}
sub rLz {
 my ($str) = @_;
 $str =~ s/'/\\'/g;
 $str =~ s/\n/\\n/g;
 $str =~ s/\r//g;
 return qq!document.write('$str');!;
}
sub oL{
 $iS->cR();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n" if(!$iS->{qR}); 
 if($abmain::gJ{all}) {
 	my @all_cfgs;
 	for(values %abmain::qJa) {
 	     push @all_cfgs, @{$_->[1]};
 	}
 	$iS->jI(\@all_cfgs, "", "Forum options", 1, 1);
 }else {
 $iS->jI(\@abmain::tL, "", "Forum options", 1, 1);
 }
}
sub uO {
 $iS->cR();
 $iS->bI();
 $iS->jI(\@abmain::bO, "bV", "Change Admin login and password", 0);
}
sub lKa {
 $iS->cR();
 my $pass = int (rand()*time()+1);
 my $sf = $iS->nDz('skey');
 open F, ">$sf" or abmain::error('sys', "On writing file $sf: $!");
 print F abmain::lKz($pass);
 close F; 
 $iS->xI("New admin password", "Password: $pass\nURL: ".$iS->fC()."\n"."You should change password immediately\n", 1);
 cTz("Password has been sent to you by email", "New password", $iS->fC());
}
sub uK {
 $iS->cR();
 $iS->bI();
 $iS->{moderator}= $abmain::gJ{mod_name}; 
 ($iS->{moderator_email}, $iS->{vI}, $iS->{vM}, $iS->{vN})
 = @{$iS->{moders}->{$iS->{moderator}}};
 $iS->jI(\@abmain::vC, "vG", "Change Moderator Login/Password", 0);
}
sub xOz {
 $iS->cR();
 $iS->bI();
 if($abmain::gJ{qQz}) {
 my $pp = $iS->qZz($abmain::gJ{qQz});
 $iS->cJ($pp, \@abmain::qSz) if -f $pp;
 }
 $iS->jI(\@abmain::qSz, "rCz", "Add or modify poll", 0);
}
sub lK {
 $iS->cR();
 $iS->{hide_flink}=1 if($iS->{gOz});
 abmain::error('inval', "$iS->{name} does not have user registration enabled") if not $iS->{gBz};
 my @regcfgs= abmain::oCa(\@abmain::bB);
 if($iS->{short_reg_form}) {
	$regcfgs[3]->[1]="hidden";
	$regcfgs[4]->[1]="hidden";
	$regcfgs[5]->[1]="hidden";
 }
 pop @regcfgs if not $iS->{notify_usr};
 if($abmain::gJ{qIz}) {
 push @regcfgs, ['qIz', 'hidden', '', '','', $abmain::gJ{qIz}];
 }
 if($iS->{ask_on_reg}) {
 push @regcfgs, ['my_answer', 'text', qq(size="60"), $iS->{reg_question}];
 }
 $iS->{_banner_html} = $iS->{regform_banner};
 $iS->jI(\@regcfgs, "reg", "User Registration", 0);
}
sub oCa{
	my $jF = shift;
 my @cfgs2 =();
 for(@$jF){
		push @cfgs2, [@$_];
 }
 return @cfgs2;

}
sub yP {
 $iS->cR();
 abmain::error('inval', "$iS->{name} does not have user registration enabled")
 if(not ($iS->{gBz} || $iS->{gAz}));
 $iS->{tHa} =1;
 $iS->gCz();
 if(not $iS->{fTz}->{reg}) {
	abmain::error("inval", "User $iS->{fTz}->{name} is not registered");
 }
 my @regcfgs= abmain::oCa(\@abmain::bB);
 if($iS->{short_reg_form}) {
	$regcfgs[3]->[1]="hidden";
	$regcfgs[4]->[1]="hidden";
	$regcfgs[5]->[1]="hidden";
 }
 $regcfgs[0]->[2]  = "Modify $iS->{fTz}->{name}"; 
 my $profile = $iS->{gFz}->{lc($iS->{fTz}->{name})};

#email 
 $regcfgs[2]->[5] = $profile->[1];
#wO
 $regcfgs[3]->[5] = $profile->[3];
#location
 $regcfgs[4]->[5] = $profile->[7];
#desc 
 $regcfgs[5]->[5] = $profile->[8];
 
#showme
 $regcfgs[8]->[5] = $profile->[10];
#noti
 $regcfgs[9]->[5] = $profile->[9];

 pop @regcfgs if not $iS->{notify_usr};
 $iS->jI([@regcfgs[0, 2..9]], "xT", "Modify user registration information", 1);
}
sub yEz {
 $iS->cR();
 $iS->bI();
 my $kQz = $abmain::gJ{kQz};
 my @jS = abmain::oCa(\@abmain::del_conf_cfgs);
 push @jS, ["gJz", "hidden"];
 $iS->{gJz} = $kQz;
 $jS[0][2]="Please confirm the deletion of user: <b>$kQz</b>";
 push @jS, ["hIa", "hidden", "", "", "", "1"];
 $iS->jI(\@jS, "cQ", "");
}

 

sub wHz {
 $iS->cR();
 $iS->bI();
 my $kQz = $abmain::gJ{kQz};
 $kQz = lc($kQz);
 $iS->fZz($kQz);

 my @regcfgs= abmain::oCa(\@abmain::bB);
 if($iS->{short_reg_form}) {
	$regcfgs[3]->[1]="hidden";
	$regcfgs[4]->[1]="hidden";
	$regcfgs[5]->[1]="hidden";
 }
 $regcfgs[0]->[2]  = "Modify user $kQz"; 
 my $profile = $iS->{gFz}->{$kQz};
 if( not $iS->{fYz}->{$kQz}) {
 	abmain::error('inval', "User not found!");
 }
 $profile =[] if not $profile;
#email 
 $regcfgs[2]->[5] = $profile->[1];
#wO
 $regcfgs[3]->[5] = $profile->[3];
#location
 $regcfgs[4]->[5] = $profile->[7];
#desc 
 $regcfgs[5]->[5] = $profile->[8];
 $regcfgs[8]->[5] = $profile->[10];
 $regcfgs[9]->[5] = $profile->[9];
 
 pop @regcfgs if not $iS->{notify_usr};
 $regcfgs[6]=undef;
 $regcfgs[7]=undef;

 push @regcfgs, [status=>"select", $abmain::user_stat_sel, "Status", "", $profile->[4]];
 push @regcfgs, [fMz=>"select", $abmain::user_type_sel, "Access type", "", $profile->[6]];
 push @regcfgs, [kQ=>"hidden", undef, undef, undef, $kQz];
 $iS->jI([@regcfgs[0, 2..12]], "amodreg", "Modify user registration information", 0);
}
sub gG {
 $iS->cR();
 my ($is_root, $root) = eVa() ;
 if($is_root && $root ne "") {
 $iS->oXa($root);
 }else {
 	$iS->gCz();
 }
 $iS->gG($abmain::gJ{cG}, $is_root, $abmain::gJ{plainform});
}
sub xSz {
 $iS->cR();
 $iS->gCz();
 if($iS->{fWz}) {
	sVa::hCaA "Location: ". $iS->kTz( $iS->{fTz}->{name}). "\n\n";
 }else {
 sVa::hCaA "Location: $iS->{cgi_full}?@{[$abmain::cZa]}cmd=dW\n\n";
 }
}
sub aBz {
 abmain::error('inval') if not defined($abmain::gJ{cG});
 $iS->cR();
 $iS->gCz() if $iS->{rRz};
 my $cG = $abmain::gJ{cG};
 my $rat;
 $rat  = "(".$abmain::gJ{rate} .")" if $abmain::gJ{rate} ne "";
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC('zN', "$cG", '/'), "\n";
 $iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>
 <title>RATE THE ARTICLE</title>
 $iS->{sAz}
 $iS->{other_header}
 <center>
 <table bgcolor="$iS->{xM}" cellpadding=5 cellspacing=0>
 <tr><th colspan=2>Rate Article #$cG $rat (high score is better)</th></tr>
 <tr><td align="center">$iS->{aPz} (+) </td><td align="center">  $iS->{minus_word} (-)</td></tr>
 <tr><td align="center" colspan=2>
 <form action="$iS->{cgi}" method="POST">
 	@{[$abmain::cYa]}
 <select name="zM">
 );
 my $i;
 for($i=$iS->{rate_high}; $i>= $iS->{rate_low}; $i--) {
 print qq(<option value="$i"> $i);
 }
 print qq#</select>
 <input type="hidden" name="cG" value="$cG">
 <input type="hidden" name="cmd" value="zJ">
 <input type="hidden" name="arch" value="$abmain::gJ{arch}">
 <input type="submit" class="buttonstyle" name="Rate it" value="Rate it!">
 </form></td></tr></table>
 <p>
 @{[abmain::cUz($iS->fC(), $iS->{name})]}
 </center>
$iS->{other_footer}
 #;
}
sub vW {
 $iS->cR();
 $iS->wA($abmain::gJ{uname}, $abmain::gJ{vkey});
}
sub iOz{
 $iS->cR();
 $iS->iMz($abmain::gJ{gJz}, $abmain::gJ{iNz}, $abmain::gJ{email}, $abmain::gJ{create});
 abmain::cTz("Password set to ".$abmain::gJ{iNz});
}
sub vR {
 $iS->cR();
 &abmain::error('inval', "You must check the box to indicate that you have read the rules") unless $abmain::gJ{yJ};
 $iS->wG($abmain::gJ{name}, $abmain::gJ{vkey});
 my @jS = abmain::oCa(\@abmain::pP);
 my $mp_url = $iS->{mp_url} || "$iS->{cgi}?@{[$abmain::cZa]}cmd=mform";
 push @jS, ['qIz', 'hidden', '', '','', $mp_url ] if($iS->{mp_enabled}); 
 $iS->jI(\@jS, "bH", "Account activated! Please enter user info to login $abmain::gJ{name}");
 $iS->pHa($abmain::gJ{name}) if $iS->{post_welcome};
}
sub jJz{
 my $nref = shift;
 $$nref =~ s/\t/ /g;
 $$nref =~ s/\0/,/g;
 $$nref =~ s/^\s+//;
 $$nref =~ s/\s+$//;
 $$nref =~ s/\s+/ /g;
 $$nref =~ s/\s*(,|;)+\s*$/ /g;
 $$nref =~ s/\<|\>|\&|\'|\"|\`|\|//g;
}
sub wDz{
 my $nref = shift;
 $$nref =~ s{<!(.*?)(--.*--\s*)+.(.*?)>}{if($1||$3) {"<!$1 $3>";}}ges;
 $$nref =~ s#<(!|[a-zA-Z]|/)[^>]*>##gs;
}
sub jVz {
 my $name = shift;
 return "User name cannot contain quotes" if $name =~ /\"|\'|`/g; 
 return "User name cannot contain less, greater or ampersand" if $name =~ /\>|\<|\&/g; 
}
sub xAz {
 $iS->cR();
 $iS->bI();
 my $name= $abmain::gJ{kQ} ;
 $name = lc($name);
 if(length($name) > $iS->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($iS->{sO})} characters");
 }
 my $err;
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }
 abmain::jJz(\$name);

 $abmain::gJ{wO}=~ s/\s+/ /g;
 $abmain::gJ{wJ} =~ s/\s+/ /g;
 $abmain::gJ{xK} =~ s/\s+/ /g;
 $abmain::gJ{status} =~ s/\s//g;
 $abmain::gJ{fMz}  =~ s/\s//g;

 $iS->fZz($name);
 $iS->{_adm_mod_reg} =1;
 $iS->aG($name, $iS->{fYz}->{$name}, $abmain::gJ{email}, $abmain::gJ{wO},
 $abmain::gJ{status}, 0, $abmain::gJ{fMz},
 $abmain::gJ{wJ}, 
 $abmain::gJ{xK}, 
 $abmain::gJ{add2notifee},
 $abmain::gJ{noshowmeonline}
 );
 abmain::cTz("<h1>$name has been modified</h1>");
}
sub bFa{
 	$iS->cR();
 	$iS->{gAz} = 1;
 	$iS->{tHa} = 1;
 	$iS->tGz();
 my $gJz = $abmain::gJ{kQ} || $iS->{fTz}->{name};
	my $mf = $iS->gXa(lc($gJz));
	$mf->zQz($jT);
 my $kQz =  $iS->{fTz}->{name};
	my $isadm=   $iS->{moders}->{$kQz} || $kQz eq $iS->{admin};
 $isadm |= $iS->yXa();
 abmain::error('deny', "Only admin can edit only member's profile") if lc($gJz) ne lc($kQz) && not $isadm;
	$mf->aCa(['mp_info', "head", "Enter profile information for user $gJz"]);
	$mf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
	$mf->{homepageurl}= $iS->{fTz}->{wO} if (not $mf->{homepageurl}) && lc($gJz) eq lc($kQz);
	$mf->cOa([split /\W+/, $iS->{mp_reqfields}], 1);
	$mf->dNa('userid', $gJz);
 $mf->cGa($iS->{required_word});
	sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$iS->{sAz} $iS->{other_header});
	$mf->sRa('pvhtml', 1);
 	print sVa::tWa();
	$mf->bSa($iS->{mpformlayout}) if length($iS->{mpformlayout})>32; 
 print $mf->form(0, [split /\s+/, $iS->{mp_skipfields} ]);
 print   $iS->{other_footer};
}
sub bIa{
 	$iS->cR();
 	$iS->{gAz} = 1;
 	$iS->{tHa} = 1;
 	$iS->tGz();
	abmain::error("deny", "Can't show email") if  $iS->{gNz};
 my $gJz = $abmain::gJ{kQ};
 if($abmain::gJ{vcf}) {
		sVa::gYaA "Content-type: text/x-vcard\n\n";
		print $iS->fYa($gJz);
	       
 } else {
		sVa::gYaA "Content-type: text/html\n\n";
 	print "<html><head>$iS->{sAz}";
 	print $iS->{mpheader};
		$iS->bVa($gJz);
		print "<br/>";
		print sVa::cUz(sVa::sTa($abmain::jT, {docmancmd=>'fVaA', kQz=>$gJz, dir=>'/public'}), "View Files");
 	print $iS->{mpfooter};
 }

}
sub bUa{
 	$iS->cR();
 	$iS->{gAz} = 1;
 	$iS->{tHa} = 1;
 	$iS->tGz();
 my $gJz = $abmain::gJ{kQ};
	my $imgf = $iS->bJa($gJz, "img");
	if(open IMGF, "<$imgf") {
		sVa::gYaA "Content-type: image/gif\n\n";
		binmode IMGF;
		binmode STDOUT;
		print <IMGF>;
		close IMGF;
	}else {
		abmain::oLa();
	}
}
sub bEa{
 	$iS->cR();
 	$iS->{gAz} = 1;
 	$iS->{tHa} = 1;
 	$iS->tGz();
 my $gJz = $abmain::gJ{userid} || $iS->{fTz}->{name};
 my $kQz =  $iS->{fTz}->{name};
	my $isadm=   $iS->{moders}->{$kQz} || $kQz eq $iS->{admin};
 $isadm |= $iS->yXa();
 abmain::error('deny', "Only admin can edit only member's profile") if lc($gJz) ne lc($kQz) && not $isadm;
	my $mf = $iS->gXa(lc($gJz));
	$mf->zQz($jT);
	$mf->zOz();
	$mf->aAa(\%abmain::gJ);
	$mf->dNa('userid', $gJz);
 if($iS->{filter_words}) {
 $mf->{signature} =~ s/$iS->{filter_words}/\?\?\?/ig; 
 }
 $iS->mXa(join(" ", $mf->{signature}, $mf->{realname},  $mf->{mystatement}, $mf->{company}, $mf->{address}), $mf->{realname});

 $iS->zMa($mf, $gJz);

	if($mf->{photofile}->[0]) {
		open IMGF, ">".$iS->bJa($gJz, "img");
		binmode IMGF;
		print IMGF $mf->{photofile}->[1];
		close IMGF;
	}
	sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$iS->{sAz} $iS->{other_header});
	$mf->aCa(['mp_info', "head", "Entered profile for user $gJz"]);
	$mf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
 print $mf->form(1, [split /\s+/, $iS->{mp_skipfields} ]);
	print $iS->dRz();
	print $iS->{other_footer};

}
sub nQa{
 	$iS->cR();
 	$iS->{gAz} = 1;
 	$iS->{tHa} = 1;
 	$iS->tGz();
	my $mf = new aLa('mem', \@abmain::mailer_cfgs, $jT);
 my $gJz = $abmain::gJ{kQ} || $iS->{fTz}->{name};
 my $kQz =  $iS->{fTz}->{name};
	my $isadm=   $iS->{moders}->{$kQz} || $kQz eq $iS->{admin};
 $isadm |= $iS->yXa();
	$mf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
	abmain::error('inval', "User does not have a valid email address") if (not $iS->{fTz}->{email}) && not $isadm;
	$mf->dNa('from', $iS->{fTz}->{email});
	$mf->dNa('to', $abmain::gJ{pat});
	sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$iS->{sAz} $iS->{other_header});
	$mf->sRa('pvhtml', 1);
 	print sVa::tWa();
 print $mf->form();
 print   $iS->{other_footer};
}
sub cQa{
 	$iS->cR();
	abmain::error('deny', "Form processing disabled") if not $iS->{cNa};
	abmain::error('deny', "Form originating from unauthorized page") 
		if $iS->{formreferer_match} && not $ENV{HTTP_REFERER} =~ /$iS->{formreferer_match}/; 

	if($iS->{cLa}) {
 		$iS->{gAz} = 1;
 		$iS->{tHa} = 1;
 		$iS->tGz();
	}

	my $hdr = "Received from $iS->{fTz}->{name} ". abmain::lWz(). " at ".abmain::dU();
	my $mf = new aLa('procform');
	$mf->zNz(['mf_info', "head", "$ENV{HTTP_REFERER}\n<br>$hdr"]);
	$mf->zNz(['AnyBoard User', "const", "", "AnyBoard User", "$iS->{fTz}->{name} $iS->{fTz}->{email}"]) if $iS->{fTz}->{name};
	$mf->zOz();
	$mf->zLz(\%abmain::gJ, \@abmain::lWa);
 	$iS->{_admin_only}=1 if $abmain::gJ{abf_require_admin};

	my $cPz;
	if ($iS->{cWa} && -d $iS->{cWa} ) {
		for(values %abmain::mCa) {
			$cPz = abmain::kZz($iS->{cWa}, $_->[0]);
 		abmain::error('inval', "Attempt to upload a file that exists") if -f $cPz && not $iS->{qDz};
 			open(kE, ">$cPz" ) || abmain::error('sys', $!. ": $cPz");
 			binmode kE;
 			print kE $_->[1];
 			close kE;
 			chmod 0600, $cPz if $iS->{oLz};
		}
	}
	$mf->cOa([split /\s+/, $abmain::gJ{abf_required_fields}], 1);
	my @miss = $mf->cHa();
	abmain::error("miss", "Missing:<br>".join("<br>", @miss)) if @miss;
	$mf->aCa(["abf_required_fields", "hidden", ""]);
	$mf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
	my %mail;
 	$mail{To} = $iS->{cVa};
 $mail{From} = $iS->{notifier};
 $mail{'Reply-To'} = $iS->{fTz}->{email} if $iS->{fTz}->{email};
 $mail{Cc} = $iS->{fTz}->{email} if ($iS->{fTz}->{email} &&  $abmain::gJ{abf_cc_registered_user});
 $mail{Subject} = $abmain::gJ{abf_subject} || "Form submission: $hdr";
 $mail{Body} = "$hdr\n$iS->{fTz}->{name}--- $iS->{fTz}->{email}\n\nSee attached html file for details.";

 my $cTa= $mf->form(1, [qw(abf_required_fields abf_require_admin cmd abf_subject abf_cc_registered_user)]);
 my $e = abmain::mXz(\%mail, time().".html", join("", "<html><body>",  $cTa, "<br>$ENV{HTTP_REFERER}<p></body></html>"));
 abmain::error('sys', "When sending mail: $e") if $e; 
	sVa::gYaA "Content-type: text/html\n\n";
 print $iS->{cMa};
	print "<html><body><center><h1>Thank you! $iS->{fTz}->{name}</h1>\nThe following information have been sent by email:</center><p>";
	print $cTa;
	print "<hr>$ENV{HTTP_REFERER}<p>";
	print "Sent by AnyBoard (http://netbula.com/anyboard/)\n";
 print $iS->{cPa};
	return;
}
sub lR {
 $iS->cR();
 $iS->gCz(1);
 my $name= $abmain::gJ{kQ} || $iS->{fTz}->{name};
 my $fMz= $iS->{user_init_type}||'E';
 my $ustat = $iS->{user_init_stat} || 'A';
 my $yK;
 if($abmain::gJ{cmd} eq 'xT') {
 abmain::error('deny', "Username does not match") if(lc($name) ne lc($iS->{fTz}->{name}));
 }
 if(lc($name) eq lc($iS->{fTz}->{name}) && $iS->{fTz}->{reg}){
 $yK =1;
 if($iS->{gFz}->{lc($name)}->[1] eq $abmain::gJ{email}){
 $iS->{rH} = 0;
 }
 $fMz = $iS->{gFz}->{lc($name)}->[6];
 $ustat = $iS->{gFz}->{lc($name)}->[4];
 }elsif($iS->{rH}) {
 $ustat = 'C';
 }
 if($iS->{ask_on_reg} && not $yK) {
 my $ans = $iS->{reg_answer};
 my $ans1 = $abmain::gJ{my_answer};
 $ans1 =~ s/\s+/ /g;
 $ans =~ s/\s+/ /g;
 abmain::error('inval', $iS->{inval_ans_err}) unless $ans1 =~ /$ans/i;
 }
 my $err;
 
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }

 if(length($name) > $iS->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($iS->{sO})} characters");
 }
 abmain::error('miss', "Name and Password are required") 
 unless $abmain::gJ{nC} && $name;
 if($abmain::gJ{nC} =~ /\s+/) {
 abmain::error('inval', "Password must not contain spaces");
 }
 if($abmain::gJ{nC} ne $abmain::gJ{bD}) {
 abmain::error('inval', "Passwords do not match");
 }
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }
 abmain::jJz(\$name);
 my $n_re = $iS->{forbid_names};
 if($n_re) {
 &abmain::error('inval', "The name you used is not allowed") if $name =~ /$n_re/i;
 }

 $abmain::gJ{wO}=~ s/\t/ /g;
 $abmain::gJ{wO}=~ s/\n/ /g;
 $abmain::gJ{wJ} =~ s/\t/ /g;
 $abmain::gJ{wJ} =~ s/\n/ /g;
 $abmain::gJ{xK} =~ s/\t/ /g;
 $abmain::gJ{xK} =~ s/\n/ /g;

 $iS->dJ($name, $abmain::gJ{nC}, 
 $abmain::gJ{email},  $abmain::gJ{wO}, $ustat, int rand()* time(),
 $fMz, $abmain::gJ{wJ}, $abmain::gJ{xK}, $abmain::gJ{add2notifiee}, $abmain::gJ{noshowmeonline});
 my $url = $iS->fC();
 if($iS->{rH}) {
 $jW::iG = "";
 }    
 my $uid_c = unpack("h*", $name);
 my $cook = abmain::bC($abmain::cH, abmain::nXa($name), '/', abmain::dU('pJ',24*3600*128));
 my $cVz=$abmain::gJ{qIz};
 my $msg;
 if($iS->{rH}) {
 	$msg = "Thank you, $name! An email with account activation instruction has been sent to you.";
 }else {
 if($yK) {
 		 $msg= "$name! Your registration has been modified";
 }else {
 	 $msg ="Congratulations, $name! You are now registered.";
 		 $cVz = $iS->{mp_url} || "$iS->{cgi}?@{[$abmain::cZa]}cmd=mform" if $iS->{mp_enabled};
	        $iS->pHa($name) if $iS->{post_welcome};
 }
 }
 abmain::cTz("<h1>$msg</h1>", "Register", $cVz||$iS->fC(), $cook);
}
sub oT {
 $iS->cR();
 my @jS = abmain::oCa(\@abmain::tM);
 if(not $iS->{allow_body_search}) {
 $jS[3]->[1]="fixed";
 }
 my $scat_line;
 if($iS->{allow_subcat} && $iS->{catopt}=~ /=/ ) {
	my $selmak;
	$selmak = aLa::bYa(['scat', $iS->{scat_use_radio}?'radio':'select',  join("\n", $iS->{catopt}, $iS->{hBa})]);
 my $sels = $selmak->aYa();
	$jS[2] = ['notused', 'const', '', "Message category", "", $sels];
 }else {
	$jS[2]->[1]= 'fixed';
 }

 $iS->{xWz} = 'GET';
 if($abmain::gJ{gV}) {
 $jS[3]->[0]= undef;
 $jS[5]->[5]= qq(From <input type="text" size="4" name="hIz" value="365"> days ago, to <input type="text" size="4" name="hJz" value="0"> days ago.);
 $iS->jI(\@jS, "finda", "Search for messages in archive");
 } else {
 $iS->jI(\@jS, "find", "Search for messages");
 }
}
sub gMa {
 $iS->cR();
 if($iS->{aXa}) {
	$iS->{tHa}=0;
	$iS->{gAz}=0;
 }else {
 	$iS->{tHa} = 1;
 }
 $iS->tGz();
 my $cG = $abmain::gJ{cG};
 $iS->aFz($cG, undef, 1);
 my ($aUz, $cnt, $ovis, $ofval) = split /\t/, $iS->{ratings2}->{$cG};
 if($ofval & 4) {
	abmain::error("inval", "Alert has already been sent for this message");
 }
 my $ent = $iS->pO($cG);
 $iS->{re_subject} = $ent->{wW};
 my @jS = abmain::oCa(\@abmain::gZa);
 push @jS, ["cG", "hidden", undef, undef, undef, $cG]; 
 $iS->jI(\@jS, "alertadm", "");
}
sub hVa{
 $iS->cR();
 if($iS->{aXa}) {
	$iS->{tHa}=0;
	$iS->{gAz}=0;
 }else {
 	$iS->{tHa} = 1;
 }
 $iS->tGz();
 my $cG = $abmain::gJ{cG};
 my $ent = $iS->pO($cG);
 abmain::error("inval", "Message not found") if not $ent;
 my $wW = "Alert!! $ent->{wW}";
 my $msg = "Alert sent by user ". $iS->{fTz}->{name}. "\nURL: ".
		$ent->nH($iS, -1)."\nComments:\n". $abmain::gJ{comments};
 $iS->xI($wW, $msg);
 $iS->gSa($cG, 3, 1);
 abmain::cTz("The following alert has been sent:<p>$msg", "", $iS->fC());

}
sub wEz {
 $iS->cR() if -f $iS->nCa();
 if($iS->{aXa}) {
	$iS->{tHa}=0;
	$iS->{gAz}=0;
 }else {
 	$iS->{tHa} = 1;
 }
 $iS->tGz();
 my $url = $abmain::gJ{url};
 my $wW = $abmain::gJ{wW};
 $iS->{re_subject} = $wW;
 abmain::error("deny", "Recommendation feature disabled") if $iS->{tellcnt} <=0;
 my @jS = abmain::oCa(\@abmain::hPa);
 push @jS, ["url", "hidden", undef, undef, undef, $url]; 
 push @jS, ["wW", "hidden", undef, undef, undef, $wW]; 
 $iS->jI(\@jS, "recommend", "");
}
sub xBz{
 $iS->cR() if -f $iS->nCa();
 if($iS->{aXa}) {
	$iS->{tHa}=0;
	$iS->{gAz}=0;
 }else {
 	$iS->{tHa} = 1;
 }
 $iS->tGz();
 my $url = $abmain::gJ{url};
 my $wW = $abmain::gJ{wW};
 my $comments = $abmain::gJ{mycomments};
 my $myname = $abmain::gJ{myname} || "Your friend";
 if(length($comments) > $iS->{qK}){
 &abmain::error('iK', "Message body must be less than $iS->{qK}");
 }
 my $email = $abmain::gJ{friend_email};
 my $name = $abmain::gJ{friend_name};
 my %mail;
 $mail{From} = $iS->{notifier};
 $mail{To} = $email;
 $mail{To} =~ s/,?$//;
 $mail{Subject} ="$wW";
 $mail{Body}  = "Greetings! $name:\n";
 $mail{Body} .= "$myname recommended the following page to you\n\n";
 $mail{Body} .= "$wW\nURL: $url\n\n";
 $mail{Body} .= "$myname said:\n";
 $mail{Body} .= "$comments\n\n";
 $mail{Body} .= "\n-------------------\nEmail sent by AnyBoard (http://netbula.com/anyboard/)\n";
 $mail{Body} .= abmain::bW($ENV{'REMOTE_ADDR'}); 
 $mail{Smtp}=$iS->{cQz};
 $mail{MAX_RECIP} = $iS->{tellcnt};
 &abmain::vS(%mail);
 if($abmain::wH) {
 abmain::cTz("Recommendation email failed: $abmain::wH");
 $iS->wNz(0, $iS->{fTz}->{name}."==>".$email, $iS->nDz('telllog'));
 }else {
	abmain::cTz("<h1>Recommendation e-mail sent</h1>", "Response", $url);
 $iS->wNz(1, $iS->{fTz}->{name}."==>".$email, $iS->nDz('telllog'));
 }
}
sub sQa{
 $iS->cR() if -f $iS->nCa();
 $iS->{tHa} = 1;
 $iS->{gAz} = 1;
 
 $iS->tGz();
 my $wW = $abmain::gJ{subject};
 my $message= $abmain::gJ{message};
 if(length($message) > $iS->{qK}){
 &abmain::error('iK', "Message body must be less than $iS->{qK}");
 }
 my $from = $iS->{fTz}->{email};
 abmain::error("inval", "You do not have an email on record") if not $from;
 my %mail;    
 my $to = $abmain::gJ{to};
 $iS->fZz($to);
 my $profile = $iS->{gFz}->{lc($to)};
 my $to_email =   $profile->[1];
 
 abmain::error("inval", "Recipient does not have an email on record") if not $to_email;

 $mail{From} = $from;
 $mail{Subject}= $wW;
 $mail{To} = qq("$to"<$to_email>);
 $mail{Bcc} = $from if $abmain::gJ{bccself};

 my $nb = "------ANYBOARD".time().$$;
 my @attachs=();
 my $fattach;
 for(sort keys %abmain::mCa) {
 	push @attachs, $abmain::mCa{$_} if $abmain::mCa{$_};
 }
 if(@attachs) {
 $mail{'Content-type'} = qq(multipart/mixed; boundary="$nb");
 my @marr;
 push @marr, "This is a multipart message\n";
 push @marr, "--$nb\r\n";
 	push @marr, "Content-type: text/plain\r\n\r\n";
 	push @marr, $message;
 push @marr, "\r\n--$nb";
 my $type;
 for $fattach(@attachs) {
 push @marr, "\r\n";
 	($type) = $fattach->[0] =~ /\S+\.(.*)/;
		my $disp = "attachment";
 $disp = "inline" if $fattach->[2] =~ m!(text|image)/!;
 	push @marr, "Content-type: $fattach->[2]\r\n";
 	push @marr, "Content-transfer-encoding: base64\r\n";
 	push @marr, qq(Content-disposition: $disp; filename="$fattach->[0]"\r\n\r\n);
 	push @marr, dZz::nBz($fattach->[1]);
 	push @marr, "\r\n--$nb";
 }
 	push @marr, "--\r\n";
 $mail{Message} = join('', @marr);
 }else {
 	$mail{Message} = $message;
 }
 $mail{Message} .= abmain::bW($ENV{'REMOTE_ADDR'}); 
 $mail{Smtp}=$iS->{cQz};
 &abmain::vS(%mail);
 if($abmain::wH) {
 abmain::cTz("Email failed: $abmain::wH");
 $iS->wNz(0, $iS->{fTz}->{name}."==>".$to_email, $iS->nDz('telllog'));
 }else {
	abmain::cTz("<h1>Mail sent</h1>".$iS->dRz(), "Response");
 $iS->wNz(1, $iS->{fTz}->{name}."==>".$to_email, $iS->nDz('telllog'));
 }
}
sub gTa {
 $iS->cR() if -f $iS->nCa();
 $iS->jI(\@abmain::gEa, "hMa", "");
}
sub gQa{
 $iS->cR() if -f $iS->nCa();
 abmain::error("deny") if  not abmain::eVa() ;
 my $wW = $abmain::gJ{em_subject};
 my $comments = $abmain::gJ{mycomments};
 my $myname = $abmain::gJ{myname} || "Your friend";
 my $myemail= $abmain::gJ{myemail};
 my $mailmerge= $abmain::gJ{em_merge};
 if($iS->{qK} >0 && length($comments) > $iS->{qK}){
 &abmain::error('iK', "Message body must be less than $iS->{qK}");
 }
 my $email = $abmain::gJ{em_emails};
 my %mail;
 $mail{From} = $myemail;
 $mail{To} = $email;
 $mail{To} =~ s/,?$//;
 $mail{Bcc} = $abmain::gJ{mybcc} ;
 $mail{Mlist} = scalar(abmain::hAa()) if $abmain::gJ{em_all};
 $mail{Mlist} =~ s/,?$//;
 $mail{Subject} =$wW;
 $mail{Body} = "$comments\n\n";
 #$mail{Body} .= "\n-------------------\nEmail sent by AnyBoard (http://netbula.com/anyboard/)\n";
 #$mail{Body} .= abmain::bW($ENV{'REMOTE_ADDR'}); 
 $mail{Smtp}=$iS->{cQz};
 my @errs;
 if($mailmerge) {
	$mail{to_list} = $mail{To};
	$mail{To} = undef;
	@errs = sVa::gLaA( \%mail);
 }else {
 	&abmain::vS(%mail);

 }
 if($abmain::wH) {
 abmain::cTz("Email failed: $abmain::wH");
 }else {
	abmain::cTz("<h1>Email sent</h1> Recipients:<br>$email<br>$mail{Mlist}\n@errs", "Response");
 }
}
sub vIz {
 $iS->cR();
 $iS->jI(\@abmain::tJz, "activate", "Enter validation key to activate your account");
}
sub tWz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz}=1 if $iS->{uSz};
 $iS->tGz();  
 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->zNz([cmd=>"hidden"]);
 $eveform->dNa('cmd', "tZz");
 $iS->dNaA($eveform);
}
sub wWz {
 $iS->cR();
 $iS->{_admin_only}=1 if not $iS->{lnk_usr_add};
 $iS->{gAz}=1 if $iS->{lnk_usr_must_reg};
 $iS->tGz();  
 my $selcat = aLa::bYa(['lnkcat', 'select',  $iS->{lnk_opt}]);
 $iS->jI(\@abmain::uWz, "addlnk", "");
}
sub tKz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz}=1 if $iS->{uSz};
 my @jS = abmain::oCa(\@abmain::uHz);
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);
 $eveform->zNz([cmd=>"hidden"]);
 $eveform->zNz([eveid=>"hidden"]);
 $eveform->dNa('cmd', "tTz");
 $eveform->dNa('eveid', $abmain::gJ{eveid});
 $eveform->zQz($jT);
 $eveform->aCa([eve_info=>"head", "Modify event $eveform->{eve_subject}"]);

 $iS->tGz();  
 my $name=$iS->{fTz}->{name};
 if ($name ne $eveform->{eve_author}) {
		abmain::error('deny', "Only the author can modify it")
 unless (($name eq $iS->{admin} || $iS->{moders}->{$name}));
 }
 $iS->dNaA($eveform);
}
sub tLz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->{_admin_only}=1 if not $iS->{uIz};
 $iS->{gAz} =1 if $iS->{uSz};
 my @jS = abmain::oCa(\@abmain::del_conf_cfgs);
 push @jS, ["eveid", "hidden"];
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);
 $iS->tGz();  
 my $name=$iS->{fTz}->{name};
 if ($name ne $eveform->{eve_author}) {
		abmain::error('deny', "Only the author can modify it")
 unless (($name eq $iS->{admin} || $iS->{moders}->{$name}));
 }
 $jS[0][2]="Please confirm the deletion of event: <b>$eveform->{eve_subject}</b>";
 $iS->{eveid} = $abmain::gJ{eveid};
 $iS->jI(\@jS, "tUz", "");
}
sub tSz {
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 my @jS = abmain::oCa(\@abmain::commit_cfgs);
 push @jS, ["eveid", "hidden"];
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);
 $iS->{eveid} = $abmain::gJ{eveid};
 abmain::error('inval', "This event is not set to sign up") unless $eveform->{eve_can_sign};
 $iS->jI(\@jS, "tXz", "Sign up for <b>$iS->{eve_subject}</b>");
}
sub xPz{
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{eveid} = $abmain::gJ{eveid};
 $abmain::gJ{commit_contact} =~ s!\n!<br>!g;
 $abmain::gJ{commit_contact} =~ s/</\&lt;/g;
 $abmain::gJ{commit_contact} =~ s/\t/ /g;
 $abmain::gJ{commit_comment} =~ s!\n!<br>!g;
 $abmain::gJ{commit_comment} =~ s/</\&lt;/g;
 $abmain::gJ{commit_comment} =~ s/\t/ /g;
 $bYaA->new(abmain::kZz($iS->nDz('evedir'), "$iS->{eveid}.sig"), {schema=>"AbEveSignup", paths=>$iS->zOa($iS->{eveid}) } )->iSa(
 [$iS->{fTz}->{name}, time(), $abmain::gJ{commit_contact}, $abmain::gJ{commit_comment}, $abmain::gJ{eveid}]
 );
 abmain::cTz("Thank you for signing up!");
}
sub wIz{
 $iS->cR();
 $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->{eveid} = $abmain::gJ{eveid};
 my $linesref = $bYaA->new(abmain::kZz($iS->nDz('evedir'), "$iS->{eveid}.sig"), {schema=>"AbEveSignup", paths=>$iS->zOa($iS->{eveid}) })->iQa({noerr=>1, where=>"eveid=$iS->{eveid}"} );
 my $eveform = aLa->new("eve", \@abmain::uHz);
 my $ef = abmain::kZz($iS->nDz('evedir'), "$abmain::gJ{eveid}.eve"); 
 $eveform->load($ef);

 my $i=0;
 my %signhash;
 for(@$linesref) {
 my ($n, $t, $inf, $com, $eveid) = @$_;
 $signhash{$n} = [$t, $inf, $com];
 }
 my $cnt = keys %signhash;
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eMaA( [qw(other_header other_footer)]);
 print "<html><head><title>Sign up list for $eveform->{eve_subject}</title>$iS->{sAz}$iS->{other_header}";
 print "<h2>$cnt members have signed up</h2>";
 my @ths = ($iS->{sH}, "Time", "Contact information", "Comments");
 my @rows;
 for(sort keys %signhash) {
 my $v=$signhash{$_};
 push @rows, [$_, abmain::dU('SHORT', $v->[0], 'oP'), $v->[1], $v->[2]];
 }
 print sVa::fMa(rows=>\@rows, ths=>\@ths, $iS->oVa());
 print "</table>$iS->{other_footer}";
}

 
sub  lIa {
 my($inimg, $outimg, $maxdimension) = @_;

 if( !$maxdimension) {
	$maxdimension = 80;
 }

 my $htp = dDa->new();

 my $lRa = dZz->zVz("data");
 $lRa->zNz("action", "convert");
 $lRa->zNz("width", "$maxdimension");
 $lRa->zNz("icon", undef, "image/gif", "$inimg");

#print STDERR "Conecting to iconizer: $abmain::iconizer\n";
 $htp->eNa($abmain::iconizer, 'POST', $lRa->bCa(), 'PASS');
 my $status =  $htp->{cur_status};
#print STDERR "statys $status\n";
 return if $status != 200;

 open ICONF, ">$outimg" or abmain::error('sys', "On write file $outimg: $!");
 binmode (ICONF);
 print ICONF join("", $htp->dEa());
 close ICONF;
 chmod 0644, $outimg;
 return 1;
}
sub fetch_url_old {
 my ($url, $save_to) = @_;
 my $htp = dDa->new();

 $htp->eNa($url);
 my $status =  $htp->{cur_status};
 if (2!= int($status /100)) {
 	print STDERR "http error: $url: $status\n";
	return;
 }
 my $data = join("", $htp->dEa());
 return $data if not $save_to;
 open ICONF, ">$save_to" or abmain::error('sys', "On write file $save_to: $!");
 binmode (ICONF);
 print ICONF $data;
 close ICONF;
 chmod 0644, $save_to;
 return $data;
}

sub mGa {
 my ($url, $save_to) = @_;
 eval 'require LWP::Simple';
 my $data = LWP::Simple::get($url);
 return $data if not $save_to;
 open ICONF, ">$save_to" or abmain::error('sys', "On write file $save_to: $!");
 binmode (ICONF);
 print ICONF $data;
 close ICONF;
 chmod 0644, $save_to;
 return $data;
}

sub dQaA {
 my $url = $abmain::lGa;
 if($url =~ /^https/i) {
	return;
 } 
 $url= sVa::kZz($url, "/");
 my $d = mGa($url);
 return if not $d;
 my %hv;
 for (split /\n/, $d) {
	my ($k, $v) = split /:/, $_;
	$hv{$k} = $v;
 }
 return ($hv{path_info}, $hv{path_translated});
}

sub eSaA{
 my ($pi, $pt) = dQaA();
 return if $pi ne "/";
 return 'needtop' if not -d $pt;
 return 'ok';
}
 
 
sub hK {
 $iS->cR();
 $iS->{aGz}=1;
 $iS->aQz();
 $iS->{hEz}=0;
 $iS->{iWz} = 0;
 $iS->yIz(\%abmain::gJ, qw(max_match_count iW yVz 
 hG aO mJ mAz 
					  lVz rP revlist_topic 
					  revlist_reply hEz));
 if($iS->{force_login_4read}) {
 $iS->gCz();
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Search");
 }
 $iS->{collapse_age}=0;
 $iS->kV($abmain::gJ{tK}, $abmain::gJ{gV}, $abmain::gJ{wT}, 
			$abmain::gJ{hKz}, $abmain::gJ{hIz}, $abmain::gJ{hJz}, 0, $abmain::gJ{scat});
}
sub pYa{
 my ($fsref, $fshash) = abmain::pTa();
 my @fis;
 my $mf = new aLa('idx', \@abmain::iBa, $jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'));
 my $fvp_str_save = $abmain::cZa;
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 if($abmain::no_pathinfo) {
 	$abmain::cZa = "fvp=$_->[4]";
 }else {
 	$abmain::cZa = "";
 }
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 $iS->cR();
 my $fi = $iS->lJz();
 next if $fi->{no_list} && not $abmain::gJ{all};
 $fi->{lastmsg} = $iS->nTa() if $mf->{inc_last}; 
 push @fis, $fi;
 }
 my $selmak = aLa::bYa(['fcat', 'radio',  $mf->{fcatopt}]);
 my @rows;
 my $fi;
 my $fcat;
 for $fi (sort { $a->{forum_cat} cmp $b->{forum_cat} || $a->{sort_idx} cmp $b->{sort_idx} } @fis) {
 if($fi->{forum_cat} && $fi->{forum_cat} ne $fcat) {
		$fcat = $fi->{forum_cat};
		push @rows, [$selmak->bDa($fcat)];
 }
 my $msg;
 $msg = qq(<hr width="100%" size="1" noshade>$fi->{lastmsg}) if $mf->{inc_last} && $fi->{lastmsg};
 push @rows, [$fi->{icon}||'&nbsp', abmain::cUz($fi->{fC}, $fi->{name}||"(no name)")."<br>$fi->{desc}$msg", 
 $fi->{mcnt}, $fi->{ltime}, $fi->{admin}];
 }
 my @ths = ('&nbsp', "Forum", "# Topics", "Last post", "Admin");
 @ths = jW::mJa($iS->{cfg_head_font}, @ths);
 $abmain::cZa = $fvp_str_save ;
 return sVa::fMa(rows=>\@rows, ths=>\@ths, $iS->oVa(), usebd=>$mf->{add_border});
}
sub wC {
 $iS->cR();
 $iS->{hEz}=0;
 $iS->{dyna_out}=1;
 if($iS->{force_login_4read}) {
 $iS->gCz();
 }
 $iS->yIz(\%abmain::gJ, qw(max_match_count iW yVz hG mJ rP revlist_topic revlist_reply));
 my $gV =1;
 $iS->kV($abmain::gJ{tK}, $gV, $abmain::gJ{wT}, $abmain::gJ{hKz}, $abmain::gJ{hIz}, $abmain::gJ{hJz});
}
sub sPa{
 $iS->cR();
 $iS->bI();
 my $cnt =0;
 my $eS =  $iS->nDz('msglist');
 my $topos = abmain::oTa(\@lB::mfs, 'to');
 my $mynopos = abmain::oTa(\@lB::mfs, 'fI');
 my $privfilter = sub { return ($_[0]->[$topos] ne "") ; };
 
 my $linesref = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($eS) })->iQa({noerr=>1, filter=>$privfilter});
 return if not $linesref;
 sVa::gYaA "Content-type: text/plain\n\n";
 for(@$linesref) {
	     my $cG = $_->[$mynopos];
	     my $of = $iS->fA($cG);
	     my $nf = $iS->fA($cG, 0, 1);
	     if(-f $of) {
		rename $of, $nf;
		print "Renamed: $of\n";
		$cnt ++;
	     }
 }
 print "Porcessed files: $cnt\n";
}
sub bW{   
 my ($pQ)= @_;
 my @nums = split /\./, $pQ;
 my $i = pack("C4", @nums);  
 $i = unpack("h*", $i);
 $i;
}
sub pT{
 my ($i)= @_;
 $i = pack("h*", $i);
 my @nums = unpack("C4", $i);  
 my $pQ = join('.', @nums);
 $pQ;
}
sub lWz{
 	my ($host, $honly) = @_;
 $host = $host || $ENV{REMOTE_ADDR};
 if(!$@) {	
	    	require Socket;
 	   	Socket->import( qw(PF_INET SOCK_STREAM AF_INET sockaddr_in inet_aton) );
 
 		my $addr = inet_aton($ENV{REMOTE_ADDR});
 		my $tmp = gethostbyaddr ($addr, AF_INET);
 return $tmp if $honly;
 $host .= "($tmp)" if $tmp;
 }
 return $host;
}
sub iIz {
 my $d=shift;
 my ($k, $c) = split /#/, $d;
 return $c == (unpack("%16C*", $k)%987);
}
sub vA {
 if($jW::uT ne 'adm') {
 error('deny', "This function is only accessible to chief admin ($jW::uT)");
 }
}
sub cV {
 my $pv = $abmain::gJ{btn_preview} ne "";
 $iS->cR();
 $iS->bI();
 if(scalar(abmain::mEa()) > ($abmain::kQa[5] || (1+1)) ){
 	#sVa::hCaA "Location: ", $iS->fC(), "\n\n";
	#return;
 }
 my ($old_idx, $new_idx);
 if(not $pv) {
 	$old_idx = $iS->dGz();
 	$iS->hL($iS->nCa(1)); 
 }
 $iS->mR();
 if (not $pv) {
 	$iS->hL();
 	$new_idx = $iS->dGz();
 }
 $iS->cR();
 $iS->rXz();
 $iS->aT();
 if($pv) {
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eG(\*STDOUT);
 return;
 }
 $iS->eG();
 #unlink $old_idx if($new_idx ne $old_idx && not $iS->{dDz});
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub kJz {
 abmain::error('miss', "Please check the box to confirm this operation") if not $abmain::gJ{kIz};
 $iS->cR();
 $iS->bI();
 vA();
 my $bd2 = new jW(eD=>$eD, cgi=>$jT, cgi_full=>$dLz, pL=>$pL); 
 $bd2->cR();
 $bd2->cOz($iS->nCa(1));
 my $old_idx = $iS->dGz();
 $iS->hL($iS->nCa(1)); 
 $bd2->hL();
 $iS->cR();
 my $new_idx = $iS->dGz();
 $iS->rXz();
 $iS->aT();
 $iS->eG();
 #unlink $old_idx if($new_idx ne $old_idx && not $iS->{dDz});
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub qUa {
 abmain::error('miss', "Please check the box to confirm this operation") if not $abmain::gJ{kIz};
 abmain::error('inval', "Invalid input") if not $abmain::gJ{old};
 my $pv = $abmain::gJ{preview};
 $iS->cR();
 $iS->bI();
 if(scalar(abmain::mEa()) > ($abmain::kQa[5] || (1+1)) ){
 	#sVa::hCaA "Location: ", $iS->fC(), "\n\n";
	#return;
 }
 my ($old_idx, $new_idx);
 if(not $pv) {
 	$old_idx = $iS->dGz();
 	$iS->hL($iS->nCa(1)); 
 }
 $iS->rAa($abmain::gJ{old}, $abmain::gJ{new});
 if (not $pv) {
 	$iS->hL();
 	$new_idx = $iS->dGz();
 }
 $iS->rXz();
 $iS->aT();
 if($pv) {
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eG(\*STDOUT);
 return;
 }
 $iS->eG();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub eXa{
 $iS->cR();
 $iS->bI();
 my $xO=$abmain::gJ{xO};
 my $perm = $abmain::gJ{perm};
 $xO =~ s/\.\.//g;
 my $f = abmain::kZz($iS->{eD}, $xO);
 abmain::error('inval', "File $f does exist") if  not -f $f; 
 chmod oct($perm), $f or abmain::error('inval', "$f: $!"); 
 abmain::cTz("File $f changed to $perm"); 
}

	

sub mGz{
 $iS->cR();
 $iS->bI();
 my $file = $abmain::mCa{attachment};
 &abmain::error('miss', "No file sent") if not $file->[0];
 &abmain::error('inval', "Invalid file name") if $file->[0] eq '.override' or $file->[0] eq '.cday';
 my $f = abmain::kZz($iS->{eD}, $file->[0]);
 abmain::error('inval', "File $f exists") if -f $f and not $abmain::gJ{conf_over};
 open F, ">$f";
 binmode F;
 print F $file->[1];
 close F;
 my $len = length($file->[1]);
 abmain::cTz("File ". 
 abmain::cUz($iS->lMa($file->[0]), $file->[0]). " uploaded ($len bytes)");
}
sub iI{
 $iS->cR();
 $iS->bI();
 vA();
 abmain::error('miss', "Please check the box to confirm this operation") if not $abmain::gJ{kIz};
 my $fU = $abmain::gJ{cKz};
 my $bd2 = new jW(eD=>$eD, cgi=>$jT, cgi_full=>$dLz, pL=>$pL); 
 if($fU eq "Built-in") {
 	$bd2->cNz();
 $bd2->cOz("", $abmain::gJ{cfg_sec}, 1);
 }else {
 	$bd2->cR();
	$bd2->{forum_layout}=undef;
 $bd2->cOz(abmain::cLz($fU), $abmain::gJ{cfg_sec});
 }
 $bd2->hL();
 $iS->cR();
 $iS->rXz();
 $iS->aT();
 $iS->eG();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub vSz{
 $iS->cR();
 $iS->bI();
 vA();
 my $fU = $abmain::gJ{cKz};
 my $bd2 = new jW(eD=>$eD, cgi=>$jT, cgi_full=>$dLz, pL=>$pL); 
 if($fU eq "Built-in") {
 	$bd2->cNz();
 }else {
 	$bd2->cR();
 $bd2->cOz(abmain::cLz($fU), $abmain::gJ{cfg_sec});
 }
 $bd2->rXz();
 $bd2->aT();
 sVa::gYaA "Content-type: text/html\n\n";
 $bd2->eG(\*STDOUT);
}
sub mIz{
 $iS->cR();
 $iS->bI();
 vA();
 abmain::error('miss', "Please check the box to confirm this operation") if not $abmain::gJ{kIz};
 my $fU = $abmain::gJ{mFz};
 abmain::error('iK', "Name must be less than 20 characters") if length($fU) >20;
 $fU =~ s/(^\s+|\s+$)//g;
 $fU =~ s/\s+/_/g;
 $fU =~ s/^\.+//;
 abmain::jJz(\$fU);
 my $cfgf;
 my $i=0;
 my $ocfg= $fU;
 while(1) {
 $cfgf = abmain::cLz($fU);
 if (-f $cfgf) {
 $fU = "$ocfg.$i"; $i++;
 }else {
 last;
 }
 }
 $iS->hL($cfgf, 1);
 abmain::cTz("Configuration saved to template $fU");
}
sub uR{
 $iS->cR();
 $iS->lI();
 $iS->iMz($iS->{admin}, $iS->{eF}->{mS}, $iS->{admin_email}, 1);
 $iS->hL();
 sVa::hCaA "Location: ", $iS->{cgi_full}, "?@{[$abmain::cZa]}cmd=log", "\n\n";
}
sub uU{
 $iS->cR();
 $iS->jMz();
 $iS->hL();
 sVa::hCaA "Location: ", $iS->{cgi_full}, "?@{[$abmain::cZa]}cmd=log", "\n\n";
}
sub iKz {
 $iS->cR();
 $iS->bI();
 abmain::jJz(\$abmain::gJ{mod_name});
 abmain::error('miss', "No moderator name supplied") if not $abmain::gJ{mod_name};
 $iS->iKz($abmain::gJ{mod_name});
 abmain::cTz("<h1>One moderator added</h1>");
};
sub wSz {
 $iS->cR();
 $iS->bI();
 $iS->iLz($abmain::gJ{mod_name});
 abmain::cTz("<h1>One moderator deleted</h1>");
};
sub dP{
 $iS->cR();
 $iS->bI();
 my $cnt = $iS->dP($abmain::gJ{gJz}, $abmain::gJ{qD});
 abmain::cTz("<h1>$cnt records deleted for @{[$abmain::gJ{gJz}]}</h1>");

}
sub tH{
 $iS->cR();
 $iS->bI();
 my $cnt = $iS->qF($abmain::gJ{pat}, $abmain::gJ{hIz}, $abmain::gJ{hJz},0, $abmain::gJ{fMz}, $abmain::gJ{ustat}, $abmain::gJ{innoti});

}
sub kLz{
 $iS->cR();
 $iS->{gAz}=1;
 $iS->{tHa}=1;
 $iS->tGz();
 my $cnt = $iS->qF($abmain::gJ{pat}, $abmain::gJ{hIz}, $abmain::gJ{hJz}, $abmain::gJ{regmatch}?2:1);
}
sub hXz{
 $iS->cR();
 $iS->bI();
 $iS->{gRa}= $abmain::gJ{vcardrecip} if $abmain::gJ{vcardrecip} =~ /@/;;
 my $em = $iS->hWz($abmain::gJ{pat}, $abmain::gJ{full}, $abmain::gJ{valid}, $abmain::gJ{hIz}, $abmain::gJ{hJz}, $abmain::gJ{innoti});
 abmain::cTz(qq(<form><textarea cols="70" rows="24" wrap="soft">$em</textarea></form><p><a href="mailto:$em">$em</a>), "Email list");
 abmain::iUz();

}
sub iJz{
 $iS->cR();
 $iS->bI();
 $iS->iJz("It works!");
 abmain::iUz();
}
sub yTa{
 $iS->cR();
 my $auto =0;
 if($abmain::gJ{auto} == 1) {
	$auto =1;
		
 }else {
 	$iS->bI();
 }
 $iS->yTa($auto);
 abmain::iUz();
}

sub nU {
 if($abmain::gJ{cO}) {
	$iS->{_verbose}=1;
	local $| =1;
	sVa::gYaA "Content-type: text/html\n\n";
	print "<html><body><pre>";
 }
 $iS->nU($abmain::gJ{cO}, $abmain::gJ{hIz},
 $abmain::gJ{hJz}, $abmain::gJ{zA});
 if($iS->{_verbose}) {
	print "</pre>";
 	print $iS->dRz(), "</body></html>";
 }else{
	sleep(1);
 	sVa::hCaA "Location: ", $iS->fC(), "\n\n";
 }
 abmain::iUz();
};

sub yKa{
 $iS->cR();
 $iS->yFa($abmain::gJ{formid}, $abmain::gJ{cG});
 abmain::iUz();
}
sub cHz {
 $iS->cR();
 $iS->bI();
 $iS->cBz();
 $iS->rXz();
 $iS->aT();
 $iS->eG();
 sleep(1);
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
};
sub nMz {
 $iS->cR();
 $iS->bI();
 my $e = $iS->nMz($abmain::gJ{which} eq 'arch', $abmain::gJ{rmne});
 sleep(1);
 $e ||= "No errors found!";
 abmain::cTz("<pre>\n$e\n</pre>", "Validation results");
};
sub jKz{
 if(not $abmain::gJ{custom}) {
	hBaA() ;
 }else {
	gZaA() ;
 }
}

sub gZaA{
 $iS->cR();
 $iS->bI();

 chdir $iS->{eD} or abmain::error('sys', "Can not cd to $iS->{eD} : $!");
 my $cmd = $abmain::zip_command. " polls postdata .fYz .msglist .archlist data.txt .forum_cfg .rat uploads events links* archive*";
 open F, "$cmd |" or abmain::error('sys', "Fail to run command $cmd: $!");
 binmode F;
 binmode STDOUT;
 sVa::gYaA "Content-type: application/zip\n\n";
 my $buf;
 while(sysread F, $buf, 4096*4) { syswrite (STDOUT, $buf, length($buf), 0); }
 abmain::iUz();
}
sub hBaA{
 $iS->cR();
 $iS->bI();

 binmode STDOUT;
 sVa::gYaA "Content-type: application/tar\n";
 print "Content-Disposition: attachment; filename=forumbackup.tar\n\n";
 $|=1;
 my $ds = 3600*24;
 my $td = time();
 my ($gDz, $et);
 if($abmain::gJ{sday}) {
	$gDz = $td - $abmain::gJ{sday} * $ds;
 }
 if($abmain::gJ{eday}) {
	$et = $td - $abmain::gJ{eday} * $ds;
 }
 sVa::fMaA($iS->{eD}, \*STDOUT, $gDz, $et);
 abmain::iUz();
}
sub cAa{
 $iS->cR();
 $iS->bI();
 my $cnt = $iS->bKa($abmain::gJ{fMz});
 abmain::cTz("$cnt users modified");
 abmain::iUz();
}
sub xTz{
 $iS->cR();
 $iS->bI();
 $iS->wZz();
 abmain::iUz();
}
sub vRz{
 $iS->cR();
 $iS->bI();
 my $cnt = $iS->vRz(split (/^/m, $abmain::mCa{ulistfile}->[1]));
 abmain::cTz("$cnt users imported");
 abmain::iUz();
}
sub tMz {
 $iS->cR();
 $iS->vYz();
}
sub uAz {
 $iS->cR();
 $iS->vOz();
}
sub tVz {
 $iS->cR();
#    $iS->{tHa} = 1;
 $iS->tGz();  
 $iS->tPz($abmain::gJ{sstamp}, $abmain::gJ{mode});
}
sub wMz {
 $iS->cR();
 my $lidx = $iS->nDz('links');
 my $lhtml = abmain::kZz($iS->{eD}, $iS->{links_file});
 if((stat($lidx))[9] > (stat($lhtml))[9] || (time() - (stat($lhtml))[9] >60) || (stat($lhtml))[9] > (stat($iS->nCa()))[9]|| not -f $lhtml) {
 	open EIDX2, ">".abmain::kZz($iS->{eD}, $iS->{links_file}) or abmain::error('sys', "On open file: $!");
 	$iS->wBz(\*EIDX2, $iS->{lnk_show_adm});
 	close EIDX2;
 }   
 if($abmain::gJ{adm}){
 	   $iS->{tHa} = 1;
 	   $iS->{_admin_only}=1 if not $iS->{lnk_usr_add};
 $iS->{gAz} =1 if $iS->{lnk_usr_must_reg};
 	   $iS->tGz();  	
 sVa::gYaA "Content-type: text/html\n\n";
	   $iS->wBz(\*STDOUT, 1);

 }else{
 	sVa::hCaA "Location: ", $iS->lMa($iS->{links_file}), "\n\n";
 }
}
sub vXz {
 my $gV = $abmain::gJ{gV};
 my $kQz = $abmain::gJ{kQz};
 $iS->cR();
 if($iS->{aWz}) {
 	$iS->{aGz}=1;
 	$iS->{aIz}=0;
 $iS->aQz();
 }
 if($abmain::gJ{personalize}) {
 	$iS->yIz(\%abmain::gJ, qw(max_match_count iW yVz 
 hG aO mJ mAz 
					  align_col_new
					  lVz rP revlist_topic 
					  revlist_reply hEz));
 }

 my ($lfile, $pgf, $nA, $cVz, $pgno, $ofpage);
 $pgno = $abmain::gJ{pgno} || 0; 
 my $t = $abmain::gJ{t};

 if($pgno<0 && $pgno ne 'A') {
	$iS->{hEz}=0;
	if($pgno == -9999) {
		$iS->kV(undef, $gV, 0, 0, undef, 0);
	}else {
		$iS->kV(undef, $gV, 0, 0, -$pgno, 0);
	}
 return;
 }
 if($kQz || $abmain::gJ{personalize} || $iS->{allow_user_view}) {
 $iS->gCz() if $kQz;
 abmain::error('deny', "$iS->{fTz}->{name} is not $kQz") if ($kQz && $kQz ne $iS->{fTz}->{name});
 if($iS->{allow_user_view} ) {
 	 my $mf=$iS->gXa($abmain::ab_id0);
	 $iS->yIz($mf, qw(hG yVz revlist_topic revlist_reply align_col_new iW)); 
 }
 if($kQz ne "") {
 	 $iS->{kUz} = $kQz;
 	 $iS->{hEz} = 0; 
 }
 $iS->aFz();
 my $ret = $iS->aT($pgno, $lfile, 0, 0, $kQz); 
 $iS->gNa($kQz) if $kQz ne '';
 sVa::gYaA "Content-type: text/html\n\n";
 my $od = $iS->{dyna_forum}; 
 $iS->{dyna_forum} = 1; 
 $iS->eG(\*STDOUT, 1, $gV);
 $iS->{dyna_forum} = $od; 
 return;
 }

 $ofpage= $abmain::gJ{ofpage}; 
 if ($ofpage  eq 'A') {
 	$ofpage = $pgno;
	$pgno = 'A';
 }
 $lfile = $gV? $iS->nDz('archlist'): $iS->nDz('msglist');
 $pgf = $gV? $iS->kBz($pgno, $ofpage) : $iS->jWz($pgno, $ofpage);
 $cVz = $gV? $iS->kCz($pgno, $ofpage): $iS->hFz($pgno, $ofpage);
 $cVz .="#$t" if $t;

 $iS->oF(LOCK_EX, 101);
 my $ft = (stat($pgf))[9] || -1;
 my $regen_chk = sub { ($abmain::use_sql && time() - $ft > 10) || $ft < (stat($lfile))[9] 
				|| $ft <(stat($iS->nCa()))[9]  || $abmain::gJ{vDz}};

 if(&$regen_chk) {
 if($ofpage ne "") {
		$pgno = $ofpage;
 		$iS->{hG} = 1;
 }
 my $ret = $iS->aT($pgno, $lfile, 0, 0, $kQz); 
 if(not $ret) {
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
 }
 $iS->{iAa} = $regen_chk;
 	open TMPFIL, ">$pgf" or abmain::error('sys', "Fail to open file $pgf: $!");
 	$nA = \*TMPFIL;
 	$iS->eG($nA, 1, $gV);
 close TMPFIL;
 }
 $iS->pG(101);
 if($abmain::off_webroot || $iS->{dyna_forum} || $iS->{mFa}) {
	$iS->iFa($pgf);
 }else {
 	sVa::hCaA "Location: ", $cVz, "\n\n";
 }
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "ViewPage");
}
sub iXz{
 my $gV = $abmain::gJ{gV};
 my $inline = $abmain::gJ{aO};
 $iS->cR();
 if($iS->{aWz}) {
 	$iS->{aGz}=1;
 	$iS->{aIz}=0;
 $iS->aQz();
 }

 $iS->yIz(\%abmain::gJ, qw(hG aO mJ mAz iWz lVz rP));

 my ($lfile, $iZz, $aK, $jBz);

 $aK = $abmain::gJ{aK}; 
 $iZz = $abmain::gJ{iZz}; 
 $lfile = $gV? $iS->nDz('archlist'): $iS->nDz('msglist');
 my $e = $iS->pO($aK, $lfile, 1);
 $iS->{collapse_age} = 0;
 
 my $jCz = new lB; 
 push @{$jCz->{bE}}, $iS->{dA}->{$aK};
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head><title>where</title>$iS->{sAz}$iS->{other_header});
 
 print "\n", $iS->yHz($gV), "\n" if $iS->{ySz};
 $iS->{fDz} = 'undef';
 my $cmdbar = $iS->bHa(1, $gV, 1);
 print qq(<div class="ABMSGAREA">);
 print "\n$cmdbar\n";
 $jCz->jN(iS=>$iS, nA=>\*STDOUT, jK=>($inline?0:-1), hO=>0, gV=>$gV, iZz=>$iZz, 
		jAz=>($inline?0:1), kQz=>$abmain::gJ{kQz}, pub=>($jCz->{to} eq "")?'p':'v');
 print qq#<P><hr width="$iS->{cYz}"><p>@{[$iS->dRz($gV)]}#;
 print '&nbsp;' x 5;
 print qq@<a href="javascript:history.go(-1)">$iS->{back_word}</a></div>$iS->{other_footer}@;

};
sub xW {
 $iS->cR();
 sVa::hCaA "Location: ", $iS->fC(), "\n\n";
}
sub bJ {
 $iS->cR();
 $iS->bI();
 $iS->{aO}=0;
 $iS->{bMz}=0;
 $iS->{force_login_4read}=0;
 if($iS->{aWz}) {
 	$iS->{aGz}=1;
 	$iS->{aIz}=1;
 $iS->aQz();
 }
 $iS->{hEz}=0;
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->tS("gQ", $abmain::gJ{sCz}, $abmain::gJ{darch});
};
sub wE {
 $iS->cR();
 $iS->bI();
 if($iS->{aWz}) {
 	$iS->{aGz}=1;
 	$iS->{aIz}=0;
 $iS->aQz();
 }
 $iS->{hEz}=0;
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->tS("arch", $abmain::gJ{sCz}?2:0);
}
sub aHz {
 $iS->cR();
 $iS->bI();
 if($iS->{aWz}) {
 	$iS->{aGz}=0;
 	$iS->{aIz}=1;
 $iS->aQz();
 }
 $iS->{hEz}=0;
 sVa::gYaA "Content-type: text/html\n\n";
 $iS->{_doing_moder} =1;
 $iS->{dyna_forum} =1;
 $iS->tS("moder");
}
sub qAa{
 my %arghash = @_;
 my ($cols, $list, $usebd, $wd, $tba, $trafunc, $tcafunc, $th, $tha) = @arghash{qw(ncol vals usebd width tba trafunc tcafunc th tha)};
 my $str;
 my $cnt = @$list;
 if($cols ==0) {
 $str= join("<br>\n\n", $th, @$list);
 } else {
	 my $w; $w = "width=$wd" if $wd;
	 $str = qq(<table border="0" cellpadding=0 cellspacing=0 $w bgcolor="#000000" class="listouter"><tr><td>\n) if $usebd;
	 my $wid = $usebd? " width=100%": " width=$wd";
	 $str .= qq(<table $tba $wid class="listin">\n);
	 if($th){ 
		 $str .= "<tr><th $tha colspan=$cols>$th</th></tr>\n";
 	}
 	my $rcnt =0;    
 	my @cola;
 	my $tra; $tra = " ". &$trafunc($rcnt) if $trafunc;
 	$str .="<tr$tra>\n";
 	for(my $i=0; $i<$cnt; ) {
 		for(my $j=0; $j< $cols; $j++, $i++ ) {
 			my $v = $i<$cnt? $list->[$i]: "&nbsp;";
 			push @{$cola[$j]}, $v;
 		}
 	}
 	$str.=qq(<td valign=top class="listintd">);
 	$str.=join(qq(</td><td valign=top class="listintd">), map {join("<br>", @$_) } @cola);
 	$str .="</td></tr>\n";
 	$str .= "</table>\n";
 	$str .= "</td></tr></table>\n" if $usebd;
 }
 return $str;
}
sub fMa{
 my %arghash = @_;
 my ($rows, $colsel, $usebd, $wd, $tba, $trafunc, $tcafunc, $ths, $thafunc, $thfont) = @arghash{qw(rows colsel usebd width tba trafunc tcafunc ths thafunc thfont)}; 
 my $str;
 $str =qq(<table border="0" cellpadding=0 cellspacing=0 width=$wd bgcolor="#000000" align="center"><tr><td>\n) if $usebd;
 my $wid = $usebd? " width=100%": " width=$wd";
 my $ncol = 0;
 for(@$rows) {
	$ncol = scalar(@$_) if scalar(@$_) > $ncol;
 } 
 $colsel = [0..$ncol-1] if not $colsel;
 $str .= qq(<table class="rowstab" align="center" $tba$wid>\n);
 if($ths){ 
 my $col=0;
 $str .="<tr>";
 for(@$colsel) {
 my $tha; $tha = &$thafunc($col, $ncol) if $thafunc;
	      if($thfont) {
 	$str .= "<td $tha><b><font $thfont>$ths->[$_]</font></b></td>\n";
	      }else {
 	$str .= "<td $tha><b>$ths->[$_]</b></td>\n";
	      }
 $col ++;
 }
 $str .="</tr>";
 }
 $ncol = @$colsel if $ncol > @$colsel;
 my $rcnt =0;    
 my $row;
 for $row (@$rows) {
 my $tra; $tra = &$trafunc($rcnt) if $trafunc;
 $str .="<tr $tra>\n";
 my $j=0;
		  
 if(@$row == 1 && $ncol>1) {
 		my $tha; $tha = &$thafunc(0, 0) if $thafunc;
			$str .=qq(<td $tha colspan="$ncol"><font $thfont>).$row->[0].qq(</font></td></tr>);
			next;
 }
 for(@$colsel) {
 my $v = $row->[$_] || "&nbsp;";
 my $tca; $tca = &$tcafunc($rcnt, $j) if $tcafunc;
 $str .=qq(<td class="rtabtd" $tca> $v </td>\n);
 $j++;
 }
 $str .="</tr>\n";
 $rcnt++;
 }
 $str .= "</table>\n";
 $str .= "</td></tr></table>\n" if $usebd;
 return $str;
}
sub fNa{
 $iS->cR();
 my $tt= $iS->fQa();
 if($abmain::gJ{js}) {
 	sVa::gYaA "Content-type: application/x-javascript\n\n";
 	print abmain::rLz($tt);
 }else {
 	sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 	print qq(<html><head><title>Tags</title>$iS->{sAz}$iS->{other_header});
 	print $tt;
 	print $iS->{other_footer};
 }
}
sub bRa{
 my $uf; $uf = abmain::wTz('onlineusr') if $abmain::gJ{all};
 $iS->cR() if -f $iS->nCa();
 my $where = $abmain::gJ{where};
 my ($ul, $ths)= $iS->fTa($where, $uf);
 my $colsel = [0,1];
 my $code;
 my $cols = $abmain::gJ{cols};
 if($where) { #
 if($cols) {
 $code = abmain::qAa(ncol=>$cols, tba=>"cellpadding=3 cellspacing=1", vals=>[map {$_->[0]} @$ul ] );
 }else {
 $colsel = [0]; 
 $code =  sVa::fMa(rows=>$ul, ths=>$ths, $iS->oVa(), colsel=>$colsel); 
 }
 }else {
 $colsel = [0, 1, 2, 4] if  $abmain::gJ{verbose};
 $code =  sVa::fMa(rows=>$ul, ths=>$ths, $iS->oVa(), colsel=>$colsel); 
 }
 if($abmain::gJ{js}) {
 	sVa::gYaA "Content-type: application/x-javascript\n\n";
 	print abmain::rLz($code);
 }else {
 	sVa::gYaA "Content-type: text/html\n\n";
 if($abmain::gJ{from} ne 'Forum') {
 	my $ubg = $iS->{chat_usr_bg};
 		print qq(<html><head><title>Online Users</title></head><body bgcolor="$ubg">);
	}else {
 		$iS->eMaA( [qw(other_header other_footer)]);
 		print qq(<html><head><title>Tags</title>$iS->{sAz}$iS->{other_header});
 }
 	print $code;
 if($abmain::gJ{refresh} >0) {
 	print qq!<script>setTimeout("location.reload()", $abmain::gJ{refresh}*1000);</script>!;
 }
 if($abmain::gJ{from} ne 'Forum') {
 	print "</body></html>";
	}else {
 		print $iS->{other_footer};
	}
 }
 $iS->gCz(1);
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||'???', $abmain::gJ{from}) if $abmain::gJ{from};
}
sub gIaA{
 my $cf = abmain::wTz('leadcache')."_sv";;
 my $tt;

 if( (not -f $cf) || (stat($cf))[9] < time() - 1800) {
 my $lck = jPa->new($cf, jPa::LOCK_EX());
 if((not -f $cf) || (stat($cf))[9] < time() - 360) {
	      	abmain::hYa(); 
 		$tt= abmain::fKa(1);
		open F, ">$cf";
		print F $tt;
		close F;
	}
 }
 open F, "<$cf";
 local $/=undef;
 $tt = <F>;
 close F;
 return $tt;
}

sub fLa{
 my $cf = abmain::wTz('leadcache');
 my $tt;
 if((-f $cf && (stat($cf))[9] > time() - 240) && not $abmain::gJ{force}) {
	open F, "<$cf";
	local $/=undef;
	$tt = <F>;
	close F;
 }else { 
 abmain::hYa(); 
 	$tt= abmain::fKa();
	open F, ">$cf";
	print F $tt;
	close F;
 }
 my $mf = new aLa('idx', \@abmain::iBa, $jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'));
 if($abmain::gJ{js}) {
 	sVa::gYaA "Content-type: application/x-javascript\n\n";
 	print abmain::rLz($tt);
 }else {
 $iS->eYaA();
 	sVa::gYaA "Content-type: text/html\n\n";
 print jW::mTa($mf->{lead_header}, \@jW::org_info_tags, $iS->{_org_info_hash});
 	print $tt;
 print jW::mTa($mf->{lead_footer}, \@jW::org_info_tags, $iS->{_org_info_hash});
 }
}
sub oSa{
 $iS->cR();
 my ($is_root, $root) = abmain::eVa() ;
 unless ($is_root) {
	$iS->gCz();
	my $uname = $iS->{fTz}->{name};
	my $isadm=   $iS->{moders}->{$uname} || $uname eq $iS->{admin};
 $isadm |= $iS->yXa();
	abmain::error('deny') if not $isadm;
 }
 $iS->gOa($abmain::gJ{track}||$abmain::gJ{hC}, $is_root);
 abmain::cTz("Blocked ".$abmain::gJ{track}||$abmain::gJ{hC});
}
sub oFa {
 my $non_root = shift;
 $iS->cR();
 my ($is_root, $root) = abmain::eVa() ;
 my $isadm;
 unless ($is_root) {
	$iS->gCz();
	my $uname = $iS->{fTz}->{name};
	$isadm=   $iS->{moders}->{$uname} || $uname eq $iS->{admin};
 $isadm |= $iS->yXa();
	abmain::error('deny') if not $isadm;
 }
 abmain::error("deny") if  not ($is_root || $non_root || ($isadm && ($abmain::forum_admin_roll || $abmain::gJ{newscat} eq $iS->pJa() ) ));
 $iS->oFa($abmain::gJ{subject}, $abmain::gJ{cG}, $abmain::gJ{aK}, $abmain::gJ{newscat});
 my $str = jDa(10,0,1, "", $abmain::gJ{newscat});
 abmain::cTz("$str", "Message added");
}
sub mKa {
 my $non_root = shift;
 my ($is_root, $root) = abmain::eVa() ;
 my $isadm;
 unless ($is_root) {
	$iS->gCz();
	my $uname = $iS->{fTz}->{name};
	$isadm=   $iS->{moders}->{$uname} || $uname eq $iS->{admin};
	abmain::error('deny') if not $isadm;
 }
 abmain::error("deny") if  not ($is_root || $non_root || ($isadm && ($abmain::forum_admin_roll || $abmain::gJ{newscat} eq $iS->pJa() ) ));
 my $nf = abmain::wTz('news').$abmain::gJ{newscat};
 $abmain::gJ{newsurl} =~ s/\s+//g;
 my $cnt = $bYaA->new($nf, {jMa=>1, index=>1, schema=>"AbNewsIndex"} )->jLa([$abmain::gJ{newsurl}]);
 my $str = jDa(10,0,1, "", $abmain::gJ{newscat});
 abmain::fXaA();
 #abmain::cTz("$cnt messages deleted", "$cnt message deleted");
}
sub xNa{
 sVa::gYaA "Content-type: application/x-javascript\n\n";
 my $cVaA = ($abmain::agent =~ /MSIE\s*(5|6)/i);
 print sVa::xPa($abmain::gJ{xZa}) if ($cVaA && $ENV{HTTP_REFERER}=~/anyboard/);
}
sub oJa{
 my $ncol = $abmain::gJ{col};
 my $ncnt = $abmain::gJ{max};
 my $jmp  =$abmain::gJ{jmp};
 my $cat  =$abmain::gJ{cat};
 my $dyn  =$abmain::gJ{dyn};
 sVa::gYaA "Content-type: application/x-javascript\n\n";
 my $nf = abmain::wTz('news').$cat;
 my $jf = abmain::wTz('newsjs').$cat;
 my $str;
 if( $dyn || (not -f $jf) || (stat($nf))[9] > (stat($jf))[9]  || (stat($nf))[9]< time()- 600) {
 	$str = jDa($ncnt, $ncol, $jmp, $abmain::gJ{tgt}, $cat);
	if($dyn) {
 		print rLz($str);
		return;
	}
	open FX, ">$jf" or print "document.write('$!')";
 	print FX rLz($str);
 close FX;
 }
 open FX, "<$jf";
 print <FX>;
 close FX;
}
sub jDa{
 my ($ncnt, $ncol, $jmp, $tgt, $cat) = @_;
 my $mf = aLa->new('idx', \@abmain::iBa, $jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'),1);
 my $f = abmain::wTz('news').$cat;
 my $linesref = $bYaA->new($f, {index=>1, schema=>"AbNewsIndex"})->iQa({noerr=>1});
 my @links;
 my $cnt;
 my %icons= sVa::gBaA($mf->{newsiconopt});
 $cat = "__null__" if $cat eq "";
 my $ico = $icons{$cat};
 while($_ = pop @$linesref) {
	my ($wW, $url, $eD, $name, $burl, $cG, $fvp, $atime) = @$_; 
	if($jmp) {
		$url = $burl if $burl;
 } 
	push @links, $ico." ".abmain::cUz($url, $wW, $tgt);
 $cnt ++;
 last if $cnt >= $ncnt;
 }
 return if not scalar(@links);
 return qAa(ncol=>$ncol, tba=>$mf->{newstabattr}, vals=>\@links);
}
sub fXaA{
 my ($ncnt, $cat) = @_;
 my $mf = aLa->new('idx', \@abmain::iBa, $jT);
 $mf->zOz();
 $mf->load(abmain::wTz('leadcfg'));
 my %cats = sVa::gBaA($mf->{newscatopt});
 my %icons= sVa::gBaA($mf->{newsiconopt});

 my $f = abmain::wTz('news');

 my @rows;
 for my $k (sort keys %cats) {
 my $rk = $k;	
	$rk = "" if $k eq '__null__';
	my $newjs = $abmain::dLz."?cmd=newsjs;cat=$rk";
	push @rows, [$cats{$k}."<br>( $newjs )"];

 	my $linesref = $bYaA->new($f.$rk, {index=>1, schema=>"AbNewsIndex"})->iQa({noerr=>1});
 	my @links;
 	my $cnt;
 	while($_ = pop @$linesref) {
		my ($wW, $url, $eD, $name, $burl, $cG, $fvp, $atime) = @$_; 
		my $lnk =  abmain::cUz($url, $wW, $tgt);
		my $delbtn = qq(<form action="$abmain::jT">
				<input type="hidden" name="newscat" value="$rk">
				<input type="hidden" name="newsurl" value="$url">
				<input type="hidden" name="cmd" value="delnews">
				<input type="submit" value="Delete"></form>);
		push @rows, [$icons{$k}." ".$lnk, $delbtn];
 	}
 }
 sVa::gYaA "Content-type: text/html\n\n";
 my $h;
 ($h, $f) = abmain::nOa();
 print $h;
 print sVa::fMa(ths=>["Subject", "Command"], rows=>\@rows, $iS->oVa());
 print $f;
}

sub lHa {
	$iS->lHa($abmain::gJ{img});
}
sub fPa {
	$iS->cR();
 	$iS->bI();
	my $bd2 = new jW(eD=>$abmain::gJ{dir});
	$iS->fPa($bd2, $abmain::gJ{thr}, $abmain::gJ{keepdate}, $abmain::gJ{scat});
 abmain::cTz("Thread copied","Result");
}
sub mL {
 $iS->cR();
 $iS->bI();
 $iS->aQz();
 $iS->{aGz} = 1;
 $iS->{aIz} = 1;
 my @fJ = split '\0', $abmain::gJ{fJ};
 my $e;
 $iS->{_show_prog} =1;
 local $| = 1; 
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 
 if(!$abmain::gJ{fromarch}) {
 if($abmain::gJ{by} eq 'fI') {
 	$e = $iS->qNa(\@fJ, $abmain::gJ{thread}, 0, $abmain::gJ{gLz}, $abmain::gJ{backup});
 }else {
 	$e = $iS->aQ($abmain::gJ{by}, \@fJ, $abmain::gJ{thread}, 0, $abmain::gJ{gLz}, $abmain::gJ{backup});
 }
 	$iS->aQz();
 	for(@{$iS->{just_deleted}}) {
 		delete $iS->{aLz}->{$_};
 	}
 	$iS->aVz();
 	$iS->{aIz} = 0;
 	$iS->aT();
 	$iS->eG();
 	my $fC=$iS->fC();
 }else {
 $e = $iS->iNa($abmain::gJ{by}, \@fJ, 0, $abmain::gJ{gLz});
 }
 print "<pre>\n$e\n</pre>";

 #abmain::cTz("<pre>\n$e\n</pre>","Deletion results");
};
sub aDz {
 $iS->cR();
 $iS->bI();
 $iS->aQz();
 my $action = $abmain::gJ{submit};
 if($action eq "Delete" &&  not $abmain::gJ{confdel}) {
 abmain::error("inval", "Please check the box the confirm deletion operation");
 }
 my @fJ= split '\0', $abmain::gJ{fJ};
 if($action eq "Delete") {
 	$iS->{aGz} = 1;
 	$iS->{aIz} = 1;
 my $e;
 if($abmain::gJ{by} ne 'fI') {
 		$e =$iS->aQ($abmain::gJ{by}, \@fJ, $abmain::gJ{thread}, 0, 1);
	}else {
 		$e =$iS->qNa(\@fJ, $abmain::gJ{thread}, 0, 1);
	}
 abmain::cTz("<pre>$e</pre>");
 return;
 }

 my @tnos;
 for(@fJ) {
 next if not $_;
	 my ($cG, $aK) = split /\s+/, $_;
 $iS->{aLz}->{$cG}=1;
	 push @tnos, $aK;
 }
 $iS->aVz();
 $iS->{aGz} = 1;
 $iS->{aIz} = 0;
 $iS->aT('A');
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body><pre>";
 for(@fJ) {
 next if not $_;
	 my ($cG, $aK) = split /\s+/, $_;
 $iS->bT($cG);
	 print "Approved message $cG\n";
 }
 print "</pre></body></html>";
 $iS->nU();
}
sub vE{
 $iS->cR();
 $iS->bI();
 $iS->{aGz} = 1;
 $iS->{aIz} = 0;
 $iS->aQz();
 my @fJ= split '\0', $abmain::gJ{fJ};
 my $e;
 $iS->{_show_prog} =1;
 local $| = 1; 
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";

 if($abmain::gJ{by} eq 'fI') {
 	$e =$iS->qNa(\@fJ, $abmain::gJ{thread}, 'A'); 
 }else {
 	$e =$iS->aQ($abmain::gJ{by}, \@fJ, $abmain::gJ{thread}, 'A'); 
 }
 $iS->aT();
 $iS->eG();

 print "<pre>\n$e\n</pre>";
#x1
};
sub jL {
 $iS->cR(undef, 1);
 if($iS->{force_login_4read} || $abmain::gJ{p}) {
 $iS->tGz();
 }
 if($iS->{qKa}) {
 $iS->tGz(1);
 }
 my ($cG, $aK, $arch, $entry);
 if($abmain::gJ{v} == 2) {
 ($cG, $aK) = (pack("h*", $abmain::gJ{cG}), pack("H*", $abmain::gJ{zu}));
 }else {
 ($cG, $aK) = ($abmain::gJ{cG}, $abmain::gJ{zu});
 }
 $entry = lB->new($aK,0, $cG);

 $arch = $abmain::gJ{gV};

 if($abmain::gJ{xml} && not $arch) {
	$entry->load($iS);
	sVa::gYaA "Content-type: text/plain\n\n";
	print dZz::hash2XML($entry, "message", [@lB::mfs, @lB::mfs2]);
	return;
 }
 if($abmain::gJ{domod} && not $arch) {
	$iS->nEa($cG);
	return;

 }
 my  $name = lc($iS->{fTz}->{name});
 if($abmain::gJ{p}) {
	$entry->load($iS);
	if (not (lc($name) eq lc($entry->{hC}) || jW::sFa($entry->{to}, $name))) {
		my $wD = $iS->eEaA($entry->{fI});
		abmain::error('deny', "$name, you are not in recipient list") 
		 if (not  jW::sFa($wD, $name) );
	}
 $iS->cOaA($entry->{fI}, $name, {read_time=>time()});
 }
 
 $iS->aFz($cG, undef, 1) if $arch != 1;
 my @arr = split /\t/, $iS->{ratings2}->{$cG};

 if(not $iS->{redir_onread}) {
 	my $aD = $iS->fA(($arch || $iS->{lJ})?$aK:$cG, $arch==1, $abmain::gJ{p});
	$iS->iFa($aD, $abmain::gJ{p}, $arr[5]);
 }else {
 	sVa::hCaA "Location: ", $entry->nH($iS, -1, $arch, 0, 1, $abmain::gJ{p}), "\n\n";
 }
 abmain::jJz(\$name);
 my $rdss;
 my $vcnt = $arr[2];
 $vcnt ++;
 if($arch != 1) {
	my $i=0;
	for(;$i<3; $i++){
		$arr[$i] = 0 if not defined($arr[$i]);
	}
	for(;$i<6; $i++){
		$arr[$i] = undef if not defined($arr[$i]);
	}
 	$arr[2] ++;
 if($abmain::gJ{p} && $name) {
 	my @rds = split /,/, $arr[5];
		my %rdh;
		for(@rds) { $rdh{$_} =1; }
		$rdh{$name} = 2 if not $rdh{$name};
	        $rdss = $arr[5] = join (",", keys %rdh);	
		if($rdh{$name} == 2) {
			my $to = $entry->{email};
			if(not $to) {
 			$iS->fZz($entry->{hC});
 			my $profile = $iS->{gFz}->{lc($entry->{hC})};
				$to = $profile->[1];
			}
			if($to) {
				$iS->sJa($to, qq($name has read "$entry->{wW}"), 
					"URL: ". $entry->nH($iS, -1, $arch, 0, 0, $abmain::gJ{p})."\n".
					"At time: ".abmain::dU());
			}
		}
	}
 $iS->{ratings2}->{$cG} = join("\t", @arr);
 }
 if($abmain::use_sql) {
		$iS->dXaA($cG, $vcnt, $rdss);
 }
 $iS->aKz($cG, undef, 1) if $arch != 1;
 $iS->rSz();
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Message");
}
sub kAz {
 $abmain::gJ{gV}=1;
 jL();
}
sub fP {
 $iS->cR();
 if($abmain::gJ{attachfid} ne "") {
	$iS->{tHa} =1;
 }

 $iS->gCz();
 if($iS->{gL} eq "1" || $iS->{gL} eq 'true') {
 	abmain::error('deny', "Followup function is turned off for this forum");
 }
 abmain::error('inval', "Maximum number of attachment files is limited")
	if($abmain::gJ{upldcnt} > $iS->{max_extra_uploads} ); 
 if($iS->{rL}) {
 	$iS->aFz($abmain::gJ{zu}, undef, 1);
 my @arr = split /\t/, $iS->{ratings2}->{$abmain::gJ{zu}};
	abmain::error("inval", "Thread closed") if $abmain::gJ{zu} > 0 && $arr[3] & 2;
 }
 
 if($abmain::gJ{attachfid} ne "") {
	$iS->{xL} =0;
	$iS->{xA} =0;
	$iS->{take_file} =0;
	$iS->{pform_rows} = 4;
 }
 $iS->{gPa} = $abmain::gJ{scat};
 my $ph= $iS->gU($abmain::gJ{zu}, $abmain::gJ{fu}, $abmain::gJ{upldcnt}, $abmain::gJ{kQz}, $abmain::gJ{attachfid});
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC($abmain::cH, abmain::nXa($iS->{fTz}->{name}), '/', abmain::dU('pJ',24*3600*128));
 print "\n";
 print $ph;
 
}
sub hT {
 $iS->uW();
}
sub aP {
 $iS->vF();
}
sub bHz {
 $iS->bEz();
 $iS->rXz();
 $iS->aT();
 $iS->eG();
}
sub zO {
 $iS->cR();
 $iS->{yLz} = 'RATE';
 $iS->gCz(1);
 abmain::error('inval', "Rating was not enabled") if not $iS->{zP};
 my $zS = $abmain::fPz{$iS->zR('rt')};
 my @zU= split ('Q', $zS);
 my $cG = $abmain::gJ{cG};
 my $aCz = $abmain::gJ{zM};
 if($aCz< $iS->{rate_low} || $aCz > $iS->{rate_high} ) {
 abmain::error('inval', "Invalid rate value");
 }
 for(@zU) {
 if($cG == $_) {
 abmain::error('inval', "Please rate only once!");
 }
 }
 my $uname = $iS->{fTz}->{name};
 my ($is_root, $root) = abmain::eVa() ;
 my $isadm=   $iS->{moders}->{$uname} || $uname eq $iS->{admin} || $is_root;
 $isadm |= $iS->yXa();
 my $wt;
 if($uname) {
	$wt = $iS->{rate_wt_reg};
 }
 if($isadm) {
	$wt = $iS->{rate_wt_adm};
 }
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Rate");
 $iS->zK($cG, $aCz, $wt, $abmain::gJ{arch}); 

 unshift @zU, $cG;
 splice @zU, 512;
 sVa::gYaA "Content-type: text/html\n";
 print bC($iS->zR('rt'), join('Q', @zU), "/", dU('pJ', 1000*3600)); 
 print "\n";
 print qq(<html><head>
 <META HTTP-EQUIV="refresh" CONTENT="1; URL=@{[$iS->fC()]}">
 $iS->{sAz}
 $iS->{other_header}
	   <center>
	   <div class="ThankRateMessage">
 <h1>Article was rated $aCz</h1><p>Your rate will not show up immediately, please be patient.<br>Thank you.
	   </div>
 $iS->{other_footer}
 );
}
sub xLz {
 $iS->cR();
 my $pid = $abmain::gJ{qQz};
 my $pd = $iS->rJz($pid);
 my $linesref = $bYaA->new($pd, {schema=>"AbVotes", paths=>$iS->zOa($pid) })->iQa({noerr=>1});
 sVa::gYaA "Content-type: text/html\n\n";
 	$iS->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$iS->{sAz}\n$iS->{other_header});
 my $line;
 my @rows;
 while ($line = shift @$linesref) {
 my($ans, $t, $pQ, $domain,  $n, $ali) = @$line;
 push @rows, ["$ans",  
 abmain::dU('LONG', $t, 'oP'), $pQ, $domain, $n, $ali];
 }
 my @rows2 = sort {$a->[0] cmp $b->[0] } @rows;
 my @ths = ("Vote", "Time", "IP", "Domain", "Name", "Comment");
 print sVa::fMa(rows=>\@rows2, ths=>\@ths, $iS->oVa());
 print "</table>$iS->{other_footer}";
}
sub vJz{
 $iS->cR();
 sVa::gYaA "Content-type: text/html\n\n";
 	my $tJ = $iS->bHa(0,0,1);
 print "<html><head><title>$iS->{name} stats</title>";
 print  $iS->{sAz};
 	$iS->eMaA( [qw(other_header other_footer)]);
	print $iS->{other_header};
 print "<center>\n";
 	print $tJ;
 $iS->vLz($abmain::gJ{kQz});
 	print $tJ;
 print "</center>\n";
	print $iS->{other_footer};
}
sub rGz{
 $iS->cR();
 abmain::error('inval', "Voting was not enabled") if not $iS->{enable_voting};
 my $zS = $abmain::fPz{$iS->zR('tv')};
 my @zU= split (':', $zS);
 my $qQz = $abmain::gJ{qQz};
 my $ans = $abmain::gJ{$qQz};
 abmain::error('inval', "Please make a choice!") if $ans eq '';
 for(@zU) {
 if($qQz eq $_) {
 abmain::error('inval', "Please vote only once!");
 }
 }
 $iS->fSa($iS->{fTz}->{name}||$abmain::ab_id0||"???", "Vote");
 $iS->rGz($qQz, $ans); 
 unshift @zU, $qQz;
 splice @zU, 512;
 my $cook= bC($iS->zR('tv'), join(':', @zU), "/", dU('pJ', 1000*3600)); 
 my $result = $iS->rMz($qQz);
 abmain::cTz("<h1>Your vote may not show up immediately.<br>Thank you.</h1>$result", "", "", $cook); 
}
sub dE {
 my $dir = shift;
 open(aXz, abmain::kZz($dir, ".kill"));
 while(<aXz>) {
 chop;
 $hI{$_}=1 if $_ =~ /\S+/;
 }
 close aXz;
}
sub xEz{
 my ($t) = @_;
 $t = time() if not $t;
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst)=localtime($t);
 	my $aorp = $hour>12 ? "PM": "AM";
 	$hour -= 12 if $hour > 12;;
 	$hour = "0$hour" if $hour<10;
 	$min = "0$min" if $min<10;
 	$mon = "0$mon" if $mon<10;
 	$nQ = "0$nQ" if $nQ<10;
 	$year+=1900;
 return  join(':', $year, $mon, $nQ, sprintf("%02d",$hour), sprintf("%02d", $min), $aorp, $mD);
}
sub wCz{
 my ($id, $ts) = @_;
 $ts = xEz() if not $ts;

 my($min,$hour,$nQ,$mon,$year, $aorp, $mD);
 ($year, $mon, $nQ, $hour, $min, $aorp, $mD) = split /:/, $ts;
 my ($y, $m, $d, $h, $mn, $ap);
 
 my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 $y = zSz($id."_year", [$year-1, $year, $year+1, $year+2, $year+3, $year+4], $year);
 $m = zSz($id."hHa", [map {sprintf("%02d", $_)}(0..11)], $mon, \@months);
 $d = zSz($id."_day", [map {sprintf("%02d", $_)}(1..31)], $nQ);
 $h = qq(<input type="text" name="${id}_hour" value="$hour" size="2" maxlength="2">);
 $mn = qq(<input type="text" name="${id}iOa" value="$min" size="2" maxlength="2">);
 $ap = zSz($id."_apm",  [qw(AM PM)], $aorp);
 return "$d - $m - $y, $h:$mn $ap";

}
sub wFz{
 my ($ts, $tt4) = @_;
 $ts = xEz() if not $ts;

 my($min,$hour,$nQ,$mon,$year, $aorp, $mD);
 ($year, $mon, $nQ, $hour, $min, $aorp) = split /:/, $ts;
 if($tt4) {
 $hour += 12 if(uc($aorp) eq 'PM');
 return join(':', $year, $mon, $nQ, $hour, $min);
 }
 my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 my	@wdays  = qw(Sun Mon Tue Wed Thu Fri Sat);
 my $m = $months[$mon];
 my $w = $wdays[$mD],
 return "$m $nQ, $year, $hour:$min $aorp";

}
#return date 

sub xUz {
 my ($aFa, $id) = @_;
 my ($y, $m, $d, $h, $mn, $ap)=
 ($aFa->{$id."_year"}, $aFa->{$id."hHa"}, $aFa->{$id."_day"},
 $aFa->{$id."_hour"}, $aFa->{$id."iOa"}, $aFa->{$id."_apm"});
 return wantarray? ($y, $m, $d, $h, $mn, $ap) : join(":", $y,$m,$d,sprintf("%02d",$h),sprintf("%02d", $mn), $ap);
}
sub dU {
 my ( $format, $li, $gF, $strfmt) = @_;
 my $t;
 if($gF eq "oP") {
 $t = $li;
 } else {
 $t = time() + $li;
 }

 $t += $abmain::tz_offset*3600;

 my($sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst)=localtime($t);
 if($format eq 'POSIX') {
		$strfmt='%c' if not $strfmt;
		return strftime($strfmt, $sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst);
		
 }
 my (@months, @wdays);
 
 if($format ne 'pJ') {
 	@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 	@wdays  = qw(Sun Mon Tue Wed Thu Fri Sat);
 }else {
 	@months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
 	@wdays  = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
 }
		          
 my $mon = $months[$monidx];
 $mD = $wdays[$mD];

 $sec = "0$sec" if $sec<10;
 $hour = "0$hour" if $hour<10;
 $min = "0$min" if $min<10;
 $nQ = "0$nQ" if $nQ<10;
 $year+=1900;
 my $dstr= "$mD, $nQ-$mon-$year $hour:$min:$sec";
#   my $dstr= "Fri, 10-Nov-99 12:23:23";

 if($format eq 'pJ') {
 return "$dstr GMT";
 }
 if($format eq 'LONG') {
 return "$mD, $mon $nQ, $year, $hour:$min:$sec";
 }
 if($format eq 'STD') {
 $monidx++;
 $monidx ="0$monidx" if $monidx <10;
 return "$monidx/$nQ/$year, $hour:$min:$sec";

 }

 if($format eq 'SHORT') {
 return "$mon $nQ, $hour:$min, $year";
 }
 if($format eq 'DAY') {
 return "$mon $nQ";
 }
 
 if($format eq 'YDAY') {
 return "$mon $nQ, $year";
 }
 
 return "$mon $nQ,$year,$hour\:$min";  
 
}
sub jSz {
 
 my $time = $_[0] || time(); # default to now if no argument

 my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
 my @wdays  = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");

 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($time);
 $mon = $months[$mon];
 $mD = $wdays[$mD];
 my $zone = sprintf("%+05.d", ($TZ + $isdst) * 100);
 return join(" ", $mD.",", $nQ, $mon, $year+1900, sprintf("%02d", $hour) . ":" . sprintf("%02d", $min), $zone );
}
sub mXz{
 my ($mail, $localf, @data) = @_;
 $mail->{'X-mailer'}="Netbula AnyBoard(TM) $VERSION";
 if($localf) {
	unless (@data) {
 	open F, $localf or return "Fail to open file, $!";
 	my @gHz = <F>;
 	close F;
 	push @data,  join('', @gHz);
	}
 my $nb = "------6161616".time().$$;
 $mail->{'Content-type'} = qq(multipart/mixed; boundary="$nb");
 $localf =~ s#^.*/##;
 my $type;
 $localf =~ /\S+\.([^\.]*)$/;
 $type = $1 || "octet-stream";
 my %mimemap=(html=>'text/html', txt=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg', vcf=>'text/v-card'); 
 my $lRa= $mimemap{$type} || "application/$1";
 my @marr;
 push @marr, "This is a multipart message\n\n";
 push @marr, "--$nb\r\n";
 push @marr, "Content-type: text/plain\r\n\r\n";
 push @marr, $mail->{Body};
 push @marr, "\r\n--$nb\r\n";
 my @datas;
 for(@data) {
 my $str= "Content-type: $lRa\r\n";
 $str .= "Content-transfer-encoding: base64\r\n";
 $str .= qq(Content-disposition: inline; filename="$localf"\r\n\r\n);
 $str .= dZz::nBz($_);
 push @datas, $str;
 }
 push @marr, join("\r\n--$nb\r\n", @datas);
 push @marr, "\r\n--$nb--\r\n";
 $mail->{Body} = join('', @marr);
 }
 $mail->{Body} .= "\n-------------------\nEmail sent by AnyBoard ( http://netbula.com/anyboard/ )\n";
 abmain::vS($mail);
 return $abmain::wH;
}
sub bWa {
 my $str;
 my @gHz;
 push @gHz,   qq(<table bgcolor="#666666" cellspacing=0 cellpadding=0 border="0"><tr><td>);
 my $ta = qq(cellspacing=1 cellpadding=3 border="0");
 push @gHz,  &jW::nNa($ta, "E-Mail", "Status");
 my $i =0;
 for(keys %mail_status) {
 push @gHz, jW::nKz($abmain::bgs[$i++%2], "$_", "$mail_status{$_}");
 }
 push @gHz, "</table></td></tr></table>";
 return join("", @gHz);
}
sub lTa {
	my %hash= @_;
 my $str = "BEGIN:vCard\nVERSION:3.0\n";
 $hash{name} = $hash{nick} if(not $hash{name});
 $str .="FN:$hash{name}\n";
 $str .="NICKNAME:$hash{nick}\n" if $hash{nick};
 $str .="ORG:$hash{org}\n" if $hash{org};
 $str .="EMAIL;TYPE=INTERNET,PREF:$hash{email}\n";
 $str .="TEL;TYPE=VOICE:$hash{phone}\n" if $hash{phone};
 $str .="TEL;TYPE=FAX:$hash{fax}\n" if $hash{fax};
 $str .="URL:$hash{wO}\n" if $hash{wO};
 $str .="PHOTO;VALUE=uri:$hash{photourl}\n" if $hash{photourl};
 $str .="END:vCard\n";
 return $str;
}
sub vS {
	
 $wH = '';
 local $_;

 local *mail;
 
# redo hash, arranging keys case
 my %mail2=(); my ($k, $v);
 if (ref $_[0] eq 'HASH') {
 *mail = $_[0];
 }else {
 *mail = \%mail2;
 	 while (@_){
 $k = shift @_;
 $v = shift @_;
#		$mail{ucfirst lc $k} = $v;
		$mail{$k} = $v;
 	}
 }
 my $smtp = $mail{Smtp} || $abmain::smtp_server;
 my $max_recip = $mail{MAX_RECIP};
 delete $mail{Smtp}; 
 delete $mail{MAX_RECIP}; 
 
 my $message	= $mail{Message} || $mail{Body} || $mail{Text};
 delete($mail{Message})
 || delete($mail{Body})
 || delete($mail{Text}); 
 
 my $wF = $mail{From};
	unless ($wF =~ /$abmain::uD/o) {
		$wH = "Bad From address: $wF ($mail{From})";
		return;
	}	# get from email address
 $wF = $1;

 $mail{'X-mailer'} = "AnyBoard $VERSION" unless $mail{'X-mailer'};

# Default MIME headers if needed
	unless ($mail{'Mime-version'}) {
		 $mail{'Mime-version'} = '1.0';
	};
	unless ($mail{'Content-type'}) {
		 $mail{'Content-type'} = 'text/plain; charset="iso-8859-1"';
	};
	unless ($mail{'Content-transfer-encoding'}) {
		 $mail{'Content-transfer-encoding'} = '8bit';
	};

# add Date header if needed
	unless ($mail{Date}) {
#		 $mail{Date} = jSz();
	};

# cleanup message, and encode if needed
 $message =~ s/^\./\.\./gm; 	# handle . as first character
 $message =~ s/\r\n/\n/g; 	# handle line ending
 $message =~ s/\n/\r\n/g;
 $message = encode_qp($message) if ($mail{'Content-transfer-encoding'} =~ /^quoted/i);

 
# cleanup smtp
 $smtp =~ s/^\s+//g;
 $smtp =~ s/\s+$//g;

 if($smtp eq $abmain::sendmail_cmd || $abmain::use_sendmail_cmd) {
 $smtp = $abmain::sendmail_cmd;
 my $cmd = $smtp;
 $cmd =~ s/\s+.*$//;
 unless (-x $cmd ) {
 $wH = "$cmd is not executable";
 return;
 }
 unless(open (MAIL, "|$smtp>$abmain::master_cfg_dir/smtp.err") ) {
 $wH = "When executing $smtp: $!";
 return;
 }
 	      if($mail{Mlist}) {
 if($mail{Bcc}) {
 	   $mail{Bcc} .= ", $mail{Mlist}";
 }else {
 	   $mail{Bcc} = $mail{Mlist};
 }
 	      }
 my $msg = 
 	"To: $mail{To}\r\n".
 	"Cc: $mail{Cc}\r\n".
 	"Bcc: $mail{Bcc}\r\n".
 	"From: $wF\r\n".
 	"Return-Path: $wF\r\n".
 	"Subject: $mail{Subject}\r\n\r\n".
 	"$message";
 print MAIL $msg;
 close (MAIL);
 return;
 }
 
# Get recipients
# my $wD = join(' ', $mail{To}, $mail{Bcc}, $mail{Cc});
# Nice and short, but gives 'undefined' errors with -w switch,
# so here's another way:
 my $wD = "";
 $wD   .= $mail{To}        if defined $mail{To};
 $wD   .= " " . $mail{Bcc} if defined $mail{Bcc};
 $wD   .= " " . $mail{Cc}  if defined $mail{Cc};
 if($mail{Mlist}) {
 $wD .= " ".$mail{Mlist};
 }
 my @fUa = ();
 while ($wD =~ /$abmain::jQz/go) {
 	push @fUa, $1;
 }
 unless (@fUa) { $wH .= "No recipient!"; return; }
 if($max_recip >0 && @fUa > $max_recip) { $wH .="Too many recipients"; return;}

 delete $mail{Bcc};
 delete $mail{Mlist};
 
 eval {
	use Socket;
 };

 my $proto = getprotobyname('tcp');
 #abmain::error('sys', "Fail to retrieve TCP proto: $!") if !$proto;
 $proto= 6 if not $proto;
 
# the following produced a "runtime exception" under Win95:
# my($oE) = (getservbyname('smtp', 'tcp'))[2]; 
# so I just hardcode the oE at the start of the module: 
 my $oE = $abmain::default_smtp_port;
 
 my($vP) =
 	($smtp =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/)
 	? inet_aton($smtp)
 	: (gethostbyname($smtp))[4];
 
 unless (defined($vP)) {
 	$wH .= "smtp host \"$smtp\" unknown";
 	return;
 }
 
# Add info to log variable
 $vV .= "Server: $smtp Port: $oE\n"
 		   . "From: $wF\n"
 		   . "Subject: $mail{Subject}\n"
 		   . "To: ";
	
	# open socket and start mail session
 local *S;
 if($@) {
 	$wH .= "Import Sokcet module failed ($@)";
	return;
 }
	
 if (!socket(S, PF_INET, SOCK_STREAM, $proto)) {
 	$wH .= "socket failed ($!)";
 	return;
 }
 if (!connect(S, sockaddr_in($oE, $vP))) {
 	$wH .= "connect to $smtp failed ($!)";
 	return;
 }
 
 my($oldfh) = select(S); $| = 1; select($oldfh);
 
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "service unavailable: $_";
		return ;
	}
 
 print S "helo localhost\r\n";
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
		return ;
	}
 
 print S "mail from: <$wF>\r\n";
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 my $rcpt_cnt =0;
 %mail_status = ();
 my $to;
 foreach $to (@fUa) {
 	print S "rcpt to: <$to>\r\n";
 	$_ = <S>;
 	if (/^[45]/) {
 		$wH .= "Mail rejected for recipient ($to), SMTP server replied with error: $_\n";
 		$vV .= "!Failed: $to\n    ";
 $mail_status{$to} = "Failed: $_";
 	}
 	else {
 		$vV .= "$to\n    ";
 $rcpt_cnt ++;
 $mail_status{$to} = "Successful";
 	}
 }
 if($rcpt_cnt ==0) {
 close S;
 return;
 }
 
# send headers

 print S "data\r\n";
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 



 my $header;
 foreach $header (keys %mail) {
 	print S "$header: ", $mail{$header}, "\r\n";
 };
 

 print S "\r\n",
 		$message,
 		"\r\n\r\n.\r\n"
 		;
 
 $_ = <S>;
 if (/^[45]/) {
 	close S;
 	$wH .= "transmission of message failed: $_";
 	return ;
 }
 
 print S "quit\r\n";
 $_ = <S>;
 
 close S;
 return 1;
}
sub nUa{   
 my $str = shift;
 $str =~ s/([%\r\n\t])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}
sub oDa{
 my $v = shift;
 $v =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge;
 return $v;
}
sub wS {   
 my $str = shift;
 return "" if $str eq "";
 $str =~ s/([" %?&+<=>';\r\n])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}

sub gEaA {
%jW::bar_tags_def =(
_instruction=>"These macros are used in the navigation bar and forum's header and footer sections",
POSTLNK =>"Link to the post message form",
FINDLNK=>"Link to the search message form",
OVERVIEWLNK=>"Link to the overview index page",
PREVLNK =>"Link to the previous message index page",
NEWESTLNK=>"Link to the newest message index page",
REGLNK=>"Link to the user registration form",
LOGINLNK=>"Link to the user login form",
OPTLNK =>"Link to the page that displays configurations",
ADMLNK =>"Link to the admin login page",
GOPAGEBTN =>"The HTML code consists of the page index and the go button",
MAINLNK =>"Link to the main index page",
ARCHLNK =>"Link to the archive page",
CHATLNK=>"Link to the chat room",
RELOADLNK=>"The reload page command",
MYFORUMLNK=>"Link to private message area",
STATSLNK =>"Link to the posting statistics page",
WHOLNK =>"Link to the online user list page", 
TAGSLNK =>"Link to the tags maping page",
QSRCHLNK =>"Link to the fast full text search form",
QSEARCHBOX=>"HTML code for search form",
DBLNK=>"Link to the database and forms entry page",
FPOSTLINK=>"Link to the message post with forms attached", 
LINKSLNK =>"Link to the links submission and listing page",
MEMBERLNK =>"Link to the member list and search page",
SURVEYLNK =>"Link to the polls page",
EVELNK=>"Link to the events page",
USERCPANELLINK=>"Link to the user control panel where users can change profile, etc",
PAR_LINKS=>"Links back to top level",
ALL_FORUMS_LIST=>"The list of all available forums",
FORUMNAME=>"Forum name",
FORUM_AD =>"Adverstisement link",
FORUM_TOP_BANNER=>"Forum top banner",
FORUM_BOOTOM_BANNER=>"Forum bottom banner",
FORUM_MSG_AREA=>"Forum message area, including navigation bar and message links",
FORUM_DESC_FULL=>"Forum detail description",
);

%jW::msg_row_defs=(
_instruction=>"These macros are used to format message rows on the index page",
MSG_STAT_TAG=>"Message status tag",
MSG_MOOD=>"Message emoticon",
MSG_LINK=>"Link to message page",
MSG_POSTER=>"Poster",
MSG_ABS=>"Message abstract",
MSG_NUMBER=>"Message ID",
MSG_FLAGS=>"Message feature indicators, such as link indicator",
MSG_RATE_LNK=>"Link to the rate message page",
MSG_READS=>"Number of reads, available only if read counter is enabled",
MSG_READ_STATUS=>"Read status",
MSG_REPLY_CNT=>"Number of replies",
MSG_SIZE=>"Message size",
MSG_SPACER=>"In threaded mode, this is the indentation before the message link",
MSG_TIME=>"Posting time"
);
%jW::mbar_tags_def =(
_instruction=>"These macros can be used only in the message page layout. Some of the macros, such as MBAR_WIDTH are here only for backward compatibility",
ORIG_MSG_STR=>"The HTML code shows the original message information, note this macro is composed by other macros",
POST_BY_WORD=>"The post by word as defined in labels",
RE_WORD =>"The RE word as defined in labels",
MSG_REF_LNK=>"The link to the message which the current message is replying to", 
MSG_AUTHOR_ORIG =>"The author of the message being replied to",
MSG_AUTHOR_STR =>"HTML code showing the author of this message",
MSG_DATE=>"Posting time of the message",
REPLY_MSG_LNK=>"Link to reply form",
TOP_MSG_LNK=>"Link to the first topic in the thread",
PREV_MSG_LNK =>"Link to previous message",
NEXT_MSG_LNK =>"Link to next message",
SIBLING_MSG_LINKS =>"Links of messages at the same level",
PARENT_LEVEL_MSG_LINKS =>"Links of messages at the parent level",
CHILDREN_MSG_LINKS =>"Links of messages of followups",
MSG_PATH_LINKS =>"Links of messages going up to the top level",
FORUM_LNK=>"Link to the forum",
MBAR_WIDTH =>"Width of the navigation bar inside message",
MBAR_BG=>"Navigation bar background color",
MBAR_ATTRIB=>"Other attributes of the navigation bar",
MSG_TOP_BAR=>"Top navigation bar inside message",
TOPMBAR_BODY_SEP =>"Separator between top navigation bar and message body",
MSG_TITLE=>"Message title",
MSG_MOOD_ICON =>"Message emoticon",
MSG_BODY =>"Message body",
MSG_IMG =>"The linked image inside the message",
MSG_ATTACHMENTS =>"The HTML code for the attachments area",
UPLOADED_FILES=>"The links to the uploaded files",
AUTHOR_AVATAR=>"Author avatar",
AUTHOR_SIGNATURE=>"Author signature",
MSG_RLNK=>"Related link",
MSGBODY_BBAR_SEP=>"Separator between message body and bottom navigation bar",
MSG_BOTTOM_BAR=>"Bottom navigation bar inside message",
MSG_ATTACHED_OBJ_MOD=>"Link to the modify form of attached form",
MSG_ATTACHED_OBJ=>"HTML code for the attached form",
MODIFIED_STR=>"String shows the modification date and modifier",
AUTHOR_PROFILE_LNK=>"Link to author's profile",
EDIT_MSG_LNK=>"Link to the edit message page",
CURRENT_PAGE_LNK =>"Link to the current index page",
RECOMMEND_MSG_LNK=>"Link to the recommend message form",
ALERT_ADM_LNK=>"Link to the alert admin form",
MAIL_USER_LNK=>"Link to the mail user form",
RATE_MSG_LNK=>"Link to the rate message form",
UP_MSG_LNK=>"Link to the parent message to which this message replies",
WHERE_AMI_LNK=>"Link to the where am I page",
VIEW_ALL_LNK=>"Link to the page shows the whole content of current thread",
FORUMNAME=>"Forum name"
);

%jW::dyna_tags_def=(
_instruction=>"These macros are only processed if the pages are made dynamic, they must be used as \&lt;macro_name\&gt;", 
LOGIN_USER=>"HTML code shows the logout link for a logged in user",
PRIVATE_MSG_ALERT=>"HTML code alerts the presence of new private message",
LOCAL_USER_LIST=>"Current online users in the current forum",
GLOABL_USER_LIST=>"All online users",
MSG_READERS =>"Used in private message page only, shows the readers of this message",
ALL_FORUMS_LIST=>"The list of all available forums",
);

%jW::org_defs =(
_instruction=>"These macros can be used any where, you put them in the HTML code sections, and they will be replaced by the information you entered, their value can be globally defined in the master admin panel, and overridden by per forum settings",
join("<br>", @jW::org_info_tags), "For definition, see the organization information section"
);

 sVa::gYaA "Content-type: text/html\n";
 print "\n";
 print "<html><head>\n";
 $iS->cR(undef, 1);
 print $iS->{sAz}, "\n";
 print "\n";
 if( $iS->{_loaded_cfgs} ) {
		$iS->eMaA([qw(other_header other_footer)]);
 }
 print $iS->{other_header};
 print $abmain::close_btn;
 print "<h4>Macro definitions</h4>";
 print qq(&nbsp;<p><p>);
 for my $hash (\%jW::org_defs, \%jW::bar_tags_def, \%jW::msg_row_defs, \%jW::mbar_tags_def, \%jW::dyna_tags_def) { 
 	my @rows;
	push @rows, [$hash->{_instruction}];
 for (sort keys %$hash) {
		next if $_ eq '_instruction';
		push @rows, [$_, $hash->{$_}];
 }
 print sVa::fMa(rows=>\@rows, ths=>["Macro", "Definition"], $iS->oVa());
	print "<p>";

 } 

 
 
 print $abmain::close_btn;

 print qq@<p><hr><a href="javascript:history.go(-1)"><small>back</small></a>@;
 print "</body></html>";
 print $iS->{other_footer};
}
 
1;
package dDa;

use strict;
use Socket;
use hIaA;
use Benchmark;

BEGIN{
$dDa::eGa = 5;
#$dDa::LOG = \*STDERR;
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

#$http = new dDa;
#$http->eNa("http://192.92.1.1/testb");

#print "got: $error";
#print $http->dEa();
sub new {
	my $type = shift;
	my $self = {};
	$self->{fPz} = {};
	$self->{sock} = undef;
	return bless $self, $type;
}

sub eVaA{
	my ($d, $u) =@_;
	open F, ">>/tmp/blog";
	print F time(), "\n-------------===========================\n$u\n";
	print F $d;
	close F;
}

sub DESTROY {
 my ($self) = @_;
#    $self->finish();
}

sub dEa {
	my ($self) = @_;
	my $nA = $self->{sock};
	return if not $nA;
	my @arr;
	my $buf;
	my $len =0;
	my $cnt =0;
 my $maxlen =int($self->{eTa}->{'content-length'}) || $self->{max_recv_size};
	my $bsize=4096*4;
	while(($cnt=read($nA, $buf, $bsize)) >0) {
		push @arr, $buf;
		$len += $cnt;
		if ($maxlen >0 && $len >= $maxlen){
			last;
		}
		if($maxlen > 0 && $maxlen-$len < $bsize) {
			$bsize = $maxlen - $len;
		}
 }
	my $d = join("", @arr);
	#eVaA($d, $self->{dYa});
	return $d;
}

sub eBaA {
	my ($self, $fho) = @_;
	my $nA = $self->{sock};
	my $buf;
	my $len =0;
	my $cnt =0;
	while(($cnt=read($nA, $buf, 4096*4)) >0) {
		print $fho $buf;
		$len += $cnt;
		last if ($self->{max_recv_size} >0 && $len >= $self->{max_recv_size});
 }
	return $len;
}

sub tVa{
	my ($self) = @_;
	return ($self->{cur_status} == 301 || $self->{cur_status} == 302);
}

sub tUa{
	my ($self) = @_;
	return $self->{cur_status} >400;
}

sub eDa{
	my ($self) = @_;
	my $s = $self->{sock};
	my $lkey;
	my $cnt=0;
 $self->{eTa}= {};
	do {
		$_ = <$s>;
		print $dDa::LOG $_ if ($dDa::LOG ne "");
 defined($_) or return;
		last if length($_) > 1024*256;
 $_ =~ s/\r\n/\n/;
		if(/^([^:]+):\s+(.*)$/) {
			my $k = $1;
			my $v = $2;
			if(exists $self->{eTa}->{lc($k)}) {
				$self->{eTa}->{lc($k)} .="\0".$v;
				print $dDa::LOG "got header $k=$v\n" if ($dDa::LOG ne "");
			}else {
				$self->{eTa}->{lc($k)}=$v;
				print $dDa::LOG "got header2 $k=$v\n" if ($dDa::LOG ne "");
			}
			$lkey=lc($k);
		}
		/^\s+(\S+)$/ and $lkey and $self->{eTa}->{$lkey} .=$_;
		last if $cnt++ > 200;
	} until /^\s*$/;
}

sub dUaA {
	my ($ab_path) = @_;
	if($ab_path =~ m!/\.\./!) {
		$ab_path =~ s!^/\.\.$!!;
		$ab_path =~ s!/[^/]+/\.\./!/!;
		return dUaA($ab_path);
	}
	return $ab_path;
}

sub eAa{
	my ($pL, $path) = @_;
 my ($service, $host, $eUa) = $pL =~ /(\w+):\/\/([^\/]+)(.*)$/;
 my $url;
	if($path =~ m#^(\w+)://# ) {
		$url = $path;
	}elsif($path =~ m#^/#) {
		$url = "$service://$host$path";
	}else {
		$eUa =~ s#/[^\/]*$##;
		$url =  kZz("$service://$host", kZz($eUa, $path));
	}
	my ($page, $oE);
 ($service, $host, $page, $oE) = &dKa($url);
	$page =~ s#/[^/]+/\.\./#/#g;
	return $oE? "$service://$host:$oE$page": "$service://$host$page";
}

sub dIa {
	my ($self, $tracker) = @_;
	$self->{dSa}= $tracker;
}

sub dXa {
	my ($self, $type) = @_;
	$self->{dMa} = @_;
}

sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
	last if not $_;
 $_ =~ s#^/?##;
 $root =~ s#/*$#/#;
 $root .= $_; 
 }
 return $root;
}

sub hFaA{
	my ($nA, $timeout) = @_;
 my ($inbuf,$bits,$chars) = ("","",0);
 vec($bits,fileno($nA),1)=1;
 my $nfound = select($bits, undef, $bits, $timeout);
 if ($nfound == 0)
 {
 # Timed out
 return undef;
 } else {
 # Get the data
 $chars = sysread($nA, $inbuf, 4096);
 }
 # End of stream?
 if ($chars <= 0 && !$!{EAGAIN})
 {
 return;
 }
 

}

sub eNa
{
 my($self, $url, $method, $eSa, $dJa, $cook) = @_;
 my($service, $host, $page, $oE);
 my($eEa, $status_s, $eMa);
 my($dTa) = 0;
 my($result) = 0;
 ($service, $host, $page, $oE) = &dKa($url);
 $self->{eQa}=$host;
 $self->{dYa}=$url;
 $self->{_error} =undef;

 if ($service ne "http") {
		printf($dDa::LOG "Error: not an http service [%s]\n", $service)
			if ($dDa::LOG ne "");
		return 0;
 }
 my $status;

OUTERLOOP:
 while ($dTa < $dDa::eGa) {

		print $dDa::LOG "Connecting to [$host$page]..." if ($dDa::LOG ne "");

		if ($oE) {
			$result = $self->dZa($oE, $host);
		}
		else {
			$result = $self->dZa($service, $host);
		}

 		my $nA = $self->{sock};
		if ($result) {

			print $dDa::LOG "connected\n" if ($dDa::LOG ne "");

			# Send the request
			$self->eRa($host, $page, $method, $eSa, $dJa, $cook);

			# Get the status line
			
			my $cnt =4;
			while($cnt >0) {
				my $b;
				my $c = read($nA, $b, $cnt); 
				if ($c <=0) {
					$self->{_error} .= "\nFailed to read response: $!";
					return;
				}
				$status_s .= $b;
				$cnt -= $c;
			}

			if(lc($status_s) ne 'http') {
				$self->finish();
				$self->{_error} .= "\nInvalid reponse line $status_s";
				last;
			}
			$eMa = <$nA>;
			$status = int ((split /\s+/, $eMa)[1]);

			$self->{_stat_line} = $status_s.$eMa;
			$self->eDa();
			if($self->{dMa} && $self->{eTa}->{'content-type'}) {
			            my $tm = $self->{dMa};
				   if($self->{eTa}->{'content-type'} =~ /$tm/io) {
					$self->finish();
					last;
				   }
			}
			$dTa++;
			if ($dTa > $dDa::eGa) {
				last;
			}
			#$status = int ((split /\s+/, $eMa)[1]);

			if ($status == 301 || $status == 302 ){

				$eEa = $self->{eTa}->{location};

				$self->finish();

				if($eEa !~ /^http:/i) {
					$eEa = eAa($self->{dYa}, $eEa);
				}

				print $dDa::LOG "Redirecting [$host$page] to $eEa\n" if ($dDa::LOG ne "");

				# Connect to the new one
				($service, $host, $page) = &dKa($eEa);
				$self->{dYa}= $eEa;
				$self->{eQa} = $host;
				$self->{dSa}->{$eEa} =1 if $self->{dSa};
				$eSa = undef;
				$method = 'GET';
				print $dDa::LOG " [$host$page]\n" if ($dDa::LOG ne "");

				$dTa++;
			} else {
				last;
			}
		} else {
			$self->{_error} .= "\nConnection to $host failed: $!";
			last;
		}
 }

 $self->{cur_status} = $status;
 $result;
}

sub finish 
{
 my($self) = @_;
 close $self->{sock};
 shutdown($self->{sock}, 2);
}
sub dKa
{
 my($url) = @_;
 my($service, $host, $path, $oE);

 ($service, $host, $path) = $url =~ /(\w+):\/\/([^\/]+)(.*)$/;

	# Look for a oE number in the service
	if ($host =~ m/:\d+$/) {
		($host, $oE) = $host =~ /^([^:]+):(\d+)$/;
	}

 if ($path eq "") {
		$path = "/";
 }
 $path =~ s#/{2,}#/#g;

 ($service, $host, $path, $oE);
}

sub dZa
{
 my($self, $service, $eLa) = @_;
 my($name, $aliases, $protocol, $oE, $len);
 my($result) = 1;
 $oE = $service;

 $oE = 80 if ($service eq 'http');

 $protocol = (getprotobyname('tcp'))[2];

 ($name, $aliases, $oE, $protocol) = getservbyname($service, 'tcp')
		unless $oE =~ /^\d+$/;

 my $dQa;

 if($main::dns_over{$eLa} =~ /\d+\.\d+/) {
 	$dQa = inet_aton($main::dns_over{$eLa});
 }
 
 if(not $dQa) {
 $dQa =
 	($eLa =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/)
 	? inet_aton($eLa) 
 	: (gethostbyname($eLa))[4];
 }

 unless (defined($dQa)) {
 	$self->{_error} .= "\nUnable to resolve hostname:  \"$eLa\" ($!)";
 	return 0
 }
 
 my $sock = eval '\*sock::SOCK'.time();
 if (!socket($sock, PF_INET, SOCK_STREAM, $protocol)) {
 	$self->{_error} .= "\nsocket failed ($!)";
 	return 0
 }

 if (!connect($sock, sockaddr_in($oE, $dQa))) {
 	$self->{_error} .= "\nConnect failed ($eLa: $!)";
 	return 0;
 }
 
 my($oldfh) = select($sock); $| = 1; select($oldfh);
 if($main::use_buffer_reader) {
 	local *MYSOCK;
 	tie(*MYSOCK, hIaA::, $sock, 5*60);
 	$self->{sock} = *MYSOCK;
 }else {
 	$self->{sock} = $sock;
 }

 return $result;
}

sub eRa
{
 my($self, $host,  $page, $method, $eSa, $dJa, $cookie) = @_;

 $method = 'GET' unless $method;
 if($method eq 'POST' && not $dJa) {
		$dJa= "application/x-www-form-urlencoded";
 }
 
 my $nA = $self->{sock};
 print $nA "$method $page HTTP/1.0\r\n";
 print $nA "Connection: close\r\n";
 print $nA "Host: $host\r\n";

 print $nA "User-Agent: ", $self->{user_agent} ||"AnyBoard/8.2 (netbula application)", "\n";
 print $nA "Accept: */*\r\n";
 print $nA "Accept-Charset: gb2312,big5,iso-8859-1,*,utf-8\r\n";
 print $nA "Accept-language: zh-cn,zh-tw,en,*\r\n";
 print $nA "Referer: $self->{referer}\n" if $self->{referer} =~ /\w/;
 print $nA "X-Forwarded-For: $self->{originip}\n" if $self->{originip} =~ /\w/;
 print $nA "Cookie: $cookie\n" if $cookie;

 if ($method eq "POST") {
	if($dJa ne 'PASS'){
		print $nA "Content-type: $dJa\n";
		print $nA "Content-length: ", length($eSa), "\r\n";
		print $nA "\r\n";
		print $nA $eSa;
	}else {
		print $nA $eSa;
	}
 }

 # Terminate the request
 print $nA "\r\n\r\n";
 print $dDa::LOG "sent request...\n" if ($dDa::LOG ne "");
}

1;

package sVa;
require dZz;
use Exporter();
use Fcntl ':flock';
use strict;
use POSIX;
use Time::Local;
use Time::HiRes qw(gettimeofday);
@sVa::ISA=qw(Exporter);
@sVa::EXPORT = qw(cTz bF bC cUz hFa fUaA sIa sBa tPa  rSa
$wH kZz nextseq dU lWz 
vS mXz wS error oDa 
rTa round_float
dO kP @lWa %gJ %mCa $jT $bS 
oF pG tYa $siteurl $dLz); 

use vars qw( $wH  $bS $siteurl $dLz
$dC $max_upload_file_size  %mail
@months
@wdays
%mCa
$dB
$hUz
$eD
$fix_top_dir
$fix_top_url
$pL
$fix_cgi_url
$agent
$err_filter
$no_flock
$lock_fh
%locks
$tz_offset
$TZ
$VERSION
$smtp_server
$vV
$t0
);

use vars qw(%fPz %gJ %VFILES @lWa $jT
%cP $uD $default_smtp_port);

BEGIN{
my $word_rx = '[\x21\x23-\x27\x2A-\x2B\x2D\w\x3D\x3F]+';
my $user_rx = $word_rx .'(?:\.' . $word_rx . ')*';
my $dom_rx = '\w[-\w]*(?:\.\w[-\w]*)*'; 
my $ip_rx = '\[\d{1,3}(?:\.\d{1,3}){3}\]';
$sVa::uD = '((' . $user_rx . ')\@(' . $dom_rx . '|' . $ip_rx . '))';
$default_smtp_port = 25;  # set this if you want to send e-mail
$sVa::cQaA = "/abicons/apache/";
$sVa::please_wait_label=" ...Please wait ...";
$sVa::close_btn =qq(<form><input type=button name=x value="Close window" onclick="window.close()"></form>);
@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@wdays  = qw(Sun Mon Tue Wed Thu Fri Sat);
};
#IF_UT use SelfLoader;
#IF_UT 1;
#IF_UT __DATA__
sub fVz{
 my ($str, $cnt) = @_;
 return unpack("%16C*", $str)%$cnt;
} 

sub round_float{
	my ($v ) = @_;
	return sprintf("%.02f", $v);
}

sub kZz{
 my ($root, @compos)= @_;
 for my $c (@compos) {
	next if $c eq "";
 $c =~ s#^/?##;
 $root =~ s#/*$#/#;
 $root .= $c; 
 }
 return $root;
}

sub lWz{
 	my ($host, $honly) = @_;
 $host = $host || $ENV{REMOTE_ADDR};
 use Socket;
 if(!$@) {
 		my $addr = inet_aton($ENV{REMOTE_ADDR});
 		my $tmp = gethostbyaddr ($addr, AF_INET);
 return $tmp if $honly;
 $host .= "($tmp)" if $tmp;
 }
 return $host;
}

sub get_unix_file_owner{
	my $path= shift;
	my $gJz = (stat($path))[4];
	my $v ;
	eval {
		$v = eval 'getpwuid($gJz)';
	};
	return $v;
}

sub get_unix_file_perm{
	my $path= shift;
	my $md = (stat($path))[2];
	return sprintf("%04o", $md&07777);
}

sub encode_entities{
 my $ref = shift;
 # Encode control chars, high bit chars and '<', '&', '>', '"'
 $$ref =~ s/([<>\n\r\t !\#\$%\'&;"])/sprintf "&#x%X;", ord($1)/ge;
 return $$ref;
}

sub pQa{
 my ($where, $where2, $w3, @rest) = @_;
 if($sVa::t0 eq '') {
	my ($s, $m) = gettimeofday();
	$sVa::t0 = $s + $m/1000000;
	return;
 }
 my ($s, $m) = gettimeofday();
 my $t1  = $s + $m/1000000;
 my $intv = ($t1 - $sVa::t0) * 1000;
 open F, ">>/tmp/utlog.txt";
 my $caller = caller(). ",". caller(1). ", ". caller(2). ", ". caller(3);
 print F $intv, " reach $where $w3 , $caller, @rest\n";
 close F;
 ($s, $m) = gettimeofday();
 $sVa::t0 = $s + $m/1000000;
}
sub make_full_name{
	my ($lang, $fn, $ln, $mn) =@_;
	if($lang eq 'zh') {
			return join('', $ln, $fn);
	}
	if($lang eq 'en') {
		if($mn) {
			return join(' ', $fn, $mn, $ln);
		}else {
			return join(' ', $fn, $ln);
		}
	}
}

sub wS {   
 my $str = shift;
 return if $str eq "";
 $str =~ s/([" %&+?<=>'\r\n\t])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}
sub cIaA{   
 my $str = shift;
 return if $str eq "";
 $str =~ s/([^a-zA-Z0-9_\-\.\/:;\&\$])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}

sub oDa{
 my $v = shift;
 $v =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge;
 return $v;
}

sub test_pattern{
	my $pat = shift;
	return 1 if $pat eq "";
	my $ok1 = eval { "" =~ /$pat/; 1};
	return if not $ok1;
	return ('a' =~ /$pat/)? 0: 1;
}

sub rm_file_recurse {
	my ($d, $file, $no_this_dir) = @_;
	my $f = kZz($d, $file);
	unlink $f unless ($no_this_dir && $d eq $no_this_dir);
	local *DIR;
	opendir DIR, $d;
	my @es = readdir DIR;
	close DIR;
	for my $e (@es) {
		next if $e eq '.';
		next if $e eq '..';
		my $d2 = kZz($d, $e);
		rm_file_recurse($d2, $file) if -d $d2;
	}
}
sub bW{   
 my ($pQ)= @_;
 my @nums = split /\./, $pQ;
 my $i = pack("C4", @nums);  
 $i = unpack("h*", $i);
 $i;
}

sub pT{
 my ($i)= @_;
 $i = pack("h*", $i);
 my @nums = unpack("C4", $i);  
 my $pQ = join('.', @nums);
 $pQ;
}

sub nUa{   
 my $str = shift;
 $str =~ s/([%\r\n\t])/sprintf '%%%.2X' => ord $1/eg;
 return $str;
}
BEGIN {
%cP = (
miss=>[	"Missing required field",
	"You did not fill in one or more required fields in the form submission.", 
	"Go back and complete the information and then resubmit."],

iK=>["Field too long",
	"One of the fields exceeded limit.",
	"Go back, reduce the field length and then resubmit."],

oO=>["Rule violation",
	"You violated the rules imposed by this forum!",
	"Please read the rules again and cooperate. Thank you!"],

inval =>["Input rejection", "The information or command you sent was rejected",
 "Go back to the previous page and make corrections. Please see the detailed error message for explanation."],    
deny    => ["Access denied!", "Sorry!", "Sorry!"],

dM => ["Fail to authenticate!", 
	"Missing or invalid authentication information.", 
	"Provide the correct authentication info and retry."],

iT=> ["No cookie!", 
	"Your browser did not send the expected cookie!", 
	"Get a browser that supports cookie and enable cookie" ],

'sys'=>	["System error", 
	"Error caused by incorrect setup, incorrect permission setting, etc.", 
	"Notify webmaster with the detailed error message."
	],
);

}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub tWa{
return qq@
<script type="text/javascript">
<!--
var ab_newin=null;
function newWindow(nH, myname, w, h, scroll) {
w=(screen.width)?screen.width*w: 620;
h=(screen.height)?screen.height*h:420;
LeftPos=(screen.height)?screen.width-w-200:0;
TopPos=(screen.height)?100:0;
settings='height='+h+',width='+w+',top='+TopPos+',left='+LeftPos+',scrollbars='+scroll+',resizable';
var ab_newin = window[myname];
if(ab_newin==null || ab_newin.closed) {
	ab_newin=window.open(nH, myname, settings);
	window[myname]=ab_newin;
}else {
	ab_newin.location=nH;
}
ab_newin.focus();
if(nH == null) return ab_newin;
}

function changeStyle(ele, sty) {
	ele.className=sty;
}

function setCssPropByID(eid, prop, val) {
	var ele = document.getElementById(eid);
	if(ele!=null) ele.style[prop]=val;

}
function submitButtonClicked(btn) {
	btn.className='clickedButtonStyle';
 if(!btn.disabled) {
		if(btn.form.target == window.name) {
			btn.value= "$sVa::please_wait_label";
			window._tmfunc = function() { btn.form.submit(); }
			btn.disabled = true;
			setTimeout("_tmfunc()", 350);
			return false;
		}else {
			return true;
		}
	}else {
		return false;
	}
}
var cm=null;
var cobj=null;
document.onclick = new Function("hide_m()");

function getPos(el,sProp) {
	var iPos = 0
	while (el!=null) {
		iPos+=el["offset" + sProp]
		el = el.offsetParent
	}
	return iPos

}

var tid = null;
function hide_m() {
	if(cm!=null) {
		 cm.style.display='none';
	}
	cm = null;
}

function show_m(el,mn) {
 var m = document.getElementById(mn);
	if(el==null) {
		el = cobj;
	}
	if(m && m == cm) {
		clearTimeout(tid);
		tid = null;
	}else {
		if (cm != null) {
			clearTimeout(tid);
			tid = null;
			hide_m();
		}
	}

	if (m) {
		m.style.display='';
		m.style.pixelLeft = getPos(el,"Left") + 4;
		m.style.pixelTop = getPos(el,"Top") + el.offsetHeight +0;
	}
	cm=m;
	cobj=el;
}

function out_m(mn) {
 var m = document.getElementById(mn);
	if(m!=null) {
		tid = window.setTimeout('hide_m()', 550);
		
	} 
	cm=m;
}
//-->
</script>
@;

}

sub hFa{
 my ($url, $str, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 return '' if !$str;
 return cUz($url, $str, undef, $attr) if $sVa::no_pop_link;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.75 if not $w;
 $h = 0.75 if not $h;
 return qq(<a href="javascript:newWindow('$url', '$popwin', $w, $h,'yes')" $attr>$str</a>);
}

sub pop_js_url{
 my ($url, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.75 if not $w;
 $h = 0.75 if not $h;
 return qq("javascript:newWindow('$url', '$popwin', $w, $h,'yes')" $attr);
}

sub link_str_pop_o{
 my ($url, $str, $popwin, $attr, $w, $h) = @_;
 return '' if !$url;
 return '' if !$str;
 $popwin="netbula_new" if $popwin eq "";
 $w = 0.6 if not $w;
 $h = 0.6 if not $h;
 return qq(<a href="$url" $attr onclick="newWindow(this.href, '$popwin', $w, $h,'yes');return false;">$str</a>);
}
sub fUaA{
 my ($url, $str, $msg, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 return qq(<a href="$url" $attr onclick="return window.confirm('$msg');">$str</a>);
}

sub cUz {
 my ($url, $str, $tgt, $attr) = @_;
 return '' if !$url;
 return '' if !$str;
 $attr ||="";
 $attr =" $attr" if $attr;
 return qq(<a href="$url" target="$tgt"$attr>$str</a>) if $tgt;
 return qq(<a href="$url"$attr>$str</a>);
}

sub parse_parms_old{
	my ($str) = @_;
	return {} if not $str;
	my @kvs = ($str =~ /(\w+="[^"]+")/g);
	my $hsh = {};
	for my $s (@kvs) {
		$s =~ /(\w+)="(.*)"/;
		$hsh->{$1} = $2;
	}
	return $hsh;
}

sub parse_parms{
	my ($str) = @_;
	return {} if not $str;
	my $hsh = {};
#	while ($str =~ /(\w+)="([^"]|\\")+"/g){

	while ($str =~ /(\w+)\s*=\s*"([^"]*)"/g){
		my $v = $2;
		my $k = $1;
		$v =~ s/\&quot;/"/go;
		$v =~ s/''/"/go;
		$hsh->{$k} = $v;
	}
	return $hsh;
}

sub gVaA{
	my ($url, $raw) = @_;
	if($raw || $ENV{raw_redir}) {
		print "HTTP/1.0 301 Moved Permanently\n";
	}
	print "Location: $url\n\n";
}

sub hCaA(@){
	if($ENV{raw_redir}) {
		print "HTTP/1.0 301 Moved Permanently\n";
	}
	if($ENV{http_10_close}) {
		print "Connection: close\n";
	}
	print @_;
}

sub gYaA (@){
	if($ENV{raw_redir}) {
		print "HTTP/1.0 200 OK\n";
	}
	if($ENV{http_10_close}) {
		print "Connection: close\n";
	}
	print @_;
}

sub bC {
 my($name, $val, $path, $exp) = @_;
 if($exp) {
 	return "Set-Cookie: $name=$val; expires=$exp; path=$path\n";
 }else {
 	return "Set-Cookie: $name=$val; path=$path\n";
 }
}

sub bF {
 my($name, $val);
 foreach (split (/; /, $ENV{'HTTP_COOKIE'})) {
 ($name, $val) = split /=/;
 $fPz{$name}=$val;
 }
}

sub dO {
 my($in) ;
 my ($name, $value) ;
 my @eRz;
 undef %gJ;
 undef @lWa;

 &error('sys',"Script was called with unsupported REQUEST_METHOD $ENV{'REQUEST_METHOD'}.") 
 if ( not defined($ENV{'REQUEST_METHOD'})); 

 if ( ($ENV{'REQUEST_METHOD'} eq 'GET') ||
 ($ENV{'REQUEST_METHOD'} eq 'HEAD') ) {
 $in= $ENV{'QUERY_STRING'} ;
	$in =~ s/;/&/g;
 $dC="GET";
 } elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
 length($ENV{'CONTENT_LENGTH'})
 || &error('sys', "No Content-Length sent with the POST request.") ;
 my $len = $ENV{'CONTENT_LENGTH'};
 my $cnt=0;
 $dC="POST";
 my $buf;
 if ($ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 while($len ) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt ==0;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
		open F, ">/tmp/pd";
		print F $in;
		close F;
 }elsif($ENV{'CONTENT_TYPE'}=~ m#^multipart/form-data#i) {
 error('iK', "Data size $len exceeded specified limit ($max_upload_file_size)") 
 if $len > $max_upload_file_size && $max_upload_file_size >0;

 binmode STDIN;
 while($len ) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt ==0;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
 my @plines = split /^/m, $in;
 
 my $lRa = new dZz(\@plines);
 $lRa->{head}->{'content-type'} = $ENV{'CONTENT_TYPE'}; 
 $lRa->bVz();
 $lRa->eBz();
 my $ent;
 for $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 if (length($ent->{eFz})>0) {
 $ent->{eFz} =~ s/\s+/_/g;
 $mCa{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 $gJ{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 } else {
 	              if (defined($gJ{$name})){
 	              	$gJ{$name} .= "\0" if defined($gJ{$name}); 
 }else {
 push @lWa, $name;
 }
		      $val =~ s/\x1a//g;
 	              $gJ{$name} .=  $val;
 }
 }
 
 }
 }
 if ($dC eq 'GET'  || $ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 	foreach (split('&', $in)) {
 	    s/\+/ /g ;
 	    ($name, $value)= split('=', $_, 2) ;
 	    $name=~ s/%([0-9a-fA-F][0-9A-Fa-f])/chr(hex($1))/ge ;
 	    $value=~ s/%([0-9A-Fa-f][0-9a-fA-F])/chr(hex($1))/ge ;
 	    if (defined($gJ{$name})) {
 	    	$gJ{$name}.= "\0";
 }else {
 push @lWa, $name;
 }
 	    $gJ{$name}.= $value ;
 	}
 }
}

sub kP {
 my $no_p = shift;
 my $oE = $ENV{SERVER_PORT};
 $dB = $ENV{HTTP_HOST} || $ENV{SERVER_NAME};
 $bS = $ENV{PATH_INFO};
 $hUz = $dB;
 $hUz =~ s/^www\./\./;
 $hUz = "domain=$hUz;";
 if($bS =~ /$0(.*)/) {
 $bS = $1;
 }
 $bS =~ s#$ENV{SCRIPT_NAME}##;
 $bS =~ s#^/?#/#;
 $bS =~ s#/?$#/#;
 $eD = $ENV{PATH_TRANSLATED};
 if($fix_top_dir) {
 $fix_top_dir =~ s#/?$##;
 $eD=$fix_top_dir.$bS;
 }
 $eD =~ s/`|\s+|;//g; #pass taint checking
 $bS =~ s/`|\s+|;//g; #pass taint checking
 $eD =~ /(.*)/; $eD = $1;
 $bS =~ /(.*)/; $bS =$1;
 my $proto = lc((split /\//, $ENV{SERVER_PROTOCOL})[0]); 
 $proto="https" if $ENV{HTTPS} && lc($ENV{HTTPS}) ne 'off';
 my $dJz = $proto."://$dB";
 if($oE != 80 && $oE != 443) {
 $dJz .= ":$oE";
 }
 if ($fix_top_url) {
 $fix_top_url =~ s#/?$##;
 $dJz = $fix_top_url;
 }
 $siteurl = $dJz;
 $pL = $dJz. $bS;
 $bS ="" if $no_p;
 if($fix_cgi_url) {
 $jT = $fix_cgi_url.$bS;
 	$dLz = $jT;
 } else{
 	$jT = $ENV{SCRIPT_NAME}. $bS;
 	$dLz = $dJz. $ENV{SCRIPT_NAME}. $bS;
 }
 $agent = $ENV{'HTTP_USER_AGENT'}.$ENV{'HTTP_USERAGENT'};
 $jT =~ s#/$##;
 #pEa(join(':', %ENV));
}

sub cTz {
 my $msg = shift;
 my ($tit, $cVz, $cookie) = @_;
 sVa::gYaA("Content-type: text/html\n");
 print "$cookie\n" if $cookie;
 print "\n";
 print "<html><head>\n";
 print qq(<META HTTP-EQUIV="refresh" CONTENT="1; URL=$cVz">) if $cVz;
 print "\n";
 print "<title>$tit</title>\n";
 print qq(</head><body>\&nbsp;<p><p>);
 print $msg;
 print qq@</center></body></html>@;
}
sub rLz {
 my ($str) = @_;
 $str =~ s/'/\\'/g;
 $str =~ s/\n/\\n/g;
 $str =~ s/\r//g;
 return qq!document.write('$str');!;
}

sub error {
 my ($error, $kG, $suggest)  = @_;
 my $lU = $error;
 my $nT  = "Unknown";
 my $fG = "Notify webmaster";

 my $var = $cP{$error};
 if($var) {
 $lU = $var->[0];
 $nT = $var->[1];
 $fG  = $suggest || $var->[2];
 }

 my $header ="";
 $error =~ s#$err_filter#X#g if $err_filter;
 $kG =~ s#$err_filter#X#g if $err_filter;
 sVa::gYaA ("Content-type: text/html\n");

 print $header;
 print "\n<html><head><title>Error: $kG</title>\n";
 if($abmain::iS) {
	print $abmain::iS->{other_header};
 }else {
 	print qq(<body bgcolor="#ffffff">);
 }
 print qq(<table width="75%" align="center" border="0"><tr><td><h3>$kG</h3></td></tr></table><br/>);
 print qq( 
<table align="center" border="0" cellpadding=0 cellspacing=0 width=75% bgcolor="#000000"><tr><td>
<table align="center" border="0" width=100% cellspacing=1 cellpadding=5>
<tr bgcolor="#cc0000"><th colspan=2> <font color="#ffffff">$kG</font></th></tr> 
<tr bgcolor="#d3e3f8"><th>Error type</th><th> $lU</th></tr> 
<tr bgcolor="#ffffff"><td> General description</td><td> $nT</td></tr> 
<tr bgcolor="#d3e3f8"><td>Suggested action</td><td>$fG</td></tr>
</td></tr></table>
</table>
);
 print "<p><p>\n";
 if($abmain::iS) {
	print $abmain::iS->{other_footer};
 }else {
 	print "</body></html>\n";
 }
 
 iUz(); 
 
}  
sub iUz {
 my $code = shift;
 if($ENV{GATEWAY_INTERFACE} =~ /^CGI-Perl/ || exists $ENV{MOD_PERL}) {
 undef %gJ;
 undef %mCa;
 undef %fPz;
 Apache::exit($code); 
 }elsif($main::is_ithread) {
	die;
	#threads->self()->join();
 }else {
 exit;
 }
}

sub rSa{
	my ($eFz, $outfile) =@_;
	open FF2, "<$eFz" or return;
 open FF3, ">$outfile" or return close FF2;
 my $buf;
	while(read (FF2, $buf, 4096)) {
		print FF3 $buf;
 }
 close FF3;
 return 1;
}

sub tZa{
	my ($outfile, $data) =@_;
 open FF3, ">$outfile" or return;
	binmode FF3;
	print FF3 $data;
 close FF3;
 return 1;
}

sub oF {
 my ($qU, $gK, $lockfdir) = @_;
 $gK = "0" if not $gK;
 error('sys', "Your system is missing Fcntl:flock") if $no_flock;
 my $lf = kZz($lockfdir, "$gK");
 $qU = LOCK_EX if (!$qU);
 my $lock_fh= eval "\\*lT$gK";
 open ($lock_fh, ">>$lf") or error('sys', "Fail to open lock file $lf: $!");
 eval {
	 local $SIG{ALRM} = sub { die "lock_operation_timeout" };
 eval 'alarm 10' if $sVa::use_alarm;
 flock ($lock_fh, LOCK_EX) or error('sys', "Fail to lock $lf: $!");
 eval 'alarm 0' if $sVa::use_alarm;
 };
 if ($@) { error('sys', $@." Go back and retry.");  }
 $locks{$gK}=1;
}

sub pG {
 my ($gK) = @_;
 $gK = "0" if not $gK;
 my $lock_fh= eval "\\*lT$gK";
 flock ($lock_fh, LOCK_UN) 
 ;
#x1
 close $lock_fh;
 $locks{$gK}=0;
}

sub dU {
 my ( $format, $li, $gF, $strfmt) = @_;
 my $t;
 if($gF eq "oP") {
 $t = $li;
 } else {
 $t = time() + $li;
 }

 $t += $abmain::tz_offset*3600;

 my($sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst)=localtime($t);
 if($format eq 'POSIX') {
		$strfmt='%c' if not $strfmt;
		return strftime($strfmt, $sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst);
		
 }
		          
 my ($mon);

 if($format eq 'pJ') {
 	my @months2 = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 	my @wdays2  = qw(Sun Mon Tue Wed Thu Fri Sat);
 	$mon = $months2[$monidx];
 	$mD = $wdays2[$mD];
 }else {
 	$mon = $months[$monidx];
 	$mD = $wdays[$mD];

 }

 $sec = "0$sec" if $sec<10;
 $hour = "0$hour" if $hour<10;
 $min = "0$min" if $min<10;
 $nQ = "0$nQ" if $nQ<10;
 $year+=1900;
 my $dstr= "$mD, $nQ-$mon-$year $hour:$min:$sec";

 if($format eq 'pJ') {
 return "$dstr GMT";
 }
 if($format eq 'LONG') {
 return "$mD, $mon $nQ, $year, $hour:$min:$sec";
 }
 if($format eq 'CN_DATE') {
 return "$year $mon $nQ, $mD";
 }
 if($format eq 'STD' || $format eq 'time') {
 $monidx++;
 $monidx ="0$monidx" if $monidx <10;
 return "$monidx/$nQ/$year, $hour:$min";

 }

 if($format eq 'CANON' || $format eq 'date') {
 $monidx++;
 $monidx ="0$monidx" if $monidx <10;
 return "$year/$monidx/$nQ";

 }

 if($format eq 'SHORT') {
 return "$mon $nQ, $hour:$min, $year";
 }

 if($format eq 'DAY') {
 return "$mon $nQ";
 }
 
 if($format eq 'YDAY') {
 return "$mon $nQ, $year";
 }
 
 return "$mon $nQ,$year,$hour\:$min";  
 
}

sub jSz {
# convert a time() value to a date-time string according to RFC 822
 
 my $time = $_[0] || time(); # default to now if no argument

 my 	@months2 = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 my @wdays2  = qw(Sun Mon Tue Wed Thu Fri Sat);
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($time);
 $mon = $months2[$mon];
 $mD = $wdays2[$mD];
 my $zone = sprintf("%+05.d", ($TZ + $isdst) * 100);
 return join(" ", $mD.",", $nQ, $mon, $year+1900, sprintf("%02d", $hour) . ":" . sprintf("%02d", $min), $zone );
}

sub mXz{
 my ($mail, $localf, $data) = @_;
 $mail->{'X-mailer'}="Netbula AnyBoard(TM) $VERSION";
 if($localf) {
	if(not $data) {
 	open F, $localf or return "Fail to open file, $!";
 	my @gHz = <F>;
 	close F;
 	$data = join('', @gHz);
	}else {
	}
 my $nb = "------6161616".time().$$;
 $mail->{'Content-type'} = qq(multipart/mixed; boundary="$nb");
 $localf =~ s#^.*/##;
 my $type;
 $localf =~ /\.([^.]*)$/;
 $type = $1 || "octet-stream";
 	my %mimemap=(html=>'text/html', txt=>'text/plain', conf=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg');
 my $lRa= $mimemap{$type} || "application/$1";
 my @marr;
 push @marr, "This is a multipart message\n\n";
 push @marr, "--$nb\r\n";
 push @marr, "Content-type: text/plain\r\n\r\n";
 push @marr, $mail->{Body};
 push @marr, "\r\n--$nb\r\n";
 push @marr, "Content-type: $lRa\r\n";
 push @marr, "Content-transfer-encoding: base64\r\n";
 push @marr, qq(Content-disposition: inline; filename="$localf"\r\n\r\n);
 push @marr, dZz::nBz($data);
 push @marr, "\r\n--$nb--\r\n";
 $mail->{Body} = join('', @marr);
 }
 $mail->{Body} .= "\n-------------------\nEmail sent by AnyBoard (http://netbula.com/anyboard/)\n";
 vS($mail);
 return $wH;
}
sub gLaA {
 my $mail = shift;
 my $wD = "";
 
 if($mail->{to_list}) {
 $wD = $mail->{to_list};
 }
 delete $mail->{to_list};
 my @msgs= ();
 while ($wD =~ /$uD/go) {
	my $e = $1;
	$mail->{To} = $e;
	vS($mail);
	if ($wH) {
		push @msgs, 'Error:'.$wH;
	}else {
		push @msgs, 'Sent to:'.$e;
	}
 
 }
 return @msgs;
}
sub gUaA($) {
	my $s = shift;
	my $res = <$s>;
	if ($res =~ s/^(\d\d\d)-/$1 /) {
		my $nextline = <$s>;
		while ($nextline =~ s/^\d\d\d-//) {
			$res .= $nextline;
			$nextline = <$s>;
		}
		$nextline =~ s/^\d\d\d //;
		$res .= $nextline;
	}
	$Mail::Sender::LastResponse = $res;
	return $res;
}

sub vS {
	
 $wH = '';
 local $_;

 local *mail;
 
# redo hash, arranging keys case
 my %mail2=(); my ($k, $v);
 if (ref $_[0] eq 'HASH') {
 *mail = $_[0];
 }else {
 *mail = \%mail2;
 	 while (@_){
 $k = shift @_;
 $v = shift @_;
		$mail{ucfirst lc $k} = $v;
 	}
 }
 my $smtp = $mail{Smtp} || $smtp_server ||"localhost";
 
 my $message	= $mail{Message} || $mail{Body} || $mail{Text};
 
 my $wF = $mail{From};
	unless ($wF =~ /$uD/o) {
		$wH = "Bad From address: $wF ($mail{From})";
		return;
	}	# get from email address
 $wF = $1;

 $mail{'X-mailer'} = "AnyEmail $VERSION" unless $mail{'X-mailer'};
 $mail{'X-Sender-x'} = unpack("h*", $main::ENV{REMOTE_ADDR});
	unless ($mail{'Mime-version'}) {
		 $mail{'Mime-version'} = '1.0';
	};
	unless ($mail{'Content-type'}) {
		 $mail{'Content-type'} = 'text/plain';
	};
	unless ($mail{'Content-transfer-encoding'}) {
		 $mail{'Content-transfer-encoding'} = '8bit';
	};

	unless ($mail{Date}) {
		 $mail{Date} = jSz();
	};

 $mail{To} =~ s/\n|\r/ /g;

# cleanup message, and encode if needed
 $message =~ s/^\./\.\./gm; 	# handle . as first character
 $message =~ s/\r\n/\n/g; 	# handle line ending
 $message =~ s/\n/\r\n/g;
 $message = encode_qp($message) if ($mail{'Content-transfer-encoding'} =~ /^quoted/i);

 
# cleanup smtp
 $smtp =~ s/^\s+//g; # remove spaces around $mail{Smtp}
 $smtp =~ s/\s+$//g;

 if($mail{sendmail_cmd}) {
 my $cmd =  $mail{sendmail_cmd};
 $cmd =~ s/\s+.*$//;
 unless (-x $cmd ) {
 $wH = "$cmd is not executable";
 return;
 }
 unless(open (MAIL, "|$mail{sendmail_cmd}>/tmp/smtp.err") ) {
 $wH = "When executing $smtp: $!";
 return;
 }
 	      if($mail{Mlist}) {
 	  $mail{Bcc} .= ", $mail{Mlist}";
 	      }
 my $msg = 
 	"To: $mail{To}\r\n".
 	"Cc: $mail{Cc}\r\n".
 	"Bcc: $mail{Bcc}\r\n".
 	"From: $wF\r\n".
 	"Return-Path: $wF\r\n".
 	"Subject: $mail{Subject}\r\n\r\n".
 	"$message";
 print MAIL $msg;
 close (MAIL);
 return;
 }
 
# Get recipients
# my $wD = join(' ', $mail{To}, $mail{Bcc}, $mail{Cc});
# Nice and short, but gives 'undefined' errors with -w switch,
# so here's another way:
 my $wD = "";
 $wD   .= $mail{To}        if defined $mail{To};
 $wD   .= " " . $mail{Bcc} if defined $mail{Bcc};
 $wD   .= " " . $mail{Cc}  if defined $mail{Cc};
 if($mail{Mlist}) {
 $wD .= " ".$mail{Mlist};
 }
 my @recipients = ();
 while ($wD =~ /$uD/go) {
 	push @recipients, $1;
 }
 unless (@recipients) { $wH .= "No recipient!"; return; }

 
 my $proto = getprotobyname('tcp');
 $proto= 6 if not $proto;
 
# the following produced a "runtime exception" under Win95:
# my($oE) = (getservbyname('smtp', 'tcp'))[2]; 
# so I just hardcode the oE at the start of the module: 
 my $oE = $default_smtp_port || 25;
 
 my($vP) =
 	($smtp =~ /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/)
 	? inet_aton($smtp)
 	: (gethostbyname($smtp))[4];
 
 unless (defined($vP)) {
 	$wH .= "smtp host \"$smtp\" unknown";
 	return;
 }
 
# Add info to log variable
 $vV .= "Server: $smtp Port: $oE\n"
 		   . "From: $wF\n"
 		   . "Subject: $mail{Subject}\n"
 		   . "To: ";
	
	# open socket and start mail session

 local *S;
	
 if (!socket(S, PF_INET, SOCK_STREAM, $proto)) {
 	$wH .= "socket failed ($!)";
 	return;
 }
 if (!connect(S, sockaddr_in($oE, $vP))) {
 	$wH .= "connect to $smtp failed ($!)";
 	return;
 }
 
 my($oldfh) = select(S); $| = 1; select($oldfh);
 
 my $smtpcon =\*S;
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "service unavailable: $_";
		return ;
	}
 
 print S "helo localhost\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
		return ;
	}
 
 print S "mail from: <$wF>\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 my $rcpt_cnt =0;
 my %mail_status = ();
 my $to;
 foreach $to (@recipients) {
 	print S "rcpt to: <$to>\r\n";
 	$_ = gUaA($smtpcon);
 	if (/^[45]/) {
 		$wH .= "Mail rejected for recipient ($to), SMTP server replied with error: $_\n";
 		$vV .= "!Failed: $to\n    ";
 $mail_status{$to} = "Failed: $_";
 	}
 	else {
 		$vV .= "$to\n    ";
 $rcpt_cnt ++;
 $mail_status{$to} = "Successful";
 	}
 }
 if($rcpt_cnt ==0) {
 close S;
 return;
 }
 
# send headers

 print S "data\r\n";
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "SMTP error: $_";
 	return;
 }
 
 #Is the order of headers important? Probably not! 

 # print headers
 my @no_headers=qw(Smtp Body Message Text Mlist Bcc);
 my %no_header= map {$_=>1} @no_headers;

 foreach my $header (keys %mail) {
	next if $no_header{$header};
	$mail{$header} =~ s/\r?\n//g;
 	print S "$header: ", $mail{$header}, "\r\n";
 };
 
 #send message body and quit
 print S "\r\n",
 		$message,
 		"\r\n\r\n.\r\n"
 		;
 
 $_ = gUaA($smtpcon);
 if (/^[45]/) {
 	close S;
 	$wH .= "transmission of message failed: $_";
 	return ;
 }
 
 print S "quit\r\n";
 $_ = <S>;
 
 close S;
 return 1;
}
sub nextseq{
 my ($seqdir, $max, $seqidx) = @_;
 my $cLaA= kZz($seqdir, "data.txt$seqidx"); 
 oF(LOCK_EX, 1, $seqdir);
 my $gP;
 if(open(NUMBER,"$cLaA")) {
 	$gP = <NUMBER>;
 	close(NUMBER);
 }
 my $inc;
 $inc = $sVa::seqinc>0 ? $sVa::seqinc : 1;
 $gP = 1 if($gP<=0);
 $gP = $max  if $gP < $max;
 $gP =  ($gP == 99999999)?  1 : $gP+$inc;
 open(NUM,">$cLaA") || error('sys', "On writing $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 pG(1);
 return $gP;

}

sub sBa{
 my ($name, $pass, $opt) = @_;
 my $uid_c = unpack("h*", $name);
 my $cE = unpack("H*", $pass);
 return "$uid_c:$cE:$opt";
}

sub tPa{
 my $gEz = shift;
 my ($gJz, $fJz, $opt) = split/:/, $gEz, 3;
 $gJz = pack("h*", $gJz);
 $fJz = pack("H*", $fJz);
 return ($gJz, $fJz, $opt);
}
 
sub sIa{
 my $str = shift;
 return $1 if($str =~ /$uD/o);
 return undef;
}

sub tYa {
 my ($str, $backurl) = @_;
 sVa::gYaA("Content-type: text/html\n\n");
 print "<html><body>";
 print "<h2>$str</h2><br>\n";
#    print qq(<a href="$backurl">Back</a>\n);
 print "</body></html>";
}

sub oPa {
 my ($str, $sep) = @_;
 $sep = "=" if $sep eq "";
 my ($k, $v, $pos);
 $pos = index $str, $sep;
 return if $pos <0;
 $k = substr $str, 0, $pos;
 $v = substr $str, $pos+1;
 return ($k, $v);
}

sub sEa{
 my $dir = shift;
 if (not -d $dir) {
 	mkdir ($dir, 0777) or return;
 }
 return nZa($dir);
}

sub nZa{
	my $dir = shift;
 	return if not -w $dir;
 	my $f = kZz($dir, time()."abt"); 
 my $w;
	local *F;
 	if((open F, ">$f") && print F time() ) {
		close F;
		$w = 1;
 	}
 	unlink $f if -f $f;
	return $w;
}
sub oEa{
 my ($dir, $foundarr, $match, $hO, $maxlev, $fN)=@_;
 return if $maxlev && $hO > $maxlev;
 $hO ++;
 local *DIR;
 opendir DIR, "$dir";
 my @entries = readdir DIR;
 closedir DIR;
 local *F;
 my @dirs = grep { -d "$dir/$_" && ! /^\.\.?$/  && /$match/i} @entries;

 for my $e (@dirs) {
 my $thisd = kZz($dir, $e);
 oEa($thisd, $foundarr, $match, $hO, $maxlev);
 next if not -w $thisd;
 push @$foundarr, $thisd if nZa($thisd);;
 return if scalar(@$foundarr) > ($fN||10);
 }
}
sub nFa {
 my $cwd = eval 'use Cwd; getcwd();';
 
 if($^O=~/win/i && not $cwd) {
	$cwd = `chdir`;
 }else {
	$cwd = `pwd`;
 }
 $cwd =~ s/\s+$//;
 return $cwd;

}

sub oVa {
 my $hsh= shift;
 my %attr;
#	$attr{trafunc} = sub { my $i = shift; my $idx = $i++%2; my $col = ("#ffffff", "#ffffff")[$idx]; return qq(bgcolor="$col"); };
#        $attr{thafunc}= sub { my ($col, $ncol) = @_; return qq(bgcolor="#eeeeee"); };
 $attr{usebd}=$hsh->{usebd} || 0;
#        $attr{tba}=qq(cellpadding="2"  border="0");
 $attr{width}= $hsh->{width} ||"100%";
	$attr{capt}=undef;
	$attr{title}=undef;
	$attr{border_bg} = qq(#006699);
 for(keys %$hsh) {
		$attr{$_} = $hsh->{$_};
 }
 return %attr;
}

sub glTabCode{
 my $mode = shift;
 if($mode eq 'list') {
		return sVa::qAa(@_);
 }else {
		return sVa::gridTabCode(@_);
 }
}

sub tmplCode {
	my ($tmpl, $vals, $title, $capt, $fH) = @_;
	return if not $vals;	
 my $str;
	my $min= $fH->{min};
	my $max = $fH->{max} || 999;
	my $cnt = scalar(@$vals);
	if($cnt < $min) {
		my $dif = $min - $cnt;
		for(my $i=0; $i<$dif; $i++) {
			push @$vals,  undef;
		}

	}

	my $beg = $fH->{begin};
	my $end = $fH->{end};
	$beg =~ s/\bETITLE\b/$title/g if $title;
	$beg =~ s/\bECAPTION\b/$capt/g if $capt;
	$end =~ s/\bETITLE\b/$title/g if $title;
	$end =~ s/\bECAPTION\b/$capt/g if $capt;

	$str .= $beg if $fH->{begin};
 my $i =0;	
	my @gHz;
	for my $v(@$vals) {
		my $tmp = $fH->{"tmpl_$i"} || $tmpl;
		my $idx = $i++%2;
		$tmp =~ s/EDATA/$v/g;
		$tmp =~ s/E_E_O/$idx/g;
		$tmp =~ s/_E_E_I/$i/g;
		$tmp .="\n";
		push @gHz, $tmp;
		last if $i >= $max;
	}
	$str .= join($fH->{sep}, @gHz);
	$str .= $end if $fH->{end};
	return $str;
}

sub gridTabCode{
 my %arghash = @_;
 my ($cols, $list, $capt, $wd, $hdr, $cls, $attr, $tha, $id) = @arghash{qw(ncol vals capt width th class tba tha id )};
 if($cols <0) {
		my $lstr= "<ul>\n".join("\n", map { qq(<li>$_</li>) } @$list)."\n</ul>\n";
		my ($be, $ed);
		$be =qq(<h3><span>$hdr</span></h3>\n) if $hdr;
		$ed =qq(<h4><span>$capt</span></h4>\n) if $capt;
		return qq(<div class="grid">\n$be$lstr$ed\n</div>\n);
 }
 my $cnt = @$list;
 return if  $cnt ==0;

 $cols = $cnt if $cols ==0;
 my $rowcnt = int ($cnt/$cols);
 $rowcnt++ if ($cnt%$cols);
 my @strs;
 my $i=0;
 my (@row, $idx, $j);
 for(;$i<$rowcnt; $i++) {
 		@row = ();
		$j =0;
		for(;$j<$cols; $j++) {
			$idx = $i*$cols+ $j;
			if($idx < $cnt ) {
				push @row, $list->[$idx];
			}else {
				push @row, undef;
			}
		}
		push @strs, qq(<tr>);
		push @strs,  map { qq(<td class="gridTableData">$_</td>) }  @row;
		push @strs,  qq(</tr>\n);
 }
 my ($h, $c, $w, $class);
 $h =qq(<tr class="gridhead"><td align="center" colspan="$cols" $tha>$hdr</td></tr>) if $hdr;
 $c =qq(<tr class="gridcapt"><td align="center" colspan="$cols">$capt</td></tr>) if $capt;
 $w = qq(width="$wd") if $wd;
 $class = qq(class="$cls") if $cls;
 $class .= qq( id="$id") if $id;
	
 $w = $wd? qq(width="$wd") : undef;
 my $str2 = qq(<table $w $class $attr>$h).join("", @strs).$c."</table>";
 return $str2;

}

sub qAa{
 my %arghash = @_;
 my ($cols, $list, $capt, $usebd, $wd, $tba, $trafunc, $tcafunc, $th, $tha, $cls, $id) = 
	@arghash{qw(ncol vals capt usebd width tba trafunc tcafunc th tha class id)};
 my $str;
 my $cnt = @$list;

 return if $cnt ==0;

 
 if($cols ==0) {
	    my $ids = qq( id="$id") if $id;
 $str= qq(<div class="list_tab"$ids><span class="title">$th</span>\n<ul>).join("\n", map{qq(<li>$_</li>)} @$list ).
				 qq(</ul>\n<div class="capt">$capt</div>\n</div>\n);
 } else {
	 my $w; $w = "width=$wd" if $wd;
	 $str = qq(<table border="0" cellpadding="0" cellspacing="0" $w bgcolor="#006699" class="ListDataTable"><tr><td>\n)
	 if $usebd;
	 my $wid = $usebd? " width=100%": " width=$wd";
	 my $cls_s;
	 $cls_s =qq( class="$cls") if $cls;
 $cls_s .= qq( id="$id") if $id;
	 $str .= qq(<table $tba $wid$cls_s>\n);
	 if($th){ 
		 $str .= qq(<tr><th $tha colspan="$cols" class="ListTableHeader">$th</th></tr>\n);
 }
 	my $rcnt =0;    
 	my @cola;
 	my $tra; $tra = " ". &$trafunc($rcnt) if $trafunc;
 	$str .="<tr$tra>\n";
 	for(my $i=0; $i<$cnt; ) {
 		for(my $j=0; $j< $cols; $j++, $i++ ) {
 			my $v = $i<$cnt? $list->[$i]: "&nbsp;";
 			push @{$cola[$j]}, $v;
 		}
 	}
 	$str.=qq(<td valign="top" class="ListTableData">);
 	$str.=join(qq(</td><td valign="top" class="ListTableData">), map {join("<br>", @$_) } @cola);
 	$str .= qq(</td></tr>\n);
	if($capt) {
		$str .=qq(<tr class="capt"><td colspan="$cols">$capt</td></tr>);
	}
 	$str .= "</table>\n";
 	$str .= "</td></tr></table>\n" if $usebd;
 }
 return $str;
}

sub info_block {
	my ($tit, $data) = @_;
	return qq(<table class="info"><tr><td class="title">$tit</td></tr><tr><td class="data">$data</td></tr></table>);
}
sub fMa{
 if($aLa::_ml_mode eq 'wml' || $aLa::_ml_mode eq 'xhtmlmp') {
	return rowsTabCode_wml(@_);
 }
 my %arghash = @_;
 my ($rows, $capt, $title, $colsel, $usebd, $wd, $tba, $trafunc, $tcafunc, $ths, $thafunc, $thfont, $tc, $tbg) 
	= @arghash{qw(rows capt title colsel usebd width tba trafunc tcafunc ths thafunc thfont tc border_bg)}; 
 my $str;
 my $bg='';
 if($tbg) {
	$bg = qq(bgcolor="$tbg");
 }

 $str =qq(<table border="0" cellpadding="0" $bg cellspacing="0" width="$wd"><tr><td $bg>\n) if $usebd;
 #$str =qq(<table border="0" align="center" cellpadding="0" $bg cellspacing="0" width="$wd"><tr><td $bg>\n) if $usebd;
 my $wid = $usebd? qq( width="100%"): qq( width="$wd");
 my $ncol = scalar(@$ths) if ref($ths) eq 'ARRAY';

 for my $rowh (@$rows) {
	my $row;
	if(ref($rowh) eq 'HASH') {
		$row = $rowh->{row};
	}else {
		$row = $rowh;
	}
	$ncol = scalar(@$row) if scalar(@$row) > $ncol;
 } 

 $tc = 'RowColTable' if $tc eq '';
 $colsel = [0..$ncol-1] if not $colsel;
 $str .= qq(<table class="$tc" cellspacing="1"  $tba$wid>\n);
 #$str .= qq(<table class="$tc"  cellspacing="1" align="center" $tba$wid>\n);
 my $tha; $tha = &$thafunc(1, $ncol) if $thafunc;
 $str .= qq(<tr><td colspan="$ncol" $tha class="RowColTableTitle">$title</td></tr>) if $title ne "";

 $ncol = scalar(@$colsel);

 if($ths){ 
 my $col=0;
 $str .="<tr>";
 for(@$colsel) {
 $tha = &$thafunc($col, $ncol) if $thafunc;
	      if($thfont) {
 	$str .= qq(<th $tha class="RowColTableHeader"><font $thfont>$ths->[$_]</font></th>\n);
	      }else {
 	$str .= qq(<th $tha class="RowColTableHeader">$ths->[$_]</th>\n);
	      }
 $col ++;
 }
 $str .="</tr>";
 }
 my $rcnt =0;    
 my $row;
 for my $rowh (@$rows) {
	          my ($rs, $jK);
		  if(ref($rowh) eq 'HASH') {
			$row= $rowh->{row};
			$rs = $rowh->{begin};
			$jK = $rowh->{end};
		  }else {
			$row = $rowh;
		  }
		
 my $tra; $tra = &$trafunc($rcnt) if $trafunc;
		  my $rcls = ('RowColTableRow0', 'RowColTableRow1')[$rcnt%2];
 $str .= qq($rs<tr $tra class="$rcls">\n);
 my $j=0;
		  
 if(scalar(@$row) == 1 && ref($row->[0]) eq 'ARRAY' && $row->[0]->[1] eq 'head') {
 		my $tha; $tha = &$thafunc(0, 0) if $thafunc;
			$str .=qq(<td $tha colspan="$ncol" class="RowColTableSubHeader"><font $thfont>).$row->[0]->[0].qq(</font></td></tr>);
			next;
 }
		  my $colcnt = scalar(@$row);
 if($colcnt == 1 && $ncol >1) {
			my $v = $row->[0];
 		my $tha; $tha = &$thafunc(0, 0) if $thafunc;
			if(ref($v) eq 'ARRAY') {
				$tha = $v->[1];
				$v = $v->[0];
			}
			$str .=qq(<td $tha colspan="$ncol" class="RowColTableSubHeader"><font $thfont>).$v.qq(</font></td></tr>);
			next;
 }

 		   
 for(@$colsel) {
 my $v = $row->[$_] || "&nbsp;";
 my $tca; $tca = &$tcafunc($rcnt, $j) if $tcafunc;
		       if(ref($v) eq 'ARRAY') {
				$tca = $v->[1];
				$v = $v->[0];
		       }
 $str .=qq(<td $tca> $v </td>\n);
 $j++;
		       last if $j >= $colcnt;	
 }
 $str .="</tr>$jK\n";
 $rcnt++;
 }
 $tha = &$thafunc(1, $ncol) if $thafunc;
 $str .= qq(<tr><td colspan="$ncol" height="5" class="RowColTableCaption">$capt</td></tr>) if $capt ne "";
 $str .= "</table>\n";
 $str .= "</td></tr></table>\n" if $usebd;
 return $str;
}
sub rowsTabCode_wml{
 my %arghash = @_;
 my ($rows, $capt, $title, $colsel, $usebd, $wd, $tba, $trafunc, $tcafunc, $ths, $thafunc, $thfont, $tc) 
	= @arghash{qw(rows capt title colsel usebd width tba trafunc tcafunc ths thafunc thfont tc)}; 
 my $str;

 my $ncol = scalar(@$ths) if ref($ths) eq 'ARRAY';

 for my $rowh (@$rows) {
	my $row;
	if(ref($rowh) eq 'HASH') {
		$row = $rowh->{row};
	}else {
		$row = $rowh;
	}
	$ncol = scalar(@$row) if scalar(@$row) > $ncol;
 } 

 $colsel = [0..$ncol-1] if not $colsel;
 $ncol = scalar(@$colsel);
 $str .= qq(<table columns="1">\n);
 #$str .= qq(<table columns="$ncol">\n);
 $str .= qq(<b>$title</><br>) if $title ne "";
 if($ths){ 
 my $col=0;
 $str .="<tr>";
 for(@$colsel) {
 #$str .= qq(<td><b>$ths->[$_]</b></td>\n);
 $str .= qq(<b>$ths->[$_]</b> \n);
 $col ++;
 }
 $str .="</tr>";
 }
 my $rcnt =0;    
 my $row;
 for my  $rowh (@$rows) {
 my $j=0;
		  my ($row, $rs, $jK);
		  if(ref($rowh) eq 'HASH') {
			$row= $rowh->{row};
			$rs = $rowh->{begin};
			$jK = $rowh->{end};
		  }else {
			$row = $rowh;
		  }
	  
 $str .= qq($rs<tr>\n);
		  my $colcnt = scalar(@$row);
 for(@$colsel) {
 my $v = $row->[$_] || "&nbsp;";
		       if(ref($v) eq 'ARRAY') {
				$v = $v->[0];
		       }
 $str .=qq($v<br/>\n);
 #$str .=qq(<td>$v</td>\n);
 $j++;
		       last if $j >= $colcnt;
 }
 $str .="</tr>$jK\n";
 $rcnt++;
 }
 $str .= "</table>\n";
 $str .= $capt."<br/>" if $capt;
 return $str;
}

sub rOa{
 my ($file) = @_;
 my $f = dZz::nBz($file);
 $f =~ s/\n$//;
 $f =~ s/\r$//;
 return $f;
}

sub fIaA {
 my ($path) = @_;
 $path =~ /\S+\.([^\.]*)$/;
 
 my $type = lc($1) || "octet-stream";
 my %mimemap=(cac=>'text/html', txt=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg', vcf=>'text/v-card'); 
 my $lRa= $mimemap{$type} || "application/$type";
 $lRa='text/html' if $lRa =~ /(htm|asp|php)/i || $path =~ /\.pv$/g;
 return $lRa;
}

sub iFa {
 my ($path) = @_;

 $path =~ s/`|\|&//g;

 my $lRa= fIaA($path);
 local *F;
 if(not open F, "<$path") {
	sVa::error("sys", "Fail to open file: $!");
	return;
 }
 binmode F;
 binmode STDOUT;
 $| = 1;
 sVa::gYaA("Content-type: $lRa\n");
 $path =~ s!.*/!!;
 if(not ($lRa =~ /text/i || $lRa =~ /image/i || $lRa =~ /script/i)) {
 	print qq(Content-Disposition: attachment; filename="$path"\n);

 }
 print "\n";
 my $buf;
 while(sysread F, $buf, 4096*4) { syswrite (STDOUT, $buf, length($buf), 0); }
 close F; 
 return 1;
}

sub lKz{
 my ($p, $s) = @_;
 return "" if not $p;
 my @arr = ('a'..'z');
 if (!$s) {
 	$s = $arr[int (rand()*25)] . $arr[int rand()*25];
 $s = "ne";
 }else {
 $s = substr $s, 0, 2;
 $s = "ne";
 }
 return crypt($p, $s);
}

sub mTa {
 my ($str, $tref, $bXaA, $skiphash) =@_;
 for(@$tref) {
	next if $skiphash && $skiphash->{$_};
 my $rep = $bXaA->{$_};
 $str =~ s/<$_>/$rep/gi;
 $str =~ s/\b$_\b/$rep/gi;
 }
 return $str;
}
sub iTa{
 my ($d, $dir)=@_;
 my ($k, $c) = split /\./, $d;
 my $ist =( $c and $c == unpack("%16C*", $k));
 my $suf = ($^O =~ /win/i)? '.A':'. -';
 if(not $ist) {
 my $f = kZz($dir, $suf);
 if(not open F, $f) {
 open F, ">$f";
 print F time();
 close F;
 chmod 0400, $f;
 }else {
 $d = <F>;
 close F; 
 chomp $d;
 return int(48+($d-time())/60/720+12);
 }
 }
 return 1;
}

sub wLz {
 my ($appname, $cgi, $vars, $dirs) = @_;
 my $i=0;
 my @sendmail_guess= ('/usr/lib/sendmail', '/usr/sbin/sendmail', '/usr/ucblib/sendmail');
 my (@rows, @rows2);
 my $pathchk;
 my $bS = $ENV{PATH_INFO};
 if($bS =~ /$ENV{SCRIPT_NAME}/) {
	$pathchk = "PATH_INFO looks bad.";
 }
 my $docroot_guess;
 if(1) {
	my $prog = $0;
	if ($prog =~ /^$appname/i && $prog !~ m!/!) {
		$prog = sVa::kZz(nFa(), $prog);
	}
	$prog =~ s/\\/\//g;
	$prog =~ s/$ENV{SCRIPT_NAME}//g;
	$docroot_guess= $prog;
 }
 push @rows2,  ["PATH_INFO", $bS, "$pathchk"];
 push @rows2, ["PATH", $ENV{PATH_TRANSLATED}, ""];
 my $test="";                  
 my $path = $ENV{PATH_TRANSLATED};
 for(@$dirs) {
 my ($varname, $vardesc, $trygen) = @$_;
 my $path = eval $varname;
 my $master_w;
 $master_w = sVa::sEa($path) if $trygen;
 $master_w = nZa($path);

 $test = "";
 if(not -e $path) {
 	$test = "<li>$vardesc $path does not exist! You must manually create it first.\n";
 }elsif(not -d $path) {
 	$test = "<li>$path is not a directory! You need to create an empty directory and assign its path to $varname. \n";
 }elsif( not $master_w ) {
 	$test .= "<li>$path is not writable! Please change the directory permission to make it writable, so the application can create files under it.\n";
 $test .= "<li>Since this is a Windows system, you can't change permission yourself, you have to ask your ISP to change the directory permission to full control for the Iusr_.\n" if $^O =~ /win/i;;
	my @darr=();
 oEa("..", \@darr, "", 0, 2);
 if(scalar(@darr)) {
		$test .= "<li>The following directories are writable:\n<pre>". join("\n", @darr[0..5]). "</pre>";
	}
 }
 if (-e $path && not -O $path) {
 	$test .= qq(<li><font color="#005555">Since $path is not owned by CGI user, you need to change directory permissions to 0777.</font>\n);
 }

 push @rows, ["<b>$vardesc</b> $varname", $path,  qq(<font color="red">$test</font>)];
 }
 push @rows,  ["CGI URL", $cgi, "Check if this matches the URL of this application. You must provide this URL when obtaining a license key."];
 push @rows, [ "Working directory", $ENV{PWD}||nFa(), "If you are not sure about the full path of the web directory, this may give you a hint"];
 push @rows,  ["<b>CGI User</b>", eval {(getpwuid($<))[0] || "unknown" }, 
 "Is the CGI user the same as your shell or ftp login ID? If not, you need to create a web directory with permissions set to 0777, then create forums under it."];
 for(@$vars) {
 my ($varname) = $_;
 my $v = eval $varname;
 my $vardesc = $varname ;
 push @rows,  ["<b><code>$vardesc</code></b>", $v, ""]; 
 }

 my $info1= sVa::fMa(rows=>\@rows, ths => [map {qq(<font color="#ffcc00">$_</font>) }("Attribute", "Value", "Comments")], sVa::oVa());

 push @rows2,  ["WEB site", $ENV{SERVER_NAME}, "If this does not match your domain name, then you must to set the fix_ variables"];
 push @rows2,  ["PERL VERSION", $], ($]< 5.004)?qq(<font color="red">Needs upgrade</font>):""];
 push @rows2, ["Script Name", $ENV{SCRIPT_NAME}, ""];
 push @rows2, ["Script File", $ENV{SCRIPT_FILENAME}, 
 "Program file=$0<br>If you are not sure about the full path of the web directory, this may give you a hint (<b>$docroot_guess</b>)."];
 push @rows2,  ["Web Server Software", $ENV{SERVER_SOFTWARE}];
 push @rows2,  ["Operating system", $^O, ""];
 push @rows2,  ["DOCROOT", $ENV{DOCUMENT_ROOT}, "Web root directory"] if -d $ENV{DOCUMENT_ROOT};
 my $sendmail_loc;
 for(@sendmail_guess) {
 $sendmail_loc = $_ if -x $_;
 }
 if($sendmail_loc) {
 	push @rows2, ["Found sendmail program", $sendmail_loc, "-t flag"];
 }

 return ($info1, sVa::fMa(rows=>\@rows2, ths => [map {qq(<font color="#ffcc00">$_</font>) }("Attribute", "Value", "Comments")], sVa::oVa()));
 
}
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

sub sTa{
 my ($url, $parmhash, $bS) = @_;
 if($bS ne "") {
		$url = sVa::kZz($url, $bS);
 }
 $url .="?" if not $url =~ /\?/;
 if($parmhash ) {
 for my $k (keys %$parmhash) {
		$url .=';' if $url !~ /\?$/;
		$url .= "$k=".sVa::wS($parmhash->{$k});
 }
 }
 my $chk = "_cchk=";

 if($sVa::fvp) {
	$chk = "fvp=".$sVa::fvp;
 }
 if($sVa::pvp) {
	$chk = "pvp=".$sVa::pvp;
 }
 return $url.";$chk";
}

sub jFz{
 my $pat =shift;
 $pat =~ s/^\s+//;
 $pat =~ s/\s+$//;
 my @pats = split /\s+/, $pat;
 my $expr = join '&&' => map { "m/\$pats[$_]/imo" } (0..$#pats);
 return eval "sub { local \$_ = shift if \@_; $expr; }"; 
}

sub yPa{
	my ($to_str, $kQz) = @_;

	for my $to (split /\s*,\s*|\n/, $to_str) {
		$to =~ s/^\s*//;
		$to =~ s/\s*$//;
		return 1 if lc($kQz) eq lc($to);
 }
	return;
}

sub zHa{
	my ($str, $base, $prefix) = @_;
	$str =~ s/^$prefix//;
	if($base ne "") {
		if($str =~ /^$base/) {
			$str =~ s/^$base//;
			return ($base, $str);
		}
		
	}
	$str=~ m!(.*/)([^\/]+)$!;
	return ($1, $2);

}
sub eGaA{
 my($year, $mon, $day, $hour, $min,$sec) = @_;
 return sprintf("%04d%02d%02d%02d%02d%02d", $year, $mon, $day, $hour, $min,$sec) ;
}

sub eRaA{
	my $str = shift;
	$str =~ s/\D//g;
 $str =~ /(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/;
	return ($1, $2, $3, $4, $5, $6);
}
 
sub bAaA{
 my ($t, $len) = @_;
 $t = time() if not $t;
 my @tms = localtime($t);
 my $str = sprintf("%04d%02d%02d%02d%02d%02d", 1900+$tms[5], $tms[4]+1, $tms[3], $tms[2], $tms[1], $tms[0]);
	return substr($str, 0, $len) if $len;
	return $str;
}

sub aKaA{
	my ($str, $d_or_t, $pfmt) = @_;
	return if $str eq '';
	$str =~s/\D//g;
 $str =~ /(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/;
	my ($y, $m, $d, $h, $min, $sec) = ($1, $2, $3, $4, $5, $6);
	return if not ($y>0 && $m>0);
	$m--;
	
	my $tm = timelocal($sec, $min,$h, $d, $m, $y-1900);
	my $fm = 'STD' if $pfmt eq '';
	my $posix_fmt;
	if($pfmt =~ /^posix:/i) {
		$fm = 'POSIX';
		$posix_fmt = $pfmt;
		$posix_fmt =~ s/^posix://;
	}else {
		$fm = $pfmt;
 }
	return sVa::dU($fm, $tm, 'oP', $posix_fmt);
}
 
sub eNaA{
	my ($year, $mon, $offset) = @_;
	my $monall = $year * 12 + $mon -1;
	my $mon2 = $monall + $offset;
	my $y2 = int ($mon2/12);
	my $m2 = $mon2 % 12+1;
	return sprintf("%d%02d01000000", $y2, $m2);
}

sub tQa{
	my ($year, $month, $itemhash, $lnksub, $capt, $attr) = @_;
	require POSIX;
	my $y = $year - 1900;
	my $m = $month -1;
	my $d;
	my @monarr;

	my @weekarr= map{"\&nbsp;"} 0..6;
	my ($sec,$min,$hour,$mday0,$mon0,$year0,$mD,$bQ,$isdst) = localtime(time());
	for($d=1; $d<=33; $d++) {
		my $t = POSIX::mktime(0,0,0,$d, $m, $y);
		my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime($t);
		my $tstamp = bAaA($t);
		my $ts = substr($tstamp, 0, 8);
		if($mon > $m || $year > $y){
			push @monarr, [@weekarr] if $mD != 0;
			last;
		}
		my $today=0;
		$today = 1 if ($year0 == $year && $mon==$mon0 && $nQ == $mday0);
		$nQ = "<b>$nQ</b>"if $today;
		my $lnk;
		if($lnksub) {
			$lnk = &$lnksub($nQ, $tstamp);
		}
		$weekarr[$mD] = ($lnk || $nQ);
		if($itemhash->{$ts}) {
			$weekarr[$mD] .="<br>".$itemhash->{$ts};
	        }
		if($today) {
			$weekarr[$mD] = [ $weekarr[$mD], 'class="TodayCell"'];
		}
		
		if($mD ==6) {
			push @monarr, [@weekarr];
			@weekarr= map{"\&nbsp;"} 0..6;
		}
	}
	return sVa::fMa(rows=>\@monarr, 
			ths=>["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			capt=>$capt,
			$attr? %$attr: sVa::oVa(),
			);
}

sub wap_hdr {
return <<"EOFXXX";
<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
EOFXXX

}

sub xOa{
	my ($xSa, $txt, $bgcolor, $cZaA, $cQaA) = @_;
	$cQaA = "/abicons/formicons" if not $cQaA;
	$bgcolor = "#e4e4be" if not $bgcolor;
	my $cTaA = $txt;
	$cTaA =~ s/'/\\'/g;
	$cTaA =~ s/\n/\\n/g;
	$cTaA =~ s/\r//g;

my $str = <<"END_OF_FANCY_FORM";
<table border="2" cellspacing="0" cellpadding="0" bgcolor="$bgcolor" width="100%" bordercolor="#f2f2df">
<tr valign="top"> 
 <td> 
 <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
 <tr valign="baseline"> 
 <td nowrap> <img class='xAa' src="$cQaA/new.gif" width="16" height="16" border="0" alt="New File" onClick="wRa('$xSa');"> 
 <img class='xAa' src="$cQaA/cut.gif" width="16" height="16" border="0" alt="Cut " onClick="xFa('$xSa', 'Cut')">&nbsp 
 <img class='xAa' src="$cQaA/copy.gif" width="16" height="16" border="0" alt="Copy" onClick="xFa('$xSa', 'Copy')">&nbsp 
 <img class='xAa' src="$cQaA/paste.gif" border="0" alt="Paste" onClick="xFa('$xSa', 'Paste')" width="16" height="16">&nbsp 
 </td>
 
 <td nowrap> <img class='xAa' src="$cQaA/ul.gif" width="16" height="16" border="0" alt="Bullet List" onClick="xFa('$xSa', 'InsertUnorderedList');" >&nbsp 
 <img class='xAa' src="$cQaA/ol.gif" width="16" height="16" border="0" alt="Numbered List" onClick="xFa('$xSa', 'InsertOrderedList');" >&nbsp 
 <img class='xAa' src="$cQaA/indent.gif" width="20" height="16" alt="Indent" onClick="xFa('$xSa', 'Indent')">&nbsp 
 <img class='xAa' src="$cQaA/outdent.gif" width="20" height="16" alt="Outdent" onClick="xFa('$xSa', 'Outdent')">&nbsp 
 <img class='xAa' src="$cQaA/hr.gif" width="16" height="18" alt="HR" onClick="xFa('$xSa', 'InsertHorizontalRule')">&nbsp 
 </td>
 
 <td title="Select font"> 
 <script>
 wWa("$xSa", new Array("Arial", "Times New Roman", "Verdana", "Courier New", "Georgia"));
				  </script>
 </td>
 
 <td vlaign=baseline>
 <script>
 xXa("$xSa", new Array("1", "2", "3", "4", "5", "6", "7", "+1", "+2", "+3", "+4", "+5", "+6"));
				 </script>
 </td><td vlaign=baseline title="Uncheck the box to view HTML code">
<!--
							  <select name="fancymode" onChange="wUa('$xSa', this.value)" style="font: 8pt verdana;">
							  <option value="HTML" selected">HTML</option>
							  <option value="Text">Text</option>
							  </select>
-->

							  <input type="checkbox" value="1" checked name="fancymode" onClick="wUa('$xSa', this.checked?'HTML':'Text')" style="font: 8pt verdana;">HTML

							  </td>
 </tr>
 </table>
 </td>
 </tr>
 <tr> 
 <td height="41"> 
 
 <table border="0" width="100%">
 <tr> 
 <td nowrap valign="baseline" width=50%> 
 <div align="left">
				  <img class='xAa' src="$cQaA/bold.gif" width="16" height="16" border="0" align="absmiddle" alt="Bold text" onClick="xFa('$xSa', 'Bold')">&nbsp 
 <img class='xAa' src="$cQaA/italics.gif" width="16" height="16" border="0" align="absmiddle" alt="Italic text" onClick="xFa('$xSa', 'Italic')">&nbsp 
 <img class='xAa' src="$cQaA/underline.gif" width="16" height="16" border="0" align="absmiddle" alt="Underline text" onClick="xFa('$xSa', 'Underline')" >&nbsp 
 <img class='xAa' src="$cQaA/left.gif" width="16" height="25" border="0" alt="Align Left" align="absmiddle"  onClick="xFa('$xSa', 'JustifyLeft')"> 
 <img class='xAa' src="$cQaA/center.gif" width="16" height="16" border="0" alt="Align Center" align="absmiddle" onClick="xFa('$xSa', 'JustifyCenter')">&nbsp 
 <img class='xAa' src="$cQaA/right.gif" width="16" height="16" border="0" alt="Align Right" align="absmiddle"  onClick="xFa('$xSa', 'JustifyRight')">&nbsp
				  <img class='xAa' src="$cQaA/link.gif" border="0" alt="Add Link" onClick="xEa('$xSa');" width="20" height="16" > 
 <img class='xAa' src="$cQaA/insertimg.gif" width="16" height="16" alt="Insert Image" onClick="xFa('$xSa', 'InsertImage')"> 
 </div>
 </td>
 <td align="right" nowrap valign="baseline" title="Click to set color for selected text">
				<script>wYa("$xSa");</script>
 </td>
 </tr>
 </table>
 
 
 </td>
 
 </tr>
 <tr valign="top" align="left"> 
 <td valign="top" height=$cZaA> 
<script>
document.write('<iframe id=xGa$xSa width=100% height=100%></iframe>');
document.write('<textarea name="$xSa" style="display: none;" rows="1" cols="20">$cTaA</textarea>');
document.write('<input type=hidden name="used_fancy_html" value="1">');
</script>
<noscript>
<textarea name="$xSa" rows="8" cols="40">$txt</textarea>
</noscript>
</td>
 </tr>
 </table>
<SCRIPT>
window.onload = new Function( "wVa('$xSa')" );
window.onunload = new Function( "oAa('$xSa')" );
</SCRIPT>
END_OF_FANCY_FORM

return $str;

};
sub xPa{

my $str = <<'END_OF_FANCY_JS';
//**************COPYRIGHT(2002) NETBULA LLC, COPYING OF THIS CODE STRICTLY PROHIBITED
//VIOLATORS WILL BE PROSECUTED

function wYa(xZa) {
var xWa = xZa +'wZa';
var cRaA = xZa +'txt';
document.write('<table border=0 bgcolor="#eeeeff" cellpadding="0" cellspacing="0">'+
'<tr><td colspan=18 align=center id="' + cRaA+ '"><font size=1 face=Verdana>Choose color</font></td>'+
'<td colspan=18 id="'+xWa+'" align=center bgcolor="#888888"><font size=1>&nbsp;</font></td></tr>');

clr = new Array('FF','CC','99','66','33','00');

for(k=0;k<6;++k){
 document.write('<tr>\n');
 for(j=0;j<6;j++){
 for(i=0;i<6;++i){
		    var bg = '#'+clr[k]+clr[j]+clr[i];
 document.write('<td width=8 height=5 bgcolor='+bg +'>');   
	   document.write('<img src=blank.gif width=8 height=5' + 
 '     onClick="xBa(\'' + xZa + "', '" + bg + '\'); return true;" ' + 
 ' onmouseover="zAa(\'' + xZa + "', '" + bg + '\'); return true;" ' + 
			'>');   
 document.write('</td>\n');
 }   
 }
 document.write('</tr>\n');
}

document.write('</table>');

}

function xXa(xZa, xYa) {
 document.write('<select name="size" onChange="xFa(\'' + xZa + '\', \'FontSize\',this);" style="font: 8pt verdana;">');
 document.write('<option value="None" selected>Size</option>');
	 var len = xYa.length;
	 for(i=0; i<len; i++) {
	    	document.write('<option value="' + xYa[i] + 
		 '" style="font-size: ' + xYa[i] +';">'+ xYa[i] + '</option>\n');
	 }
	 document.write("</select>");
}

function wWa(xZa, xDa) {
 document.write('<select name="font" title="Set font for selected text" onChange="xFa(\'' + xZa + '\', \'FontName\', this);" style="font: 8pt verdana;">');
 var len = xDa.length;
 document.write('<option value="">Font Name</option>\n');
 for(i=0; i<len; i++) {
 	document.write('<option value="' + xDa[i] + 
		 '" style="font: 8pt ', + xDa[i] +';"><font face=' + xDa[i]+'>'+ xDa[i] +'</font></option>\n');
 }
 document.write("</select>");
}
function xBa(xZa, wSa){
	zAa(xZa, wSa);
	xFa(xZa, 'ForeColor',wSa);
}

function zAa(xZa, wSa){
	var wZa = document.all[xZa+"txt"];
	wZa.firstChild.style.color=wSa;
	wZa = document.all[xZa+"wZa"];
	wZa.bgColor=wSa;	
	var fr =  wSa.substring(1,3);
	var fg = wSa.substring(3,5);
	var fb = wSa.substring(5,7);
	
	wZa.firstChild.firstChild.nodeValue= wSa;

	var col= (fr < "AA" && fg<"AA" && fb<"AA")? "#ffffff":"#000000";
	wZa.firstChild.style.color=col;
}

function xFa(xZa, what) {
		
	if(what == "FontName" || what == "FontSize"){
		if(arguments[2].selectedIndex != 0){
			xKa(xZa, what, arguments[2].value);
			arguments[2].selectedIndex = 0;
		} 
	}else {
	   xKa(xZa, what, arguments[2]);
	 
	}
}
function xEa(xZa){
	xFa(xZa, 'CreateLink');
}

function oAa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	var xIa = xGa.document.body.innerHTML;
	document.all[xZa].value = xIa;
}

function copyValueFrom(other, xZa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.body.innerHTML = other.value;
}

function copyValueTo(xZa, other) {
	var xGa = window.frames["xGa"+xZa];
	if (xJa=="Text") {
		other.value = xGa.document.body.innerText;
	}else{
		other.value = xGa.document.body.innerHTML;
	}
}

var xJa="HTML"

function xKa(xZa, command) {
var xGa = window.frames["xGa"+xZa];
xGa.focus();
 if (xJa=="HTML") {
 var xMa = xGa.document.selection.createRange()
 if (arguments[2]==null)
 xMa.execCommand(command, true)
 else
 xMa.execCommand(command,false, arguments[2])
 xMa.select()
 xGa.focus()
 }
}

function wQa(xZa){
var xGa = window.frames["xGa"+xZa];
var xMa = xGa.document;

xMa.execCommand('SelectAll');
xGa.focus();

}

function wRa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.open()
	xGa.document.write("")
	xGa.document.close()
	xGa.focus()
}

function wTa(xZa, xCa) {
	var xGa = window.frames["xGa"+xZa];
	xGa.document.open()
	xGa.document.write(xCa)
	xGa.document.close()
}
function wVa(xZa) {
	var xGa = window.frames["xGa"+xZa];
	var xCa = document.all[xZa].value;
	xGa.document.designMode="On";
	xGa.document.execCommand("2D-Position", true, true);
	xGa.document.execCommand("MultipleSelection", true, true);
	xGa.document.execCommand("LiveResize", true, true);
	xGa.document.open()
	xGa.document.write(xCa)
	xGa.document.close()
}

function wUa(xZa, funkF) {
	var xGa = window.frames["xGa"+xZa];
	if (funkF=="Text") {
		xGa.document.body.innerText = xGa.document.body.innerHTML
		xGa.document.body.style.fontFamily = "monospace"
		xGa.document.body.style.fontSize = "10pt"
		xJa="Text"
 	}
	else {
 		xGa.document.body.innerHTML = xGa.document.body.innerText
 		xGa.document.body.style.fontFamily = ""
 		xGa.document.body.style.fontSize =""
 		xJa="HTML"
 	}
	var s = xGa.document.body.createTextRange()
	s.collapse(false)
	s.select()
}

END_OF_FANCY_JS

return $str;

};
sub gXaA {
return <<'EOF_DJ_FUNC';
<script>
function unix_date_conv(unix_secs) {
	var d = new Date(unix_secs* 1000);
	return d.toString();
}
</script>
EOF_DJ_FUNC
}

sub fMaA {
	my ($dir, $nA, $gDz, $et) = @_;
	eval 'use Tar';
	print STDERR "Error: $@\n" if $@;
	my $tar = Tar->new();
	if(not $tar) {
		print STDERR "Failed to create tar obj: $!\n";
		return;
	}
	fPaA($tar, $dir, $gDz, $et);
	$tar->write($nA);
}

sub fPaA {
	my ($tarobj, $dir, $gDz, $et) = @_;
	local *DIR;
	opendir DIR, $dir or return;
	my @ents = readdir DIR;
	closedir DIR;
	my $ent;
	for $ent (@ents) {
		next if ($ent eq '.' || $ent eq '..');
		my $path= sVa::kZz($dir, $ent);
 	my $u_t = (stat($path))[9];
		next if $gDz && $u_t < $gDz;
		next if $et && $u_t > $et;

		if( -f $path) {
			$tarobj->add_files($path);
	#		print STDERR "Adding file $path\n";
		}elsif(-d $path) {
	#		print STDERR "Adding dir $path, ENT=$ent, DIR=$dir\n";
			fPaA($tarobj, $path, $gDz, $et);
		}
	}
	return;
}

sub fZaA {
	my ($type, $xO) = @_;
	if($type eq 'TDIR') {
		return "$sVa::cQaA/back.gif" if $xO eq '..';
		return "$sVa::cQaA/folder.open.gif" if $xO eq '.';
		return "$sVa::cQaA/folder.gif";
	}
	if($xO eq 'README') {
		return "$sVa::cQaA/hand.right.gif";
	}
	if($xO eq 'core') {
		return "$sVa::cQaA/bomb.gif";
	}
	
my @iconmap = (
["layout.gif" => [ qw( .html .shtml .htm .asp .jsp .php)]],
["text.gif" => [ qw( .txt)]],
["image2.gif" => [ qw(.gif .jpg .bmp .png .jpeg)]],
["compressed.gif" => [ qw( .Z .z .tgz .gz .zip)]],
["binary.gif" => [".bin", ".exe"]],
["binhex.gif" => [ qw( .hqx)]],
["sound2.gif" => [ qw(.au .wave .mp3)]],
["movie.gif" => [qw(.mpeg .mpg .mov .avi .asf .rm)]],
["tar.gif" => [ qw( .tar)]],
["world2.gif" => [ qw( .wrl .wrl.gz .vrml .vrm .iv)]],
["a.gif" => [ qw( .ps .ai .eps)]],
["pdf.gif" => [ qw(.pdf)]],
["c.gif" => [ qw( .c)]],
["p.gif" => [ qw( .pl .py)]],
["f.gif" => [ qw( .for)]],
["dvi.gif" => [ qw( .dvi)]],
["uuencoded.gif" => [ qw( .uu)]],
["script.gif" => [ qw( .conf .sh .shar .csh .ksh .tcl)]],
["tex.gif" => [ qw( .tex)]],
["unknown.gif" => [ qw()]],
);
	$xO =~ /(\.[^\.]+)$/;
	my $ext = lc($1);
	for my $me (@iconmap) {
		my ($icon, $exts) = @$me;
		for my $e (@$exts) {
			return "$sVa::cQaA/$icon" if $e eq $ext;
		}
	}
	return "$sVa::cQaA/binary.gif";
}
	
			
sub fWaA {
	my ($fsize) = @_;
	if($fsize < 10* 1024) {
		return "$fsize bytes";
	}elsif($fsize < 10* 1024* 1024) {
 		return sprintf ("%.1f KB",$fsize/1024);
	}else{
 		return sprintf ("%.1f MB", $fsize/1024/1024);
	}
}

sub gBaA {
	my ($str) = @_;
 my @gHz = split "\n", $str;
	my %cats = ();
 for(@gHz) {
		my ($k, $v) = split '=', $_, 2;
		$k =~ s/^\s*//;
		$k =~ s/\s*$//;
		$v =~ s/^\s*//;
		$v =~ s/\s*$//;
		next if $k eq "" && $v eq "";
		$k = '__null__' if $k eq "";
		$cats{$k} = $v;
 }
	return %cats;
}

sub hAaA {
	my ($dir) = @_;
	my $size=0;
	local *D;
	opendir D, $dir;
	my @files = readdir D;
	close D;
	my $e;
	for $e(@files) {
		my $path = sVa::kZz($dir, $e);
		next if $e eq '.';
		next if $e eq '..';
		if (-d $path) {
			$size += hAaA($path);
		}
		my @stats = stat($path) ;
		$size += $stats[7];
 }
 return $size;
}
	
1;
package bAa;
require sVa;
use vars qw(@fs);
use strict;
no strict "refs";
BEGIN {
 @fs=qw(name type aJa desc val verifiers required dbtype dbsize idxtype);
}

$bAa::missing_val_label = "missing value";
$bAa::invalid_val_label = "invalid value";
$bAa::invalid_id_label = "invalid id, must be alphanumeric";
$bAa::invalid_card_label = "invalid card number";
$bAa::invalid_email_label = "invalid email address";
$bAa::invalid_url_label = "invalid URL";

sub new {
 my $type = shift;
 my $self = {};
 @{$self}{@fs} = @_;
 bless $self, $type;
 $self->dLaA();
 return $self;
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__
sub zSz {
 my ($id, $varri, $aOa, $zJz) = @_;
 my $str = qq(<select class="FormSelect" name="$id">);
 my ($sel, $dv);
 my $i =0;
 for (@$varri) {
 $sel = "";
 $sel =qq(selected="selected") if $aOa && $aOa eq $_;
 if($zJz) {
 $dv = $zJz->[$i];
	    $i++;
 }else {
 $dv = $_;
 }
	my $idx = $i%2;
	my $cls;
	if($sel ne '') {
		$cls = "option_selected";
	}else {
		$cls = "option_select_$idx";
	}
 $str .= qq(<option class="$cls" value="$_" $sel>$dv</option>);
 }
 return $str."</select>";  
}

sub wCz{
 my ($id, $tmstamp, $format) = @_;
 $tmstamp = sVa::bAaA() if not $tmstamp;

 my($year, $mon, $day, $hour, $min,$sec)= sVa::eRaA($tmstamp);

 my ($y, $m, $d, $h, $mn, $ap);
 
 $y = zSz($id."_year", [$year-100..$year+20], $year);
 $m = zSz($id."hHa", [map {sprintf("%02d", $_)}(1..12)], $mon, \@sVa::months);
 $d = zSz($id."_day", [map {sprintf("%02d", $_)}(1..31)], $day);
 $h = zSz("${id}_hour", [map {sprintf("%02d", $_)} (0..23)], $hour);
 $mn  = zSz("${id}iOa", [map {sprintf("%02d", $_)} (0..59)], $min);
 return $format eq 'date' ? "$y-$m-$d" : "$y - $m - $d, $h : $mn";
}

sub xUz {
 my ($aFa, $id) = @_;
 return if not $aFa->{$id."_year"};
 return sVa::eGaA($aFa->{$id."_year"}, $aFa->{$id."hHa"}, $aFa->{$id."_day"},
 $aFa->{$id."_hour"}, $aFa->{$id."iOa"}, 0);
}

sub wFz{
 my ($ts) = @_;
 $ts = xEz() if not $ts;

 my($min,$hour,$nQ,$mon,$year, $aorp, $mD);
 ($year, $mon, $nQ, $hour, $min, $aorp) = split /:/, $ts;
 
 my $m = $sVa::months[$mon];
 my $w = $sVa::wdays[$mD],
 return "$m $nQ, $year, $hour:$min $aorp";

}

sub dLaA{
	my ($self, $verfstr) = @_;
	return if not ($verfstr||$self->{verifiers});
	my @verfs = split /\s*\|\s*/, $verfstr||$self->{verifiers};
	for(@verfs) {
		$_ =~ s/^\s+//;
		$_ =~ s/\s+$//;
		my ($hR, $arg) = split /\s+/, $_, 2;
		next if not $hR;
		$hR =~ /(.*)/; $hR = $1;
		$self->iEa([eval "\\\&$hR", $arg?[split /\s*,\s*/, $arg]:undef ]);
	}
}

sub be_set{
 my ($v, $arga) = @_;
 return " $bAa::missing_val_label" if ($v eq "");		 
 return if ($v ne "" && not $arga);
 my $ok=1;
 if(scalar(@$arga)) {
	$ok=0;
 	for(@$arga) {
		$v =~ /$_/i and $ok =1 and last;
 	}
 }
 return " $bAa::invalid_val_label" if not $ok;		 
}

sub be_id {
 my $v = shift;
 return "($v) $bAa::invalid_id_label" if ($v =~ /\W/ or $v eq "");
 return;
}

sub be_card{
 my ($v, $cardarr) = @_;
 #require sNa;
 my $cardt= sNa::zYz($v);
 return if($cardt && not $cardarr); 
 my $ok=0;
 for(@$cardarr) {
	uc($_) eq  $cardt and $ok =1 and last;
 }
 return " $cardt $bAa::invalid_card_label" if not $ok;		 

}

sub be_email{
 my ($v) = @_;
 return " $bAa::invalid_email_label" if $v !~ /$sVa::uD/o;
 return;

}

sub be_url{
 my $v = shift;
 return " $bAa::invalid_url_label" if $v !~ /^\w+:/o;

}
 
sub be_deci {
 my $v = shift;
 return " invalid decimal" if ($v !~ /\d+(\.\d+)*/ or $v eq "");
 return;
}   

sub wKa{
	my $err= shift;
	return sub { return $err;}
}
sub aZa{
 my ($self, $vform, $k) = @_;
 if($self->{type} eq 'date' || $self->{type} eq 'time') {
 	$self->{val} = xUz($vform, $k||$self->{name});
 	return $self->{val};
 }else {
 	return $self->{val} = $vform->{$k||$self->{name}};
 }
}

sub iEa{
	my $self = shift;
	push @{$self->{verifier}}, @_;
}

sub nLa{
	my ($self, $hR) = @_;
 $self->{aDa} = $hR;
}

sub eCaA {
	my ($self, $type) = @_;
	$self->{type} = $type;
}

sub validate{
 my ($self, $v)= @_;
 $v = $self->{val} if not defined ($v);
 if($v eq ''){
 	if($self->{required}){
 	 $self->{_error} = " $bAa::missing_val_label";
		 return;
	}else {
		return 1;
	}
 }
 return 1 if not $self->{verifier};
 $self->{_error} = undef;

 for(@{$self->{verifier}}) {
	 my ($hR, $arga);
	 if (ref($_) eq 'ARRAY') {
	 	$hR = $_->[0] ;
 	$arga = $_->[1];
 }else {
		$hR = $_;
 }
 $self->{_error} .= &$hR($v, $arga);
	 return if $self->{_error} ne "";
 }
 return 1;
}

sub eDaA {
 my ($self)  = @_;
 my $str = $self->{name};
 $str .= " $self->{dbtype}";
 my $prec="";
 if($self->{dbtype} eq 'VARCHAR' && $self->{dbsize} eq "") {
	$self->{dbsize} = 32;
 }
 if($self->{dbsize} && $self->{dbtype} ne 'BLOB' && $self->{dbtype} ne 'INT') {
	$prec="($self->{dbsize})";
 }
 $str .=$prec;
 my $nullstr="";
 if($self->{idxtype} eq 'pk') {
	$nullstr = " PRIMARY KEY";
 }elsif ($self->{required}){
	$nullstr = " not NULL";
 }
 $str .= $nullstr;
 return $str;
}

sub bDa {
 my ($self, $v)  = @_;
 $v = $self->{val} if $v eq "";
 my $t = $self->{type};

 if( ref($v) eq 'ARRAY') {
 	$v = $v->[0];
 }
 if($t eq 'date') {
	return sVa::aKaA($v, 'date');

 }elsif($t eq 'time') {
	return sVa::aKaA($v, 'time');
 }
 if($self->{aDa}) {
	return $self->{aDa}->($v);
 }
 return $self->bCa($v);
}
 
sub bCa{
 my ($self, $v, $enc)  = @_;
 $v = $self->{val} if $v eq "";
 my $t = $self->{type};
 if(($t eq 'file' || $t eq 'ifile') && ref($v) eq 'ARRAY') {
 	$v = $v->[0];
 }elsif($t eq 'kAa' || $t eq 'checkbox') {
 	my @vs = split "\0", $v;
 	$v = join("\t", @vs);
 }
 $v = sVa::wS($v) if $enc;
 return $v;
}   

sub aYa{
 my  ($self, $vo, $mvsep, $ksuffix) = @_;
 my ($k, $v, $a, $t) = ($self->{name}, $self->{val}, $self->{aJa}, $self->{type});
 my $bZa;
 if($t eq 'fixed') {
	return $v;
 }
 my $dq = '&#34;';
 if($t eq 'label') {
	return $v;
 }

 sVa::encode_entities(\$v) if($t eq 'text' || $t eq 'hidden');
 if($t eq 'const' || $t eq 'fixed') {
	my $v2 = $v;
 	sVa::encode_entities(\$v2);
	return qq(<input type="hidden" name="$k$ksuffix" value="$v2"/>$v);
 }
 if($t eq 'htmltext') {
	$a = qq(rows="2" cols="60") if $a eq '';
	my $id="html$k$ksuffix";
	$bZa =  qq(<textarea $a name="$k$ksuffix" id="$id" class="htmltext">$v</textarea>);
 	if($self->{form} && $self->{form}->tGa('pvhtml')) {
		$bZa .= "<br/>". sVa::hFa("$self->{form}->{zKz}->{cgi}?htmlviewcmd=view&xZa=$k$ksuffix", "Edit HTML", "$k$ksuffix");
	}
 unless ($aLa::_ml_mode eq 'xhtmlmp' ) {
		if($k eq 'description' || $k eq 'content') {
			$bZa .= qq@<script> var oEdit1 = new InnovaEditor("oEdit1"); oEdit1.REPLACE("$id"); </script>\n@;
		}
	}
	return $bZa;
 }
 if($t eq 'icon') {
		my $img="";
		if($v) {
			$img =qq(<img id="img$k$ksuffix" src="$v"/>);
		}else {
			$img =qq(<img id="img$k$ksuffix" src="/images/blank.gif"/>);
		}
		$a = qq(size="64") if $a eq '';
 my $js= qq! onblur="(document.all? document.all.img$k$ksuffix: document.getElementById('img$k$ksuffix')).src=this.value;"!;
		$bZa =  qq($img <input type="text" $a name="$k$ksuffix" value="$v" $js/>);
		return $bZa;
 }
 if($t eq 'color') {
		$bZa =  qq(<input type="text" $a name="$k$ksuffix" value="$v" class="input_text"/>);
 }
		
 if($t eq 'textarea') {
		$a = qq(rows="2" cols="60") if $a eq '';
		$bZa =  qq(<textarea $a name="$k$ksuffix">$v</textarea>);
		return $bZa;
 }
 
 if($t eq 'date') {
	return wCz("$k$ksuffix", $v, 'date');
 }
 if($t eq 'time') {
	return wCz("$k$ksuffix", $v, 'time');
 }
 if($t eq 'ifile' || $t eq 'file') {
 	return qq(<input type="file" $a name="$k$ksuffix" class="input_file"/> $v);
 }
 $bZa=   qq(<input type="$t" $a name="$k$ksuffix" class="input_$t");
 if( $t eq "checkbox" ) {
 			$bZa .= qq( checked="checked") if $v;
 } else{
 			$bZa .= qq( value="$v");
 }
 $bZa .=  "/>";
 return $bZa;
}

sub bQa{
 my ($v) = @_;
 return unpack("h*", $v);
}
 
sub bTa{
 my ($v) = @_;
 return pack("h*", $v);
}

sub zPz{
	my $str = shift;
	my @gHz= split "\n", $str;
	my @a;
	for(@gHz) {
		my @pair= sVa::oPa($_);
		push @a, @pair if @pair;
	}
	return @a;
}
1;

package bGa;
use vars qw(@ISA);

#IF_AUTO use bAa;

BEGIN {
@ISA = qw(bAa);
}

sub new {
	my $type = shift;
	my ($k, $t, $a, $v, $r) = @_;
 	my $self = new bAa(@_);
	my @a=();
	if(ref $a eq 'ARRAY') {
		@a = @$a;
	}else {
		@a = bAa::zPz($a);
	}
 my ($opt, $lab);
	my $cnt = @a;
	my $i;
	for($i=0; $i<$cnt; $i+=2) {
		$opt = $a[$i];
		next if not defined($opt);
		$lab = $a[$i+1];
		$self->{cUa}->{$opt} = $lab;
		push @{$self->{cIa}}, $opt;

	}
	return bless $self, $type;
}

sub bDa{
	my ($self, $v) = @_;
	$v = $self->{val} if not defined $v;
	return $self->{cUa}->{$v} || $v;
}

sub to_links{
	my ($self, $v, $lnkfunc)  = @_;
 my %links;
	for(@{$self->{cIa}}) {
		my $lab = $self->{cUa}->{$_};
 if ($v ne $_) {
 	$links{$_} = sVa::cUz($lab, &$lnkfunc($_));
		}else {
 	$links{$_} =  "<b>$lab</b>";
		}
	}
	return \%links; 
}

1;

package bBa;
use vars qw(@ISA);

#IF_AUTO use bGa;

BEGIN{
	@ISA=qw(bGa);
}

sub new {
	my $type = shift;
	my $self = new bGa(@_);
	return bless $self, $type;
}

sub aYa{
	my ($self, $v, $sep, $ksuffix) = @_;
	$v = $self->{val} if not defined $v;
 my $sel;
	my ($bZa, $lab);
 $bZa = '';
 $sep = '<br/>' if not $sep;
 my @strs=();
	for(@{$self->{cIa}}) {
		$sel="";
		$lab = $self->{cUa}->{$_};
		$sel =' checked="checked"' if $_ eq $v;
		my $id = "r".rand();
		$id=~s/\W//g;
		my $js =qq@if(window.xx_rad) window.xx_rad.className=''; window.xx_rad=document.getElementById('$id');  window.xx_rad.className='checkedRadio'; @;
		push @strs, qq(<input type="radio" onclick="$js" name="$self->{name}$ksuffix" class="input_radio" value="$_"$sel/><span id="$id">$lab</span> );
	}
	my $max;
	$max = 'max' if scalar(@strs) > 10;
	return qq(<div class="radio_group_$max">).$bZa.join($sep, @strs)."</div>";
}

1;

package cEa;
use vars qw(@ISA);

#IF_AUTO use bGa;
BEGIN{
@ISA=qw(bGa);
}

sub new {
	my $type = shift;
	my $self = new bGa(@_);
	return bless $self, $type;
}

sub aYa{
	my ($self, $v, $sep, $ksuffix) = @_;
	$v = $self->{val} if not defined $v;
 my $sel;
	my ($opt, $lab);
	my %vhas;
	my $bZa;
	for(split ("\t|\0", $v)) {
			$vhas{$_}=1;
	}
 $bZa = '';
 $sep = '<br/>' if not $sep;
 my @strs=();
	for(@{$self->{cIa}}) {
		$sel="";
		$lab = $self->{cUa}->{$_};
		$sel =' checked="checked"' if $vhas{$_};
		push @strs, qq(<input type="checkbox" class="input_checkbox" name="$self->{name}$ksuffix" value="$_"$sel/>$lab );
	}
	my $max;
	$max = 'max' if scalar(@strs) > 10;
	return qq(<div class="checkbox_group_$max">).$bZa.join($sep, @strs)."</div>";
}

sub bDa{
	my ($self, $v) = @_;
	$v = $self->{val} if not defined $v;
	my @vs = split ("\t|\0", $v);
	if(not $self->{cUa}) {
		return join("; ", @vs);
	}
	return join("; ", @{$self->{cUa}}{@vs});
}

1;

package bNa;
use vars qw(@ISA);

#IF_AUTO use bGa;
BEGIN{
@ISA=qw(bGa);
}

sub new {
	my $type = shift;
	my $self = new bGa(@_);
	return bless $self, $type;
}

sub aYa{
	my ($self, $v, $extra, $ksuffix) = @_;
	$v = $self->{val} if not defined $v;
 my $sel;
	my $mult ="";
	$mult = ' MULTIPLE' if $self->{type} eq 'kAa';
 $mult .=" $extra" if $extra;
	my $bZa = qq(<select class="afselect" name="$self->{name}$ksuffix"$mult>);
	my ($opt, $lab);
	my %vhas;
	for(split ("\t|\0", $v)) {
			$vhas{$_}=1;
	}
	my $i=0;
	for(@{$self->{cIa}}) {
		$i++;
		$sel="";
		$lab = $self->{cUa}->{$_};
		$lab = '-----' if $lab eq '';
		$sel =' SELECTED' if $vhas{$_};
		my $idx = $i%2;
		my $cls;
		if($sel ne '') {
			$cls = "option_selected";
		}else {
			$cls = "option_select_$idx";
		}
		$bZa .= qq(<option class="$cls" value="$_"$sel>$lab</option>);
	}
	$bZa .=qq(</select>\n);
	return $bZa;
}

sub bDa{
	my ($self, $v) = @_;
	$v = $self->{val} if not defined $v;
	my @vs = split ("\t|\0", $v);
	if(not $self->{cUa}) {
		return join("; ", @vs);
	}
	return join("; ", @{$self->{cUa}}{@vs});
}

1;
		
package aLa;
#IF_AUTO use bAa;
#IF_AUTO use bGa;
#IF_AUTO use bBa;
#IF_AUTO use bNa;
#IF_AUTO use cEa;

use vars qw(@cfgfs);
use strict;

BEGIN {
@cfgfs=qw(name jF cgi pk bBaA);
$aLa::req_tag = qq(<font color=red><b>*</b></font>);
$aLa::default_submit_label = qq(Submit);
$aLa::default_reset_label = qq(Reset);
}

#for radio button the  fU look like
#['key', 'radio', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "default"]
#or
#['key', 'radio', "option1=Label 1\noption2=Label 2", "Description for this key", "default"]

#for single selection the fU looks like
#['key', 'select', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "default"]
#['key', 'select', "option1=Label 1\noption2=Label 2", "Description for this key", "default"]

#for multi selection the fU looks like
#['key', 'kAa', [option1=>"Label 1", option2=>"Label 2"], "Description for this key", "option1"]

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

#IF_UT use SelfLoader;
#IF_UT 1;
#IF_UT __DATA__

sub new {
 my $type = shift;
 my $self = {};
 $self->{zKz} = {};
 my $aJa = $self->{zKz};
 @{$aJa}{@cfgfs} = @_;

 bless $self, $type;
 if($aJa->{jF}) {
 	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'head';

 $self->{$p->[0]} = $p->[4];
 $self->{zKz}->{aEa}->{$p->[0]} = $p->[1];
		$self->{zKz}->{bLa}->{$p->[0]} = bYa($p);
		$self->{zKz}->{bLa}->{$p->[0]}->{form} = $self;
 }
 }
 return $self;
}
sub dOaA {
	my ($self, $fieldarr) = @_;
	if($fieldarr) {
		for my $k (@$fieldarr) {
			my $f = $self->jOa($k);
			if($f) {
				push @{$self->{zKz}->{pk}}, $k;
			}
		}
	}
	return $self->{zKz}->{pk};
}
sub bYa{
	my ($refa) =@_;
 my $t = $refa->[1];
	if($t eq 'select' || $t eq 'kAa') {
		return bNa->new(@$refa);
	}
	if($t eq 'radio') {
		return bBa->new(@$refa);
	}
	if($t eq 'checkbox') {
		return cEa->new(@$refa);
	}
	if($t eq 'textarea' || $t eq 'htmltext' || $t eq 'hidden'|| $t eq 'text' || $t eq 'file' || $t eq 'ifile' || $t eq 'password' || $t eq 'const' || $t eq 'fixed'){
		return bAa->new(@$refa);
	}
	return bAa->new(@$refa);
}

sub aCa{
 my ($self, $f) = @_;
 my $aJa = $self->{zKz};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p; 
 if($p->[0] eq $f->[0]) {
 	${$aJa->{jF}}[$i] = $f;
			$aJa->{bLa}->{$p->[0]} = bYa($f);
			$aJa->{bLa}->{$p->[0]}->{form} = $self;
		}
 }
}

sub sRa{
	my ($self, $attr, $val) = @_;
	$self->{zKz}->{$attr}= $val;
}

sub tGa{
	my ($self, $attr) = @_;
	return $self->{zKz}->{$attr};
}

sub jOa{
 my ($self, $xO) = @_;
 my $aJa = $self->{zKz};
 return if not $aJa->{jF};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p; 
 if($p->[0] eq $xO) {
 	return ${$aJa->{jF}}[$i];
		}
 }
}

sub tKa{
 my ($self, $xO) = @_;
 my $aJa = $self->{zKz};
 return if not $aJa->{jF};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p; 
 if($p->[0] eq $xO) {
			return $aJa->{bLa}->{$p->[0]};
		}
 }
}

sub rQa{
 my ($self, $xO) = @_;
 my $obj= $self->tKa($xO);
 return $obj->bDa();

}

sub yIa{
 my ($self, $k) = @_;
 my $obj= $self->tKa($k);
 return $obj->{desc}||ucfirst($k);
}

sub rYa{
 my ($self, $xO, $v) = @_;
 my $obj= $self->tKa($xO);
 return $obj->bDa($v);
}

sub sXa{
 my ($self, $xO, $v) = @_;
 my $obj= $self->tKa($xO);
 return $obj->aYa($v);
}

sub gGa{
 my ($self, $fn) = @_;
 my $aJa = $self->{zKz};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p;
 if($p->[0] eq $fn) {
 	${$aJa->{jF}}[$i] = undef;
			delete $aJa->{bLa}->{$p->[0]};
		}
 }
}

sub gSaA{
 my ($self, $fn) = @_;
 my $aJa = $self->{zKz};
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p;
 if($p->[0] eq $fn) {
 	${$aJa->{jF}}[$i]->[1] = 'hidden';
			$aJa->{bLa}->{$p->[0]}->{type}='hidden';
		}
 }
}

sub get_field_count{
 my ($self, $all) = @_;
 my $aJa = $self->{zKz};
 if($all) {
 	 return scalar(@{$aJa->{jF}});
 }
 my $cnt=0;
 for(my $i=0; $i< @{$aJa->{jF}}; $i++) {
 my $p =${$aJa->{jF}}[$i];
 next if not $p;
 $cnt ++ if $p->[1] eq 'hidden';
 }
 return $cnt;
}

sub dNa{
 my ($self, $f, $v) = @_;
 my $aJa = $self->{zKz};
 my $obj = $aJa->{bLa}->{$f};
 return if not $obj;
 $obj->{val} = $v;
 $self->{$f} = $v;
}

sub rWa{
 my ($self, $kv) = @_;
 while( my ($k, $v) = each %$kv) { 
	$self->dNa($k, $v);
 }
}

sub cOa{
	my ($self, $fsref, $req) = @_;
	my $aJa = $self->{zKz};
 for(@$fsref) {
 my $ele= $aJa->{bLa}->{$_};
		next if not $ele;
		$ele->iEa(\&bAa::be_set) if $req;
		$ele->{required}=1 if $req;
	}
}

sub iEa{
	my ($self, $key, @verfs) = @_;
	my $aJa = $self->{zKz};
	$aJa->{bLa}->{$key}->iEa(@verfs);

}

sub sYa{
	my ($self, $key, $verfstr) = @_;
	my $aJa = $self->{zKz};
	$aJa->{bLa}->{$key}->dLaA($verfstr) if ref($aJa->{bLa}->{$key});

}

sub nLa{
	my ($self, $key, $sfunc) = @_;
	my $aJa = $self->{zKz};
	$aJa->{bLa}->{$key}->nLa($sfunc);
}
 
sub pFa{
	my ($self, $type, $sfunc) = @_;
	my $aJa = $self->{zKz};
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} ne $type); 
		$ele->nLa($sfunc);
	}
}
sub hQa{
	my ($self, $type, @verfs) = @_;
	my $aJa = $self->{zKz};
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} ne $type); 
		$ele->iEa(@verfs);
	}
}

sub cGa {
	my ($self, $tag)= @_;
	$self->{zKz}->{gBa}= $tag;
}

sub zOz{
	my ($self)=@_;
	$self->{zKz}->{gFa}=1;
}

sub aGa {
	my ($self, $errt, $err) = @_;
	if($self->{zKz}->{gFa} ) {
		return @{$self->{zKz}->{hJa}} if not $err;
		$self->{zKz}->{hJa} = [$errt, $err];
		return;
	}
 sVa::error($errt, $err);
}
 

sub zQz {
 my ($self, $cgi)=@_;
 $self->{zKz}->{cgi} = $cgi;
}

sub yQa{
 my ($self, $method)=@_;
 $self->{zKz}->{method} = $method;
}

sub bSa{
 my ($self, $tmp)=@_;
 $self->{zKz}->{temp} = $tmp;
}

sub cFa{
	my ($self, $tmfile)=@_;
	open F, "<$tmfile" or return;
	$self->bSa(join("", <F>));
	close F;
}

 
sub add_field_before{
 my ($self, $fn, $f, $prefix) = @_;
 my $aJa = $self->{zKz};
 my @fs =  @{$aJa->{jF}};
 my @nfs ;
 $f->[0] .= "${prefix}_" if $prefix;
 for(my $i=0; $i< @fs; $i++) {
 my $p =$fs[$i];
 next if not $p;
 if($p->[0] eq $fn) {
			push @nfs, $f;
		}
		push @nfs, $p;
 }
 @{$aJa->{jF}} = @nfs;
 $self->{zKz}->{bLa}->{$f->[0]} = bYa($f);
 $self->{zKz}->{bLa}->{$f->[0]}->{form} = $self;
 $self->{$f->[0]} = $f->[4];

}  
sub zNz {
 my ($self, $f, $prefix)=@_;
 return if not $f;
 $f->[0] .= "${prefix}_" if $prefix;
 push @{$self->{zKz}->{jF}}, $f;
 $self->{zKz}->{bLa}->{$f->[0]} = bYa($f);
 $self->{zKz}->{bLa}->{$f->[0]}->{form} = $self;
 $self->{$f->[0]} = $f->[4];
}
 
sub sDa{
 my ($self, $f2)=@_;
 return if not $f2;
 for my $f (@{$f2->{zKz}->{jF}}){
	 $self->zNz($f);
	 my $fn = $f->[0];
	 $self->dNa($fn, $f2->{$fn});
 }

}

sub cBa {
	my ($self, $colorh, $coloro, $colore, $colorb) = @_;
	$self->{zKz}->{_colors}= [$colorh, $coloro, $colore, $colorb];
}

sub fOaA{
	my ($self, $fonth, $font_fh) = @_;
	$self->{zKz}->{_fonts}= [$fonth, $font_fh];
}

sub setWidth{
	my ($self, $wd) = @_;
	$self->{zKz}->{_width}= $wd;
}

sub aSa {
 my ($self, $skips)=@_;
 $self->{zKz}->{wGa} = $self->tGa("flat") ? $self->rMa(0, $skips) : $self->pKa(0, $skips);
}
 

sub pKa {
 my ($self, $viewonly, $skips)=@_;
	my $aJa = $self->{zKz};
	my @gHz;

 #  $self->cBa("#ffffff", "#ffffff", "#ffffff", "#eeeeee") if not $aJa->{_colors};

 my $nofile = $aLa::_ml_mode eq 'xhtmlmp';

	$self->fOaA(
	        qq(style="font-weight: bold"),
		qq(),
 ) if not $aJa->{_fonts};

	my ($fonth, $font_fh) = @{$aJa->{_fonts}};

 my ($bgh, $bgo, $bge) = @{$aJa->{_colors}};
 $bgh = qq(bgcolor="$bgh") if $bgh;
 $bgo = qq(bgcolor="$bgo") if $bgo;
 $bge = qq(bgcolor="$bge") if $bge;

 $bge .= qq( class="formRow0");
 $bgo .= qq( class="formRow1");
 $bgh .= qq( class="formRowHeader");

 my $wd = $self->{zKz}->{_width} || '90%';
	my $tid ="tbl".rand();
	$tid=~s/\W//g;

	push @gHz, qq(<table cellspacing="0" border="0" cellpadding="0"  width="$wd" class="FormTableOuter">\n<tr><td>\n);
	#push @gHz, qq(<table cellspacing="0" border="0" cellpadding="0" align="center" width="$wd" bgcolor="#eeeeee">\n<tr><td>\n);
	push @gHz, qq(<table border="0" cellspacing="1" cellpadding="3" align="center" width="100%" class="FormTable">\n);

	my ($p, $k, $i, $j);
 my $zDz;
	my $plc=qq(class="PFTDL");
	my $prc=qq(class="PFTDR");

 my $kpf = $self->tGa('keeponly');

 $i =1;
 $j =1;
	my @opts;
	foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 			my $str= qq(<tr $bgh align=left><td colspan=2 class="FormHeader">$h</td></tr>\n);
			if($aJa->{_opt_fields}->{$p->[0]}) {
				push @opts, $str;
			}else {
				push @gHz, $str;
			}
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
		next if ($nofile && ($t eq 'file' || $t eq 'ifile'));
 if ($t eq 'hidden' || $t eq 'command') {
 next;
 }
		next if ($kpf && $k ne $kpf);
		next if $skips->{$k};
		next if $self->tGa("skip_undef") && not $self->{$k};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }

	        my $linecode;
		my $col = $i++%2 ? $bgo : $bge;
		if($t eq 'htmltext' || $t eq 'textarea') {
	        	$linecode= qq(<tr $col>\n<td valign="top" colspan="2"><span plc>$d</span><br/><div $prc>\{$k\}</div>\n</td></tr>\n);
		}else {
	        	$linecode= qq(<tr $col>\n<td valign="top" $plc>$d</td>\n<td $prc>\{$k\}</td>\n</tr>\n);
		}
		if($aJa->{_opt_fields}->{$k} && $k ne $kpf) {
	        	push @opts, $linecode;
		}else {
	        	push @gHz, $linecode;
		}
	}
	push @gHz, "\{_COMMAND_\}\n" if not $viewonly;
 push @gHz, "</table>\n";
	my $optline;
 if(@opts) {
		my $show_lab = $self->tGa('showopts_lab') || "Show additional fields";
		my $hide_lab = $self->tGa('hideopts_lab') || "Hide";
		my $addi_lab = $self->tGa('addi_lab') || "Additional fields";
		#$optline =  qq(<br/><div>\&nbsp;<a id="l$tid" href="" onclick="document.getElementById('$tid').style.display='';this.style.display='none';return false">$show_lab</a>);
		$optline =  qq(<br/><div class="adv_fields">$show_lab \&nbsp;<input type="checkbox" id="l$tid" onclick="document.getElementById('$tid').style.display=this.checked?'':'none';">);
		my $hid=  qq(<a href="" onclick="document.getElementById('$tid').style.display='none'; document.getElementById('l$tid').style.display='';return false">$hide_lab</a>);
		$optline .= qq(<br/><br/><table style="display:none;"  id="$tid" border="0" cellspacing="1" cellpadding="3" align="center" width="100%" class="FormOptionTable">\n);
 		#$optline .= qq(<tr align=left><td colspan="2" class="FormOptHeader">$addi_lab ($hid)</td></tr>\n);
		$optline .= join('', @opts );
 $optline .= "</table></div>";
	}	
 return join "", @gHz, $optline, "</td></tr></table>";
}
 

sub default_temp_wap {
 my ($self, $viewonly, $skips)=@_;
	my $aJa = $self->{zKz};
	my @gHz;

	my ($p, $k, $i);
 my $zDz;

 $i =1;
	my @opts;
	foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 			push @gHz, qq(<b>$h</b>);
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if ($t eq 'hidden' || $t eq 'command' || $t eq 'checkbox' || $t eq 'select') {
 next;
 }
		next if $skips->{$k};
		next if $self->tGa("skip_undef") && not $self->{$k};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
		if($aJa->{_opt_fields}->{$k}) {
	        	push @opts, qq(<b>$d</b>:\{$k\});
		}else {
	        	push @gHz, qq(<b>$d</b>:\{$k\});
		}
	}
	push @gHz, "\{_COMMAND_\}\n" if not $viewonly;
 return join "<br/>", @gHz;
}
 

sub default_temp_chtml{
 my ($self, $viewonly, $skips)=@_;
	my $aJa = $self->{zKz};
	my @gHz;

	my ($p, $k, $i);
 my $zDz;

 $i =1;
	my @opts;
	foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 			push @gHz, qq($h);
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if ($t eq 'hidden' || $t eq 'command' || $t eq 'checkbox' || $t eq 'select') {
 next;
 }
		next if $skips->{$k};
		next if $self->tGa("skip_undef") && not $self->{$k};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
		if($aJa->{_opt_fields}->{$k}) {
	        	push @opts, qq($d: \{$k\});
		}else {
	        	push @gHz, qq($d: \{$k\});
		}
	}
	push @gHz, "\{_COMMAND_\}\n" if not $viewonly;
 return join "<br/>", @gHz;
}
 
sub rMa {
 my ($self, $viewonly, $skips)=@_;
	my $aJa = $self->{zKz};
	my @gHz;

	$self->fOaA(
		qq(color="#000000" style="font-weight: bold"),
		qq()
 ) if not $aJa->{_fonts};

	my ($fonth, $font_fh) = @{$aJa->{_fonts}};
 $self->cBa("#eeeeee", "", "", "#eeeeee") if not $aJa->{_colors};
 my ($bgh, $bgo, $bge) = @{$aJa->{_colors}};
 $bgh = qq(bgcolor="$bgh") if $bgh;
 $bgo = qq(bgcolor="$bgo") if $bgo;
 $bge = qq(bgcolor="$bge") if $bge;
	push @gHz, qq(<table cellspacing="3" border="0" cellpadding="3" width="99%">\n\n);
	#push @gHz, qq(<table cellspacing="3" border="0" cellpadding="3" align="center" width="99%">\n\n);

	my ($p, $k, $i);
 my $zDz;
	my $plc=qq(CLASS="PFTDL");
	my $prc=qq(CLASS="PFTDR");

 $i =1;
	my @opts;
	foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 			push @gHz, qq(<tr $bgh align=left><td><font $fonth>$h</font><br/>\n);
			$i++;
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if ($t eq 'hidden' || $t eq 'command') {
 next;
 }
		next if $skips->{$k};
		next if $self->tGa("skip_undef") && not $self->{$k};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
		my $col = $i++%2 ? $bgo : $bge;
		if($aJa->{_opt_fields}->{$k}) {
	        	push @opts, qq(<tr $col>\n<td valign="top" width="30%" $plc>$d</td>\n<td $prc>\{$k\}</td>\n</tr>\n);
		}else {
	        	push @gHz, qq(<tr $col><td>$d<br/>\{$k\}</td>\n</tr>\n);
		}
	}
	push @gHz, "\{_COMMAND_\}\n" if not $viewonly;
 push @gHz, "</table>";
	my $optline;
	if(@opts) {
		$optline = qq(<br/><p><table cellspacing="3" border="0" cellpadding="3" width="99%">\n);
		$optline .= join('', @opts);
		$optline .= "</table></p>";
	}
 return join "", @gHz, $optline;
}
 
sub cHa{
	my $self = shift;
	my $aJa = $self->{zKz};
 my @miss;
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		push @miss, $ele->{desc}. " :".$ele->{_error} if not $ele->validate();
	}
	return @miss;
}
 
sub dCaA{
	my ($self, $bBaA) = @_;
	my $aJa = $self->{zKz};
 $bBaA = $self->tGa('bBaA') if not $bBaA;
 my @miss;
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		next if($ele->{dbtype} eq ""); 
		push @miss, $ele->eDaA();
	}
	return "create table $bBaA (\n\t". join (",\n\t", @miss). "\n)\n";
}

sub eHaA {
 my ($self, $bBaA) = @_;
 my $sql =  $self->dCaA($bBaA);
 require zDa;
 my $db = zDa->new();
 $db->aRaA($sql);
}

sub rKa{
	my ($self, $lab) = @_;
	$self->sRa('button_label', $lab);

}

sub uHa {
	my ($self, $k) = @_;
	$self->{_vokeys}->{$k} = 1;
}

sub tXa{
	my ($self, $k) = @_;
	$self->{_pvkeys}->{$k} = 1;
}
sub rUa {
	my ($self, $k) = @_;
	if(not $k) {
		delete $self->{_vokeys};
	}else {
		delete $self->{_vokeys}->{$k};
	}
}

sub fXa {
	my $self = shift;
	my $aJa = $self->{zKz};
 my @miss;
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		next if($ele->{type} eq 'const'); 
		push @miss, $p->[0];
	}
	return @miss;
}

sub set_opt_fields{
	my ($self, $fields) = @_;
	my $aJa = $self->{zKz};
	if($fields) {
		for(@$fields) {
			$aJa->{_opt_fields}->{$_} =1;
		}
	}
}
 
sub set_opt_field{
	my ($self, $field) = @_;
	my $aJa = $self->{zKz};
	if($field) {
			$aJa->{_opt_fields}->{$field} =1;
	}
}
 
#Third a argument is a reference to an array of skipped fields, such as [ 'field1', 'field2']

sub form{
	my ($self, $yG, $zGz, $mark_inval) = @_; 
	if($aLa::_ml_mode eq 'wml') {
		my $str= $self->form_wap($yG, $zGz, $mark_inval); 
		return $str;

	}elsif($aLa::_ml_mode eq 'chtml') {
		my $str= $self->form_chtml($yG, $zGz, $mark_inval); 
		return $str;
 }
 my $nofile = $aLa::_ml_mode eq 'xhtmlmp';

	my $aJa = $self->{zKz};
	my $name = $aJa->{name}||"f".time();
	$aJa->{button_label} = $aLa::default_submit_label if not $aJa->{button_label};
	my $cgi  = $aJa->{cgi}; 
	my $method = $aJa->{method} || 'post';
 my %skips=();
	my @gHz;
 my $mvsep = $self->tGa('mvsep');
	if($zGz) {
		for(@$zGz) {
			$skips{$_} =1;
		}
	}
 $self->cBa(undef, undef, undef, "#f0f0f0") if not $aJa->{_colors};

 my ($bgh, $bgo, $bge, $bgb) = @{$aJa->{_colors}};
	if ($self->tGa("skip_undef") || not $self->{zKz}->{temp}) {
	       	 $self->aSa(\%skips);
	       	 $self->{zKz}->{temp} = $self->{zKz}->{wGa};
	}

 my $cmdstr;
 my $fcnt = $self->get_field_count();

 my $submit_btn = 
 	qq(<input type="submit" onmouseover="javascript:changeStyle(this, 'buttonover')" onmouseout="javascript:changeStyle(this,'buttonstyle')" onclick="javascript:return submitButtonClicked(this)" value="$aJa->{button_label}" class="buttonstyle">);
	if (not $yG) {
 if($self->tGa("flat")) {
 	$cmdstr=qq(<tr class="FormButtonRow">\n\n<td>$submit_btn</td>\n</tr>\n);
 }else {
		if($fcnt < 5) {
 		$cmdstr=qq(<tr class="FormButtonRow">\n<td></td><td>$submit_btn</td>\n</tr>\n);
		}else {
 		$cmdstr=qq(<tr class="FormButtonRow">\n<td><input type="reset" value="$aLa::default_reset_label" class="buttonstyle"></td>\n<td>$submit_btn</td>\n</tr>\n);
		}
 }
 }

 
	my $bZa;
 my $enc ="";
 my $has_file;
 my @fields;
 my @types;
 my $zDz;
	my $reqtag= $aJa->{gBa} || $aLa::req_tag;
	my $dup_cnt = $self->tGa('dupcnt')||1;

 my $idx=0;
 my @strs;

 for(; $idx<$dup_cnt; $idx++) {
	my $ftemp = $self->{zKz}->{temp};
 my $ksuffix="";
	if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		my $v;
		my ($k, $t, $a,  $d) = @{$ele}{qw(name type aJa desc)};
		next if ($nofile && ($t eq 'file' || $t eq 'ifile'));

		my $fk = "$k$ksuffix";
 push @fields, $fk;
 push @types, $t;

		if ($self->{$k}) {
		     $v = $self->{$k};
		}else {
 $v = $ele->{val};
 }
 
		$v="" if $t eq 'password';
 if($t eq 'hidden' || $t eq 'command') {
			next if $yG;
 			$zDz .=qq(<input type="hidden" name="$fk" value="$v">\n);
 		}

 if ((not $yG) && not $self->{_vokeys}->{$k}) {
		   if($t eq 'checkbox' || $t eq 'radio') {
 $bZa = $ele->aYa($v, $mvsep, $ksuffix);
 }else {
 $bZa = $ele->aYa($v, undef, $ksuffix);
 }
		     $bZa .= " $reqtag" if (not $ele->validate("")) && not $mark_inval;
		     $bZa .= qq( <font color="red">$ele->{_error}</font>) if $mark_inval && not $ele->validate(); 
 $has_file = 1 if ($t eq 'file' || $t eq 'ifile');
 if($self->{_pvkeys}->{$k}) {
		     $bZa .= "<br/>".sVa::cUz("javascript:ab_preview2(document.forms.$name.$fk)", "Preview");
 }
 }else {
 $bZa = $ele->bDa($v);
 }
 $bZa = '&nbsp;' if $bZa eq "";
 $ftemp =~ s/\{$k\}/$bZa/g;
	}
	if($idx<$dup_cnt -1) {
 	$ftemp =~ s/\{_COMMAND_\}//g;
	}
	push @strs, $ftemp;
 }
 my $ftemp = join("", @strs);
 my $fs = join('-', @fields);
 my $ts = join('-', @types);
 $ftemp =~ s/\{_COMMAND_\}/$cmdstr/g;
	return $ftemp if $yG;
	$method=$aJa->{method} || 'post';
 $enc= qq(ENCTYPE="multipart/form-data") if $has_file;
	my $aef_mult = qq(<input name="_aef_multi_kc" value="$dup_cnt" type="hidden">);
	my $tgt="";
	$tgt= qq( target="$aJa->{tgt}" ) if $aJa->{tgt};
	my $cls="";
	$cls= qq( class="$aJa->{cls}" ) if $aJa->{cls};
	return qq(<form name="$name" action="$aJa->{cgi}" $enc method="$method" $tgt$cls>\n$ftemp\n
$sVa::cYa
$zDz
$aef_mult
<input type="hidden" name="_af_xlist_" value="$fs">
<input type="hidden" name="_af_tlist_" value="$ts">
</form>);
}

sub form_wap{
	my ($self, $yG, $zGz, $mark_inval) = @_; 
	my $aJa = $self->{zKz};
	my $name = $aJa->{name}||"f".time();

	$aJa->{button_label} = $aLa::default_submit_label if not $aJa->{button_label};
	$aJa->{button_label} =~ s/<.*?>//g;

	my $cgi  = $aJa->{cgi}; 
	my $method = $aJa->{method} || 'post';
 my %skips=();
	my @gHz;
 my $mvsep = $self->tGa('mvsep');
	if($zGz) {
		for(@$zGz) {
			$skips{$_} =1;
		}
	}

	$self->{zKz}->{temp} = $self->default_temp_wap($yG, \%skips);

 my $cmdstr;
 
	my $bZa;
 my $enc ="";
 my $has_file;
 my @fields;
 my @types;
 my $zDz;
	my $reqtag= $aJa->{gBa} || $aLa::req_tag;
	my $dup_cnt = $self->tGa('dupcnt')||1;

 my $idx=0;
 my @strs;

 for(; $idx<$dup_cnt; $idx++) {
	my $ftemp = $self->{zKz}->{temp};
 my $ksuffix="";
	if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 

		my $v;
		$ele->{aJa}=undef;
		$ele->{type}='text' if $ele->{type} eq 'textarea';
		$ele->{type}='text' if $ele->{type} eq 'htmltext';
		my ($k, $t, $a,  $d) = @{$ele}{qw(name type aJa desc)};
		next if($aJa->{_opt_fields}->{$k});

		my $fk = "$k$ksuffix";
 push @fields, $fk;
 push @types, $t;

		if ($self->{$k}) {
		     $v = $self->{$k};
		}else {
 $v = $ele->{val};
 }
 
		$v="" if $t eq 'password';
 if($t eq 'hidden' || $t eq 'command') {
			next if $yG;
 			$zDz .=qq(<postfield name="$fk" value="$v"/>\n);
 		}

 if ((not $yG) && not $self->{_vokeys}->{$k}) {
		   $bZa = "";
		   if($t eq 'checkbox' || $t eq 'radio') {
 }elsif( $t eq 'text' || $t eq 'password' || $t eq 'const') {
 $bZa = $ele->aYa($v, undef, $ksuffix);
 		     $zDz .=qq!<postfield name="$fk" value="\$$fk"/>\n!;
			
 }
 }else {
 $bZa = $ele->bDa($v);
 }
 $bZa = ' ' if $bZa eq "";
 $ftemp =~ s/\{$k\}/$bZa/g;
	}
	if($idx<$dup_cnt -1) {
 	$ftemp =~ s/\{_COMMAND_\}//g;
	}
	push @strs, $ftemp;
 }
 my $ftemp = join("", @strs);
 my $fs = join('-', @fields);
 my $ts = join('-', @types);
 $ftemp =~ s/\{_COMMAND_\}/$cmdstr/g;
	return $ftemp if $yG;
	$method=$aJa->{method} || 'post';
	my $aef_mult = qq(<postfield name="_aef_multi_kc" value="$dup_cnt"/>);
	my $tgt="";
	$tgt= qq( target="$aJa->{tgt}" ) if $aJa->{tgt};
	return qq($ftemp
<anchor title="ok">
$aJa->{button_label}
<go href="$aJa->{cgi}" method="$method">
$zDz
$aef_mult
<postfield name="_af_xlist_" value="$fs"/>
<postfield name="_af_tlist_" value="$ts"/>
</go>
</anchor>
<do type="accept" label="$aJa->{button_label}">\n\n
<go href="$aJa->{cgi}" method="$method">
$zDz
$aef_mult
<postfield name="_af_xlist_" value="$fs"/>
<postfield name="_af_tlist_" value="$ts"/>
</go>
</do>

);
}

sub form_chtml{
	my ($self, $yG, $zGz, $mark_inval) = @_; 
	my $aJa = $self->{zKz};
	my $name = $aJa->{name}||"f".time();
	$aJa->{button_label} = $aLa::default_submit_label if not $aJa->{button_label};
	my $cgi  = $aJa->{cgi}; 
	my $method = $aJa->{method} || 'post';
 my %skips=();
	my @gHz;
 my $mvsep = $self->tGa('mvsep');
	if($zGz) {
		for(@$zGz) {
			$skips{$_} =1;
		}
	}

	$self->{zKz}->{temp} = $self->default_temp_chtml($yG, \%skips);

 my $cmdstr;
	if (not $yG) {
 	$cmdstr=qq(<input type="submit"  value="$aJa->{button_label}">);
 }

 
	my $bZa;
 my $enc ="";
 my $has_file;
 my @fields;
 my @types;
 my $zDz;
	my $reqtag= $aJa->{gBa} || $aLa::req_tag;
	my $dup_cnt = $self->tGa('dupcnt')||1;

 my $idx=0;
 my @strs;

 for(; $idx<$dup_cnt; $idx++) {

	my $ftemp = $self->{zKz}->{temp};
 my $ksuffix="";
	if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
	foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		next if($ele->{type} eq 'head'); 
		my $v;
		$ele->{aJa}=undef;
		my ($k, $t, $a,  $d) = @{$ele}{qw(name type aJa desc)};
		next if($aJa->{_opt_fields}->{$k});
		my $fk = "$k$ksuffix";

 push @fields, $fk;
 push @types, $t;

		if ($self->{$k}) {
		     $v = $self->{$k};
		}else {
 $v = $ele->{val};
 }
 
		next if $t eq 'file';

		$v="" if $t eq 'password';
 if($t eq 'hidden' || $t eq 'command') {
			next if $yG;
 			$zDz .=qq(<input type="hidden" name="$fk" value="$v">\n);
 		}

 if ((not $yG) && not $self->{_vokeys}->{$k}) {
		   if($t eq 'checkbox' || $t eq 'radio') {
 $bZa = $ele->aYa($v, $mvsep, $ksuffix);
 }else {
 $bZa = $ele->aYa($v, undef, $ksuffix);
 }
		     $bZa .= " $reqtag" if (not $ele->validate("")) && not $mark_inval;
		     $bZa .= qq( $ele->{_error}) if $mark_inval && not $ele->validate(); 
 }else {
 $bZa = $ele->bDa($v);
 }
 $bZa = '&nbsp;' if $bZa eq "";
 $ftemp =~ s/\{$k\}/$bZa/g;
	}
	if($idx<$dup_cnt -1) {
 	$ftemp =~ s/\{_COMMAND_\}//g;
	}
	push @strs, $ftemp;
 }
 my $ftemp = join("", @strs);
 my $fs = join('-', @fields);
 my $ts = join('-', @types);
 $ftemp =~ s/\{_COMMAND_\}/$cmdstr/g;
	return $ftemp if $yG;
	$method=$aJa->{method} || 'post';
 $enc= qq(ENCTYPE="multipart/form-data") if $has_file;
	my $aef_mult = qq(<input name="_aef_multi_kc" value="$dup_cnt" type="hidden">);
	my $tgt="";
	$tgt= qq( target="$aJa->{tgt}" ) if $aJa->{tgt};
	return qq(<form action="$aJa->{cgi}" $enc method="$method">\n$ftemp\n
$zDz
$aef_mult
<input type="hidden" name="_af_xlist_" value="$fs">
<input type="hidden" name="_af_tlist_" value="$ts">
</form>);
}
sub aPa {
 my($self, $field, $form, $ks) = @_;
 my $ele = $self->{zKz}->{bLa}->{$field};
 return if not $ele;
 my $type = $ele->{type};
 return if ($type eq 'head' || $type eq 'fixed');
 $self->{$field}=$ele->aZa($form, $ks);
}

sub aAa {
 my($self, $other, $def, $idx) = @_;
 my $fF;
 my $aJa = $self->{zKz};
 my @fs;
 my $ksuffix="";
 if($idx>0) {
		$ksuffix ="_aef_ss_$idx";
 }
 foreach (@{$aJa->{jF}}) {
 next if not $_;
	my $k = $_->[0];
	my $ks = "$k$ksuffix";
 	my $ele = $self->{zKz}->{bLa}->{$k};
 if($ele->{type} eq 'date' || $ele->{type} eq 'time') {
		next if $def && not exists $other->{$ks."_year"};
	}else {
		next if $def && not exists $other->{$ks};
	}
	$self->aPa($k, $other, $ks);
	push @fs, $k;
 }
 return @fs;
}

sub zLz {
 my($self, $form, $fields) = @_;
 my $aJa = $self->{zKz};

 my (@fs, @ts);
 my %aEa;
 if($fields) {
 @fs = @$fields;
 }elsif($form->{_af_xlist_}) {
 @fs = split ('-', $form->{_af_xlist_});
 @ts = split ('-', $form->{_af_tlist_});
 map { $aEa{$fs[$_]} = $ts[$_] } 0 .. $#fs;
 }else {
 @fs = sort keys %$form;
 }
 delete $form->{_af_xlist_};
 delete $form->{_af_tlist_};
 foreach (@fs){
 my $t =  $aEa{$_};
 if (ref($form->{$_}) eq 'ARRAY') {
 $t = 'file';
 }
 if (not $t) {
		if(index("\0", $form->{$_}) < length($form->{$_}) ) {
		   $t = 'checkbox';
 }else {
	           $t = 'textarea' ;
		}
	   }

	   
 $self->zNz([$_, $t, "", $_]) unless $aJa->{aEa}->{$_};
	   $self->aPa($_, $form);
 }
}

sub tEa{
 my($self, $adb) = @_;
 $adb->iSa([$self->pkey(), $self->dHa()]);

}

sub rRa{
 my($self, $adb) = @_;
 $adb->jHa([$self->pkey(), $self->dHa()]);

}

sub sHa{
 my($self, $pkey, $adb) = @_;
 $adb->jLa([$self->pkey()]);
}

sub sCa{
 my($self, $pkey, $adb) = @_;
 my $row = $adb->get_rows_by_id($self->pkey());
 return if not $row;
 $self->dFa(@$row);
}

sub store{
 my($self, $datafile, $zTz, $hashref) = @_;
 if($self->tGa('usedb')) {
	$self->zPa($datafile, $zTz, $hashref);
 }else {
	$self->zIa($datafile, $zTz, $hashref);
 }

}

sub rGa{
 my($self, $datafile, $hashref) = @_;
 if($self->tGa('usedb')) {
 	my $dbo= zDa->new($self->tGa('bBaA'));
	$dbo->dEaA($hashref);
 }else {
	unlink $datafile;
 }

}
sub zIa {
 my($self, $datafile, $zTz) = @_;
 open lW, ">$datafile" or return $self->aGa('sys', "On writing $datafile: $!") ;
 my $cJa= $self->eHa($zTz||$self->{filedir}, 1);
 $cJa->aNa(\*lW);
 close lW;
 chmod 0600, $datafile;
}

sub zPa{
 my($self, $datafile, $zTz, $hashref) = @_;
 require zDa;
 my $dbo= zDa->new($self->tGa('bBaA'));
 my $rowhsh = $dbo->eQaA($hashref);
 if( not $rowhsh) {
 	$dbo->aTaA($self);
	$dbo->tEa();
 }else {
	$dbo->dGaA($self, $hashref);
 } 
 1;
}

sub eHa{
 my($self, $zTz, $xF) = @_;
 my $aJa = $self->{zKz};
 my @fs =();
 my @ts =();
 my $cJa= dZz->zVz("anyform_$self->{name}");
 
 foreach (@{$aJa->{jF}}) {
 next if not $_;
 my $ele= $aJa->{bLa}->{$_->[0]};
	    next if not $ele;
 my $fn = $ele->{name};
 my $ft = $ele->{type};
 next if ($ft eq 'head' || $ft eq 'command');
 push @fs, $fn;
 push @ts, $ft;
 my $v = $self->{$fn};
 my $sv;
 if($ft eq 'file' && ref($v) eq 'ARRAY') {
 my $path;
 if( $zTz && $xF) {
 	$path = sVa::kZz($zTz, $v->[0]);
 	open DF, ">$path" or next;
 	binmode DF;
 	print DF $v->[1];
 	close DF;
 }else {
 $path = $v->[0];
 }
		$sv = $path;
 
 }else {
		  $sv = $ele->bCa($v);
	    }
	    $sv =~ s/(\r+\n){3,}/\n/g;
 $cJa->zRz(dZz->zVz($fn, [$sv], "text/plain"));
 }
 $cJa->zRz(dZz->zVz("_af_xlist_", [join ("-", @fs)], "text/plain"));
 $cJa->zRz(dZz->zVz("_af_tlist_", [join ("-", @ts)], "text/plain"));
 return $cJa;
}

sub dHa{
 my($self) = @_;
 my $aJa = $self->{zKz};
 my @fs =();
 foreach (@{$aJa->{jF}}) {
 next if not $_;
 my $ele= $aJa->{bLa}->{$_->[0]};
	    next if not $ele;
 my $fn = $ele->{name};
 my $ft = $_->[1];
 next if ($ft eq 'head' || $ft eq 'command');
 my $v = $self->{$fn};
 my $sv;
 if($ft eq 'file' and $v ne "") {
 my $path = $v->[0];
		$sv = $path;
 
 }else {
		  $sv = $ele->bCa($v);
	    }
	    push @fs, sVa::wS($sv);
 }
 return @fs;
}

sub dFa{
 my($self, @fs) = @_;
 return if not @fs;
 my $aJa = $self->{zKz};
 foreach (@{$aJa->{jF}}) {
 next if not $_;
 my $fn = $_->[0];
 my $ft = $_->[1];
 next if ($ft eq 'head' || $ft eq 'command');
	    $self->dNa($fn, sVa::oDa(shift @fs));
 }
}

sub load{
 my($self, $cL, $init, $hashref) = @_;
 if($self->tGa('usedb')) {
	$self->zQa($cL, $init, $hashref);
 }else {
	$self->zLa($cL, $init, $hashref);
 }
}

sub zLa{
 my($self, $cL, $init, $hashref) = @_;

 open lW, "<$cL" or 
 return $self->aGa('sys', "$self->{name}: on reading file $cL: $!") ;
 my @plines = <lW>;
 close lW;

 my $lRa = dZz->new(\@plines);
 $lRa->parse();
 $self->dPa($lRa, $init);
 1;
 
}

sub zQa{
 my($self, $cL, $init, $hashref) = @_;
 require zDa;
 my $dbo= zDa->new($self->{zKz}->{bBaA});
 my $rowhsh = $dbo->eQaA($hashref);
 return if not $rowhsh;
 $self->rWa($rowhsh);
 1;
}

sub dPa{
 my($self, $lRa, $init) = @_;
 my %fL;

 for my $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 if (length($ent->{eFz})>0) {
 $ent->{eFz} =~ s/\s+/_/g;
 $fL{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 } else {
 	              if (defined($fL{$name})){
 	              	$fL{$name} .= "\0" if defined($fL{$name}); 
 }
 	              $fL{$name} .=  $val;
 }
 }
 
 if($init) {
 $self->zLz(\%fL,undef, 1);
 return;
 }
 delete $fL{_af_tlist};
 delete $fL{_af_xlist};

 my $fF;
 my $aJa = $self->{zKz};
 foreach  (@{$aJa->{jF}}) {
 next if not $_;
 	   my $fU = $_->[0];
 	   my $t = $_->[1];
	   my $v;
 	   next if not exists $fL{$fU}; 
 next if ($t eq 'head' || $t eq 'fixed' || $t eq 'command');
 	   $v = $fL{$fU} if exists $fL{$fU}; 
	   $self->dNa($fU, $v);
 }
}

sub genDefMime {
 my($self) = @_;
 my $aJa = $self->{zKz};
 my @fs =();
 my $cJa= dZz->zVz("def");
 
 my $dlen = @bAa::fs;
 foreach my $p (@{$aJa->{jF}}) {
 next if not $p;
 my $fn = $p->[0];
	    for (my $i=0; $i<$dlen; $i++){ 
 	$cJa->zRz(dZz->zVz("$fn.".$bAa::fs[$i], [$p->[$i]], "text/plain"));
	    }
	    push @fs, $fn;
 }
 $cJa->zRz(dZz->zVz("_af_xlist_", [join ("-", @fs)], "text/plain"));
 $cJa->zRz(dZz->zVz("_af_temp_", [$self->{temp}], "text/plain"));
 return $cJa;

}

sub cCa {
 my($self, $cL) = @_;
 $cL =~ /(.*)/; $cL =$1;
 open (lW, "> $cL") or return $self->aGa('sys', "On writing $cL: $!") ;

 my $cJa=$self->genDefMime();
 $cJa->aNa(\*lW);
 close lW;
 chmod 0600, $cL;
}

sub loadDefFromString{
 my ($self, $str, $prefix)= @_;
 my @plines = split /^/m, $str;
 my %fL;

 my $lRa = dZz->new(\@plines);
 $lRa->parse();
 for my $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 $fL{$name} =  $val;
 }
 my @fs = split ('-', $fL{_af_xlist_});
 for my $fn(@fs) {
		my @fdefs=();
 		for my $ff (@bAa::fs) {
			push @fdefs, $fL{"$fn.$ff"};
		}
		$self->zNz([@fdefs], $prefix);
 }

}

sub cDa{
 my($self, $cL, $prefix) = @_;

 local $/ = undef;
 open lW, "<$cL" or 
 return $self->aGa('sys', "$self->{name}: on reading file $cL: $!") ;
 my $gHz = <lW>;
 close lW;
 $self->loadDefFromString($gHz);

}

sub xEz{
 my ($t) = @_;
 $t = time() if not $t;
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst)=localtime($t);
 my $aorp;
 	$aorp = $hour>12 ? "PM": "AM";
 	$hour -= 12 if $hour > 12;;
 	$hour = "0$hour" if $hour<10;
 	$min = "0$min" if $min<10;
 	$mon = "0$mon" if $mon<10;
 	$nQ = "0$nQ" if $nQ<10;
 	$year+=1900;
 return  join(':', $year, $mon, $nQ, sprintf("%02d",$hour), sprintf("%02d", $min), $aorp, $mD);
}
1;

package sNa;

BEGIN{
 use vars qw(@zIz);
 @zIz = (
 [MC=> '5[1-5]', 16, 10, "Master Card"],
 [VISA=>'4', 16, 10, "Visa"],
 [VISA=>'4', 13, 10, "Visa"],
 [DISC=>'6011', 16, 10, "Discover"],
 [AMEX=>'34|37', 15, 10, "American Express"],
 [DCCB=>'30[0-5]|36|38', 14, 10, "Diners Club/Carte Blanche"],
 [JCB=>'3', 16, 10, "JCB"],
 [ENR=>'2014|2149', 15, 1, "enRoute"],
 [JCB=>'2131|1800', 15, 10, "JCB"]
 );
}

sub zYz{
 my $zUz = shift;
 $zUz =~ s/\D//g;
 my @digits = reverse split //, $zUz;
 my $len = length($zUz);
 return undef if($len < 13);
 my $sum =0;
 for(my $i=0; $i<$len; $i++) {
 my $tmp = $digits[$i]*(1+ ($i%2));
	$sum += int $tmp/10 + $tmp%10;

 }

 for (@zIz) {
 next if $len != $_->[2];
 next if not $zUz =~ /^($_->[1])/;
 next if ($sum % $_->[3]);
 return $_->[0];
 }
 return undef;
}

1;
package dZz;

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

#IF_UT use SelfLoader;
#IF_UT 1;
#IF_UT __DATA__

sub new {
 my ($type, $lref, $ep) = @_;
 my $self = {};
 $self->{gHz}= $lref;
 $self->{ePz}=0;
 $self->{eKz}=0;
 if($lref) {
 	$self->{eLz} = $ep? $ep: scalar @$lref;
 }
 $self->{parts}=[];
 $self->{eOz}="";
 $self->{head}={};
 $self->{eCz}=0;
 return bless $self, $type;
}

sub zVz{
 my ($type, $name, $dataref, $ct, $file) = @_;
 my $self = {};
 $self->{gHz}= $dataref if $dataref;
 $self->{ePz}=0;
 $self->{eKz}=0;
 $self->{eLz} = 1;
 $self->{parts}=[];
 $self->{head}={};
 $self->{head}->{'content-type'} = "$ct";
 $self->{eJz} = $name;
 $self->{eFz} = $file;
 return bless $self, $type;
}
sub hEa{
	my ($self, $fhash, $fields) = @_;
	$fields = [keys %$fhash] if not $fields;
	for(@$fields) {
		$self->zNz($_, $fhash->{$_});
	}
}

sub zNz {
	my ($self, $name, $val, $type, $file) = @_;
 if($file && not $val) {
		if(open (F, $file)) {
			local $/=undef;
			$val = <F>;
			close F;
		}
	}
 $self->zRz( zVz dZz($name, [$val], $type||"text/plain", $file));
}

sub zRz {
 my ($self, @parts) = @_;
 for(@parts) {
 	push @{$self->{parts}}, $_;
	next if not $_->{eJz};
	$self->{parthash}->{$_->{eJz}} = $_ if $_->{eJz};
 }
}

sub hWa{
 my ($self, $key) = @_;
 return $self->{parthash}->{$key};
}

sub gVa{
	my ($self, $key) = @_;
	my $part= $self->hWa($key);
	return $part? $part->nDa() : undef;
}

sub bCa{
 my ($self, $new_bd) = @_;
 my @gHz;
 my @hlines;
 unless (@{$self->{parts}}) {
 if($self->{head}->{'content-type'}) {
 push @gHz, qq(Content-type: $self->{head}->{'content-type'}\n);
 }
 if($self->{eJz}) {
	     if($self->{eFz} ne "") {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}; filename="$self->{eFz}"\n);
 }else {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 }
 push @gHz, "\n";
 push @gHz, $self->nDa();
 return join("", @hlines, @gHz);
 }
 if($new_bd || !$self->{eOz}) {
 	  my $r = rand();
 $r =~ s/\./_/g;
 $self->{eOz} = "YXASASA".time().$r;
 }
 push @hlines, qq(Content-type: multipart/form-data; boundary=$self->{eOz}\n);
 if($self->{eJz}) {
 push @hlines, qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 if($self->{head}->{'content-disposition'}) {
 
 }
 for(@{$self->{parts}}) {
	next if not $_;
	push @gHz, "\n--$self->{eOz}\n";
 push @gHz, $_->bCa($new_bd);
 }
 push @gHz, "\n--$self->{eOz}--\n";
 my $line = join("", @gHz);
 my $len = length($line);
 return join ("", @hlines, "Content-length: $len\n", $line);
}

sub aNa{
 my ($self, $nA, $new_bd) = @_;
 unless (@{$self->{parts}}) {
 if($self->{head}->{'content-type'}) {
 print $nA qq(Content-type: $self->{head}->{'content-type'}\n);
 }
 if($self->{eJz}) {
 print $nA qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 print $nA "\n";
 print $nA $self->nDa();
 return;
 }
 if($new_bd || !$self->{eOz}) {
 	  my $r = rand();
 $r =~ s/\./_/g;
 $self->{eOz} = "YXASASA".time().$r;
 }
 print $nA qq(Content-type: multipart/form-data; boundary=$self->{eOz}\n);
 if($self->{eJz}) {
 print $nA qq(Content-disposition: form-data; name=$self->{eJz}\n);
 }
 if($self->{head}->{'content-disposition'}) {
 
 }
 for(@{$self->{parts}}) {
	next if not $_;
	print $nA "\n--$self->{eOz}\n";
 $_->aNa($nA, $new_bd);
 }
 print $nA "\n--$self->{eOz}--\n";
}

 
sub eEz {
 my $self = shift;
 my @data;
 for(my $i=$self->{ePz};$i<$self->{eKz}; $i++) {
 push @data, $self->{gHz}->[$i];
 }
 return join('', @data);
 
}

sub mIa{
 my ($lref, $start, $end) = @_;
 my @res;
 my $i;
 my $str;
 for($i=$start; $i<$end; $i++) {
 $str = $lref->[$i];
 	$str =~ tr|A-Za-z0-9+=/||cd;            
 	if (length($str) % 4) {
 
 	}
 	$str =~ s/=+$//;                       
 	$str =~ tr|A-Za-z0-9+/| -_|;          
 	while ($str =~ /(.{1,60})/gs) {
		my $len = chr(32 + length($1)*3/4); 
		push @res, unpack("u", $len . $1);   
	}
 
 }
 return join('', @res);
}

sub eHz {
 my $self = shift;
 return $self->nDa();
}

sub nDa{
 my $self = shift;
 return $self->{eAz} if $self->{eAz};
 my @data;
 my $i=$self->{eKz};
 if($self->{head}->{'content-transfer-encoding'} =~ /^base64/i) {
 return mIa($self->{gHz}, $i, $self->{eLz});

 }elsif($self->{head}->{'content-transfer-encoding'} =~ /^quoted/i) {
 for(;$i<$self->{eLz}; $i++) {
 push @data, oZa($self->{gHz}->[$i]);
 }
 }else {
 for(;$i<$self->{eLz}; $i++) {
 if($i==($self->{eLz}-1)){
 $self->{gHz}->[$i] =~ s/\r\n$//;
 $self->{gHz}->[$i] =~ s/\n$//;
 }
 push @data, $self->{gHz}->[$i];
 }
 }
 
 $self->{eAz} = join('', @data);
 return $self->{eAz};
}

sub pLa{
	my $sub = shift;
	my $pat = '=\?[^\?]+\?(.)\?([^\?]*)(\?=)?';
	$sub =~ s{$pat}{lc($1) eq 'q' ? oZa($2) : fIa($2)}ge;
 return $sub;
} 

sub eBz {
 my ($self) = @_;
 my $eNz = "--$self->{eOz}";
 my $dYz = $eNz."--";
 my $eIz=0;
 my $isme=0;
 return $self->{got_parts} if $self->{got_parts};
 return if not $self->{eOz};

 my $start = $self->{eKz};
 my $lref = $self->{gHz};
 my $ent;
 for(;$start< $self->{eLz}; $start++) {
	    my $line = $lref->[$start];
	    $line =~ s/\r\n$//;
	    $line =~ s/\n$//;
	    if($line eq $eNz || $line eq $dYz) {
 	       if ($ent) {
 $ent->{eLz} = $start;
 $ent->parse();
 	    my $ent_try = dZz->new();
 	    $ent_try->{gHz} = $self->{gHz};
 	    $ent_try->{ePz} = $ent->{eKz};
 	    $ent_try->{eLz} = $start;
		    if($ent_try->parse()) {
 	            	push @{$ent->{parts}}, $ent_try;
 }
 	            $self->zRz($ent);
 last if $line eq $dYz;
 }
	       if($line eq $eNz) {
 	   $ent = new  dZz;
 	   $ent->{gHz} = $self->{gHz};
 $ent->{ePz} = $start + 1;
 }
 }
 }
 $self->{got_parts}= scalar(@{$self->{parts}});
}

sub eQz {
 my ($self) = @_;
 my $eIz=1;

 return $self->{eCz} if $self->{eCz};

 my $lref = $self->{gHz};
 my $start = $self->{ePz};
 my $lkey="";
 for(;$start< $self->{eLz}; $start++) {
	    $_ = $lref->[$start];
	    $_ =~ s/\r?\n$//;

	    if($_ eq '' && $eIz) {
			 $eIz =0;
 $self->{eKz} = $start +1;
 last;
 }
	    if($eIz){
			if($_ =~ /^([^: 	]+):\s*(.*)/) {
 $lkey = lc($1);
			    $self->{head}->{$lkey}= $2;
 }elsif($lkey) {
 $self->{head}->{$lkey} .= $_ ;
 }else {
			   last;
 }
 }
 }
 for(keys %{$self->{head}}) {
		$self->{head}->{$_} = dZz::pLa($self->{head}->{$_});
 }
 $self->{eCz}= ($lkey ne "");

}

sub get_content_type{
 my ($self) = @_;
 return $self->{head}->{'content-type'};

}

sub get_charset{
 my ($self) = @_;
 my $ct =  $self->get_content_type();
 if($ct =~ /charset="?([0-9a-zA-Z\-]*)/) {
 	return $1;
 }
 return;
}

sub bVz{
 my ($self) = @_;
 if($self->{head}->{'content-type'} =~ /multipart/i) {
 unless( ($self->{eOz})= $self->{head}->{'content-type'} =~ /boundary=\"([^"]*)\"/i ) {
 	($self->{eOz})= $self->{head}->{'content-type'} =~ /boundary=(\S+)/i;
 }
 $self->{eOz} =~ s/;.*$//;
 }
 if($self->{head}->{'content-disposition'} =~ /(inline|form-data|attachment);/i) {
 unless(($self->{eFz}) = $self->{head}->{'content-disposition'} =~ /\bfilename=\"([^"]*)\"/i){
 ($self->{eFz}) = $self->{head}->{'content-disposition'} =~ /\bfilename=(\S+)/i ;
 }
 $self->{eFz} =~ s/^.*(\\|\/)//g;
 unless(($self->{eJz})= $self->{head}->{'content-disposition'} =~ /\bname=\"([^"]*)\"/i){
 	($self->{eJz})= $self->{head}->{'content-disposition'} =~ /\bname=(\S+)/i ;
 }
 $self->{eJz} =~ s/;.*$//;
 }
 if($self->{head}->{'content-disposition'} =~ /inline;/i) {
	$self->{inline} = 1;
 }
}

sub oZa ($)
{
 my $res = shift;
 $res =~ s/[ \t]+?(\r?\n)/$1/g; 
 $res =~ s/=\r?\n//g;           
 $res =~ s/=([\da-fA-F]{2})/pack("C", hex($1))/ge;
 $res;
}

sub fIa ($)
{
 local($^W) = 0;

 my $str = shift;
 my $res = "";

 $str =~ tr|A-Za-z0-9+=/||cd;            
 if (length($str) % 4) {
 
 }
 $str =~ s/=+$//;                       
 $str =~ tr|A-Za-z0-9+/| -_|;          
 while ($str =~ /(.{1,60})/gs) {
	my $len = chr(32 + length($1)*3/4); 
	$res .= unpack("u", $len . $1 );   
 }
 $res;
}

sub nBz ($;$)
{
 my $res = "";
 my ($str, $eol) = @_;
 $eol = "\n" unless defined $eol;
 pos($str) = 0;     
 while ($str =~ /(.{1,45})/gs) {
	$res .= substr(pack('u', $1), 1);
	chop($res);
 }
 $res =~ tr|` -_|AA-Za-z0-9+/|;    
 
 my $padding = (3 - length($str) % 3) % 3;
 $res =~ s/.{$padding}$/'=' x $padding/e if $padding;
 
 if (length $eol) {
	$res =~ s/(.{1,76})/$1$eol/g;
 }
 $res;
}
sub parse {
 my ($self) = @_;
 return if not $self->eQz();
 $self->bVz();
 $self->eBz();
}
sub sZa{
 my ($self) = @_;
 my @gHz;
 $self->{eJz} = "unamed_data" if not $self->{eJz};
 unless (@{$self->{parts}}) {
 push @gHz, qq(<$self->{eJz}>);
 push @gHz, rLa($self->nDa());
 push @gHz, qq(</$self->{eJz}>\n);
 	       return join ("", @gHz);
 }
 push @gHz, qq(<$self->{eJz}>);
 
 for(@{$self->{parts}}) {
	next if not $_;
 push @gHz, $_->sZa();
 }
 push @gHz, qq(</$self->{eJz}>\n);
 return join ("", @gHz);
}

sub rLa {
 $_[0] =~ s/&/&amp;/g;
 $_[0] =~ s/</&lt;/g;
 $_[0] =~ s/>/&gt;/g;
 $_[0] =~ s/'/&apos;/g;
 $_[0] =~ s/"/&quot;/g;
 $_[0] =~ s/([\x80-\xFF])/&tFa(ord($1))/ge;
 return($_[0]);
}

sub tFa {
 my $n = shift;
 if ($n < 0x80) {
 return chr ($n);
 } elsif ($n < 0x800) {
 return pack ("CC", (($n >> 6) | 0xc0), (($n & 0x3f) | 0x80));
 } elsif ($n < 0x10000) {
 return pack ("CCC", (($n >> 12) | 0xe0), ((($n >> 6) & 0x3f) | 0x80),
 (($n & 0x3f) | 0x80));
 } elsif ($n < 0x110000) {
 return pack ("CCCC", (($n >> 18) | 0xf0), ((($n >> 12) & 0x3f) | 0x80),
 ((($n >> 6) & 0x3f) | 0x80), (($n & 0x3f) | 0x80));
 }
 return $n;
}

1;

1;

package fRaA;
use strict;

#IF_AUTO use AutoLoader 'AUTOLOAD';

%fRaA::bK= (
 view=>[\&eTaA, ''],
);

#IF_AUTO 1;
#IF_AUTO __END__

sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{icon_loc}= $argh->{icon_loc};
 $self->{agent}= $argh->{agent};
 $self->{input} = $argh->{input};
 $self->{homeurl} = $argh->{homeurl};
 return bless $self, $type;
}

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
package gPaA;
use strict;

sub TIEHANDLE {
	my $class = shift;
	bless [], $class;
}

sub PRINT {
	my $self = shift;
	push @$self, join('', @_);
}

sub PRINTF{
	my $self = shift;
	my $fmt = shift;
	push @$self, sprintf $fmt, @_;
}

sub READLINE{
	my $self = shift;
 return join('', @$self);
}

sub yB{
	my $self = shift;
 return join('', @$self);

}	

1;
package eUaA;

use strict;
use vars qw(
%bK
$tabattr
);

use aLa;
use gAaA;
use jEa;
use sVa;
sub sVa::gYaA(@);

@eUaA::edit_file_form=(
["efhead", "head", "<b>Edit or create new file</b>"],
["filename", "text", "size=40", "File name"],
["filecontent", "textarea", "rows=12 cols=60", "Content"],
["filepermission", "text", "size=4", "File permission", "0644"],
["filenocr", "checkbox", "1=Yes", "Strip carrige return?", 1],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fBaA"],
);

@eUaA::confirm_delfile_form=(
["", "head", "<b>Confirm file deletion</b>"],
["filename", "const", "size=40", "File name"],
["confirm", "checkbox", "1=Yes", "Detele file?"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fAaA"],
);

@eUaA::upload_file_form=(
["", "head", "<b>Upload files</b>"],
["file1", "file", "size=40", "File 1"],
["file2", "file", "size=40", "File 2"],
["file3", "file", "size=40", "File 3"],
["file4", "file", "size=40", "File 4"],
["filepermission", "text", "size=4", "File permission", "0644"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "upload"],
);
@eUaA::replace_file_form=(
["", "head", "<b>Upload a new file to replace the file</b>"],
["oldfilename", "const", "size=40", "File name"],
["file1", "file", "size=40", "File 1"],
["filepermission", "text", "size=40", "File permission"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fSaA"],
);

@eUaA::chmod_file_form=(
["", "head", "<b>Change file permission</b>"],
["filename", "const", "size=40", "File name"],
["filepermission", "text", "size=40", "File permission"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fLaA"],
);

@eUaA::create_subdir_form=(
["", "head", "<b>Create new folder</b>"],
["subdir", "text", "size=40", "Sub folder name"],
["permission", "text", "size=4", "Permission", "0755"],
["dir", "hidden"],
["kQz", "hidden"],
['docmancmd', 'hidden', '', "", "fYaA"],
);

%bK = (
fVaA=> [\&fVaA, 'ADM'],
fDaA=> [\&fDaA, 'ADM'],
fBaA=> [\&fBaA, 'ADM'],
rA=> [\&rA, 'ADM'],
fHaA=> [\&fHaA, 'ADM'],
upload=> [\&upload, 'ADM'],
fGaA=> [\&fGaA, 'ADM'],
fSaA=> [\&fSaA, 'ADM'],
eZaA=> [\&eZaA, 'ADM'],
fLaA=> [\&fLaA, 'ADM'],
fFaA=>[\&fFaA, 'ADM'],
fAaA=>[\&fAaA, 'ADM'],
fNaA=>[\&fNaA, 'ADM'],
fYaA=>[\&fYaA, 'ADM'],
deletesubdir=>[\&deletesubdir, 'ADM'],
sinfo=>[\&wLz, 'ADM']
);

$tabattr= {width=>"100%", usebd=>0};
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{rootdir}= $argh->{rootdir};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{home} = $argh->{home};
 $self->{header} = $argh->{header};
 $self->{footer} = $argh->{footer};
 $self->{jW} = $argh->{jW};
 $self->{kQz} = $argh->{kQz};
 return bless $self, $type;
}

sub cFaA{
	my ($self, $adm) = @_;
	$self->{uTa} = $adm;
}

sub cJaA{
	my ($self, $kQz) = @_;
	$self->{wOa} = $kQz;
}

sub bUaA{
	my ($self, $url) = @_;
	$self->{wCa} = $url;
}

sub setShortView {
	my ($self, $short) = @_;
	$self->{_short_view} = $short;
}

sub setNoPermission {
	my ($self, $nop) = @_;
	$self->{_no_permission} = $nop;
}

sub setQuota{
	my ($self, $q) = @_;
	$self->{_quota} = $q;
}

sub bTaA{
	my ($self, $url) = @_;
	$self->{uQa} = $url;
}

sub bWaA{
	my ($self, $link) = @_;
	$self->{vSa} = $link;
}

sub setPath{
	my ($self, $p) = @_;
	$p =~ s!^/?!/!;
	$p =~ s#/[^/]+/\.\./#/#g;
	$p =~ s#/[^/]+/\.\.$#/#g;
	$p =~ s#/\./#/#g;
	$p = "" if $p =~ m!^/\.\./!;
	$p = "" if $p =~ m!^/\.\.$!;
	$p = "" if $p eq '/';
	$self->{docdir} = gAaA->new($self->{rootdir}, $p);
}
sub getFreeSpace{
	my($self) = @_;
	return 1024*1024*99999 if $self->{_quota} eq '';
	my $rootd = gAaA->new($self->{rootdir});
	return $self->{_quota} - $rootd->get_size();
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__
sub fVaA {
	my ($self, $input) = @_;
	my $sk = $input->{sortkey};
	my $dsc = $input->{dsc};
	my $docd = $self->{docdir};
	my $kQz = $self->{kQz};
	my @dlist = $docd->list();
	my @dsca=();
	$dsca[$sk] = !$dsc;
	 
	my @rows;
	my @zJz=(1, 3, 4, 6, 7);
	my $skidx = $zJz[$sk];
	
	if($sk == 3 || $sk == 4) {
		@dlist = sort {$a->[2] cmp $b->[2] || $a->[$skidx] <=> $b->[$skidx] } @dlist;
	}else {
		@dlist = sort {$a->[2] cmp $b->[2] || $a->[$skidx] cmp $b->[$skidx] } @dlist;
	}
	@dlist = reverse @dlist if $dsc;

	my %uidmap = ();
	my $filecnt=0;
	my $filesize=0;
	my $dircnt=0;
	for(@dlist) {
		my ($path, $name, $type, $perm, $gJz, $gid, $size, $mtime, $ctime)  = @$_;
		my $url;
		my $lnk;
		my $icon;
		my @cmds;
		if(not exists $uidmap{$gJz}) {
			$uidmap{$gJz} = eval 'getpwuid($gJz)';
			$uidmap{$gJz} = $gJz if $uidmap{$gJz} eq "";
		}
		my $usru = $uidmap{$gJz};
			
		if($type eq 'TDIR') {
		   next if $name eq '.';
		   next if $name eq '..' && $docd->path() eq "";
		   $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>sVa::kZz($docd->path(),$name) });
		   $lnk = sVa::cUz($url, $name eq '..'? "Parent folder": $name);
		   $icon = $self->eWaA($type, $name);
		   if($name ne '..') {
		   	my $du = sVa::sTa($self->{cgi}, {docmancmd=>'deletesubdir', kQz=>$kQz, dir=>$docd->path(), dsc=>$dsc, filename=>$name, sortkey=>$sk, confirm=>1});
		   	my $dulnk = sVa::fUaA($du, "Delete", "Are you sure you want to delete the folder $name ?");
		   	push @cmds, $dulnk;
			$dircnt ++;
		   }
		}elsif($type eq 'TFILE') {
		   $url = sVa::sTa($self->{cgi}, {docmancmd=>'fDaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
		   $lnk = sVa::hFa($url, $name, "_tgt");
		   $icon = $self->eWaA($type, $name);
		   if(sVa::fIaA($name) =~ /text|octet-stream/ ) {
		   	my $edu = sVa::sTa($self->{cgi}, {docmancmd=>'rA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
			my $edulnk = sVa::hFa($edu, "Edit", "_ed");
			push @cmds, $edulnk;

		   }
		   my $du = sVa::sTa($self->{cgi}, {docmancmd=>'fAaA', kQz=>$kQz, dir=>$docd->path(), dsc=>$dsc, filename=>$name, sortkey=>$sk, confirm=>1});
		   my $dulnk = sVa::fUaA($du, "Delete", "Are you sure you want to delete the file $name ?");
		   my $ru = sVa::sTa($self->{cgi}, {docmancmd=>'fGaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
		   my $rulnk = sVa::hFa($ru, "Replace", "_ed");
		   push @cmds, $rulnk, $dulnk;
		   $filecnt ++;
		}
		push @rows, [$icon." ".$lnk, 
			sVa::hFa(
		   		sVa::sTa($self->{cgi}, {docmancmd=>'eZaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name}),
				sprintf("%04o",$perm) 
			),
			$kQz, 
			qq(<span class="FileSize" title="$size bytes">).sVa::fWaA($size).qq(</span>), 
			sVa::dU('STD',$mtime, 'oP'),
			join(" ", @cmds) ];
		
	}
	my $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path()});
	my @ths = ("Filename", "Permission", "User ID", "Size", "Time", "Commands");
	@ths = map { qq(<a href="$url;sortkey=$_;dsc=). $dsca[$_]. qq("><font color="#ffcc00">).$ths[$_].qq(</font></a>) } 0..4; 
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	print $input->{msg} if $input->{msg} ne "";
	my @ds = split ("/", $docd->path());
	my $pp ="/";
	my $cp = pop @ds;
	my @ps;
	for my $d(@ds) {
		$pp =sVa::kZz($pp, $d);
		my $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$pp });
		my $lnk = sVa::cUz($url, $d||"Top level");
		push @ps, $lnk;
	}
	push @ps, sVa::cUz(sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() }), qq(<b>$cp</b>));
	print join(" <b>&gt&gt;</b> ", @ps);

 my $upformurl = sVa::sTa($self->{cgi}, {docmancmd=>'fHaA', kQz=>$kQz, dir=>$docd->path()});
	my $upformlnk = sVa::hFa($upformurl, "Upload files");
 my $addformurl = sVa::sTa($self->{cgi}, {docmancmd=>'rA', kQz=>$kQz, dir=>$docd->path()});
	my $addformlnk= sVa::hFa($addformurl, "New text file");
 my $mkdirurl = sVa::sTa($self->{cgi}, {docmancmd=>'fNaA', kQz=>$kQz, dir=>$docd->path()});
	my $mkdirlnk= sVa::hFa($mkdirurl, "New folder");

	my @navlnks = ($upformlnk, $addformlnk, $mkdirlnk);
	push @navlnks, $self->{vSa},   sVa::cUz($self->{uQa}, "Main page");

	print "<br>", join(" \&nbsp;|\&nbsp; ", @navlnks);

	my $colsel = [0..5];
	if($self->{_short_view}) {
		$colsel = [0, 3,4,5]; 
	}
 	print sVa::fMa(ths=>\@ths, rows=>\@rows, colsel=>$colsel,  sVa::oVa($tabattr));
	print "<p>";
	print "Folder path: ", sVa::cUz(sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() }), $docd->path() || "Top level"), "<br>";
	print "Number of files: $filecnt<br>";
	print "Number of folders: $dircnt<br>" if $dircnt >0;
 	print $self->{footer};
}

sub rA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::edit_file_form, $self->{cgi});
	my $fn = $input->{filename};
	$af->dNa('filename', $fn);
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
 if($fn ne "") {
		my $p = $docd->gCaA($fn);
		local *F;
		local $/ =undef;
		open F, "<$p";
		my $d = <F>;
		close F;
		$af->dNa('filecontent', $d);
		$af->dNa('filepermission', sVa::get_unix_file_perm($p));
	}
	$af->gSaA('filepermission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

sub fNaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("mkdir", \@eUaA::create_subdir_form, $self->{cgi});
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
	$af->gSaA('permission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

sub fYaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	my $kQz = $self->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $e = $docd->eXaA($input->{subdir}, oct($input->{permission}) || 0755);
	if(not $e) {
		sVa::error('sys', $docd->{_error});
	}else {
		print "Folder created!";
	        my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
		print qq(<script>opener.location="$url";</script>);
		print qq(<center>$sVa::close_btn</center>);
	}
 	print $self->{footer};
}

sub deletesubdir{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	if(not $input->{confirm}) {
		sVa::error("inval", "You must check the confirmation box");
	}
	my $e = $docd->remove_subdir($input->{filename});
	if($e) {
		$input->{msg}="<h1>Folder deleted ($input->{filename})</h1>";
	}else {
		$input->{msg} = $docd->{_error} .qq!<br>!;
	}
	$self->fVaA($input);
}

sub fGaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::replace_file_form, $self->{cgi});
	my $fn = $input->{filename};
	$af->dNa('oldfilename', $fn);
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
 if($fn ne "") {
		my $p = $docd->gCaA($fn);
		$af->dNa('filepermission', sVa::get_unix_file_perm($p));
	}
	$af->gSaA('filepermission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

sub eZaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::chmod_file_form, $self->{cgi});
	my $fn = $input->{filename};
	$af->dNa('filename', $fn);
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
 if($fn ne "") {
		my $p = $docd->gCaA($fn);
		$af->dNa('filepermission', sVa::get_unix_file_perm($p));
	}
	print $af->form();
 	print $self->{footer};
}
sub fLaA {
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 my $kQz=$docd->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::chmod_file_form, $self->{cgi});
	$af->aAa($input);
	my $e = $docd->chmod_files(oct($af->{filepermission}), $af->{filename});
	if(not $e) {
		print "Error: $docd->{_error}";
	}else{
		print "Permission changed";
	}
	print qq(<center>$sVa::close_btn</center>);
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);
 	print $self->{footer};
}

sub fFaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 my $kQz=$docd->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::confirm_delfile_form, $self->{cgi});
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
	my $fn = $input->{filename};
	$af->dNa('filename', $fn);
	print $af->form();
 	print $self->{footer};
}

sub fAaA {
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	if(not $input->{confirm}) {
		sVa::error("inval", "You must check the confirmation box");
	}
	my $e = $docd->del_files($input->{filename});
	if($e) {
		$input->{msg}="<h1>File deleted ($input->{filename})</h1>";
	}else {
		$input->{msg} = $docd->{_error} .qq!($input->{filename})<br>!;
	}
	$self->fVaA($input);
}
sub fBaA {
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 my $kQz=$docd->{kQz};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::edit_file_form, $self->{cgi});
	$af->aAa($input);
	if($af->{filenocr}) {
		$af->{filecontent} =~ s/\r//g;
	}
	my $free = $self->getFreeSpace();
	my $e = $docd->tZa($af->{filename}, $af->{filecontent}, oct($af->{filepermission}), $free);
	if(not $e) {
		print "Error: $docd->{_error}";
	}else{
		print $af->form(1);
	}
	print qq(<center>$sVa::close_btn</center>);
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);
 	print $self->{footer};
}

sub eXaA {
	my ($self, $input) = @_;
	my $dir = $self->{docdir}->eXaA($input->{subdir}, $input->{mode});
	sVa::cTz("Directory created") if $dir;

}

sub  fDaA {
	my ($self, $input) = @_;
	my $xO = $input->{filename};
	my $docd = $self->{docdir};
	my $path = $docd->gCaA($xO);
	sVa::iFa($path);
}

sub fHaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	my $af = aLa->new("edit", \@eUaA::upload_file_form, $self->{cgi});
	$af->dNa('dir', $docd->path());
	$af->dNa('kQz', $docd->{kQz});
	$af->gSaA('filepermission') if $self->{_no_permission};
	print $af->form();
 	print $self->{footer};
}

sub upload{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
 	my $cPz;
	my $e;
	if($input->{filepermission} eq "") {
		$input->{filepermission} ="0644";
	}
	my $free = $self->getFreeSpace();
 	for(values %$input) {
		next if not ref($_) eq 'ARRAY';
		$cPz = $_->[0];
		$e = $docd->tZa($cPz, $_->[1], oct($input->{filepermission}), $free);
		$free -= length($_->[1]);
		last if not $e;
 	}

 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();

	if($e) {
		print "Files uploaded";
	}else {
		print $docd->{_error};
	}
	print qq(<center>$sVa::close_btn</center>);
 my $kQz=$docd->{kQz};
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);

 	print $self->{footer};
}

sub fSaA{
	my ($self, $input) = @_;
	my $docd = $self->{docdir};
	my $path = $input->{oldfilename};
	if($input->{filepermission} eq "") {
		$input->{filepermission} ="0644";
	}
	my $free = $self->getFreeSpace();
	if(not $docd->tZa($path, $input->{file1}->[1], oct($input->{filepermission}), $free)) {
		sVa::error("sys", "$path, $!");
	}
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();

	print "File replaced";
	print qq(<center>$sVa::close_btn</center>);
 my $kQz=$docd->{kQz};
	my  $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() });
	print qq(<script>opener.location="$url";</script>);

 	print $self->{footer};
}

sub eWaA {
	my ($self, $ftype, $xO) = @_;
	return qq(<img src=").sVa::fZaA($ftype, $xO).qq(">);;

}
 
sub eVa{
 my ($self) = @_;
 return $self->{uTa} && ( $self->{uTa} eq  $self->{wOa});
}
sub tJa{
	my ($self) = @_;
	print "Location: $self->{wCa}\n\n";
	sVa::iUz();
}
1;


package fKaA;
use Object;
@fKaA::ISA= qw(Object);
@fKaA::fs= qw(type);
package fJaA;
use strict;

@fJaA::ftypes=qw(FILE DEVICE FIFO SYMLINK DIR);

sub new {
 my ($type, $root, $path) = @_;
 my $self;
 $self = {};
 $self->{_path} = $path;
 $self->{_root} = $root;
 return bless $self, $type;
}
sub list {
 my ($self) = @_;

};

sub path{
 my ($self, $ndir) = @_;
 if (@_ == 2) {
 $self->{_path} = $ndir;
 }
 return $self->{_path};
 
}

sub root{
 my ($self, $ndir) = @_;
 if (@_ == 2) {
 $self->{_root} = $ndir;
 }
 return $self->{_root};
 
}

sub gCaA {
	my ($self, $xO) = @_;
	$xO =~ s!.*/!!;
	$xO =~ s!.*\\!!;
	$xO =~ s!^\.\.$!!;
	return sVa::kZz($self->root(), $self->path(), $xO);
}

sub goto_self {
	my ($self) = @_;

}

sub eXaA {
	my ($self, $subdir, $mod) = @_;
}

sub remove_subdir {
	my ($self, $subdir) = @_;
}

sub chmod_files {
	my ($self, $perm, @files) = @_;

}

sub del_files {
 my ($self, @files) = @_;

}

sub tZa {
 my ($self, $xO, $data, $perm) = @_;

}

sub output_file{
 my ($self, $xO, $nA) = @_;
}

sub find_files {
 my ($self, $testfunc) = @_;
}

sub get_last_error{
 my ($self) = @_;
 return $self->{_error};
 

}

1;
package gAaA;
use fJaA;
@gAaA::ISA=qw(fJaA);
use sVa;
use strict;

sub list {
 my ($self) = @_;
 my $dir = sVa::kZz($self->{_root}, $self->path()) ;
 local *DIR;
 if( not (opendir DIR, $dir ) ) {
	$self->{_error} = "Fail to open directory: $!";
	return;
 }
 my $ent ;
 my $path;
 my @dlist;
 my $type;
 while ($ent = readdir (DIR)) {
	$path = sVa::kZz($dir, $ent);
 my $type = undef;
	if(-f $path) {
		$type = 'TFILE';
	}elsif(-d $path) {
		$type = 'TDIR';
	}elsif(-s $path) {
		$type = 'TSLINK';
	}else {
		$type = 'TDEVICE';
	}
 my @stats = stat($path) ;
 push @dlist, [
 $path, 
 $ent,
		      $type,
		      $stats[2] &07777, #permission
 $stats[4], # gJz
 $stats[5], # gid
 $stats[7], # size
		      $stats[9], # mtime
		      $stats[10], # ctime
		      ];
 }
 closedir DIR;
 return @dlist;
}

sub get_size {
 my ($self) = @_;
 my $dir = sVa::kZz($self->{_root}, $self->path()) ;
 return sVa::hAaA($dir);

}

sub goto_self {
	my ($self) = @_;
	return chdir sVa::kZz($self->{_root}, $self->path());
}

sub eXaA{
	my ($self, $subdir, $mod) = @_;
	my $dir = sVa::kZz($self->{_root}, $self->path(), $subdir);
	if (not mkdir $dir, $mod) {
		$self->{_error} = "Fail to create directory: $! ($dir)";
		return;
	}
	return 1;
}

sub remove_subdir{
	my ($self, $subdir) = @_;
	my $dir = $self->gCaA($subdir);
	if(not rmdir $dir) {
		$self->{_error} = "Fail to remove directory: $! ($dir)";
		return;
	}
	return $subdir;
}

sub chmod_files {
	my ($self, $perm, @files) = @_;
	my @paths = map { $self->gCaA($_) } @files;
	if( not chmod $perm, @paths) {
		$self->{_error} = "Fail to chmod permission: $!";
		return;
	}
	return 1;
}

sub del_files {
	my ($self, @files) = @_;
	my @paths = map { $self->gCaA($_) } @files;
	if(not unlink @paths) {
		$self->{_error} = "Fail to delete file: $!";
		return;
	}
	return 1;
}

sub tZa {
 my ($self, $xO, $data, $perm, $maxsize) = @_;
 if($xO eq '') {
	$self->{_error} ="Missing filename";
	return;
 }
 my $path = $self->gCaA($xO);
 if($maxsize ne '' && length($data) > $maxsize) {
	$self->{_error} ="Not enough free space: ($xO)";
	return;
 }
 local *FH;
 if(not open FH, ">$path") {
	$self->{_error} ="Fail to open file: $! ($xO)";
	return;
 }
 binmode FH;
 print FH $data;
 close FH;
 $self->chmod_files($perm, $xO) if $perm ne "";
 return 1;
}

sub output_file {
 my ($self, $xO, $nA) = @_;
 my $path = $self->gCaA($xO);
 local *FH;
 if(not open FH, "<$xO") {
	$self->{_error} ="Fail to open file: $! ($xO)";
	return;
 }
 binmode FH;
 my $buf;
 while(sysread FH, $buf, 4096*4) { print $nA $buf;}
 close FH;
 return 1;
}
	

			 
1;
 
		       
			
	
 
 
 
	
package DBFileDB;

use jFa;
use DB_File;
@DBFileDB::ISA = qw(jFa);

sub pXa{
 my ($self) =@_;
 my $jTa = $self->{tb}."_dbf";
 my %hash;
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDONLY, 0644, $DB_BTREE) {
	return;
 }
 my $cnt = scalar(keys %hash);
 untie %hash;
 return $cnt;
}

sub iQa{
 my ($self, $opts) =@_;
 my %hash;
 my $index = $self->{index} ||0;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 my $jTa = $self->{tb}."_dbf";
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDONLY, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 my @rows=();
 my $filter = $opts->{filter};
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret};
 my $sidx = $opts->{sidx} || 0;
 my @mykeys = keys %hash;
 my $eidx = $opts->{eidx} || scalar(@mykeys);
 my $idx=0;
 for($idx=$sidx; $idx<$eidx; $idx++){
	$row = [split /\t/, $hash{$mykeys[$idx]}];
	if($filter && not &$filter($row, $idx)) {
		$filtcnt++;
		next;
 }
	push @rows, $row;
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 untie %hash;
 return wantarray? (\@rows, $cnt, $filtcnt) : \@rows;
}

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my %hash;
 my $index = $self->{index} ||0;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 my $jTa = $self->{tb}."_dbf";
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDWR, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 %hash= () if $clear;
 for(@$rowrefs) {
 	$hash{$_->[$index]}= join("\t", @$_);
 }
 untie %hash;
 return scalar(@$rowrefs);
}

sub jXa{
 my ($self, $rowrefs, $opts) =@_;
 return $self->kEa($rowrefs, $opts);
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
 my $jTa = $self->{tb}."_dbf";
 my %hash;
 $DB_BTREE->{'compare'} = $self->{cmp}; 
 
 if(not tie %hash, "DB_File", $jTa, O_CREAT|O_RDWR, 0644, $DB_BTREE) {
	unless($opts && $opts->{noerr} ) {
			abmain::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 %hash= () if $clear;
 my $cnt =0;
 for(@$ids) {
 if(exists $hash{$_}) {
 		delete $hash{$_};
		$cnt ++;
 }
 }
 untie %hash;
 return $cnt;
}

1;
package hIaA;
use IO::Select;
use strict;
sub TIEHANDLE {
	my ($class, $handle, $timeout) = @_;
	my $self = bless {}, $class;
	$self->{timeout} = $timeout;
	$self->{hHaA} = $handle;
	$self->{buf}= undef;
	$self->{hJaA} = 0;
	$self->{line_max} = 4*4096;
 	$self->{sel} = IO::Select->new($handle);
	return $self;
}

sub hMaA {
	my ($self) = @_;
	return length($self->{buf}) - $self->{hJaA};
}

sub hGaA {
	my ($self, $len) = @_;
	return if $self->{hNaA};
	return if $self->{hKaA};
	my $buf;
	if($self->hLaA($buf, $len,0) ==0) {
		return 0;
	}
	$self->{buf} .= $buf;
	if($self->{hJaA} > 1024){
		$self->compact_buf();
	}
	return length($buf);
}

sub compact_buf{
	my ($self) = @_;
	$self->{buf} = substr($self->{buf}, $self->{hJaA});
	$self->{hJaA}=0;
}
sub READ{
	my ($self, $length, $offset) = @_[0,2,3];
	my $bufref = \$_[1];
	my $len = $self->hMaA();
	if($len < $length) {
		my $rdcnt = $self->hGaA($length-$len);
	}
	$len = $self->hMaA();
	if($length < $len) {
			$len = $length;
	}
	return 0 if $len == 0;
	substr($$bufref, $offset) = substr($self->{buf}, $self->{hJaA}, $len); 
	$self->{hJaA} += $len;
	return $len;
}

sub READLINE{
	my ($self) = @_;
	my $pos;
	while( -1 == ($pos = index($self->{buf}, "\n", $self->{hJaA}) ) && $self->hMaA() < $self->{line_max}) {
		my $rdcnt = $self->hGaA(4096);
		last if not $rdcnt ;
	}
	my $line = undef;
	my $len =0;
	if($pos >=0) {
		$len = $pos - $self->{hJaA} +1;
	}else {
		$len = $self->hMaA();
	}
	return undef if $len <=0;
	$line = substr ($self->{buf}, $self->{hJaA}, $len);
	$self->{hJaA} += $len;
	return $line;

}

sub hLaA{
	my ($self, $bbb, $length, $offset) = @_;
	return 0 if ($self->{hKaA} || $self->{hNaA});
	my $bufref = \$_[1];
	my @ready = $self->{sel}->can_read( $self->{timeout} );
	if(scalar(@ready)>0) {
		my $cnt = sysread($self->{hHaA}, $$bufref, $length, $offset); 
		if($cnt <=0) {
			$self->{hKaA} = 1;
		}
		return $cnt;
			
	}else {
		if(eof($self->{hHaA})) {
		}else{
			print STDERR "$$ Timeout", caller(5), "\n";
			$self->{hNaA}=1;
		}
		return 0;
	}
}
sub BINMODE {
	my $self = shift;
	binmode $self->{hHaA};
}

sub PRINT {
	my $self = shift;
 print {$self->{hHaA}} @_ ;	
}

sub WRITE {
	my $self = shift;
	syswrite($self->{hHaA}, $_[0], $_[1], $_[2]);
}

sub EOF {
	my $self = shift;
	return $self->{hNaA} || eof($self->{hHaA});
}

sub CLOSE {
	my $self = shift;
	return close($self->{hHaA});
}

sub DESTROY {
	my $self = shift;
	$self->CLOSE;
}

sub PRINTF{
	my $self = shift;
 printf {$self->{hHaA}} @_;	
}

1;
__END__
package main;

tie(*MYIN, hIaA::, \*STDIN, 10);
while($_=<MYIN>) {
	print "got line $_\n";
}

1;
package jFa;

sub new {
 my ($type, $tb, $opts) = @_;
 my $self = bless {}, $type;
 $self->{tb} = $tb;
 $self->{index} = $opts->{index} || 0;
 $self->{jMa} = $opts->{jMa};
 $self->{cmp} = $self->{jMa}? undef: sub {return $_[0] <=> $_[1];} ;
 return $self;
}
sub iSa{
 my ($self, $jRa, $opts) =@_;
 return $self->kEa([$jRa], $opts);
}

sub iRa{
 my ($self, $jKa, $opts) =@_;
 return $self->kEa($jKa, $opts, 1);
}

sub jHa{
 my ($self, $jRa, $opts) =@_;
 return $self->jXa([$jRa], $opts);
}

sub jNa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my @ids;
 my $index = $self->{index} ;
 for(@$rowrefs) {
 		push @ids, $_->[$index];
 }
 return $self->jLa(\@ids, $opts, $clear);
}

sub kCa {
 my ($self, $id) = @_;
 my $jKa = $self->iQa(
 {noerr=>1, 
 filter=>
 $self->{jMa}? sub { $_[0]->[$self->{index}] eq $id; }
 : sub { $_[0]->[$self->{index}] == $id; }
 });
 return if not ($jKa && scalar(@$jKa));
 return $jKa->[0];
}

sub iQa{
 my ($self, $opts) =@_;
 return;
}

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
}
 

sub jXa{
 my ($self, $rowrefs, $opts) =@_;
}
sub pXa{
}

1;
package jEa;
use jFa;
use jPa;

BEGIN{
	@jEa::ISA= qw(jFa);
};

sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8};

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__
sub pXa{
	my ($self) = @_;
 my $f = $self->{tb};
 my $cnt =0; 
	my $buf;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_SH);
 local *F;
	open F, "<$f";
 while(sysread F, $buf, 4096*4) { $cnt += ($buf =~ tr/\n//);}
 close F;
	my $hsh = jEa::hAz($f."_del");
 my $dcnt =0;
	if($hsh) {
		$dcnt = scalar(keys %$hsh);
	}
	return wantarray?($cnt-$dcnt, $dcnt): $cnt-$dcnt;
}

sub jXa{
 my ($self, $rowrefs, $opts) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX());
 return jQa($self->{tb}."_upd", $rowrefs, $opts);
}

sub iQa{
 my ($self, $opts) =@_;
 my $jTa = $self->{tb};
 my $lck = jPa->new($self->{tb}, jPa::LOCK_SH);
 $opts->{index} = $self->{index};
 return jEa::jZa($jTa, $opts);
} 

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX());
 $self->oMz();
 return jEa::jQa($self->{tb}, $rowrefs, $opts, $clear);
}
 
sub jQa{
 my ($jTa, $rowrefs, $opts, $clear) =@_;
 local *TBF;
 my $res;
 if($clear) {
	$res = open TBF, ">$jTa";
 	unlink $jTa."_upd";       
 	unlink $jTa."_del";       
 }else {
	$res = open TBF, ">>$jTa";
 }
 if(not $res) {
		unless($opts && $opts->{noerr}) {
			sVa::error("sys", $opts->{kG}. "($!: $jTa)");
	        }
		return;
 }
 for(@$rowrefs) {
	next if not ref($_) eq 'ARRAY';
	for my $str (@$_) {
		next if not $str;
		$str =~ tr/\t/ /;
		$str =~ tr/\n/ /;
	}
 	print TBF join("\t", @$_), "\n";
 }
 close TBF;
 1;
}
 

sub jZa{
 my ($jTa, $opts, $no_upd) =@_;
 local *TBF;
 my %jIa=();
 my $index = $opts->{index} ||0;
 my $dhash=undef;
 if(not $no_upd) {
	my $jKa= jEa::jZa($opts->{aNz} || "${jTa}_upd", {index=>$index, noerr=>1}, 1);
	$dhash = jEa::hAz(${jTa}."_del");
 for(@$jKa) {
		$jIa{$_->[$index]} = $_;
 }
 }
 
 if(not open TBF, "<$jTa") {
	unless($opts && $opts->{noerr} ) {
			print caller, "\n";
			sVa::error("sys", $opts->{kG}. "($!: $jTa)");
 }
	return;
 }
 my $rows=[];
 my $filter = $opts->{filter};
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret}||0;
 my $sidx = $opts->{sidx};
 my $eidx = $opts->{eidx};
 my $idx=0;
 my $wantstr = $opts->{getstr};
 local $_;
 while(<TBF>){
 $_ =~ s/\r*\n$//;
	next if not $_;
	$row = [split /\t/, $_];
 next if($dhash && $dhash->{$row->[$index]});
 $idx ++;
	next if ($sidx && $idx <$sidx+1);
	last if ($eidx && $idx >$eidx);
 if((not $no_upd) && exists $jIa{$row->[$index]}) {
		$row = $jIa{$row->[$index]};
 }

	if ($filter && not &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
 if($wantstr) {
		push @$rows, $_;
 }else {
		push @$rows, $row;
 }
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 close TBF;
 return wantarray? ($rows, $cnt, $filtcnt) : $rows;
}

sub qYa{
 my ($delf, $ids, $opts) =@_;
 return if not @$ids;
 local *TBF;
 open TBF, ">>$delf" or sVa::error("sys", $opts->{kG}. "($!: $delf)");
 print TBF join ("\n", @$ids), "\n";
 close TBF;
}

sub hAz{
 my ($delf, $ids, $opts) =@_;
 local *TBF;
 open TBF, "<$delf" or return;
 local $/=undef;
 my $l = <TBF>;
 $l =~ s/\s+$//g;
 my @ids = split /\r?\n/, $l;
 my $idhsh = {};
 for(@ids) {
	$idhsh->{$_} =1 if $_ ne "";
 }
 close TBF;
 return $idhsh; 
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX);

 my $jTa = $self->{tb};

 if($clear) {
	unlink $jTa;
 	unlink $jTa."_upd";
	return;
 }
 my $delf = $jTa."_del";
 jEa::qYa($delf, $ids);
 my $dhash = jEa::hAz($delf);

 if($dhash && scalar(keys %$dhash) > 0) {
	$self->oMz($opts);
 }
 return scalar(@$ids);
 
}

sub oMz{
 my ($self, $opts) =@_;
 local *TBF;
 my %jIa=();
 my $index = $self->{index};
 my $jTa = $self->{tb};
 my $jKa= jEa::jZa($opts->{aNz} ||"${jTa}_upd", {index=>$index, noerr=>1}, 1);
 for(@$jKa) {
		$jIa{$_->[$index]} = $_;
 }
 my $kIa = jEa::hAz("${jTa}_del");
 return if (scalar(keys %jIa) ==0  && scalar(keys %$kIa) ==0 );

 if(not open TBF, "<$jTa") {
	return;
 }
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $filter = $opts->{filter};
 my $idx=0;
 open TBF2, ">$jTa.tmp";
 my $l;
 while( $l = <TBF>){
 $l =~ s/\r*\n$//;
	next if not $l;
 $idx ++;
	$row = [split /\t/, $l];
 if(exists $jIa{$row->[$index]}) {
		$row = $jIa{$row->[$index]};
 }
 if($kIa->{$row->[$index]}) {
	      $filtcnt ++;
	      next;
 }
	if ($filter && &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
 print TBF2 join("\t", @$row), "\n";
	$cnt ++;
 }
 close TBF;
 close TBF2;
 
 open TBF2, ">$jTa";
 open TBF, "<$jTa.tmp";
 binmode TBF2;
 my $buf;
 while(sysread TBF, $buf, 4096*4) { syswrite (TBF2, $buf, length($buf), 0); }
 close TBF;
 close TBF2;
 unlink $jTa."_upd";       
 unlink $jTa."_del";       
 unlink "$jTa.tmp";       
 return $filtcnt;
}
1;
package jPa;
sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8};

sub new {
 my ($type, $file, $mode) = @_;
 $file =~/(.*)/; $file = $1;
 my $lf = $file."_lck";
 $mode = LOCK_EX if ((!$mode) || not -f $lf);
 my $lock_fh= "lT$file";
 $lock_fh =~ s#\W#_#g;
 $lock_fh = eval "\\*$lock_fh";
 if($mode == LOCK_EX) {
 	open ($lock_fh, ">>$lf") or return;
 }else {
 	open ($lock_fh, "$lf") or return;
 }
 eval {
 my $rem=0;
	 local $SIG{ALRM} = sub { die "lock_operation_timeout ($lf)" };
 $rem = eval 'alarm 20' if $sVa::use_alarm;
 flock ($lock_fh, $mode) or sVa::error('sys', "Fail to lock $lf: $!");
 eval "alarm $rem" if $sVa::use_alarm;
 };
 if ($@ =~ /operation_timeout/) {sVa::error('sys', "Lock operation timed out. Go back and retry.<!--$@-->");  }
 my $self = bless {}, $type;
 $self->{lock_fh} = $lock_fh;
 return $self;
 
}

sub DESTROY{
 my ($self) = @_;
 my $lock_fh=$self->{lock_fh};
 return if not $lock_fh;
 flock ($lock_fh, LOCK_UN);
 close $lock_fh;
}

1;

package pAa;
use strict;

use vars qw ($fhcnt $VERSION);

use Carp;
use Socket qw(PF_INET SOCK_STREAM AF_INET sockaddr_in inet_aton);
#IF_AUTO use AutoLoader 'AUTOLOAD';

sub DESTROY {
 my $self = shift;
 $self->Close();
}

#IF_AUTO 1;
#IF_AUTO __END__

sub new
{
	my $name = shift;
	my $user = shift;
	my $pass = shift;
	my $host = shift || "pop";
	my $oE = shift || getservbyname("pop3", "tcp") || 110;
	my $debug = shift || 0;

 my $me = bless {
		DEBUG => $debug,
		SOCK => $name . "::SOCK" . $fhcnt++,
		SERVER => $host,
		PORT => $oE,
		USER => $user,
		PASS => $pass,
		COUNT => -1,
		SIZE => -1,
		ADDR => "",
		STATE => 'DEAD',
		MESG => 'OK',
		EOL => "\r\n",
	}, $name;

	$me->nHa($user) ; $me->Pass($pass);
	if ($me->Host($host) and $me->Port($oE)) {
		$me->Connect();
	}

	$me;

}

sub Version {
	return $VERSION;
}

sub Alive
{
 my $me = shift;
	$me->State =~ /^AUTHORIZATION$|^TRANSACTION$/i;
}

sub State
{
 my ($me, $stat) = @_;
 $me->{STATE} = $stat if $stat;
 return $me->{STATE};
}

sub nIa
{
 my ($me, $msg) = @_;
 return $me->{MESG} if not $msg;
 $me->{MESG} = $msg;
}

sub Debug
{
 my $me = shift;
	my $debug = shift or return $me->{DEBUG};
	$me->{DEBUG} = $debug;
 
}

sub Port
{
 my $me = shift;
	my $oE = shift or return $me->{PORT};

	$me->{PORT} = $oE;

}

sub Host
{
 my $me = shift;
	my $host = shift or return $me->{HOST};

 my $addr;
 
 if ($host =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/) {
		$addr = inet_aton($host);
 	        my $tmp = gethostbyaddr ($addr, AF_INET); 
 $me->{HOST}=$tmp || $host;
 } else {
		$addr = gethostbyname ($host) or
		$me->nIa("Could not gethostybyname: $host, $!") and return;
 $me->{HOST}= $host;
 }

 $me->{ADDR} = $addr;
 1;
} 

sub Socket {
	my $me = shift;
	return $me->{'SOCK'};
}

sub nHa
{
	my $me = shift;
	my $user = shift or return $me->{USER};
	$me->{USER} = $user;

}
sub Pass
{
	my $me = shift;
	my $pass = shift or return $me->{PASS};
	$me->{PASS} = $pass;
 
} 

sub Count
{
	my $me = shift;
	my $c = shift;
	if (defined $c and length($c) > 0) {
		$me->{COUNT} = $c;
	} else {
		return $me->{COUNT};
	}
 
} 

sub Size
{
	my $me = shift;
	my $c = shift;
	if (defined $c and length($c) > 0) {
		$me->{SIZE} = $c;
	} else {
		return $me->{SIZE};
	}
 
}

sub EOL {
 my $me = shift;
	return $me->{'EOL'};
}

sub Close
{
	my $me = shift;
 my $s;
	if ($me->Alive()) {
		$s = $me->{SOCK};
		print $s "QUIT", $me->EOL;
		shutdown($me->{SOCK}, 2) or $me->nIa("shutdown failed: $!") and return 0;
		close $me->{SOCK};
		$me->State('DEAD');
	}
	1;
} 
sub Connect
{
	my ($me, $host, $oE) = @_;

	$host and $me->Host($host);
	$oE and $me->Port($oE);

	my $s = $me->{SOCK};
	if (defined fileno $s) {
	
		$me->Close;
	}

	socket($s, PF_INET, SOCK_STREAM, getprotobyname("tcp") || 6) or
		$me->nIa("could not open socket: $!") and
			return 0;
	connect($s, sockaddr_in($me->{PORT}, $me->{ADDR}) ) or
		$me->nIa("could not connect socket [$me->{HOST}, $me->{PORT}]: $!") and
			return 0;

	select((select($s) , $| = 1)[0]); 

 my $msg;
	defined($msg = <$s>) or $me->nIa("Could not read") and return 0;
	chop $msg;
	$me->nIa($msg);
	$me->State('AUTHORIZATION');

	if($me->nHa() and $me->Pass) {
 $me->nAa;
 return 0 if($me->State() =~ /^TRANS/);
 if($main::pop_logon_retry_time >0 && $me->nIa() =~ /busy/i){
 $me->Close();
 sleep($main::pop_logon_retry_time);
 $main::pop_logon_retry_time=0;
 $me->Connect();
 }
 }

}

sub nAa
{
	my $me = shift;
	my $s = $me->{SOCK};
	print $s "USER " , $me->nHa , $me->EOL;
	$_ = <$s>;
	chop;
	$me->nIa($_);
	/^\+/ or $me->nIa("USER failed: $_") and $me->State('AUTHORIZATION')
		and return 0;

	print $s "PASS " , $me->Pass(), $me->EOL();
	$_ = <$s>;
	chop;
	$me->nIa($_);
	/^\+/ or $me->nIa("PASS failed: $_") and $me->State('AUTHORIZATION')
		and return 0;
	/^\+OK \S+ has (\d+) /i and $me->Count($1);

	$me->State('TRANSACTION');

	$me->oMa() or return 0;

} 

sub Headers
{
	my $me = shift;
	my $gP = shift;
	my $header = '';
	my $s = $me->{SOCK};
	my $mail = {};;

	$me->Debug() and print "TOP $gP 0\n";
	print $s "TOP $gP 0", $me->EOL;
	$_ = <$s>;
	$me->Debug() and print;
	chop;
	/^\+OK/ or $me->nIa("Bad return from TOP: $_") and return '';
	/^\+OK (\d+) / and $mail->{size} = $1;
	
 my $lkey ="";
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		/^([^:]+):\s+(.*)$/ and $mail->{ucfirst(lc($1))}=$2 and $lkey=ucfirst(lc($1));
		/^\s+(\S+)/ and $lkey and $mail->{$lkey} .=$_;
		$mail->{header} .= $_;
	} until /^\.\s*$/;

 for(keys %$mail) {
		$mail->{$_} = dZz::pLa($mail->{$_});
 }
	return $mail;
} 

sub oKa{

	my $me = shift;
	my $gP = shift;
	my %mail=();
	my $s = $me->{SOCK};
 $mail{gHz} = [];
	
	$me->Debug() and print "RET $gP\n";
	print $s "RETR $gP", $me->EOL;
	$_ = <$s>;
	$me->Debug() and print;
	chop;
	/^\+OK/ or $me->nIa("Bad return from RETR: $_") and return 0;
	/^\+OK (\d+) / and $mail{bytelen} = $1;
	

 my $lkey ="";
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		/^([^:]+):\s+(.*)$/ and $mail{ucfirst(lc($1))}=$2 and $lkey=ucfirst(lc($1));
		/^\s+(\S+)/ and $lkey and $mail{$lkey} .=$_;
		$mail{header} .= $_;
 push @{$mail{gHz}}, $_;
 $mail{size} += length($_);
	} until /^\s*$/;
 for(keys %mail) {
		$mail{$_} = dZz::pLa($mail{$_});
 }

 my @barr;
	do {
		$_ = <$s>;
 defined($_) or $me->nIa("Connection to POP server lost") and return;
		unless(/^\.\s*$/) {
 	push @{$mail{gHz}}, $_;
 }
	} until /^\.\s*$/;

	return %mail;
 
} 

sub oMa {
	my $me = shift;
	my $s = $me->Socket;

	$me->Debug() and carp "POP3: oMa";
	print $s "STAT", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("STAT failed: $_") and return 0;
	/^\+OK (\d+) (\d+)/ and $me->Count($1), $me->Size($2);

 return $me->Count();
}

sub List {
 my $me = shift;
	my $gP = shift || '';

	my $s = $me->Socket;
	$me->Alive() or return;

	my @retarray = ();

	$me->Debug() and carp "POP3: List $gP";
	$gP = " $gP" if $gP ne "";
	print $s "LIST$gP", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("$_") and return;
	if ($gP) {
		$_ =~ s/^\+OK\s*//;
		return $_;
	}
	while(<$s>) {
		/^\.\s*$/ and last;
		/^0\s+messag/ and last;
		chop;
		push(@retarray, $_);
	}
	return @retarray;
}

sub mHa{
 my $me = shift;
	my $gP = shift || '';

	my $s = $me->Socket;
	$me->Alive() or return;

	my @retarray = ();

	$me->Debug() and carp "POP3: UIDL $gP";
	my $num2 ="";
 $num2 = " $gP" if $gP ne "";
	print $s "UIDL$num2", $me->EOL;
	$_ = <$s>;
	/^\+OK/ or $me->nIa("$_") and return;
	if ($gP) {
		$_ =~ s/^\+OK\s*\d+\s+//;
		$_ =~ s/\s*$//;
		return {$gP=>$_};
	}
 my $uids= {};
	while(<$s>) {
		/^\.\s*$/ and last;
		/^0\s+messag/ and last;
		$_ =~ s/\s*$//;
		my ($cG, $gJz) = split /\s+/, $_;
		if($cG) {
			$uids->{$cG} = $gJz;
		}
	}
	return $uids;
}

sub Last {
 my $me = shift;
	
	my $s = $me->Socket;
	
	print $s "LAST", $me->EOL;
	$_ = <$s>;
	
	/\+OK (\d+)\s*$/ and return $1;
}

sub nRa {
 my $me = shift;
	
	my $s = $me->Socket;
	print $s "RSET", $me->EOL;
	$_ = <$s>;
	/\+OK .*$/ and return 1;
	return 0;
}

sub pGa {
 my $me = shift;
	my $gP = shift || return;

	my $s = $me->Socket;
	print $s "DELE $gP",  $me->EOL;
	$_ = <$s>;
	$me->nIa($_);
	/^\+OK / && return 1;
	return 0;
}

1;

package mOa;
use pAa;
use dZz;
use strict;

use vars qw();

BEGIN {
@mOa::ISA = qw(pAa);
}

#IF_AUTO use AutoLoader 'AUTOLOAD';

#IF_AUTO 1;
#IF_AUTO __END__

sub qEa{
 my ($self, $gP, $gJz) = @_;
 my $cG=$gP;
 my $h = $self->Headers($gP);
 my $uhsh = $self->mHa($gP);

 my %mail = $self->oKa($gP);

 my $cnt = @{$mail{gHz}};
 my $ent = dZz->new($mail{gHz});
 $ent->parse();

 

 if (@{$ent->{parts}}) {
	qHa(\%mail, $ent, 1);
 } else {
 $mail{qGa} = $ent->eHz();
 }
 return %mail;
}
 

sub qHa{
 my ($vf, $entity, $curlev) = @_;

 if (@{$entity->{parts}}) {     
 my $i=0;
 for(@{$entity->{parts}}) {     
	    qHa($vf, $_,  "${curlev}_$i");
 $i++;
	}
	return;
 }
 my ($type, $eMz) = split('/', $entity->{head}->{'content-type'});
 my $inline = $entity->{head}->{'content-disposition'} =~ /inline;/i || 0;
 $eMz = (split(';', $eMz))[0];
 my $eFz = $entity->{eFz};

 my $show_body=0;
 my $d = $entity->eHz();
 if (($type=~ /^text$/i && ($eMz =~ /^plain/i || $inline) ) || (lc($type) eq  'message' && $inline) ) {  
	    if(length($d) < 200*1024) {
 	$vf->{qGa}.="\n\n".$d;
 	$show_body=1;
	    }
 }
 if (not $show_body) {
	push @{$vf->{xattach}}, [ $eFz, $d, $entity->{head}->{'content-type'}];

 }
	
}

sub qIa {
 my ($self)=@_;
 my @listarr = $self->List();
 my $qBa = $self->mHa();
 my @mnos;
 for (@listarr) {
 my $cG;
 /^(\d+)\s+(\d+).*$/  or next;
 $cG =$1;
	push @mnos, [$cG, $2, $qBa->{$cG}];
 }
 return @mnos;
 
}

sub qSa{
 	my $pop = new mOa("anyemail_test1", "any314", "perlpro.com");
 print "fail to logon POP server : ${\($pop->State())}, ${\($pop->nIa())}" 
	  unless ($pop->State() =~ /^TRANS/);
 my @mnos = $pop->qIa();
 return if not scalar(@mnos);
 for(@mnos) {
		my ($cG, $sz, $gJz) = @$_;
		my %mail =  $pop->qEa($cG, $gJz);
		print "Got mail ", $mail{Subject}, " ", length($mail{qGa}), "\n";
		#$pop->pGa($cG);
 }
	return;
}
1;
package hDa;
#IF_AUTO use aLa;

BEGIN {
 @fs=qw(file form)
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub new {
	my $type = shift;
	my $self = {};
	@{$self}{@fs} = @_;
	$self->{entry_hash} = {}; 
	$self->{jSa} = 0;
	bless $self, $type;
	if($self->{file} && -r $self->{file}) {
		$self->load();
	}
	return $self;
}

sub kKa {
	my ($self, $idx,  $tm,  $ent) = @_;
	return if not $ent;
	$self->{entry_hash}->{$idx} = [$tm, $ent->dHa()];
	if($idx > $self->{jSa}) {
		$self->{jSa} = $idx;
	}
}

sub jGa {
	my ($self, $idx,  $tm,  $ent) = @_;
	return if not $ent;
	$self->{entry_hash}->{$idx} = [$tm, $ent->dHa()];
}

sub jUa{
	my ($self, $line) = @_;
	return if not $line;
	my @fs = split /\t/, $line;
	my $idx = shift @fs;
	$self->{entry_hash}->{$idx} = [@fs];
	if($idx > $self->{jSa}) {
		$self->{jSa} = $idx;
	}
}

sub jYa{
	my ($self, $idx, $sync) = @_;
	delete $self->{entry_hash}->{$idx};
	$self->store() if $sync;
}

sub oBa {
	my ($self)=@_;
 return keys %{$self->{entry_hash}};
}

sub mSa{
	my ($self, $idx)=@_;
 return if not ref($self->{entry_hash}->{$idx});
 my @vals = @{$self->{entry_hash}->{$idx}};
 for(@vals) {
		$_ = sVa::oDa($_);
 }
	return @vals;
}

sub kHa{
	my ($self, $idx, $ent)=@_;
	my @vals = $self->mSa($idx);
	my $len = @vals;
 $ent->dFa(@vals[1..$len-1]);
	return $ent;
}

sub aNa{
	my ($self, $nA) = @_;
	my ($k, $v);
	for $k (sort keys %{$self->{entry_hash}}) {
		$v = $self->{entry_hash}->{$k};
		print $nA join("\t", $k, @$v), "\n";
	}
} 

sub store{
	my ($self, $file) = @_;
	$file = $self->{file} if not $file;
	local *F;
	open F, ">$file" or return;
	$self->aNa(\*F);
	close F;

} 
sub kLa{
	my ($self, $nA) = @_;
	while(<$nA>) {
		chomp;
		$self->jUa($_);
	}
} 

sub load{
	my ($self, $file) = @_;
	$file = $self->{file} if not $file;
 local *F;
	open F, "<$file" or return;
	$self->kLa(\*F);
	close F;
} 

1;
package eCa;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $verbose_flag  );
@ISA = qw(AutoLoader);

$VERSION = '0.06';
#use DB_File;    
use Fcntl;   
#require 5.005;

$verbose_flag = 0;

my $debug_flag = 1;

my $errstr = undef;
my $syntax_error = undef;

BEGIN{
	$eCa::sep="\xff\xff\xff\xff";
	$eCa::ws2_enc=
qq(ec2d3c7cc7fb9c2d4dc7bcbf3c7cc7db8f0d0dc73cbb3d0dc79b4a7d7fc78cbc3c1fc79caf2bafc75d2e8b6fc77b2a5d9bc7ebdcac7cc7ecaccc2ec79bafcb2dc76d0d9bafc75d2e1d9fc78bfe3ccfc77d4dcbabc72bbb4ccdc75d2e0d9ac7bc9f2d4dc72d2f4bbcc77d7f3d3cc78c7e9bbfc77c9efb6fc71b8d0dbec77bdb7b8ac72d2fecaac76d7f2daac72daa7c3fc79c7ebb1ec7ecaa1cbcc76c0f0c4bc7ebdacb3cc72bbbac7cc72dbb6b8ac7cc5fcbefc75bbaac7cc71d0debfbc79b8dfc5bc78b9febddc70d8e2daac72bfb7b6dc72dbb0d9ac7dccaac1bc7bccbfcbec72d1debdac79bdf3bccc77b2a9cafc78cab6dadc7fc6d4dadc7dc8a9bdfc77bdb3c6ec7bccf5b4cc74dbc6bfac7cc1e8bfdc70d1aab2ac77d9e6dfac73d0bfccec71cce5bcbc72bbbdccac75bad2dbbc76d8d2daac7ac1bcb4ec72baf9cafc7ac1bab2fc74d6fcb3dc75def8beac72d4dcb0bc70dde6b0ec7bcbf5b4cc70cdf8c7ec7cbcbac5fc76b8f7c2dc79cafbbeec7ac9b3d3cc7ebfd3d0dc70cafac7bc7dcca6debc76c4ebcbfc72b9c3d3cc71bdeacebc71b8cdbfcc7fbaaaccbc7bbee6bfac7ec2c6b8cc72dbb7c0dc76daa5b0cc71b4ebbfac74baf1bdec79b6e6b8ac75b8d7c8fc7ebda9bdfc7ac5bcbacc70cdc6bfac7ac0cdb7ec75b8d7bdbc76dbb3d0dc7dcae8cbac7ecfe6dacc78cfcecaac75b3c5bdbc73b6f0c4bc73c0c9bafc77d7fecaac79b4a2d5bc77d2a2d2ec71d7afc0bc7eb6f6b8ac7bccf3c7cc70dec3b9cc7bb9f4b1ac7bc9d6b8cc75c9a3c1fc73d6a8b3cc79b4a8cbcc76c3f2d5bc72b2a7c2dc73b9cecaac76b3dec9ec73b6ffc6dc78cbc3c7cc7cc1e3b6fc75b5aecbbc7db0d7d6fc77b4b6b4dc75d2e0cfec72d4d9cfcc79bcd0cdec7db2eeb6fc72bbbfb9cc7db1e9bbfc7fc6dfc3fc7db8a9c8ec7db8a1c2ac7fb9c4ccdc76c4e6d0dc72beccb3dc7fb6c1d7ac7bb9bac7cc74ccd9bbbc77b8a2c9cc75b1bac1bc77bdbfc2fc7ac1b6cadc77b6d7d3dc7fb8d6d6cc75def2bfdc7bb9f1bebc7db7dcb6bc72baf6c7bc71bdefc6dc78b9c2bfbc71b1beb9ac73d0d9b8dc78cecabecc7cb6cbbeac74bfe5bdbc76d7ffcfac76d7f2d5ec75ddf8c7bc76d6c6b8cc72bbb6bfcc7ebda1d9ec7bc5b3c7fc76dac1cfbc76d1bdb3dc71c6a1cfbc78c5d1bebc70decacdbc77d4d8cbbc7cb6cbc3ec75c9a2d5bc7fb5d6c8fc77d9e3b9cc7bc4e8cbbc7bc9fecdbc7bb2f5dfdc76d4a3c7fc7ac5bfc6dc7bb1e2d9ec7dcae3b9cc78cecec1fc79caf3b4ac7fb9cac7cc77b6dec6fc7cb3d7cfbc7bc9f3d0dc7cbcc0d8fc71b3a6d4ac7db1eabfcc73d0d0d9ac70cde2cbdc7dbcc3ddfc78c1a5b3cc74c3e3c7cc7ac5b0d0dc70d4d6dacc72b4c1cfcc77b6d1b0fc7accd5bdbc78b4c1b4ec72ddf6c0fc73c1f6d7fc74dda4d2fc79bdf8c5ac77d3f3d2dc77b4b3d6ac7dc3b2dbbc70bcf0c8ac7dc1c5b8dc72bbbdb6fc73c1f7d5ec7db1fcccec74b6a0cdec74dce3b9cc78cba2bfbc7fc0edccac7db0fac4fc7ebba9c1fc77b2edb8ac72b9c8c1ac71b3a3b6dc77b2afc6dc77b6bec7ac78cdd2d7dc74cfb7c0bc71d7a9cafc72bfb3c5cc79b3e4b3fc72bbb9bdfc7cc8d5b3ec76bbaec7fc70bce7b8ac79c8e1b8bc7ecbb6d3cc7ec2d5b4cc74b3fcb2dc76d6c4dcec79bafcbacc7ac4a0cbfc7db1e9b9bc74b3f1cfbc74b3f0d1ac76dbbac7cc7fc5bdc3bc7bb1f5b3cc7eb0e0cbec72d2e2d5ec71bde3c6ec7fb4b5bdbc74cfb5b4cc76c6cbb5bc7dc3b6decc78cfcac6bc73cca6bcdc70c7a4c1dc72d2f6b8fc75dbf8b6fc73d6a3d3cc7ac7dfc8cc76d1bfcfdc79cfcab3ac7cb5f9c9dc71caafc5bc74cad8cddc7acea7b6dc73b4e7b6dc73bcc6b8cc75d2e6d6dc76b0e9c9dc7ebfdcc5ec73c6ebbdfc77d4d3d9cc7ac5bcb9fc74ccd1c6ac79c5f6d1cc71dfc6d8dc70cbf2d6ec75d6cec5dc75b0d8cbcc7db5b5bdcc77d4bcccac7ecfa4d1bc74b4b4dcec77dee4b3fc72dbb6c0fc74dda2d2fc78c7b6b8ac72bbbbb1ec70b4b5d5dc70d7a9bbfc72bbb2daac7db2e7b5cc79ccc6c7bc77dcb1b8bc7ec0b4b3fc79bbabcebc72dbbfc2cc78ccd2dabc76dbb2daac72b2a2bbbc74dda1cfcc7cbce2b9ec77b4b3d3bc7cc4f5ddbc7ac5b1d9ec7dcca1d9fc7ac2c2d5bc74bbeac9ac7ac4d1d9ec79b2bdccac7bbdfcbbac71d8bbc9dc73d2a9bafc75ddb5d9fc76bfa7d7fc7ab3c5b4cc7bbaf9b8dc71b4e3b9cc74dda0c4bc76c0f2d5ec75b7e1c7fc7eb9d0d0dc7dc2e9bafc7cb3d9b4ac7fc8c9cafc74bdeec3fc77c0e4caec78b9f1bebc72d4d0c4bc75b1b8cbbc70c9a4b3fc76d0fdb5ac7abdc6cdbc75b8decbbc76c8fcc5ec7cbfa6d0dc7db1f4caec79b6e2c9cc73bca9bdfc74c7c0d9ac70bfe6dafc76d4b0d0dc76b0c1c2ac79c8ecb6cc75ddf4dadc74c3b0d9ac72d4d7c0bc7bb5afc0ec79cfcac6fc74daabc8dc7bbaf9b9bc76d7a3b6dc77b8b7dfec7cbbd6d5bc7cb1e3b6dc71c7bfc0bc73d0dac1bc76d0d0d4cc7fc2c3c6ec76d8d1cfbc75def8c8ac7db8f8cbec7ebda3b3ac70d0decaac7fc2c0c4bc78bfd6b8cc74cad2bfbc7cc6d2cbdc77bdbacdbc72d4decaac74cae0c4bc74b3d6b8fc7ab1c3c7dc7dcca2dbbc7cb3d2d4dc7cb2f5b5ac79cfc3c6ec7bbaf0d5bc74dda7d3dc7ec4cbbfac7fc0e5b1bc71b8d2daac71d9b1c6ac73b9c1c2ac72c7bfcfdc75b7e2c7bc72baf1cfbc73d0d0cbfc72d4dfc2cc7dc5cdb1ec7ac2cecfec7ac7c7b1fc78b4b4d3dc75cca1c6ac78c8a0cbfc76d0d1dbec71d5b1c7bc77d0b6d3cc7dc9fdc9fc73bdf1cbcc77b7c3b3ac75c9a4b5ec70c5e3c7dc77b4b6bfac7acac5b1bc75b7e7d3dc76cdbeb9fc78b7f8b6fc74c7c1d9fc7dc8a3b3ac70d1aac1bc72d2fbc8dc7bc9f3b4ac7fc0e5b8cc71d1a4d1fc71beb9cdec76d7f5d5cc76cdb3c6ec77dcdac7cc72d5dac5fc79cdecc5ec7ac2cac5bc72b3a1c7ac71b3abb4ac7fbcb2c7cc78c7eabecc77b0c6d9bc71bae7dcbc72d2ecbbfc7ebcf6b3dc71d5fbbfac73b4a6cadc77c6d2c4dc7ac1b4bafc76c7b6d6dc75b7f5dbfc79b4a3b7ac73cfb8b6fc74b9ddb8fc7fc3adcbfc7fc3adcbfc74bbcdc2ec70d0d6bfac79b3e7babc7cb3d8cbec76d6c6b8ac77b2a1bdec72dbb6d1bc77b8a9bafc78c7efc2cc78cbc0c0ec7ac4f3dadc7ec8c6b8ac71c0d4cefc76d0dcb4ec7acdf1cfbc76d6d7d3dc76daaac6bc7fbaa5d9bc7ab2a7d3dc7dc1c8c0cc79bba9c7ec78c5a4caec72d8f0d0dc7bb6d8b4bc77dac1bebc76d1beb6bc7cc1e9b9ac75d6e5ddfc7ebcfac2cc76d0b9b4ac72b9d7d7fc70d4d4ccdc75b0c2c7bc72dbb3c6ec76cdbab2ec76d2becfec77d7f6c7bc77cfb6b8cc7db9e9ccdc77deedbcfc7fbdc9bbdc77b9cbbafc75b4cbb0bc78bab4d0fc79bbd5b3ec71cbcdb2ec75ddf3b3ac7ac0ccbdcc78c4d8cbbc78bcfcb3dc7cc8dac2ec77dee8bfdc71caaabfcc77b2abb3dc78c7e4bbcc74dbc3d3cc70beffc7fc7ebda3daac74dbcac4ec7bb7beb3bc7bbaf6c7fc7ac2c7c9ec7fc0ebb5ac79b9b3b9cc77dcddc3bc78b4c4dcec74c7c8b6fc7cb3d8c8cc75c4eabfcc72dbb6d2cc79bbd2bcec7cbfadc5cc77befec1fc71b8a8b6ec78cba3c6ec74d6f3b4ac75ddb6b7bc71b8c0cdfc70d5cab5cc75b8d6d7fc79bcc6b8ac7fc8cdb8fc7fc2c8c5ac71c2a3b1ac72d4ddc2ec74c7c0cfec78b0d5bdbc76cbf3b5bc78cbcecfec7bbfa1d7ac71c8bac3bc77b6d2bcbc79cee8cbec7acfa3ddcc72bfb6b3dc72d6c6bfac7cb1eeb6fc71cdedc2ec73b7cac0dc7cc8d0d4dc73b4a6b8cc78cfc5d6ec7fc0e7b4bc72bbb5b3cc70b2b8cbac74c3e5b4cc76c4ebccfc7fced6d6cc71ccbab3cc74b3fbb1ec7db8f9b5ac7eccfac5dc79b4a3bccc74b9b6d1bc76cdb0d0dc7ccca6b8cc77dcd0cdec79baf4cadc7fcbf3c0fc76d6d0c0ec79c9f2d4fc7fcfd6becc77deeab3cc73b0d8cfcc7db3d4b5ac73d0d0d7ac74b3f4b3fc7abfc0cdec7abfc7d7fc7ac6c1c6ac72caf7d3ec7fb4bcbbfc7cbfacc5ec7eb5f5b3cc76c5d1b9ec71d7a0d3ac77b6d5c4ec74bafcc6ec70cbefbaac72dbbcccec73b9c7b6dc74b3f2bfbc75b8d3c6ec7ac0d3b1ac71c2acb4bc79bbadbfec7bcdf5b4cc7bb8d0c4bc77b1e8bbbc75caf5c0dc79ccc2d5bc70d1abc5bc76d8d4b3fc77b2a6bfac78ccb9c5dc74dda0cdec77bdb3bccc77c0b3c6ec71cca0d8fc76b4dfc3fc70bbeeb6bc7eb5cec5ec72b6c5defc79b4aebfdc72bbb5bbac76b8a0cdec7cbbd8b1fc71b8d8cbbc75dcd1d7ac72dabcc5ec72bbb7d3ec7bc0fac7ac75b7fdbadc74dbd3c7cc77c0bdb8fc77dac1cfcc72dbb7c7ac77d6e9bafc77d7fecfec76cadcb4ec73b9c1bebc7dc3a6d9bc78b5c4ceec7fb4b3b6fc73d0dbc9fc77b2a3ddfc73c7ffc4dc71dbdeb6ac72d4d1b3ec79bbaacdbc76c5ddc8ac7fc2cdb5bc7cb0bac1bc78ccddb2ec78cbb6b8fc7ac6d6becc74d8febdac77c5e3befc72dbb1bfdc75ddbacfbc77c9e0decc77daa6bfac79cda1c6dc7acac3d3cc77b7c6dedc7ec4c5d2cc75b2c9bafc7eb9f4d8cc71d5d9cbac71b8c8ccfc7ecaa6d7fc79b4a2d5dc73b3a3b3ac7ccaf2c7bc79b9a3d6ac7fccd7b8ac7fc0e6b4dc7fc2c1c0dc73c7f8c7bc7db3daccdc77bdb5dbec73b9b5b7dc7ec4e7d0bc78b6ebcfdc74d6f4b3fc78b4c9c6cc78b7f6d6dc7db8f2bdbc79bea9bccc72d0cfbfbc73d3e0c0ec77dcddb1ec77cfb5b7fc75d9f8c1ac78b7fcb6bc75b7f2b9ec74bbadc3bc70b8bcbefc7fc4d6d8fc7ebed4b3fc7ac9ecb7cc7ac5d8cbec71bcd3c2ec70dec7d4bc76d0f2bdbc73b9ccb8ac70decac6cc77b2a3b6fc71dfc8b1fc70b2b5c5cc77b6ddb2ec70c4e8c4bc7eccabb4ac7cc8d5d7fc77dacdb0fc76d8f7d7fc7db1eac8fc71bde3c7fc7ec4c2d5dc70dbf2bcbc75c8a6b8cc7abfaacdfc71b8a5b0cc73b9c9b6ac7eced2cbdc76c5b2cacc7cb4bac9bc75c7b6dedc73ccd7c0dc77b3cecacc7fc6d4bafc75b3becfac79b1e3b9bc7fc6dac5bc78cbccb2dc7db2eacdcc74b3f6b3dc7cb8bab5fc77d4d6bfac73bdd2c6dc72bbb2dbbc72b6c2bafc74ccd1cfbc7fcbfab4cc7fc0ebc6cc77d6f5bdbc70cbe7d3dc7fbbc7befc7ec4c1d7ac71b0f8cbcc73bfafcacc7cc5ebbdfc7fb4b0c4bc7fc0e3d6ac7bbceabfcc70cbf8c3fc7aceadc2fc70dbf4bbac7fb9ccbbfc79b1bfc7dc77d7f5dfdc70d4c0cfec78bdbdbcfc7bc7c1cfcc79c9dacdfc76d8d0d2cc78c1b5b3ec7ac4e3b6fc76dcdec7ac7fc4d8cbbc73b6ffbadc72bbb9bbbc73bcc0d2fc70bbcaceac73b6f7b2ac78b4c8bfec72bbb1b4ec71b0f5b4cc7bc9f5b3cc72bfb3b4ac7dc6b7dacc7acac3d6ac7bb6b3ddac7bb6b3ddac73bfd4b7ec77bbfabfcc74cae4bafc78b4cdb8fc78b7f5b8dc77d8a3c5cc7fcee4cfbc71c2fbc1ec77caffcfdc7fcbffc2ac78beb5ceac70cdedb2ec70d7a2cacc75dcb3d0dc72d2e6debc74b3f1d7ac75d2f1d9bc7db3ddbcfc7ecca3b6dc75d9dfbaac7bb5f1b2dc71d9b6c8cc70ddf7daac70b2b7d0bc76d8dac3dc79b3f7d5ec76dfaecfec76c3fdccbc7dbbbbbbbc73cfb4caec79cfc9cdfc79bdf0c4bc77bdb1b3ec75b0c5b2cc79b5c4bafc76bfaecfec73d1dab3cc78c1b7b6ac76d8b5bcbc71cce0d4ec70cdefcbec72b5a6d6dc72b2e1cfbc79cfcfc2cc77cfb1c2dc7ab3cfc3fc7dcbb8cbbc7db8a2d9ec7bbac5bbdc7bcba7bdbc78cbcfbadc79b9b4dcec73b6f8c5ac7ecfe0cdec73d8c6c4ec71beb6dacc77b1f4d2fc72bbbeb3cc78cbacc5ec7dbccac6ac73b5bcb4ec76b4d3d6ac7db2bbb0bc79cde9cfcc75b7e7d8ec74d0f8cecc72bbb8b2dc72b2e6b8ac76d8bacebc77d4bfb6fc73d0dbbafc7cb7c5dfdc7ac7c5b4cc7eb6f0d4cc77b6d0cbec7ec3afc5dc71b1b7bdbc78b6f1b0fc7dc6c6bfac7eb8f6b4dc7db1e2cbdc74c7cac1bc72bbb2cbdc70cfe3c6ec79caf3ccfc7ec4e6c7fc74b3f5cafc78b0deb5fc73d2a0dbdc74b2fbb7fc75b3c3b6fc76d8bbb3dc7eced7b8ac7cb3dbc9dc73c6e7c0bc70d0d5defc72bbb9bcdc7fb4bfb4bc79cfc8c5ac72d2ebccbc77dbdabfcc77daa1b4ec74dac0ddec71c3ecbefc73d1a6b8cc74b3dac2cc79b6a2cacc74d6f2bafc70deccccac70d1a2c3fc75b1b7c0bc7fc5bacdfc7bb8d4b0fc73c3b2d7dc78ccb1cfcc78c8c1c2dc7abfcdb0fc71c7f6bfac75c3f3d1dc76dea7c0bc73d0d1c6ac73d6f5bdbc76bde9bafc7cb7c4d8dc7dcca2d2ec74b3f4dcbc76c4eac5bc7ac7a8c5ac7ac9a9b4ac79baf8cbcc76d1b5bdbc76c7b6dacc7dbcc1d7ac7dbba0c4bc7fc0b9bfdc79b4a7dacc73cfbcccec79c3f5c0dc75d4f6cbfc77d7f2d5bc71b8c6d8dc78bfd0dbcc79c9f3c7fc76d8b1baec75b1b5b8dc7cb2ddc5ac76bfa1c6ac76cdb5b8cc76d6c6c7bc73ccd6b8cc7bc6cab5fc72dbbac1bc7cb0e6bdbc7ec7f7bdbc7dcbb3b6fc7ab1c2bbbc7fc0e0d5cc7cc8adc5ec70decfc3fc75d1f6bfac70b9ddc2fc78bfdec2cc79ccc8cbcc74cfc7bdbc73d0d5b3ec7bccd1cfcc7bbdf0cbdc73b9c9bbfc71ddabb7bc74d8b2d2ec75d6eac7cc76b0eacdfc70d4c0cdec74d2e5bdbc74cfb1baec7ab4feccfc79cfc0c4bc77daabbfac74bbcac1bc76b0e4becc75cba1c5ac7bc4c4b8ac72dbb6ccac7fcbceccac74bcccb4ac7dbbbdc8ac7cbcc3b0dc79bba0cfec7db7c6b8cc79bbd4ceec74ceb2b4cc75d9bfbaac72c2a6bfcc73cedbb8ac77d8e1c6ac73ccf1ceec75bdb5b7dc7cb8c8cbbc78c4f8b9cc79cafecfec70dccac2cc76d8c0d2fc76deadc2ec7bc0cdc6fc77dcb8c7bc78cec2d2ec74b4b7d7fc73b9cebdcc70c0e0ddcc72d2eac6bc71beb0c4bc7fc8decfac78b7ffceec7cbba4b3fc7dcde9cfcc71ccedc1cc7cbce1d9ec72bbb1cbcc71ccadb3dc7ac2ccbefc79cdb6bbac7ec0c9cafc7dbad4dcbc71b4e0decc78c8a1c6ac7ac7c7b7cc7bc5bbb0bc73dfe1d4dc76d7f6bfac79b6e4c3ac78c8c1cfbc76d7f8cecc78c8c7c9ec75dcb1ccec7dc3bcb6cc7dcae5dbfc71d3d3b4ac7cccefc2cc7cccedb2fc7db4f5d5cc79ceefbccc7acdf7d6dc75ddbac5fc73d9c4bbcc72bbb3d3cc70ded0cdec78b0d7c9ec72dbb4b8fc74d6f7cfbc7ac5b6dacc7bbafbb1ec76d8d5b3ec72bbb4dadc78b9c9c6ec71d7abc5bc73d5c5b3ec72bbb1b8dc75bfabb9cc7cb7c2ccbc74cfceb9ac70cdf7d3dc75d6e0cdec77c3f6d4ac7acac2dbcc76b9fdcfac7ab3d4cfcc70d6d5bcdc74b8f0c4bc7dcef0d2bc7ecaa6d9bc76dcd6cadc79bafdc2ec78c5d2d6ec72daaac7cc77d4deb5fc7eb1a9bcdc7ecaa8cbcc77b2a4bfec7fcbf3bdfc77b4b8b4bc7dc6c9b3ec77b2a3c7fc7bbee8cbfc76d8f3cbfc76bba1b1bc72bee1b0fc7acacabfcc72d0cebddc70bdc0c8ec71d1aeb9dc79b3c4cfec75b8d7c2fc73d5c1ccbc7fb5dcb4ec71d5f6c8fc76b4d7bdbc79baf3c1fc71c9dac1bc73d3cdcebc79bacac2cc7abfc3b9cc73b5edcbbc79b2efcfdc71c2afbccc72d5eec1fc76b1c5dfdc71cce3d2fc75bdb4bfec71cdb1bfdc76c4e4becc73b9caccec77b4bfb9bc74c8b7c7dc74b3f1c6ac79b3e6bbac72cde9cfcc7ab5c5d9dc79bcecb3ac7eb1a1cfbc75ddfacdbc7bceb7b8ac7bcfdbcfcc7ac5b4dadc79bba9b2bc70bcfabcac74c5abc0fc72b9b3b4ec76b4ddc2ec76b8a2d5ec77b1b6d3bc7bc6eac1bc7fc0edbbbc7bceafb2ec72d5bec1fc74b5c3b1ac7eb6f2d9ec75c5c1c0dc77bdb0b8bc75b3a8cecc7ebfbeb9bc7fc2bbb6bc7ecfe7dacc77d8a2d5bc77bbdbc9ec7cc8b5bdbc77d1fac8dc71b4eecaac75c0d6bfcc7cc5e3ddfc79b6ebbeac76d6d6d6dc71b3aec0cc77c9e0d7fc77c8f3d2fc77b5c3b6fc7ab6f8cbbc7fc4dacebc76c8fab2fc7cc5efc5bc74b2ffbaac7bc9f4dadc75d2e6b9fc79bba3c1fc74c6a2b1cc79cdf8bfdc76d1c9c9dc79b8dcbcfc7abef1b1bc71b8a6ddbc79b9a8b8fc79b0ccb6cc72d6b6ccac72d4d3c2ec76d6c6bfac79bba3bfdc79bbafbaac72bcb6d3cc76b4d1c2ac76b4d4bdfc7dbbf6d9bc7eb6d3c6ec7ac7f6dcac75b8d6dacc77cfb4b3fc77b0cac8dc7fc2f9cfcc72d5f4c1bc7ab1f6b8cc77dcd2bfbc78b4c1ccbc74c4c0cfec78ceb1cfcc77b7d7b7dc7acfd2bbcc77b5c4b3fc7fbfc6b8ac77b2a1dfec79cee6b8cc72c6f3b5ec79b3e6dddc7db1eeb7ac79cba2bacc75b0c0cdec76b9f7d3dc77daa2d6cc7fcbfbbfac77d3e9bbbc71beb9bafc7db1afb5bc7dbcc5bcbc77d7f7b7ec79b5abb7fc76bef7c7ac72c8e2c8ec73d1f3c7dc74dddac1bc7dbbb1c7fc76d6d6d2bc7ec8a2dbbc70cde3d9cc7accb6d5dc7dcca1d7ac70dda6b8ac77b0c6decc75b6dfb9bc74d3d6dacc72d9ebb1ec72bbb8c7ec7fb3facfac7ecef9ccfc70c0ebc6cc7fcfd8c6ac72bbb2dbcc71bbc4bbcc72bafecfec7bc5f0d1ac79c9d4caec71d7a5dfdc72d2b0ddec72bfbecbbc77b6d1c1dc7fcafacbdc73d6a3d0dc75b4e0ddcc79bdf6b9cc76d0dbbaac7abef4cfcc76d7f9bbdc75b7e3b1ac76d1e3b0dc75b8dfc2cc7acdf6d5bc74dbc0d0dc79b6e7b6bc7db8f0c4bc7abceebcfc7fb9c2bbbc71caa3cbcc79c9d1cfbc7fcbf7b1dc73b6ffcfac79b8d0d4cc72bbb0d0dc77b6d0c0ec70bea9bafc75bdb4b6ac7dccbfc3fc72dbb5d3fc74bba2b5ac77c3efc2fc75b3b4cadc75cea7d3dc76cdb7bdbc73b4adbdac7acdf1d7ac70d2d8b3ac74b3d7c0bc77b1f6b8ac71b3a5dfcc79bba6d4ac76b8f3d6dc7dc1d0cbec7fcbe6c0fc75dbfacdfc73d6a1c6ac73b5f6cadc7fb6c1d0dc78b6dccafc78bfdcb6bc79b6e4d2fc7db2d2c6bc79bcccc5ec7ac9b5b3cc7ec3aab6ac74b3f6b9bc7cbba6c4ec75def5b3bc74bba6bfac7ec4c7d6dc74d2b0d4cc72bbb5c2cc75b1beb6dc77b2bac7cc72bbbabfcc71cdb6bbcc77bbfab5cc70c4b7d4dc77c7d7d4dc76d7a5c4ec7dc6c7bdac7dc2edbbbc7cc5efc6dc72bbb8cddc7ccce8cbbc72dbb8c5dc72cdf2cdfc71b3afc5dc7bbea7b6dc7db8ffbadc7eb5fec2fc70d1a7d9ec75b7eab9cc75b7ebb0bc7ecaaac7dc75b3b8cbcc77bfbecddc74b9dac9bc7fbaa9b8dc7ac4ebcdcc72bbb2cafc76b1e8c1ac76c6b5c9ac70d2cec5cc75ddb2c4dc76deafc2cc71b3a4b6ec7bb8d8c5ac77dcd6deac78b3eab3cc7fb3fecfec7bc3b0d2fc7db6fdb6fc74b3f3bcbc75d6eac5bc7fcaefc8bc76d8d8b4bc7abce9cbac7acdf4cfbc74b3f0ddcc72cac1ccec7ecaa4bbcc72d1c0cacc7abfcdccac7ac7f4cebc78c7bac5bc72bbbcbbfc75caf7dcbc77b2adbdcc7eb3d3c1fc75ddbfcfdc76d5b5b3cc7eb6d2bfbc7cc8bbb0bc74d6c4cfcc7dc5ccc5ec72b9d7dddc77b6d9c2ac72dbb5b0cc72bee2dcec77b2f8cbcc78bfdbc9dc76c8f8b7dc71d7c6dedc7fbde6b8cc7bcdf3c7cc77daddbccc7dbdabc5dc79c8e1c2ac79c0dec4bc74dbc7daac71b4e6bfac7cb4a1c2dc77d8a5defc70b7d9cbac7ac2d4cadc7dc6c0d0dc71d9bbc5fc73b4e2cafc73b5f2bdbc7cbdc2c9cc7dbcf4bafc78cbc9b4ac7fcbfac7ac77b9c0d0dc79b9d1c5cc70c4b5bdbc77dee3b5fc7ebda0cdec72dbbac7cc73ccfcc2ec77c9e8b0dc7ac5dbb1fc74b3d0c4bc75bfa0d4dc79b6e8b1fc71d9f7d3dc75d3edbdac73cfb4becc7fc0e1b8cc71c9ebbeec75d5d9c4ec7fb9c6daac7bc3b0cbfc72bbb6cdbc7bc5f6bccc7ab1c9cdfc7fb4b7b8ac70b3acb0bc77b4b6b8fc7cb1a8c2ec72b0e6d8dc7fb5c1c3ac72d2c7befc74b3f8cbcc78b8b7c7dc7cbce2bcec77d7fcb2dc72bbb3b9cc73c7fcccec7cb9d6b8ac79cfc2bfbc7ccdfbc5bc7dc2e3c6ec76b8a2c9cc7dccb0decc76d4aebddc77c0bcc1ec74b3d4bbcc77b4b9c4ec7fb9cfbfbc79c8e6d3cc71d9b7cfbc76b5a5b3ec76bcacbebc7db8a3b9cc72bbb1ccbc7cbebdbadc7cb7c2d4ec7bb6c9cbac7bb5fecfec72bbb6b4dc7fb5bec5fc7cc9a9bafc77d0dfc8bc7ac3b6c7bc7ac3b1decc71d7abb1ec77b7e8b1fc74cfc2bfbc75b5a6b0cc78bfaac4bc7fbaabb8ac75b8c8cbcc7ec2a9cafc71b3a1c4fc7dc6b8cbec74ddaaccbc74dce1c6dc7cb5f7c1ec75dacbb7ac70dcc7b8ac71ddd3b6fc75dbfcc5ec77d7f5ddbc7cb3dfbcec7fbcebc9dc75d4f7b2ac79b9d0c4fc76bdc1c6bc72c4eac5bc7bcea5bebc76d8d0d4cc73cbf3b6cc76cdb7b6dc74dadfc2cc76b3d3b4ac79bba2c7bc7bb9b4ddac7db4f3ccdc7fc6d3d0dc71b8d0d8ec73d5b3d0dc76d7f8c8ac7acdfebddc77b8a6d6cc70cfc8cbcc71bde4bfec74c1d5b0cc72d7c6c7fc75dbf0cdec76b8f2d1dc7dc2e3c3bc7cb2e8c1fc77c7adc2fc70d0fac6fc73c1f1b8fc7ac5d9babc76dbbab3cc7ebab8ccfc7ac2c9bacc7ac7f6d6dc74d2eaccdc7ab3d1b1bc7dc4e7cafc76bea5b3cc78b9d1ccec78c1a3b6fc78c1afcbfc7ec7f5b2cc71c3a7d3dc77d5e8cbcc77c0b5dfdc70c9a9c2ac7fc4d5b3cc77d2fcccec7fbadab5cc78c5d7d3dc78ccdcb1cc7fc8bebafc75b1b4caec7ecedfcedc72bdb6d8ec70dddfc2ac71b4ebbbbc78c7edb1fc71b8c8c7ec75c0deb6fc7db8d3c6ec7ec7f2b8dc73d0d2d2ec75d1f5b4bc78b3adb8ac78bfd5bdcc7ebfd1b8bc77c9a6b9ac74dda3d0dc72b6c8bbbc79b4abb1ec7abfc7b8ac7db3dac5dc7ebba8c7bc75cea6b9fc74daacbefc7db8f8c5ac74cae7c1ec76d6c7d7fc74b3f8b5cc74cae1c4ec74d7e2d1dc75b7e1c6ac79b2e8c9dc73c8e0d4bc76c7f9b9dc78bab5b3ac70cfcac6ac77d8a6d6cc73d5bbb4ac73d3c1c6ac75ddf2d5ec78b9c8c5cc70baddc1dc7bb9f2b3ec74c4c0d9ac79bafbb1ec78cdd6c7fc74bca2b0bc7ccdfcbbfc74c7c6d6dc70dda2d9ec72dbb6bbcc71bae6debc7db1f8c5dc7fbcb2bcec73c0c1d7ac73d2b6b8cc75ddbac4ac77d8f1baec7ac2cec1fc70dbc8c4ac7ec7f1b1bc77bac1cfcc7dbcc1d5bc78cbc8cbcc70d1a0ddcc73d0d3d3cc79b2b3d0dc7ac7d6bcbc7bc1e0d4dc73dbe6c4ec7cb8f6b8ac79c4efcfdc76d6c6b9ac7dbbaebcfc70c9a5d5cc74caddc2ec7bc0fab6ac72b0dfb1ec75d6efb5dc79b0e8b8cc7ac5dbc5fc77daabc9dc70bbe4caec72bbb7dcbc74b3f6d2cc7cc8b5c0dc7dc8a6daac73d5c0d3ec75b7e8cddc78b6fcc5ec71c2a7b8ac74dea6dafc7ab3c4b6ac73d1d2daec7dc2f2dbbc7dc5f3bfac75ddf8c7ec72becfbcbc7abce6ccec78c5d3b3ac7ec5a7b4bc71b5aabdcc78b5d2b5cc7bc5b5b0cc72bbb5b8cc7abbcbc3ec7ac6d6d8bc7dcebeb6bc7ec4ccbefc70dda5b7fc71d8f6d3bc74b8f6bfac7fbaabb1ec79c2cec7fc7ec3abbafc71decbc1ec7ebfa2bcec7bc5b7b8ac77c2e6c8fc78cdd1cfbc74d9d9cafc76ddfccafc73b1c5bdec77bcd6b7bc77b1f8cfcc7bbab2cdfc7ac5bac9ac75d6e5b4cc77b6d9b4ac7bb0f1d6ec7dbdaec7fc75cea8cbcc7dbadac1ac78cbcacfbc7ac9a7bacc76d0d1d7ac78b8e3baac7fb3f9cdbc79cdbec7fc7fcfd2c7bc73b5b1cebc77c4b4d0fc76d7f8cbcc7eb7acc5ec7fcce3d6ac7dbccacadc73c8d3ccdc71b6bacdfc75b5a4bfbc78b8b4c8bc7bbaf3b5bc7bccbeccac7dcca7c9ec72dbb6befc74d2b6dcdc79b4acbefc72ccc9cbac7ec7f5c7bc73b3acbbfc76d9d2b3cc74b3f5b8dc7fb6ccbcbc7ec4c3c7fc71d7aac5fc73d6d2daac77dfdfc2fc77b4b6deac7cb2f6d1bc71cdb5dfdc79caf0cdec7bcdb8cbcc72d4d6d2cc75dbe6b4dc74bef2b6bc76d7a2bfbc77d4d9cdec75bcb6d2cc76bcb6bdbc77b6dacdfc76d1bdb7cc77d8acb2dc72bbbacacc7cbdc4ceec79cdb7c8fc79b5c0bdcc74c1d2d4dc73d8e2d4dc7ebab5d9fc78c1b9c9dc75dce2b9ec74b2fbc3ec71cee8cbcc77d0f6d8dc72bbb6d2cc7cbba6bbcc79c1febdac74bab7cfec79baf7b0cc7dbad7d0ec7dc8a7b7ec70ded8b4cc73b9c3b4ac74b3f2cdbc74caecb4ec75c2f5ddcc79b4a0d2fc78b7f7d4dc7cbfaabfcc7fc2ffc2cc73ddc2bbcc7eb0c5ddfc7fb6c3b4ac7dcae9c6cc71b7e6d4ac72bec9bbdc74becacdfc75c5c3bdfc74b3fac9bc79bbfac5bc7fbaa7b2ac73c6e3c2bc7cc1e3bbac75b8ccb6bc77b2a9c4ec7bb6cab3dc71b0e6d6cc7dc2edb7ec77d8e0bdac75b1b6d0dc77bef4b3dc78b5c0c8ac79bac2d2ec7eb6cebbac7acfb1b8fc79b4c0c8fc73d0dab6ac73b5ebb7fc79c7e2cbdc7cb9d8c7ec73b9c6c7bc75b8d5b3ec79bdf2cbcc7db1eac5bc72bbb0ddec7cb4efc6bc7ebcdeb8fc72c3d6b1ec7ec7f4cfcc75d5d6ccac75b7f6bfac79c3f2b9ec73d5cac6cc77dbcac6cc77d4d4b3dc77b6d8beec71c6d4cebc7cc8d8c8ac74b0f3d6ac7ac3afc2cc74d6f6b0ec75dfc0bdac79b2babdcc7bb1ecc8bc7bb9e2d6fc76c0f6bfac74d8bdcbfc78bfd2bafc79bbd6dadc7abad9cbac7bb7bdbadc7fbfbdbcfc74c0d7d3dc76c8f1c7fc79cfcec7ec73d3c2d4dc77d6f7b8ac73b4adcebc72b5c3d0dc7cb4a6bfac7db1ebb9ec7cc1e7c0bc76dec1c6cc7fc2cec7ec74d9d4becc77dfe0d0dc79b7c8b9cc7bb9f5b8dc77c0dfcfdc78c1aeb6fc71d8dab3ac7abfcacacc7acfc7d5ec7ccce6c8fc7dc4bfb0ec75ddfac7cc77dcdacdfc79b4cec8ec7fbaafbadc76d3b3c1fc79bce5b0cc71c6d2d5bc77c0bdcebc7ac7f1c2ac76dcd4caec77c0dac5bc7bb0f3b5bc73c8dac9ec76d0d9b2bc7ebda0cafc74c0d5ceac70dbf1d4dc71d4f9b2ec73d0dfcedc76d1cdb1fc70b2bbb5dc70bbc0b9dc77c6d7b8bc70d4d8b1fc75b7f6d6cc72c7b9cfcc77cfb6d6cc77c1e7c1ec77dee5bdcc78c1bfcddc74bbffbeec75b7eac3dc75c4d1bfdc70ddabb1ec72daa2bbbc79b3eec7fc7cbfabb1ec75d9f6b1ec72b1a8cbcc7cb9d9c8ec71d8f7b6dc72dbb2c7bc73decbb7fc76dcf2b8dc72bfbcbefc77dcdeb6dc7eb2b6d9bc71c7fdc8ac71b1b2bfbc76bbaeb9ac78bfd3b1bc78ceb9cbac7eb3d7d1ac73c5cfbadc79cfc2b3ec7dc2e2bfbc79b2ebb4dc7eb6dac6cc70bcfec7ac7bb8d7daac72ddb9cafc76d0dabdcc72bbb0b2bc76dca7bebc7abab7d5ec78cbdbb8ac7dccfcb7cc70d2cdbeac70d7c6cadc78b6f8b6fc79b4a5c9ac70cbc7b1dc72cdefbbcc78b8e7cafc72caf2d2ec78cbcecaac70d2cfcacc71bca7b2ac79b3e2b5ac71c0d3b5bc7ccbaccbac7ec4eababc7fcdeaccdc77bfb7d3dc7fbaa2b9cc7fc0fdbabc77d9eabfcc77daafc2fc78cbabb1ec7acfa4cbac7ecaaec2dc72dbb2c9cc70bceac2cc7acebdcefc7fc4d3d0bc76d0d2bfbc74d4d5c0ec75c9a3b1ac76c0c2cbdc79c3e3d0bc7ac9d3ccfc7fc0bcc2ec7bb1ecbbfc7dc8a0d5cc72ddb1c6cc75d5d9bbcc75dbf6b9dc7cb2b2b1ac7acba8cbcc71b9a2c6bc78bfd6c5bc73c1f9bafc77c7fac6cc7ecfecbbdc72bac9cbac73b4a6bccc77b5c6cafc73cbf2d5ec72baf2c1dc75bde7bbdc7fbaa6d7ac73c1fcb4ec7fc2c7b2ac7fc0e2beec7cb3ddb4fc74dadcb2dc77b6dfbaac70cfcececc79c6ecb0bc73d7d3c7ec76d0bec1fc7bb8a9cafc76c0ccbbdc7cc5e2b9dc74d9dbc5bc75b7e3d0bc70d4c7c9ec76befcccec7ac5dcbfac70dbc7bcdc72dbb5b9ac74b2f6c6cc73d2c8b2dc74d7e6cadc79caf4b6ec70dda7d7fc76dea9cfcc73b5b2c6dc73b4d7b9bc77c7d7c0dc77c5e3bdfc78cdf9bafc71daa2dabc70b9d4caec72bbbcb0bc7cb8efb0ec71c7f1cfbc79cfccb6bc76d7a3b6fc79baf3daac73cabccfbc75c5cbceac79caf6bfac7bcea0cbfc77d6f3b9cc71beb8cbcc76bba7bdbc7ac9a3d3cc7bcea4c0ec7bc0fbb5bc7fceabb7fc71d2dacfac71b9a1c6ac74cbcac7cc72d6d6d6cc75bbd9bafc7fbec3bccc70b2b6b8ac74b3d6d0dc78bfd1d9bc79bab2c2fc7fb9b2d9ec71c2a7bdbc74cfc1b1bc77c9edbadc7ac1aecfac7fcde3d0dc74b8f1ccec77cfb6c8cc74ded3b9cc75d5c1c6ac77b2a5b7ec7fcbefc3fc78b5cac6fc7ab3aebcfc72cdd0ddfc79c8e7b8ac7ec3f2beec70d4c6d0dc71dbb6ccac73b1c6d8dc77b8a4d2fc78c8c0beac79ccc1cfbc76bef5dfdc79c8efcbec7ebcf7b7ac7ecaa6d8dc70d2cebcfc7cc1e9cdfc74c7c6b9fc70d5c0d4c);
	my @ws = split /\|/, pack("h*", $eCa::ws2_enc);
	$eCa::ws2= '('.join('|', @ws[0..100]).')';

};

sub errstr { $errstr };
#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub new { 
	my $pkg = shift;
	my $arg = shift;
	my $opt = undef;
	if (ref($arg) ne "HASH") { 
		if (-f $arg) {
			$opt->{IndexDB} = $arg;
			$opt->{Verbose} = shift;
		}
		else {	
			die " wrong usage"    
		}
	} else {
		$opt = $arg;
	};

	$verbose_flag = $opt->{Debug} || $opt->{Verbose} ; 
	
	my $kFa = $opt->{IndexDB} || $opt->{IndexPath} ;
	my $filemask 	= $opt->{FileMask} ;
	my $dirs 	= ( ref($opt->{Dirs}) eq "ARRAY" ) ? $opt->{Dirs} : [ ];
	my $kJa = defined $opt->{FollowSymLinks};
	
	my $opturls =  $opt->{Urls} ||  $opt->{URLs};
	my $urls 	= ( ref($opturls) eq "ARRAY" ) ? $opturls : [ ];
	my $level	= int $opt->{Level};
	my $max_entry   = int $opt->{MaxEntry};
	
	my $filesdbpath = $kFa;
	$filesdbpath =~ s/(\.db)*$/\-files.db/;
	my $titlesdbpath = $kFa;
	$titlesdbpath =~ s/(\.db)*$/\-titles.db/;
	
	my $kGa = $opt->{MinWordSize} || 1;
	my $self = {
		kFa 	=> $kFa,
		filesdbpath 	=> $filesdbpath,
		titlesdbpath	=> $titlesdbpath,
		filemask 	=> length($filemask) ? qq/$filemask/ : undef,
		dirs 		=> $dirs,
		kJa  => $kJa,
		kGa	=> $kGa,
		kBa	=> $opt->{IgnoreLimit} || (4/5),
		urls		=> $urls,
		level		=> $level,
 max_entry       => $max_entry,
		multibyte       => $opt->{multibyte},
		wsplit          => $opt->{wsplit},
		url_exclude	=> "(?i).*\.(zip|exe|tgz|arj|bin|hqx|Z|jpg|gif|bmp|js)", 
		url_exclude2	=> $opt->{UrlExcludeMask},
		
	};
	DEBUG("filemask=$filemask, indexfile=$kFa, kBa=$self->{kBa}\n");
	DEBUG("dirs = [", join(",", @$dirs),"], ");
	DEBUG("urls = [", join(",", @$urls),"] \n");
	bless($self, $pkg);
	return $self;
}

sub eKa {  
	my ($keys, $hash) = @_;
	my $key;
	my %fkwt= unpack("n*", $keys);
	foreach $key (keys %fkwt ) { 
		return 0 if  $key == 0 ; 
		$hash->{$key} += $fkwt{$key};
	}
	return 1;
}
	
sub eBa {
	my ($hash,$array, $regexp) = @_;
	my $w;
	for $w(keys %$hash) {
		push @$array,$w if $w =~ $regexp;
	}
}
#notes on eIa();

sub eIa {
	my $self = shift;
	my $expr = shift;
	my $kFa= $self->{kFa};
	my $filesdbpath = $self->{filesdbpath};
	my $titlesdbpath = $self->{titlesdbpath};
	my %indexdb;
	my %filesdb;
	my %titlesdb;
	return undef unless (-f $kFa && -r _);
	return undef unless (-f $filesdbpath && -r _);
	return undef unless (-f $titlesdbpath && -r _);
	return undef unless	
		eJa(\%indexdb,$kFa, $eCa::sep);
	my @ignored = ();
	my @words = ();
	my $verbose_flag_tmp = $verbose_flag;
	$verbose_flag = shift;
	chomp $expr;	
	undef $syntax_error;
	#DEBUG("********** dOa() debug **********\n");	
	my $match = dOa($expr, \%indexdb, \@ignored);
	#DEBUG("**********         end debug         **********\n");	
	if ($syntax_error) {
		$errstr = $syntax_error;
		$verbose_flag = $verbose_flag_tmp;
		return undef;
	}
	my $result =  eOa($match,$filesdbpath, $titlesdbpath, \@words, \@ignored);
	
	untie(%indexdb);
	untie(%filesdb);
	untie(%titlesdb);
	$verbose_flag = $verbose_flag_tmp;
	return $result;
}

sub dOa { 
	my ($expr, $index, $ignored) = @_;
	my $parsed = eFa($expr);
	if ( not $parsed) {
		DEBUG("Syntax error :-( \n");
		return undef;
	}
	my ( $gF, $left,$right) = @$parsed;
	
	if ($left && not $right) {  
		$left =~ s/^\s*\(?\s*|\s*\)?\s*$//g;
		#DEBUG("Looking up >$left<\n");
		my %matches = ();
		my $word = $left;
		my $rc = 0;
 		my $keys = $index->{lc $word};
		$rc = eKa($keys,\%matches);
		if (not $rc) {
			#DEBUG("$word ignored\n");
			push @$ignored, $word;
			return undef;
		
		}
		return \%matches;
	}
	
	#DEBUG("Evaluating >$left< --$gF-- >$right<\n");
	my $left_match  = dOa($left, $index, $ignored);		
	my $right_match = dOa($right, $index, $ignored);		
	
	return undef if ($syntax_error); 
	my %matches = ();
	my $file = undef;
	
	if ($gF eq 'AND' ) {
		%matches = ( %$left_match );
		for $file( keys %matches) {
			delete $matches{$file} unless $right_match->{$file}
		}
		return \%matches;
	}
	if ($gF eq 'AND NOT') {
		%matches = ( %$left_match );
		for $file( keys %matches) {
			delete $matches{$file} if $right_match->{$file}
		}
		return \%matches;
	}
	if ($gF eq 'OR')  {
		%matches = (  %$left_match );
		for $file( keys	%$right_match) {
			if ($matches{$file}) {
				$matches{$file} +=$right_match->{$file};
			} else {
				$matches{$file} =$right_match->{$file};
			}
		}
		return \%matches;
	}	
	return undef;
}	

sub eFa {
	my $arg = shift;
	my $tokens = undef; 
	if (ref($arg) ne 'ARRAY') {
		$tokens = [ 
		 $arg =~  m/( \( | \)| \bAND\s+NOT\b | \bAND\b | \bOR\b | \"[^\"]+\" | \b\w+\b) /xig 
			];
	}
	else { $tokens = $arg;
	}
	my $left =  undef; 
	my $right = undef;
	my $gF =    'OR';
	my $depth = 0;
	my $pos = 0;
	my $tok;
	my $len = int @$tokens;
	#DEBUG("expr = ", join(" + ", @$tokens),"\n"); 	
	while (1) {
		if ($len == 1) {
			return [ undef, $tokens->[0], undef ];
		}
		#DEBUG("$tok : depth=$depth pos=$pos len=$len\n");
		if ($depth == 0 && ($pos == $len) ) {
			if ($tokens->[0] eq '(' && $tokens->[$len-1] eq ')') {
			
				shift @$tokens;
				pop @$tokens;
				$len  -= 2;
				$pos   = 0;
				$depth = 0;
				#DEBUG("expr = ", join(" + ", @$tokens),"\n"); 	
			} else {
				$syntax_error = "Ill-formed expression (\"".join(' ', @$tokens)."\")";
				#DEBUG("atom not atomic\n");			
				return undef;
			}
	
		} elsif ( $pos == $len ) {
			$syntax_error = "Non-matching parentheses (\"".join(' ', @$tokens)."\")"; 
			#DEBUG("non matching parentheses\n");
			return undef;
		}
		$tok = $tokens->[$pos++];
		if ($tok eq '(') { $depth++; next; }
		if ($tok eq ')') { $depth--; next; }
		next if $depth;
		if ($tok  =~ /\b(AND\s+NOT|AND|OR)\b/i) {
			if ($pos == 1 || $pos == $len)  {
				$syntax_error = "Ill-formed expression (\"".join(' ', @$tokens)."\")";
				return undef 
			} 
			$gF = uc $1; $gF =~ s/\s+/ /g;
			$left = [ @$tokens[0..$pos-2]    ];
			$right =  [ @$tokens[$pos..$len-1] ];
			#DEBUG("right = ", join(" + ", @$right),"\n"); 	
			#DEBUG("left  = ", join(" + ", @$left),"\n"); 	
			return [ $gF, $left, $right ];
		}
	}
}
	
	

sub query { 	
	my ($self, $pats, $reg) = @_;
	my $kFa= $self->{kFa};
	my $filesdbpath = $self->{filesdbpath};
	my $titlesdbpath = $self->{titlesdbpath};
	my %indexdb;
	my %filesdb;
	my %titlesdb;
	return undef unless (-f $kFa && -r _);
	return undef unless (-f $filesdbpath && -r _);
	return undef unless (-f $titlesdbpath && -r _);
	return undef unless	
		eJa(\%indexdb,$kFa, $eCa::sep); 
	my %matches;
	my %limit;
	my %exclude;
	my @ignored;
	my $key;
	my $word;
	my $mustbe_words = 0;
	my @words = ();
	my $glob_regexp = undef;
	for (@$pats) {		# globbing feature... e.g. uni* passw?
		if ($reg || /\*|\?/) {
			s/\*/\.\*/g;
			s/\?/\./g;
			if ($reg) {
				s/$/\.\*/;
				s/^/\.\*/;
 }
			$glob_regexp = $glob_regexp ? $glob_regexp."|^$_\$" : "^$_\$" ;
		}
		else {
			push @words, $_;
		}
	}
	if ($glob_regexp) {
		my $regexp = qq/$glob_regexp/;
		eBa(\%indexdb, \@words, $regexp);
	}

	#DEBUG("looking up ", join(", ", @words ), "\n");
	foreach $word (@words) {
		my $rc = 0;
#		#DEBUG($word);
		if ($word =~ /^-(.*)/) {
 			my $keys = $indexdb{lc $1};
			$rc = eKa($keys,\%exclude);
		} elsif ($word =~ /^\+(.*)/) {
			$mustbe_words++;
 			my $keys = $indexdb{lc $1};
			$rc = eKa($keys,\%limit);
		} else {
 			my $keys = $indexdb{lc $word};
			$rc = eKa($keys,\%matches);
		}
#		#DEBUG("\n");
		if (not $rc) { push @ignored, $word }
	}
	
	if ($mustbe_words) {
		for $key(keys %limit) {
			next unless $limit{$key} >= $mustbe_words;
			$matches{$key}  += $limit{$key} ;
		}
		for $key(keys %matches) {
			delete $matches{$key} unless $limit{$key};
		}
	}
	for $key(keys %exclude) {
		delete $matches{$key};
	}
	my $result =  eOa(\%matches,$filesdbpath, $titlesdbpath, \@words, \@ignored);
	untie(%indexdb);
	return $result;
}
	

sub eOa {
#            hash-ref  hash-ref   hash-ref    array-ref   array-ref
	my ( $match,   $filesdb,  $titlesdb,  $words,     $ignored  ) = @_; 
	my $result = {
		searched =>  $words,
		ignored  =>  $ignored,
		files	 =>  []
	};
	my $key;
 	my %match2=();
	local *F;
	my $klen = length(pack("xn", 9999));
	foreach $key (keys %$match) {
		my $ckey = pack("xn",$key);
		$match2{$ckey} = $key;
	} 
	
	my ($k, $v);
	my $res={};
	open F, "<$filesdb";
	while (<F>) {
		chomp;
		#($k, $v) = split /\t/, $_;
		$k = substr $_, 0, $klen;
		next if not exists $match2{$k}; 
		$v = substr $_, $klen+1;
		my $okey = $match2{$k};
		$res->{$okey}->[0] = $v;
		$res->{$okey}->[1] = $match->{$okey};
	}
	close F;

	open F, "<$titlesdb";
	while (<F>) {
		chomp;
		($k, $v) = split /\t/, $_, 2;
		next if not exists $match2{$k}; 
		my $okey = $match2{$k};
		$res->{$okey}->[2] = $v;
	}
	close F;	
	for(values %$res) {
		push @{$result->{files}}, {filename=>$_->[0], score=>$_->[1], title=>$_->[2]};
	}
	return $result;
}

	
	
sub DEBUG (@) { $verbose_flag && print @_ };

sub eJa {
	my ($hashref, $file ,$sep) = @_;
	$sep = "\n" if not $sep;
 local *F;
	open F, "$file" or return 1;
	binmode F;
	local $/ = undef;
 my $all = <F>;
 my @gHz = split /$sep/o, $all;
	for(@gHz) {
		my ($k, $v) = split /\t/, $_, 2; 
		next if $k eq "";
		$hashref->{$k} = $v;
	}
	close F;
	return 1;
}

sub ePa {
	my ($hashref, $file, $sep ) = @_;
	$sep = "\n" if not $sep;
	if ($debug_flag) {
		my $count = int keys %$hashref;
		#DEBUG("untie $hashref ($count keys), output to $file\n")
	}
	return 1 if not $file;
	open F, ">$file" or return "On writing file $file: $1 ";
	binmode F;
	for(keys %$hashref) {
		print F $_, "\t", $hashref->{$_}, $sep;
	}
	close F;
}
sub dCa {
	my $self = shift;
	my $nA = shift || \*STDOUT;
	my $kFa= $self->{kFa};
	my %indexdb;
	die unless (-f $kFa && -r _);
	eJa(\%indexdb,$kFa, $eCa::sep);
	my %index = ( %indexdb );
	my $w;
	for $w( sort { length($index{$b}) <=> length($index{$a}) }
				keys %index ) {
		print $nA $w, "\t", length($index{$w}) / 2, "\n"; 
	}
	ePa(\%indexdb);
}

sub dUa {
	my $self = shift;
	my $key = 0;
	my $kFa = $self->{kFa};
	my $filesdbpath = $self->{filesdbpath};
	my $titlesdbpath = $self->{titlesdbpath};

	my $dir;
	my $dirs 	= $self->{dirs};
	my $urls	= $self->{urls};
	my $filemask 	= $self->{filemask};
	my $keyref = \$key;
	my $filelistfile = $kFa;
	$filelistfile =~  s/(\.db)?$/\.filelist/;
	$filelistfile =~ /(.*)/; $filelistfile = $1;
	open FILELIST, ">".$filesdbpath;
	open TITLIST, ">".$titlesdbpath;
	
	my $shared = {
		kFa 	=> $kFa,
		filesdbpath 	=> $filesdbpath,
		titlesdbpath 	=> $titlesdbpath,
		indexdb 	=> { },
		filesdb 	=> { },
		titlesdb 	=> { },
		cachedb 	=> { },
		filemask 	=> $filemask,
		current_key	=> 16, 
		bytes		=> 0,
		count 		=> 0,
		filecount	=> 0,
		filesfh		=> \*FILELIST,	
		titsfh		=> \*TITLIST,	
		status_THE 	=> 0,
		kJa	=> $self->{kJa},
		kGa	=> $self->{kGa},
		ignoreword	=> {},
		autoignore	=> 1,
		kBa	=> $self->{kBa} || (2/3),
		level		=> $self->{level},	
		max_entry	=> $self->{max_entry},
		multibyte       =>$self->{multibyte},
 wsplit          => $self->{siteidx_wsplit} || pack("h*", $qWa::cEaA),
		url_exclude 	=> $self->{url_exclude},
		url_exclude2 	=> $self->{url_exclude2},
	};
	
	unlink $kFa."~"; 
	unlink $filesdbpath."~"; 
	unlink $titlesdbpath."~";
	eJa($shared->{indexdb}, $kFa."~", $eCa::sep )   or die "$kFa: $!\n";
	eJa($shared->{filesdb}, $filesdbpath."~" )   or die $!;
	eJa($shared->{titlesdb},$titlesdbpath."~" ) or die $!;

	my $ignorefile = $kFa;
	$ignorefile =~ s/(\.db)?$/\.stopwords/;
	if (-r $ignorefile) { 
		open F, $ignorefile;
		while (<F>) {
			chomp;
			s/^\s+|\s+$//g;
			$shared->{ignoreword}->{$_} = 1;
		}
		close F;
		my $count = int keys %{ $shared->{ignoreword} };
		$shared->{autoignore} = 0;
	}
	my $time = time();
	my $filecount = 0;
	#DEBUG("Counting files...\n") if int @$dirs;
 	for $dir( sort  @$dirs) { $filecount += dBa($shared, $dir, 1); }
	for $dir( sort  @$dirs) { dBa($shared, $dir); }
	my @deads;
	for my $url( sort  @$urls) {  push @deads, [$url, [dWa($shared, $url) ]]; }
	$time = time()-$time;
	#DEBUG("$shared->{bytes} bytes read, $shared->{count} files processed in $time seconds\n");
	dVa($shared->{indexdb}, $shared);
	ePa($shared->{indexdb}, $kFa, $eCa::sep);
	# ePa($shared->{filesdb}, $filesdbpath);
	# ePa($shared->{titlesdb}, $titlesdbpath);
	
	close FILELIST;
	close TITLIST;
	if ( $shared->{autoignore} ) {
		open  F, ">".$ignorefile;
		print F join( "\n", sort keys %{ $shared->{ignoreword} } );
		close F;
	}

	return @deads;	
}

sub dBa {
	my ($shared, $dir, $kDa) = @_;
	my $kJa = $shared->{kJa};
	opendir D, $dir;
	my @files = readdir D;
	close D;
	my $e;
	my $count = 0;
	my $exclude_re = $shared->{url_exclude};
	my $exclude_re2 = $shared->{url_exclude2};
	for $e(@files) {
		if ($e =~ /^$exclude_re$/o) {
			next;
 }
		if ($e =~ /^$exclude_re2$/o) {
			next;
 }
		next if $e =~ /^\.\.?/;
		$dir =~ s!/$!!;
		my $path = $dir."/".$e;
		if (-d $path) {
			unless ($kJa) {
				next if -l $path ;
			}
			$count += dBa($shared,$path, $kDa);
		}
		elsif (-f _ ) {
			my $filemask = $shared->{filemask};
			if ($filemask) {
				next unless $e =~ $filemask;
			}
			unless ($kDa) {
				my $mt = (stat($path))[9];
				my $lmt = sVa::dU('LONG', $mt, 'oP');
				dLa($shared,$path, $lmt);
			}
			$count ++;
		}
		return if $shared->{max_entry} > 0 && $shared->{filecount} > $shared->{max_entry};
	}
	return if $shared->{max_entry} > 0 && $shared->{filecount} > $shared->{max_entry};
	return $count;
}

sub dLa {
	my ($shared, $file, $lmt, $text) = @_;
	my $cachedb = $shared->{indexdb};
	my $filesdb = $shared->{filesdb};
	my $key = $shared->{current_key};
	my $no_of_files = $shared->{filecount};
	$shared->{filecount}++;
	DEBUG $shared->{count}+1, "/$no_of_files $file (id=$key)\n";
	my $filesfh = $shared->{filesfh};
	my $titsfh = $shared->{titsfh};
	local $/;
	my $had_txt = 0;
	$had_txt = 1 if length($text) > 0;
	unless ($had_txt) {
		undef $/;
		open(FILE, $file);
		($text) = <FILE>; 	
		close FILE;
	}
	my $filesize =  length($text);
	if ($file =~ /\.s?htm.?/i || $had_txt ) {
		$text =~ s/&nbsp;/ /gi;
		$text =~ s/\s+/ /g;
		$text =~ /<title[^>]*>([^<]+)<\/title>/gci ;
		my $title = $1;
		$title =~ s/\s+/ /g;
 $text =~ s/.*<body[^>]*>//i;       
 $text =~ s/<style[^>]*>.*?<\/style>/ /gi;       
 $text =~ s/<script[^>]*>.*?<\/script>/ /gi;       
 $text =~ s/<[^>]*>/ /g;
 $text =~ s/\s+/ /g;
		my $abstract = substr $text, 1, 120;
 my $chk = unpack("%16C*", $text); 
		$lmt =~ s/\s+/ /g;
	#	$shared->{titlesdb}->{pack"xn",$key} = $title."\t".$abstract."\t$chk\t$filesize\t$lmt";  

		print $titsfh pack("xn",$key), "\t", $title."\t".$abstract."\t$chk\t$filesize\t$lmt", "\n";  

		#DEBUG("* \"$title\"\n");
		for(0..9){
			$text .= "  $title";
		}
	}
	my($wordsIndexed) = $shared->{multibyte}? pUa($cachedb, $text,$key, $shared): dRa($cachedb, $text,$key, $shared);
	$shared->{current_key}++;
	#DEBUG "* $wordsIndexed words\n";
	
	# $filesdb->{pack"xn",$key} = $file;   	 
	print $filesfh pack("xn",$key), "\t", $file, "\n";   	 
	$shared->{bytes} += $filesize;
	$shared->{count}++;
	$shared->{iMa} += $filesize;
}

sub dVa {
	my ($db, $shared) = @_;
	my $thres = $shared->{kBa} * $shared->{filecount};
	my $klen = length(pack('n', 999));
	my @ignores;
	for(keys %$db) {
		my $v = $db->{$_};
		push @ignores, $_ if length($v)/$klen > $thres;
		
	}		
	for(@ignores) {
		delete $db->{$_};
	}
	#DEBUG "Ignore ", join ("\n", @ignores);
}
	

sub dRa {
 my ($db, $words, $jVa, $shared) = @_;
#      hash  content  file-id   options	
 my (%worduniq);
 my $kGa = $shared->{kGa};	    
 my (@words) = split( /[^a-zA-Z0-9\xc0-\xff\+\_]+/, lc $words); 
 my %jJa;

 @words = grep { length  > $kGa } 		
	     grep { s/^[^a-zA-Z0-9\xc0-\xff]+//; $_ }	
 grep { /[a-zA-Z0-9\xc0-\xff]/ } 	
 @words;
 for (@words) {     			
	$jJa{$_} ++;
 }
 for(keys %jJa) {
	my $a = $db->{$_};	
	$a .= pack "n2",$jVa, $jJa{$_};	
 $db->{$_} = $a;
 }
 return int keys %jJa;
}

sub pUa {
 my ($db, $words, $jVa, $shared) = @_;
 my (%worduniq);
 my $kGa = $shared->{kGa};	    
 my (@words) = split( /(\s|`|'|"|,|\||;|:|#|\(|\)|\[|\])+/, lc $words); 
 my %jJa;
 my @words2;
 my @words3;
 if($shared->{wsplit}) {
	for(@words) {
		my @words3 = split /$shared->{wsplit}/o, $_;
		for my $k (@words3){
			if(length($k)<=4) {
				push @words2, $k;
			}else {
				my @x= split /$eCa::ws2/o, $k;
				push @words2, @x;
			}
		}
 }
 }else {
	@words2 = @words;
 }  
 for (@words2) {     			
	$jJa{$_} ++;
 }
 for(keys %jJa) {
	my $a = $db->{$_};	
	$a .= pack "n2",$jVa, $jJa{$_};	
 $db->{$_} = $a;
 }
 return int keys %jJa;
}

sub dWa {
	my ($shared, $url) = @_;
	my $req = new dDa;
	my %fetched = ();
	$shared->{req} = $req;
	$shared->{fetched} = \%fetched;
	my $jWa = $shared->{kFa};
	$jWa =~ s/(\.db)?$/\.deadlinks/;
	open DL, ">".$jWa;
	$shared->{deadlinksfh} = \*DL;
	$req->dIa(\%fetched);
	$req->dXa("text/");
	$req->{user_agent} = "Mozilla/4.0 (MSIE 6)";
	DEBUG "Spiding $url\n";
 	my ($service, $host, $page, $oE) = &dDa::dKa($url);
	$shared->{_cur_host} = $host;
	if($eCa::use_lwp) {
		eval 'use LWP::Simple';
		if($@) {
			DEBUG "LWP::Simple: $@\n";
			return;
		}
	}
	dGa($shared, $url, "", 0);
	close DL;
	open DL, "<".$jWa;
	my @deads= <DL>;
	close DL;
	return @deads;
}

sub dGa {
	my ($shared, $url, $parent, $level) = @_;
	my $req = $shared->{req};
	if($shared->{fetched}->{$url}) {
		#DEBUG "Skip visited URL $url\n";
		return;
	}
	#DEBUG "Got " , scalar(keys %{$shared->{fetched}}), " urls\n";

	$shared->{fetched}->{$url} = 1;
	my $content;

	if(not $eCa::use_lwp) {
		$req->eNa($url);
		$content = join("", $req->dEa());
	}else {
		$content = get($url);
		if(not $content) {
			$req->{cur_status}= 400;
		}else {
			$req->{cur_status}= 200;
		}
		$req->{dYa} = $url;
	}
	my $status =  $req->{cur_status};
	if ( $status != 200 && int($status/100) !=3 ) {
		my $nA = $shared->{deadlinksfh};
		my $url = $req->{dYa};
		print $nA $status, "\t",
			$url, "\t", $parent, "\n";
		DEBUG  "Error $status", "\t",
			$url, "\tIn ", $parent, "\n";
		return;	
	};
	my $len = length($content);
	$req->finish();
	my $content_ref = \$content;
	dLa($shared, $url, $req->{eTa}->{'last-modified'}, $$content_ref);
	if ($shared->{level} && $level >= $shared->{level}){
		DEBUG "Reached max fetch level $level\n";
		return;
	}
	$$content_ref =~ s/<!--.*?-->//gs;	
	my $discard;
	my @links = $$content_ref =~/(?:href|\ssrc)=([^>\s]+)/ig; 
	my $count = 0;
	my $exclude_re = $shared->{url_exclude};
	my $exclude_re2 = $shared->{url_exclude2};
	my $dYa = $req->{dYa};
	my $eQa = $shared->{_cur_host};
	if ($shared->{max_entry} && $shared->{filecount} > $shared->{max_entry}) {
		DEBUG "Reached max fetch count $shared->{max_entry}\n";
		return;
	}
	DEBUG scalar(@links), " links found ($len bytes)\n";
	for(@links) {
		s/\"|\'//g;
		next if m/^(ftp|mailto|gopher|news|javascript|ldap):/;	
		m/^(\w+):/;	
		next if $1 && lc($1) ne 'http';
		if ($_ =~ /^$exclude_re$/o) {
			#DEBUG "Exclude URL $_\n";
			next;
		}
		if ($_ =~ /$exclude_re2/o) {
			#DEBUG "Exclude2 URL $_\n";
			next;
		}
		s/#.*$//;
		next if not $_;
		my $link = dDa::eAa($dYa, $_);
		$count++;
		if($shared->{fetched}->{$link}) {
			#DEBUG "Skip fected URL $_\n";
			next;
		}
 		my ($service, $host, $page, $oE) = &dDa::dKa($link);
		if (($host !~ $eQa) && ($eQa !~ $host))  {
			#DEBUG "Skip remote URL $link\n";
			next;
		}
		dGa($shared,$link, $url, $level +  1); 
	}
}
1;
package rNa;

use strict;
use vars qw(
@lXa
@fieldtypes
@mvfieldtypes
@dN
@root_login_form
@wFa
@vVa
%wMa
@uBa
@mail_merge_form
@iGz
%bK
$tabattr
);

@lXa=(
['', 'head', "Create New Form"],
['uVa', "text", "", "ID of the new form, must start with a letter and be alphanumeric", ""],
['_aefcmd_', 'hidden', '', "", "mkform"],
);

@fieldtypes=(
[""=>"Choose type"],
[text=>"One line text field"],
[textarea=>"Multi-line text box"],
[password=>"Password entry"],
[file=>"File upload entry"],
[ifile=>"File upload inlined"],
[hidden=>"Hidden field"],
[checkbox=>"Checkbox"],
[radio=>"Radio buttons"],
[select=>"Single selection list"],
[kAa=>"Multiple selection list"],
[date=>"Date value"],
[time=>"Time value"],
[head=>"Form heading"],
);

@mvfieldtypes=(
[""=>"Choose type"],
);
@wFa=(
["vJa", "head", "Add Form Element"],
["wEa", "text", "", "Field name. Use letters, digits and _ only.", ""],
[uLa=>"select", join("\n", map { join('=', @$_) } @fieldtypes), "Field type", ""],
["vRa", "textarea", "rows=2 cols=64", "Field description", ""],
["vKa", "textarea", "rows=2 cols=64", "Field attributes.<br>Examples: size=6; rows=4; cols=64.", ""],
["vDa", "text", "", "Default value", ""],
["fieldverifier", "select", "=None\nbe_url=URL\nbe_email=Email\nbe_deci=Number\nbe_card=Credit card number", "Value check", ""],
["fieldrequired", "checkbox", "1=Yes", "Field is required", ""],
["fieldsizemax", "text", "size=8", "Field size max", ""],
["fielddbtype", "select", "VARCHAR=VARCHAR\nCHAR=CHAR\nINT=INTEGER\nFLOAT=FLOAT\nBLOB=BLOB", "Field SQL Type", ""],
["fieldidxtype", "select", "=None\nindex=index\nunique=Unique Index\npk=Primary key", "Field SQL index type", ""],
[uVa=>"hidden", "", "", ""],
["wAa", "hidden", "", "Field id", ""],
["beforeid", "hidden", "", "Field id", ""],
['_aefcmd_', 'hidden', '', "", "vZa"],
);

@vVa=(
["", "head", "<b>Search data</b>"],
[srachpat=> "const", "", qq(Search pattern), qq(<input type="text" name="pat">)],
["time", "const", "", qq(Time), qq(<input type="text" size="3" name="vWa"> days ago to <input type="text" size="3" name="vHa"> days ago)],
["sortkey", "select"],
["sortorder", "radio", "a=Ascending\nd=Descending", "Sort order"],
["output_format", "select", "TEXT=TEXT\nHTML=HTML", "Output format", ""],
["extract_fields", "text", qq(size="40"), "Only show these fields"],
[uVa=>"hidden", "", "", ""],
['_aefcmd_', 'hidden', '', "", "findidx"],
);

%wMa =(
lXa=>[\@lXa, "Create New Form"],
wFa=>[\@wFa, "Add form element"],
create_adm_form=>[\@dN, "Create Administrator"],
root_login_form=>[\@root_login_form, "Admin Login"],
);
 

@uBa=(
["", "head", "Form processing settings"],
["name", "text", "size=60", "Name of the form", "A Form"],
["publish", "checkbox", "1=yes", "Activate the form", ""],
["vAa", "checkbox", "1=yes", "Submitted data can be viewed by anyone?", ""],
["wBa", "checkbox", "1=yes", "Submitted data can be viewed by registerd users", ""],
["vCa", "checkbox", "1=", "User must register to submit the form", ""],
["allowedusers", "textarea", "rows=2 cols=40", "Only these users can submit the form (names separated by comma)", ""],
["allowedreaders", "textarea", "rows=2 cols=40", "Only these users can view the form data (names separated by comma)", ""],
["extraeditors", "textarea", "rows=2 cols=40", "Allow these additional users to edit the form data (names separated by comma)", ""],
["modbyuser", "checkbox", "1=", "Allow user to modify submitted data", ""],
["fields", "const", "", "Available field names", ""],
["wJa", "textarea", "rows=2 cols=64", "Names of required fields", ""],
["uSa", "textarea", "rows=2 cols=64", "Names of indexed fields", ""],
["vQa", "text", "", "The http referer must match this pattern", ""],
["pagesize", "text", "size=4", "Number of submitted items to display per page", "20"],
[required_word=> "text", "size=48", "Label to signify that a field is required",  qq(<font color="#cc0000"><sup>*</sup></font>)],
["qDz", "checkbox", "1=yes", "Allow overriding uploaded file", "1"],
["usedb", "checkbox", "1=yes", "Use SQL DB", "0"],
["", "head", "Form reply settings"],
["finboard", "checkbox", "1=yes", "Make the form available in message area posting. When this is checked, users can post a forum message with this form attached.", ""],
["frepfids", "checkbox", "", "", ""],
["", "head", "Form notification settings"],
["notify", "checkbox", "1=yes", "Send notification when form is submitted", ""],
["wN", "text", "size=60", "Email address to notify when form is submitted", ""],
["bcc", "text", "size=60", "Email(s) notified via BCC field", ""],
["notifier", "text", "size=60", "Sender email address of the notification", ""],
["", "head", "Layout Form"],
["multientrycnt", "text", "", "Show this many form entries by default. By setting this to greater than 1, a user can submit multiple entries of this form on one screen.", "1"],
["uRa", "checkbox", "1=yes", "Use inherited headers and footers, ignore the following settings", "1"],
["uOa", "textarea", "rows=8 cols=64", "Header of the submit page", "<html><body>"],
["uZa", "textarea", "rows=8 cols=64", "Footer of the submit page", "</body></html>"],
["vBa", "textarea", "rows=8 cols=64", "Header of the confirmation page", "<html><body>"],
["vTa", "textarea", "rows=8 cols=64", "Footer of the confirmation page", "</body></html>"],
["vNa", "htmltext", "rows=20 cols=64", "Template for the submit form. You must manually update this if fields are updated", ""],
["vLa", "htmltext", "rows=8 cols=64", "Default template for the submit form. Do not edit this entry. Use this only as a reference. When additional fields are added, the other templates are not updated. You must manually change the templates to include the new fields. A field is represented in the template as \{a_field_id\}. The _COMMAND_ tag represents the reset and submit buttons. Hidden fields and FORM tags will be added automatically by the program.", ""],
["fullview", "htmltext", "rows=20 cols=64",  "Template for detail data view."],
["vFa", "htmltext", "rows=20 cols=64", "Template for data overview", ""],
["vPa", "htmltext", "rows=8 cols=64",  "Default template for data view."],
[uVa=>"hidden", "", "", ""],
['_aefcmd_', 'hidden', '', "", "vUa"],
); 

use aLa;
use jEa;
use sVa;

sub sVa::gYaA(@);
%bK = (
mkform => [\&rPa, 'ADM'],
delfield=>[\&uAa, 'ADM'],
uYa=>[\&uYa, 'PUB'],
wLa=>[\&wLa, 'ADM'],
cCaA=>[\&cBaA],
vZa=>[\&tMa],
submit=>[\&uDa, 'PUB'],
modify =>[\&tLa, 'REG'],
dataidx=>[\&tCa],
findidx=>[\&tOa, 'CHK'],
uGa=>[\&uGa, 'CHK'],
uBa=>[\&cGaA, 'ADM'],
vUa=>[\&sGa, 'ADM'],
rFa=>[\&rFa, 'REG'],
modfield=>[\&tAa, 'ADM'],
moddata=>[\&rHa],
cKaA=>[\&cKaA, 'PUB'],
login=>[\&tJa, 'PUB'],
logout=>[\&yFz],
lico=>[\&hZz, "ADM"],
cAaA=>[\&eYa, 'PUB'],
wIa=>[\&uCa, 'PUB'],
vGa=>[\&tBa],
retr=>[\&uEa],
bSaA=>[\&yJa, 'ADM'],
crsql=>[\&eAaA, 'ADM'],
crtable=>[\&eHaA, 'ADM'],
cDaA=>[\&yYa, 'ADM'],
sinfo=>[\&wLz, 'PUB']
);

$tabattr= {width=>"90%", usebd=>1};
sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{iC}= $argh->{iC};
 $self->{tmpldir}= $argh->{tmpldir};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{home} = $argh->{home};
 $self->{header} = $argh->{header};
 $self->{footer} = $argh->{footer};
 $self->{jW} = $argh->{jW};
 return bless $self, $type;
}

sub cFaA{
	my ($self, $adm) = @_;
	$self->{uTa} = $adm;
}

sub cJaA{
	my ($self, $kQz) = @_;
	$self->{wOa} = $kQz;
}

sub bUaA{
	my ($self, $url) = @_;
	$self->{wCa} = $url;
}

sub bTaA{
	my ($self, $url) = @_;
	$self->{uQa} = $url;
}

sub bWaA{
	my ($self, $link) = @_;
	$self->{vSa} = $link;
}

sub cBaA{
 my ($self, $input) = @_;
 $self->sWa('wFa', {uVa=>$input->{uVa}, beforeid=>$input->{beforeid} }, undef, $input->{beforeid}?1:5) ;
}

sub uYa{
 my ($self, $input) = @_;
 $self->sWa($input->{uWa}) if $input->{uWa};
 $self->rZa($input) if $input->{uVa};
}

sub cGaA{
 my ($self, $input) = @_;
 $self->uBa($input) ;
}

sub wLa{
 my ($self, $input) = @_;
 $self->rVa($input->{uVa});
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub tIa{
 my ($self, $input) = @_;
 my $iC = $self->{iC};
 opendir DIR, $iC or error('sys', "Can't open dir $iC: $!"); 
 my @forms = grep !/^\.\.?$/, readdir DIR;
 close DIR;
 my @rows;
 for my $xZa (@forms) {
 next if not  -f $self->uFa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
	push @rows, [$xZa, $design->{name}, $design->{publish}, $design->{vAa}, $design->{wBa}, $design->{vCa}, $design->{finboard}];
 }
 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 $uNa->iRa(\@rows);
}

sub yVa{
 my ($self, $inboard,  $all) = @_;
 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 my $jKa = $uNa->iQa({noerr=>1});
 my $isadm = $self->eVa();
 my @ids; 
 for my $jRa (@$jKa) {
	my ($xZa, $xO, $publish, $vAa, $wBa, $vCa, $finb) = @$jRa;
 next if not  -f $self->uFa($xZa, "def");
	next if not ($isadm || $publish);
	next if ($inboard && not $finb);
	next if ($vCa && not ($self->{wOa} || $all));
	push @ids, [$xZa, $xO];
 }
 return @ids;
}

sub uCa{
 my ($self, $input) = @_;
 my $iC = $self->{iC};
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();

 my $isadm = $self->eVa();
 my $colsel=[0,1,2,3];
 if($isadm) {
 }else {
	$colsel = [0, 1, 2];
 }
 if(not $self->{wOa}) {
 print "<center>You are not logged in, only public information is displayed.</center> ";
 }

 $self->tIa() if not -f $self->tTa();

 my $uNa = jEa->new($self->tTa(), {schema=>"vEa"});
 my $jKa = $uNa->iQa({noerr=>1});

 my $nav = $self->yMa('allforms');
 print $nav, qq(<br>);
 my @rows;
 for my $jRa (@$jKa) {
 
	my ($xZa, $xO, $publish, $vAa, $wBa, $vCa) = @$jRa;
 next if not  -f $self->uFa($xZa, "def");
	next if not ($isadm || $publish);
	next if ($vCa && not $self->{wOa});
 
 my $uXa = $self->uFa($xZa, "idx");
 my $t = (stat($uXa))[9];
 
 push @rows, [ 
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'uYa', uVa=>$xZa}), $xO), 
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'dataidx', uVa=>$xZa}), "Data index"), 
 $t>0? sVa::dU('LONG', $t, 'oP') :"",
	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"wLa", uVa=>$xZa}), "Admin"), 
 ];
 }
 if(@rows) {
 	my @ths = map { qq(<font color="#ffcc00">$_</font>) } ("Form Name", "Data", "Last submit", "Command");
 	print sVa::fMa(ths=>\@ths, rows=>\@rows, colsel=>$colsel, sVa::oVa($tabattr));
 }else {
 print "<center>";
 print "No active forms available.<br>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"uYa", uWa=>"lXa"}), "Create a new form") if $isadm;
 print "</center>";
 }
	
 print $self->{footer};

}

sub rJa {
 my $v = shift;
 return 0 if $v =~ /\W/ or not $v;
 return 0 if $v eq 'cmd';
 return 1;

}

sub sWa {
 my ($self, $name, $bXaA, $msg, $multicnt)= @_;
 my $wDa = $wMa{$name};
 error('inval', "Invalid form name") if not $wDa;
 my $form = new aLa($name, $wDa->[0], $self->{cgi});
 $form->aAa($bXaA, 1) if $bXaA; 
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $msg;
 $form->sRa('dupcnt', $multicnt);
 print $form->form();
 print $self->{footer};
}

sub rPa {
 my ($self, $input) = @_;
 my $id = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") 
	if not rJa($id);
 error("inval", "Invalid form id, must start with a letter") if  $id !~ /^[a-z_]/i;
 my $vOa = sVa::kZz($self->{iC}, $id);
 my $uUa = sVa::kZz($vOa, 'data');
 mkdir $vOa, 0755 or error('sys', "Can't make form directory: $!");
 mkdir $uUa, 0755 or error('sys', "Can't make form directory: $!");

 my $formdefpath = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->zNz(["aefpid", "hidden", "", "Primary key", "", "", 0, "INT", undef, "pk"]);
 $form->cCa($formdefpath);
 $self->rVa($id);
 $self->tIa();

} 
sub tNa{
	my ($self, $ext) = @_;
 return sVa::kZz($self->{iC}, "config.$ext");
}

sub tTa{
	my ($self) = @_;
 return sVa::kZz($self->{iC}, "schema.idx");
}

sub uFa {
	my ($self, $xZa, $ext) = @_;
 return sVa::kZz($self->{iC}, $xZa, "$xZa.$ext");
}

sub sOa {
	my ($self, $xZa, $file) = @_;
 return sVa::kZz($self->{iC}, $xZa, "data", $file);
}

sub rXa {
	my ($self, $xZa, $seq) = @_;
 return sVa::kZz($self->{iC}, $xZa, "$seq.dat");
}

sub ySa {
	my ($self, $xZa, $ext) = @_;
 return sVa::kZz($self->{tmpldir}, "$xZa.$ext");
}
sub tLa{
 my ($self, $input) = @_;
 my $isadm = $self->eVa();
 my $xZa = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") if $xZa =~ /\W/;
 my $vOa = $self->uFa($xZa, "def");
 my $form = new aLa($xZa);
 $form->cDa($vOa);

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);

 my $seqno = $input->{vMa};

 my $uXa = $self->uFa($xZa, "idx");

 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});

 my $jRa = $uNa->kCa($seqno);
 my $usrok = $self->tDa($design->{extraeditors});
 if(not ($isadm || $usrok)) {
 if($design->{modbyuser}) {
	   my ($did, $xZa, $t, $mt, $kQz) = @$jRa;
	   error("deny", "") if  lc($kQz) ne lc($self->{wOa});
 }else {
	   error("deny", "");
 }
 }

 error('deny', "Form originating from unauthorized page") 
		if $design->{vQa} && not $ENV{HTTP_REFERER} =~ /$design->{vQa}/; 

 $form->aAa($input);
 $form->cOa([split /\W+/, $design->{wJa}], 1);
 my @miss = $form->cHa();
 if(@miss) {
	$self->uIa($xZa, $form, "<center><h2>The data you input was not accepted, please make corrections and resubmit</h2>".join("<br>", @miss)."</center>");
	sVa::iUz();
 }

 my $cPz;
 for(values %$input) {
		next if not ref($_) eq 'ARRAY';
		$cPz = $self->sOa($xZa, $_->[0]);
 		error('inval', "Attempt to upload a file that exists") if -f $cPz && not $design->{qDz};
		open(kE, ">$cPz" ) || error($!. ": $cPz");
		binmode kE;
		print kE $_->[1];
		close kE;
 }

 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
 $form->store($self->rXa($xZa, $seqno), undef, {aefpid=>$seqno});

 my @idxes = split /\W+/, $design->{uSa};
 my @vals = map {undef} 0..9;
 my $i=0;
 for(@idxes) {
	next if not $_;
	$vals[$i] = $form->{$_};
 $i++;	
	last if $i>=9; 
 }
 if($design->{usedb}) {
 	$uNa->jHa ([$jRa->[0], $jRa->[1], $jRa->[2], time(), $jRa->[4], $jRa->[5], $jRa->[6]]);
 }else {
 	$uNa->jHa ([$jRa->[0], $jRa->[1], $jRa->[2], time(), $jRa->[4], $jRa->[5], $jRa->[6], @vals]);
 }
 
 sVa::gYaA "Content-type: text/html\n\n";
 print $design->{uRa}? $self->{header} : ($design->{vBa}||"<html><body>");
 my $nav = $self->yMa('submit', $xZa);
 print $nav, qq(<br>);
 print "<center><h1>Thank you!</h1>\nThe following information has been accepted:</center><p>";
 $form->pFa('file', $self->sAa($xZa));
 $form->pFa('ifile', $self->sAa($xZa, 1));
 print $form->form(1);
 print $design->{uRa}? $self->{footer} : ($design->{vTa}||"</body></html>");
 if($input->{_ab_attach2mno} && $self->{jW}) {
	$self->{jW}->dMaA($input->{_ab_attach2mno});
 }
}

sub yJa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $iC = $self->{tmpldir};
 opendir DIR, $iC or error('sys', "Can't open dir $iC: $!"); 
 my @forms = grep /^(.*)\.def$/, readdir DIR;
 close DIR;

 my @fs=();
 my @rows;
 for my $xZa (@forms) {
	$xZa =~ s/\.def$//;
 next if not  -f $self->ySa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->ySa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
	push @fs, [$xZa, $design->{name}];
	push @rows, qq!<input type=radio name=tmpname value="$xZa"> $design->{name} ( $xZa )<br>!;
 
 }
 my $form = aLa->new();
 $form->zNz(['', 'head', "Load from form template"]);
 $form->zNz(['_aefcmd_', 'hidden', '', "", "cDaA"]);
 $form->zNz(['xZa', 'hidden', '', "", $input->{xZa}]);
 $form->zNz(["aeftmpl", 'const', "", "Available forms", join("", @rows)]);
 $form->zQz($self->{cgi});
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $form->form();
 print $self->{footer};
}

sub tDa{
 my ($self, $usrok) = @_;
 return 1 if $self->eVa();
 return 1 if $usrok eq "";
 return sVa::yPa($usrok, $self->{wOa});
}

sub uDa {
 my ($self, $input) = @_;
 my $xZa = $input->{uVa};
 error("inval", "Invalid form id, must be alphanumeric") if $xZa =~ /\W/;
 my $vOa = $self->uFa($xZa, "def");
 my $form = new aLa($xZa);
 $form->cDa($vOa);

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf =$self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);

 error('deny', "Form originating from unauthorized page") 
		if $design->{vQa} && not $ENV{HTTP_REFERER} =~ /$design->{vQa}/; 

 if($design->{vCa}) {
		$self->tHa();
 }

 my $usrok = $self->tDa($design->{allowedusers});
 error('deny', "You are not allowed to submit data")  if not $usrok;

 $form->cOa([split /\W+/, $design->{wJa}], 1);
 my $dupc = $input->{_aef_multi_kc};
 my $idx=0;
 my $acnt=0;
 my @strs;

 my $seqno;

 for(; $idx<$dupc; $idx++) {
 $form->aAa($input, 0, $idx);
 my @miss = $form->cHa();
 if(scalar(@miss) ==1 && $miss[0] eq 'aefpid') {
 if(@miss) {
	next if $idx >0;
 	if($input->{_ab_attach2mno} && $self->{jW}) {
		$form->zNz([_ab_attach2mno=>"hidden", "", "", $input->{_ab_attach2mno}]);
	}
	$self->uIa($xZa, $form, "<center><h2>The data you input was invalid, please make corrections and resubmit</h2>".join("<br>", @miss)."</center>");
	sVa::iUz();
 }
 }

 my $cPz;
 for(values %$input) {
		next if not ref($_) eq 'ARRAY';
		$cPz = $self->sOa($xZa, $_->[0]);
 		error('inval', "Attempt to upload a file that exists") if -f $cPz && not $design->{qDz};
		open(kE, ">$cPz" ) || error($!. ": $cPz");
		binmode kE;
		print kE $_->[1];
		close kE;
 }

 $seqno = sVa::nextseq($self->{iC});
 $form->dNa('aefpid', $seqno);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
#x2
 my $uXa = $self->uFa($xZa, "idx");
 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 my @idxes = split /\W+/, $design->{uSa};
 my @vals = map {undef} 0..9;
 my $i=0;
 for(@idxes) {
	next if not $_;
	$vals[$i] = $form->{$_};
 $i++;	
	last if $i>=9; 
 }
 if($design->{usedb}) {
 	$uNa->iSa([$seqno, $xZa, time(), undef, $self->{wOa}, $ENV{REMOTE_ADDR}, undef]);
 }else {
 	$uNa->iSa([$seqno, $xZa, time(), undef, $self->{wOa}, $ENV{REMOTE_ADDR}, undef, @vals]);
 }
 $acnt ++;
 push @strs, $form->form(1);
 }


 $form->bSa($design->{fullview}||$form->pKa());
 $form->pFa('file', $self->sAa($xZa));
 $form->pFa('ifile', $self->sAa($xZa,1));
 my $cTa= join("", @strs);
 if($design->{notify}) {
 	my %mail;
 $mail{sendmail_cmd} = $abmain::sendmail_cmd if $abmain::use_sendmail;
 $mail{Smtp} = $abmain::smtp_server;
 	$mail{To} = $design->{wN};
 	$mail{From} = $design->{notifier};
 	$mail{Bcc} = $design->{bcc};
 	$mail{Subject} = "Form submission: ".$design->{name};
 	$mail{Body} = "See attached html file for details.";
 	my $e = sVa::mXz(\%mail, time().".html", join("", "<html><body>",  $cTa, "<br/>$ENV{HTTP_REFERER}<p></body></html>"));
 	error('sys', "When sending mail: $e") if $e; 
 }
 if($input->{_ab_attach2mno} && $self->{jW}) {
	$self->{jW}->yGa($input->{_ab_attach2mno}, $xZa, $seqno, $cTa, $design);
	return;
 } 

 sVa::gYaA "Content-type: text/html\n\n";
 my $nav = $self->yMa('submit', $xZa);
 print $design->{uRa}? $self->{header} : ($design->{vBa}||"<html><body>");
 print $nav;
 print "<center><h1>Thank you!</h1>\nThe following information has been accepted:</center><p>";
 print $cTa;
 print $design->{uRa}? $self->{footer} : ($design->{vTa}||"</body></html>");
}
sub rGa{
 my ($self, $xZa, $dataid) = @_;
 my $uXa = $self->uFa($xZa, "idx");

 my $vOa = $self->uFa($xZa, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($xZa, "fmt");
 $design->zOz();
 $design->load($fmtf);
 
 my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 require zGa if $design->{usedb};
 my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 $uNa->jLa([$dataid]);

 my $form = new aLa($xZa);
 $form->cDa($vOa);
 my $wGa = $form->pKa(1);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $xZa);
 $form->rGa($self->rXa($xZa, $dataid),{aefpid=>$dataid} );
}
 

sub rFa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 $self->rGa($input->{uVa}, $input->{idx});
 $self->tCa($input);
}
sub uGa{
 my ($self, $input) = @_;
 $self->sMa($input->{uVa}, $input->{idx});
}

sub sMa {
 my ($self, $id, $dataid) = @_;
 my $vOa = $self->uFa($id, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);

 if($design->{wBa}) {
		$self->tHa();
 }
 my $isadm = $self->eVa();
 if(not ($isadm  || $design->{vAa} || $design->{wBa})) {
 		error("deny", "Access to data is restricted to administrator");
 }

 my $usrok = $self->tDa($design->{allowedreaders});
 my $curusr = lc($self->{wOa});
 if(not $usrok) {
 	my $uXa = $self->uFa($id, "idx");
 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 	my $jKa = $uNa->iQa({noerr=>1, where=>"form_id = '$id' and data_id=$dataid", filter=>sub {return $_[0]->[0] == $dataid;} });
 	error('deny', "You are not allowed to view data")  if ((scalar(@$jKa)<1) || lc($jKa->[0]->[4]) ne $curusr);
 }

 my $form = new aLa($id);
 $form->cDa($vOa);
 my $wGa = $form->pKa(1);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );
 $form->bSa($design->{fullview}||$wGa);
 $form->pFa('file', $self->sAa($id));
 $form->pFa('ifile', $self->sAa($id,1));
 sVa::gYaA "Content-type: text/html\n\n";
 print $design->{uRa}? $self->{header} : ($design->{uOa}||"<html><body>");
 print sVa::tWa();
 my $nav = $self->yMa('didx', $id);
 print $nav, qq(<hr width="100%" noshade><br>);
 print $form->form(1);
 print $design->{uRa}? $self->{footer} : ($design->{uZa}||"</body></html>");
 
}
sub yNa {
 my ($self, $id, $dataid, $mod) = @_;
 my $vOa = $self->uFa($id, "def");

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);
 $form->zOz();
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );
 my $wGa = $form->pKa(1);

 $form->bSa($design->{fullview}||$wGa);
 $form->pFa('file', $self->sAa($id));
 $form->pFa('ifile', $self->sAa($id, 1));
 return $form->form(1);
 
}

sub eAaA{
 my ($self, $input) = @_;
 my $id = $input->{xZa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body><pre>";
 print $form->dCaA($id);
 print "</pre>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'crtable', xZa=>$id}), "<center>Create table</center>");
}

sub eHaA {
 my ($self, $input) = @_;
 my $id = $input->{xZa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->eHaA($id);
 sVa::cTz("Table $id created");
}

sub rHa{
 my ($self, $input) = @_;
 my $isadm = $self->eVa();
 $self->tJa() if not ($isadm || $input->{byusr});
 my $id = $input->{uVa};
 my $dataid = $input->{idx};
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;
 my $vOa = $self->uFa($id, "def");
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);

 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->sRa('usedb', $design->{usedb});
 $form->sRa('bBaA', $id);

 $form->zNz([_aefcmd_=>"hidden", "", "", "modify"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zNz([vMa=>"hidden", "", "", "$dataid"]);
 $form->zQz($self->{cgi});
 $form->load($self->rXa($id, $dataid), undef, {aefpid=>$dataid} );

 my $wGa = $form->pKa();
 if($input->{byusr} && not $isadm) {
 my $uXa = $self->uFa($id, "idx");
 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	require zGa if $design->{usedb};
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});
 my $jRa = $uNa->kCa($dataid);
	my ($did, $xZa, $t, $mt, $kQz) = @$jRa;
 	error("deny", "") if  lc($kQz) ne lc($self->{wOa});
	
 }

 $form->bSa($design->{vNa}||$wGa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 print $form->form();
 print $self->{footer};
} 

sub rZa{
 my ($self, $input) = @_;
 my $id = $input->{uVa};
 $self->uIa($id,undef, undef, $input->{vYa});
} 

sub uIa{
 my ($self, $id, $form, $msg, $vYa, $extras) = @_;
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 if($design->{vCa}) {
		$self->tHa();
 }
 my $usrok = $self->tDa($design->{allowedusers});
 error('deny', "You are not allowed to submit data")  if not $usrok;
 if(not $form) {
 	my $vOa = $self->uFa($id, "def");
 	$form = new aLa($id);
 	$form->cDa($vOa);
 	$form->cOa([split /\W+/, $design->{wJa}], 1);
 }
 $form->zNz([_aefcmd_=>"hidden", "", "", "submit"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zQz($self->{cgi});
 if($extras) {
	for my $k (keys %$extras) {
 		$form->zNz([$k=>"hidden", "", "", $extras->{$k}]);
 }

 }
 my $wGa = $form->aSa();
 $form->bSa($vYa?$wGa:($design->{vNa}||$wGa));
 sVa::gYaA "Content-type: text/html\n\n";
 if($design->{uRa}) {
 	print $self->{header};
 }else {
 	print ($design->{uOa}||"<html><body>");
 }
 my $dupc=1;
 if(not $msg) {
	$dupc = $design->{multientrycnt};
 } 
 $form->sRa('dupcnt', $dupc);
 $form->cGa($design->{required_word});
 print sVa::tWa();
 print $msg;
 print $form->form(0, undef, $msg?1:0);
 print $design->{uRa}? $self->{footer} : ($design->{uZa}||"</body></html>");
} 

sub yOa{
 my ($self, $id, $vYa, $form, $extras) = @_;
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 if($design->{vCa}) {
		$self->tHa();
 }
 my $usrok = $self->tDa($design->{allowedusers});
 error('deny', "You are not allowed to submit data")  if not $usrok;
 if(not $form) {
 	my $vOa = $self->uFa($id, "def");
 	$form = new aLa($id);
 	$form->cDa($vOa);
 	$form->cOa([split /\W+/, $design->{wJa}], 1);
 }
 $form->zNz([_aefcmd_=>"hidden", "", "", "submit"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zQz($self->{cgi});
 if($extras) {
	for my $k (keys %$extras) {
 		$form->zNz([$k=>"hidden", "", "", $extras->{$k}]);
 }

 }
 my $wGa = $form->aSa();
 $form->bSa($vYa?$wGa:($design->{vNa}||$wGa));
 return $form;
} 

sub uEa {
 my ($self, $input) = @_;
 my $xZa = $input->{uVa};
 my $fn = dZz::fIa($input->{vf});
 sVa::iFa($self->sOa($xZa, $fn));
}

sub yUa{
 my ($self, $id) = @_;
 error("inval", "Invalid form id, must be alphanumeric") if $id =~ /\W/;

 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 my $idstr = $design->{frepfids};
 $idstr =~ s/^\s*//;
 $idstr =~ s/\s*$//;
 return split /\s+/, $idstr;
} 

sub tCa {
 my ($self, $input) = @_;
 my $xZa   = $input->{uVa};
 my $isadm = $self->eVa();
 return $self->sSa($isadm, $xZa, $input->{pg});
}

sub tOa{
 my ($self, $input) = @_;
 my $xZa = $input->{uVa};
 my ($bt, $at, $pat);
 my $isadm = $self->eVa();
 $bt = time() - $input->{vHa} *24*3600 if $input->{vHa};
 $at = time() - $input->{vWa} *24*3600 if $input->{vWa};
 my $extract=undef;
 if($input->{extract_fields} ne '') {
		my @fs = split /\s+/, $input->{extract_fields};
		$extract = [@fs];
 }

 return $self->sSa($isadm, $xZa, 'A', $at, $bt, $input->{pat}, 1, lc($input->{sortkey}), $input->{sortorder}, undef, $extract);
}

sub tHa{
	my ($self) = @_;
 if(not $self->{wOa}) {
		$self->tJa();
 }

}
sub sSa {
 my ($self, $isadm, $xZa, $page, $vXa, $vIa, $pat, $detail, $sortkey, $sortorder, $oformat, $extract_fields) = @_;
 	my $vOa = $self->uFa($xZa, "def");
 	my $form = new aLa($xZa);
 	$form->cDa($vOa);
 	my $design = aLa->new("design", \@uBa, $self->{cgi});
 	my $fmtf = $self->uFa($xZa, "fmt");
 	$design->zOz();
 	$design->load($fmtf);
 	my $usrok = $self->tDa($design->{allowedreaders}) || $self->tDa($design->{extraeditors});
 	#error('deny', "You are not allowed to view data")  if not $usrok;
 my $usermod = $design->{modbyuser};
 	my $wGa = $form->aSa();
 	$form->bSa($design->{fullview}||$wGa);
 	$form->pFa('file', $self->sAa($xZa));
 	$form->pFa('ifile', $self->sAa($xZa,1));
	$form->zQz($self->{cgi});

 	$form->sRa('usedb', $design->{usedb});
 	$form->sRa('bBaA', $xZa);

 my @rows;
 my $id;
 	$design->{uSa} =~ s/^\W+//;
 	$design->{uSa} =~ s/\W+$//;
 my $pgsz = $design->{pagesize} || 20;
 	my @idxes = split /\W+/, $design->{uSa};

 if($design->{wBa}) {
		$self->tHa();
 }
 if(not ($isadm  || $usrok || $design->{vAa} || $design->{wBa})) {
 		error("deny", "Access to data is restricted to administrator");
	}
 my $uXa = $self->uFa($xZa, "idx");

 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	require zGa if $design->{usedb};
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});

 my $jKa = $uNa->iQa({noerr=>1});
 my @ids = map { $_->[0] } @$jKa;
 my $tot = @ids;
 my $pgs = int ($tot/$pgsz) + (($tot%$pgsz)?1:0);
 my $sidx = $pgsz * $page;
 my $eidx = $sidx + $pgsz -1;
 $eidx = $tot -1 if $eidx > $tot -1;
 if($page eq 'A') {
		$sidx =0; $eidx = $tot -1;
 }
 my $ix=0; 
 for $ix ( $sidx..$eidx ) {
		my $row = $jKa->[$ix];
 my $t =  $row->[2];
		my $did = $row->[0];
		next if (($vXa && $t < $vXa)  || ($vIa && $t> $vIa));
		my $matched =0;
		$form->load($self->rXa($xZa, $did), undef, {aefpid=>$did});
 if($design->{usedb}) {
			push @$row, @{$form}{@idxes};

 }else {
			my $i =7; 
			for(@idxes) {
				$row->[$i] = $form->{$_};
				$i++;
			}
 }
		if($pat) {
			my @arr = $form->dHa();
			for(@arr) {
				$matched = 1 if $_ =~ /$pat/i;
				last if $matched;
			}
		}
 if ($matched || not $pat) {
 	push @rows, $row;
		}
 }

 my $sortidx=-1;
	my $i=0;
 my @idxfn;
	for (; $i< scalar(@idxes); $i++) {
		if (lc($idxes[$i]) eq lc($sortkey)) {
			$sortidx = $i;
			$sortidx += 7;
 }
		$idxfn[$i] = $form->yIa($idxes[$i]);
	}

	if($sortidx >=0) {
		@rows = sort {$a->[$sortidx] cmp $b->[$sortidx]} @rows ;
		@rows = reverse @rows if $sortorder eq 'd';
	}
 my @rowsb;
	my $curusr = lc($self->{wOa});
 for my $jRa (@rows) {
		my @row;
 my $id = $jRa->[0];
 my $t = $jRa->[2];
 my $mt = $jRa->[3];
 my $kQz = $jRa->[4];
 
		my $uKa= sVa::sTa($self->{cgi}, {_aefcmd_=>'uGa', idx=>$id, uVa=>$xZa});
		my $uMa= "#$id";

		my $umod = "";
 if($curusr eq lc($kQz)) {
 	$umod = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$id, uVa=>$xZa, byusr=>1}), "Modify");
			$kQz = qq(<font color="#cc0000">$kQz</font>);
 }else {
			next if not $usrok;
 }

		if($design->{usedb}) {
			$form->load($self->rXa($xZa, $id), undef, {aefpid=>$id});
		}

		for($i=0; $i<scalar(@idxes); $i++) {
			my $k = $idxes[$i];
			my $v;
			if($design->{usedb}) {
				$v = $form->{$k};
			}else {
				$v = $jRa->[$i+7];
			}
			if($detail) {
 		push @row, sVa::cUz($uMa, $form->rYa($k, $v) );
			}else {
 		push @row, sVa::cUz($uKa, $form->rYa($k, $v) );
 }
 }

		if($usrok || $isadm) {
			push @row, $kQz;
		}

 	push @row, sVa::cUz($uKa, sVa::dU('STD', $t, 'oP'));
 
	        if($isadm) {
 	push @row, 
 	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"rFa", idx=>$id, uVa=>$xZa}), "Delete").
 	"  ".sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$id, uVa=>$xZa}), "Modify");
 }else {
			push @row, $umod;
		}

 push @rowsb, [@row];
 }

	sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('didx', $xZa);
 	print $nav, qq(<br>);

 	print qq(<div class="pagelist">Page );
 for ( $i=0; $i < $pgs; $i++) {
 my $p = $i+1;
 	if ($i ne $page) {
 		print sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$xZa, pg=>$i}), $p), " \&nbsp";
 }else {
			print "<font color=red><b>$p</b></font>";
 }
 }
 	print qq(</div>);
 if(@rowsb) {
 	        print qq(<div align="center"><b>), "Showing ",  scalar(@rowsb), qq( entries.</b>);
		if($vIa || $vXa || $pat) {
			print "<br>";
			if($vXa){
				print sVa::dU("SHORT", $vXa, "oP"), "--";
			}
			if($vIa){
				print sVa::dU("SHORT", $vIa, "oP"), "--";
			}
			if($pat) {
				print "Match pattern: $pat";
			}
		}
		print "</div>";
		if( $usrok || $isadm) {
 		print sVa::fMa(
 				ths=>[map{ qq(<font color="white">$_</font>) } (@idxfn, "User", "Time", "" )],
 		rows=>\@rowsb, sVa::oVa($tabattr));
		}else {
 		print sVa::fMa(
 				ths=>[map{ qq(<font color="white">$_</font>) } (@idxfn, "Time", "" )],
 		rows=>\@rowsb, sVa::oVa($tabattr));
		}

 }else {

 	print "<center>No data found</center>";
 }
 my $sf= aLa->new("find", \@vVa, $self->{cgi});
	#$sf->sRa('flat', 1);
	$sf->dNa('uVa',$xZa);
	$sf->aCa([sortkey=> "select", "=----\n".join("\n", map {lc($_)."=$_"} @idxes), "Sort by", $sortkey]); 
	$sf->dNa('sortorder',$sortorder);
	print "<center>", $sf->form(), "</center>";
	if($detail) {
		print "<p><pre>\n";
 	for my $idx (@rows) {
			my ($id, $t) = @$idx;
			$form->load($self->rXa($xZa, $id), undef, {aefpid=>$id});
			print qq(<a name="$id"><br>);
			if(scalar(@$extract_fields)>0) {	
				print join("\t", @{$form}{@$extract_fields}), "\n";
				
			}else {
				print $form->form(1);
			}
		}
		print "</pre>";
	}
 print $self->{footer};			
}

sub uJa{
 my ($self, $id) = @_;
 my @links=();
 my $isadm = $self->eVa();
 my (@wNa, @forms, @usrs);
 if($isadm) {
 if($id) {
 	push @wNa,
 	['def', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'wLa', uVa=>$id}), "Define form")],
 	['conf', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uBa', uVa=>$id}), "Configure form")], 
 	['defview', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), "Default view")];
 }else {
 	push @wNa,
 	['', sVa::cUz(
		sVa::sTa($self->{cgi}, {_aefcmd_=>"uYa", uWa=>"lXa"}), "Create New Form")];
 }
 }
 if($id) {
 push @forms,
 	['submit',sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}), "Form Submission")], 
 	['didx', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}), "Data index")];
 }
 push @usrs,
 	['allforms', sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'wIa'}), "All forms")], 
 	['main', sVa::cUz($self->{uQa}, "Main page")];
 push @usrs, ['logout', $self->{vSa}." ($self->{wOa})"] if $self->{wOa};
 push @usrs, ['login', sVa::cUz($self->{wCa}, "Login") ] if not $self->{wOa};
 return (@forms, @wNa, @usrs);
}

sub tBa {
 my ($self, $input) = @_;
 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zNz([_aefcmd_=>"hidden", "", "", "submit"]);
 $form->zNz([uVa=>"hidden", "", "", "$id"]);
 $form->zQz($dLz);
 my $wGa = $form->aSa();
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 $form->bSa($design->{vNa}||$wGa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('', $id);
 print $nav, qq(<br>);
 print qq(<h1>Publish the form $design->{name}</h1>);
 print qq(<h2>Direct link to rNa</h2>);
 print "<ul>";
 print "<li> Use custom design: ",sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id}) ), 
 "</li>";
 print "<li> Use default design: ",
 sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}) ), 
 "</li>";

 print "</ul>";
 print "If you see missing fields in the custom design, you must edit the form template to include them";

 print qq(<h2>Form HTML which can be copied and pasted to a web page</h2>);
 my $cTa=$form->form();
 $cTa =~ s/</&lt;/g;
 print qq(<form><textarea rows="16" cols="70">), $cTa, qq(</textarea></form>);
 print qq(<h2>Link for viewing submitted data</h2>);
 print sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}), 
 		                        sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$id}) );

 print qq(<br><hr width="90%" noshade><br>);
 
 print $self->{footer};
} 
sub sAa{
 my ($self, $xZa, $inline) = @_;
 return sub {
	my $file = shift;
 	my $cTa = sVa::rOa($file);
 	my $url = sVa::sTa($self->{cgi_full}, {_aefcmd_=>"retr", uVa=>$xZa, vf=>$cTa});
	if($inline) {
		my $lRa = sVa::fIaA($file);
		if($lRa =~ /image/) {
			return qq(<img src="$url" alt="$file">);
		}
	}
 	return sVa::cUz($url, $file);
 }
}

sub sGa{
 my ($self, $input) = @_;
 my $af = new aLa("vUa", \@uBa, $self->{cgi});
 $af->aAa($input);
 $af->{vNa} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 $af->{fullview} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 $af->{vFa} =~ s/<_COMMAND_>/{_COMMAND_}/g;
 my $id = $af->{uVa};
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if $id =~ /\W/ || not $id;

 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->aSa();
 my $uPa = $form->pKa(1);

 $af->{vNa} = "" if $af->{vNa} eq  $form->{zKz}->{wGa};
 $af->{fullview} = "" if $af->{fullview} eq $uPa;
 $af->{vFa} = "" if $af->{vFa} eq $uPa;
 

 my $fmtf = $self->uFa($id, "fmt");
 $af->store($fmtf);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 my $nav = $self->yMa('conf', $id);
 print $nav, 
 qq(<br>);
 print "<center><h1>The following settings have benn stored</h1></center>";
 print $af->form(1);
 print qq(<hr width="90%" noshade><br>), $nav;
 print $self->{footer};
 $self->tIa();
}

sub yMa {
	my ($self, $pos, $xZa) = @_;
	my @links = $self->uJa($xZa);
	my $str = qq(<div class="bHa">);
	$str .= qq(<table cellpadding=3 style="font-size: 14px; font-family: Arial" class="FormMagicNavBar">);
	$str .="<tr>";
	for my $lnk (@links) {
		my ($k, $l) = @$lnk;
		my $bg ="#dddddd";
		if( $k eq $pos) {
			$bg = qq("#6699cc");
		}
		$str .= qq(<td onmouseover="this.bgColor='#99ccff'" onmouseout="this.bgColor='#dddddd'" bgcolor=$bg>$l</td>);
	}
	$str .="</tr></table></div>";
	return $str;
	
}

sub tAa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my ($id, $fldid) = ($input->{uVa}, $input->{xZa});
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if $id =~ /\W/ || not $id;
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 my $f = $form->jOa($fldid);
 error('inval', "Field $fldid not found") if not $f;
 my $af = new aLa("vZa", \@wFa, $self->{cgi});
 $af->dNa("wEa", $f->[0]);
 $af->dNa("uLa", $f->[1]);
 $af->dNa("vKa", $f->[2]);
 $af->dNa("vRa", $f->[3]);
 $af->dNa("vDa", $f->[4]);
 $af->dNa("fieldverifier", $f->[5]);
 $af->dNa("fieldrequired", $f->[6]);
 $af->dNa("fielddbtype", $f->[7]);
 $af->dNa("fieldsizemax", $f->[8]);
 $af->dNa("fieldidxtype", $f->[9]);
 $af->dNa('wAa', $fldid);
 $af->dNa('uVa', $id);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print $af->form();
 print $self->{footer};
}
sub yYa{
 my ($self, $input) = @_;
 my $tn = $input->{tmpname};
 my $xZa = $input->{xZa};
 error("miss", "No template selected")  if $tn eq "";
 error("inval", "No form selected")  if $xZa eq "";
 my $def = $self->ySa($tn, "def");
 my $fmt = $self->ySa($tn, "fmt");
 my $mydef = $self->uFa($xZa, "def");
 my $myfmt = $self->uFa($xZa, "fmt");
 sVa::rSa($def, $mydef);
 sVa::rSa($fmt, $myfmt);
 $self->rVa($xZa);
}

sub tMa {
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();

 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zQz($self->{cgi});

 my $af = new aLa("vZa", \@wFa, $self->{cgi});
 my $dupc = $input->{_aef_multi_kc};
 my $idx=0;
 $af->iEa("wEa", \&bAa::be_id);
 $af->iEa("uLa", \&bAa::be_set);
 for(;$idx <$dupc; $idx++) {
 $af->aAa($input, 0, $idx);
 error("inval", "Invalid form id $input->{uVa}, must be alphanumeric") if  ($idx==0 && not rJa($id) );
 error("inval", "Invalid form id, must start with a letter") if  $id !~ /^[a-z_]/i;
 my @miss = $af->cHa();
 if(@miss) {
	next if ($idx >0);
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->{header};
	print $af->form(0, undef, 1);
	print $self->{footer};
	sVa::iUz();
 }
 my $nfe = [$af->{wEa}, $af->{uLa}, 
		$af->{vKa}, $af->{vRa}, $af->{vDa},
		$af->{fieldverifier}, $af->{fieldrequired}, $af->{fielddbtype}, $af->{fieldsizemax}, $af->{fieldidxtype} ];
 if($af->{wAa} && $af->{wAa} ne $af->{wEa}) {
		$form->gGa($af->{wAa});
 }
 if($af->{wAa} eq $af->{wEa}) {
	$form->aCa($nfe);
 }else {
 if ($form->jOa($af->{wEa})) {
 my $ef = bAa::wKa("There is already a field with the same name. Field name must be unique.");
	  $af->iEa("wEa", $ef);
	  sVa::gYaA "Content-type: text/html\n\n";
	  print "<html><body>";
	  print $af->form(0, undef, 1);
	  sVa::iUz();
 }
 if($input->{beforeid} eq '') {	
 		$form->zNz($nfe);
	}else {
 		$form->add_field_before($input->{beforeid}, $nfe);
	}
 }
 }
 $form->cCa($vOa);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();

 my $nav = $self->yMa('def', $id);
 print $nav, qq(<br>);
 $af->aCa(["vJa", "head", "Added form element"]);
 print "<center>Added form element</center>";
 print $self->dPaA($id);
 my $nform = new aLa("wHa", \@wFa, $self->{cgi});
 $nform->aCa(["vJa", "head", "Add another form element"]);
 $nform->dNa("uVa", $id);

 $nform->sRa('dupcnt', 3);
 print $nform->form();
 print "</center>";
 print $self->{footer};
}

sub uAa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $id = $input->{uVa};
 error('inval', "Can't delete primary key") if $input->{xZa} eq 'aefpid';	
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->zQz($self->{cgi});
 $form->gGa($input->{xZa});
 $form->cCa($vOa);
 $self->rVa($id);
}

sub uBa{
 my ($self, $input) = @_;
 $self->tJa() if not $self->eVa();
 my $id = $input->{uVa};
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 $form->aSa();
 my $design = aLa->new("design", \@uBa, $self->{cgi});
 my $fmtf = $self->uFa($id, "fmt");
 $design->zOz();
 $design->load($fmtf);
 $form->{zKz}->{wGa} =~ s/{_COMMAND_}/<_COMMAND_>/g;
 my $uPa = $form->pKa(1);
 $design->dNa('fields', join("\&nbsp; ", map{ qq(<b><font size="+1">$_</font></b>) } $form->fXa()));
 $design->dNa('vLa', $form->{zKz}->{wGa});
 $design->dNa('vPa', $uPa);
 $design->dNa('uVa', $id);
 $design->dNa('_aefcmd_', 'vUa');
 my @fids = $self->yVa();
 my $sel = join("\n", map { $_->[0].'='.$_->[1] } @fids);
 $design->aCa([frepfids=>"checkbox", $sel, "Allowed forms for reply. The selected forms can be used to reply to a message with this form attached."]);
 sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 my $nav = $self->yMa('conf', $id);
 print $nav,
 qq(<br>);
 print sVa::tWa();
 $design->sRa('pvhtml', 1);
 print $design->form();
 print $self->{footer};

}

sub dPaA {
 my ($self, $id, $capt) = @_;
 my $vOa = $self->uFa($id, "def");
 my $form = new aLa($id);
 $form->cDa($vOa);
 my $aJa = $form->{zKz};

 my ($p, $k, $i);
 my $zDz;

 $i =1;
 my @rows;
 foreach $p (@{$aJa->{jF}}) {
 next if not $p;
 next if $p->[1] eq 'skip';
		if($p->[1] eq 'head') {
 			my $h = $p->[2];
 push @rows, [$p->[0], "Form heading", $h, 
 sVa::cUz(sVa::sTa($self->{cgi}, { _aefcmd_=>'delfield', uVa=>$id, xZa=>$p->[0]}), "Delete").'&nbsp;&nbsp; '.
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'modfield', uVa=>$id, xZa=>$p->[0]}), "Modify")
 ];
 			next;
		}
 my $ele= $aJa->{bLa}->{$p->[0]};
		next if not $ele;
		my ($k, $t, $d) =  @{$ele}{qw(name type desc)};
 if (not $d) {
 $d = $k;
 $d =~ s/_/ /g;
 $d = ucfirst($d);
 }
 push @rows, [$k, $d, $ele->aYa, 
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'delfield', uVa=>$id, xZa=>$p->[0]}), "Delete").'&nbsp;&nbsp; '.
 		     sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'cCaA', uVa=>$id, beforeid=>$p->[0]} ), "Insert before"). " ".
 sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'modfield', uVa=>$id, xZa=>$p->[0]}), "Modify")
 ];
	}
 if(@rows) {
 		return sVa::fMa(ths=>[map{ qq(<font color="white">$_</font>) } ("Field name", "Description", "HTML", "Commands" )], rows=>\@rows, sVa::oVa($tabattr), capt=>$capt);
 }
 	return;
 
}

sub rVa{
 my ($self, $id) = @_;
 sVa::gYaA "Content-type: text/html\n\n";
	print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('def', $id);
 print $nav, qq(<br>);
 
	print qq(<blockquote><h2>Step 1: Define form elements</h2>);
 print qq(<br>In this step, you add form elements to the form.</blockquote>); 

 my @cmds =();
 my $addel =  sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'cCaA', uVa=>$id}), "Add a field to the form");
 my $loadtl = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'bSaA', xZa=>$id}), "Load from form template");
 push @cmds, $addel, $loadtl;
 push @cmds,  sVa::hFa(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'uYa', uVa=>$id, vYa=>1}), "Preview form", "fv"); 
 push @cmds, sVa::hFa(sVa::sTa($self->{cgi}, {_aefcmd_=>'crsql', xZa=>$id}), "Show table SQL", "sql");
	
	my $cmdstr = join(" | ", @cmds);
 my $fadm = $self->dPaA($id, $cmdstr);

 if($fadm) {
 		print $fadm;
 }else {
		print qq(<center>The form is empty, click on the link below to add fields to it</center><br/>);
		print "<li>$addel";
		print "<li>$loadtl";
		
 }

	print "<p><p><hr width=90% noshade/>";
	print "<blockquote>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"uBa", uVa=>$id}), "<h3>Step 2. Configure the form</h3>");
 print qq(<blockquote>After finished adding fields to the form in step 1, you set various properties for the form, such as setting up required fields, notification email address and layout the form page.</blockquote>); 
	print "</blockquote>";
	print "<hr width=90% noshade/>";
	print "<blockquote>";
 print sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>'vGa', uVa=>$id}), "<h3>Step 3. Publish the form</h3>");
 print qq(<blockquote>This page provides the instructions on how to publish the form.</blockquote>); 
	print "</blockquote>";
 
	print $self->{footer};
}
 
sub eVa{
 my ($self) = @_;
 return $self->{uTa} && ( $self->{uTa} eq  $self->{wOa});
}

sub tSa{
 my ($self) = @_;
 return $self->{wOa};

}

sub tJa{
	my ($self) = @_;
	print "Location: $self->{wCa}\n\n";
	sVa::iUz();
}

1;

package zGa;
use jFa;
use zDa;
use strict;

BEGIN{
	@zGa::ISA= qw(jFa);
};
#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub new {
 my ($type, $realm, $opts) = @_;
 my $self = bless {}, $type;
 if($opts->{paths}) {
 	($self->{realm}, $self->{srealm} ) = @{$opts->{paths}}; 
 }else {
 	($self->{realm}, $self->{srealm} ) = sVa::zHa($realm, $opts->{base});
 }
 $self->{index} = $opts->{index} || 0;
 $self->{jMa} = $opts->{jMa};
 $self->{cmp} = $self->{jMa}? undef: sub {return $_[0] <=> $_[1];} ;
 $self->{_dbobj}= zDa->new($opts->{schema});
 return $self;
}
sub pXa{
	my ($self) = @_;
	my $dbo = $self->{_dbobj};
 my $cnt = $dbo->aCaA("where realm=? and srealm =?", [$self->{realm}, $self->{srealm}]);
	return $cnt;
}

sub kEa{
 my ($self, $rowrefs, $opts, $clear) =@_;
 my $res;
 my $dbo = $self->{_dbobj};
 if($clear) {
	$dbo->sHa("where realm=? and srealm=?", [$self->{realm}, $self->{srealm}]);
 }
 my $col_cnt = scalar(@{$dbo->bFaA()});
 for my $jRa (@$rowrefs) {
	next if not ref($jRa) eq 'ARRAY';
	if(scalar(@$jRa) < $col_cnt -2)  {
	     my $dc = $col_cnt -2 - scalar(@$jRa);
	     push @$jRa, map { undef} (1..$dc); 
	}
	push @$jRa, $self->{realm};
	push @$jRa, $self->{srealm};
	$dbo->bIaA($jRa);
 }
 1;
}

sub kCa {
 my ($self, $id) = @_;
 my $index = $self->{index};
 my $dbo = $self->{_dbobj};
 my $row;
 my $cnt=0;
 my $idxcol = $dbo->aDaA($index);
 my $allrows = $dbo->aYaA("where realm =? and srealm=? and $idxcol = ?", [$self->{realm}, $self->{srealm}, $id]);
 $row = $allrows? $allrows->[0] : undef;
 if($row) {
	pop @$row;
	pop @$row;
 }
 return $row;

}
 
sub iQa{
 my ($self, $opts) =@_;
 my $index = $self->{index};
 my $dbo = $self->{_dbobj};
 my $rows=[];
 my $filter = $opts->{filter};
 my $where = $opts->{where} || "";
 $where = "and $where"  if $where;
 my $row;
 my $cnt=0;
 my $filtcnt=0;
 my $max = $opts->{maxret}||0;
 my $sidx = $opts->{sidx};
 my $eidx = $opts->{eidx};
 my $idx=0;
 my $wantstr = $opts->{getstr};
 local $_;
 my $idxcol = $dbo->aDaA($index);
 my $no_srealm = $opts->{nosr};
 my $allrows;
 if($no_srealm) {
 	$allrows = $dbo->aYaA("where realm =? $where order by $idxcol", [$self->{realm}]);
 }else {
 	$allrows = $dbo->aYaA("where realm =? and srealm =? $where order by $idxcol", [$self->{realm}, $self->{srealm}]);
 }
 for my $row (@$allrows){
 $idx ++;
	next if ($sidx && $idx <$sidx+1);
	last if ($eidx && $idx >$eidx);
	if ($filter && not &$filter($row, $idx)) {
 $filtcnt ++;
	     next;
 }
	pop @$row;
	pop @$row;
 if($wantstr) {
		push @$rows, join("\t", @$row);
 }else {
		push @$rows, $row;
 }
	$cnt ++;
 last if $max >0 && $cnt > $max;
 }
 return wantarray? ($rows, $cnt, $filtcnt) : $rows;
}

sub jXa{
 my ($self, $rowrefs) =@_;
 my $dbo = $self->{_dbobj};
 my $index = $self->{index};
 my $idxcol = $dbo->aDaA($index);
 for my $row (@$rowrefs) {
	push @$row, $self->{realm};
	push @$row, $self->{srealm};
	if($dbo->aPaA("where realm =? and srealm=? and $idxcol=?", [$self->{realm}, $self->{srealm}, $row->[$index]])) { 
		$dbo->aZaA($row, "where realm =? and srealm=? and $idxcol=?", [$self->{realm}, $self->{srealm}, $row->[$index]]);
	}else {
		$dbo->bIaA($row);
	}
 }
}

sub jLa{
 my ($self, $ids, $opts, $clear) =@_;

 my $dbo = $self->{_dbobj};
 my $index = $self->{index};
 if($clear) {
	$dbo->sHa("where realm=? and srealm=?", [$self->{realm}, $self->{srealm}]);
	return;
 }
 my $idxcol = $dbo->aDaA($index);
 for(@$ids) {
	$dbo->sHa("where realm=? and srealm=? and $idxcol =?", [$self->{realm}, $self->{srealm}, $_]);
 }
 return scalar(@$ids);
 
}
1;
package zKa;
use DBI;
use strict;
use vars qw($dbdsn $dbuser $dbpassword);

=item
$dbdsn= "DBI:mysql:database=ut;host=localhost";
$dbuser = "ut";
$dbpassword = "ut1";
=cut
#DBI->trace(1, "/tmp/db.log");

sub new {
	my $type = shift;
 my ($dsn) = @_;
	my $self = bless {dsn=>$dsn}, $type;
	$self->{connected}=0;
	return $self;
}

sub DESTROY {
	my ($self) = @_;
	$self->disconnect();
}

sub connect {
 my ($self, $dsrc) = @_;

 if ($dsrc && (ref $dsrc)) {
 $self->{dsrc} = $dsrc;
 $self->{connected}=1;
 return $self->{dsrc};
 }

 $self->{dsrc} = DBI->connect(
			$dbdsn, $dbuser, $dbpassword,
				{RaiseError =>1, PrintError=>0}
 );

 if(not $self->{dsrc}) {
 }
 $self->{connected}=1;
 $self->{ping_time} = time();
 $self->{auto_reconnect}= $self->{dsrc}->{mysql_auto_reconnect};
 return $self->{dsrc};
}

sub ping {
 my $self = shift;
 return $self->{dsrc}->ping() if $self->{dsrc};
}

sub disconnect {
 my $self = shift;
 $self->dsrc->disconnect() if $self->dsrc();
 $self->{connected}=0;
 $self->{dsrc}=undef;
}

sub connected{
 my $self = shift;
 return $self->{connected};
}

sub commit{
 my $self = shift;
 $self->dsrc->commit();

}

sub rollback{
 my $self = shift;
 $self->dsrc->rollback();

}
sub dsrc{
	my $self =shift;
	my $t = time();
	if($t- $self->{ping_time} > 300) {
		$self->ping();
		$self->{ping_time} = $t;
	}
	return $self->{dsrc};
}

sub getDataSources {
	my @drivers = DBI->available_drivers();
	my $dshash={};
	for my $dr (@drivers) {
		eval {
			my @dss = DBI->data_sources($dr);
			$dshash->{$dr} = [@dss];
		};
	}
	return $dshash;
}

=item

my $dh = getDataSources();
for my $k (keys %$dh) {
	print $k, "\n";;
	print join(" ", @{$dh->{$k}});
}

my $dbh = zKa->new();
$dbh->connect();
=cut
1;
package zDa;
use Object;
use strict;
use zKa;
use aLa;
use File::Path; 

@zDa::ISA=qw(Object);

use vars qw(%tab_desc %sqls $tb_val_sets $global_val_sets %_sql_procs %precision_desc %nullable_desc);

sub aMaA{
 if( not $zDa::dbh){
 $zDa::dbh = zKa->new();
 $zDa::dbh->connect();
 }
 return $zDa::dbh;
}

END {
 if($zDa::dbh){
	$zDa::dbh->disconnect();
 }

}
sub DESTROY {
 my $self = shift;
 #aGaA();
 if($self->{_kill0}) {
	$self->{aHaA}->disconnect();
 }
 $self->{aHaA} = undef;
 $self->{_dbh} = undef;
	
}

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO 1;
#IF_AUTO __END__

sub new {
 my $type = shift;
 my ($bBaA, $pers, $fieldarr) = @_;
 my $self = {};
 if($pers ) {
	    $self->{aHaA} =  $pers;
 }else {
	    $self->{aHaA} =  aMaA();
	    $self->{_kill0} = 0;
 }
	
 $self->{aHaA}->connect($self->{aHaA}->dsrc)
 if not $self->{aHaA}->connected();
 $self->{_dbh} = $self->{aHaA}->dsrc();
 $self->{_dbh}->{LongReadLen} = 512*1024;
 bless $self, $type;

 return $self if($bBaA eq "");

 $self->{tb} = $bBaA;
 if ($self->{_dbh} && not $fieldarr) {
	#print STDERR "caller = ", caller, "\n";
 	$fieldarr = $self->bFaA($bBaA);
 }
 $self->{fields} = $fieldarr;
 for(@$fieldarr) {
 $self->{$_} = undef;
 }
 # zQa();
 return $self;
}
sub dbh{
 my ($self) = @_;
 return $self->{aHaA};
}

sub aCa{
 my ($self, $field, $val) = @_;
 $self->{$field} = $val;
}

sub aDaA{
 my ($self, $idx) = @_;
 return $self->{fields}->[$idx];
}

sub aEaA{
 my ($self, $fields, $vals) = @_;
 $fields = $self->{fields} if not $fields;
 @$self{@$fields} = @$vals;
}

sub aTaA{
 my ($self, $fieldshash) = @_;
 my $k;
 for(keys %$fieldshash) {
 $k = lc($_);
 next if not exists $self->{$k};
 $self->{$k} = $fieldshash->{$_};
 }
}

#if seqname is undef, then use {table_name}_seq

sub aOaA{
 my ($self, $seqname) = @_;
 my $_dbh= $self->{_dbh};
 $seqname="$self->{tb}_seq" if not $seqname;
 my $tag = "getseq_$self->{tb}";
 
 if(not $self->{_res}->{$tag}) {
 	my $stmt = "select $seqname.nextval from dual";
 	$sqls{$stmt} = $tag;
 	my $sth = $_dbh->prepare_cached($stmt);
 	$sth->execute();
 	my @row = $sth->fetchrow_array;
 	$sth->finish();
 	return $row[0];
 }
}

sub bKaA{
 my ($self, $sql, @binds) = @_;
 my $_dbh= $self->{_dbh};
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@binds);
 my @row = $sth->fetchrow_array;
 $sth->finish();
 return $row[0];
}

sub aRaA{
 my ($self, $sql, @binds) = @_;
 my $_dbh= $self->{_dbh};
 $_dbh->do($sql, undef, @binds);
}

sub commit{
 my ($self) = @_;
 my $_dbh= $self->{_dbh};
 $_dbh->commit();

}
sub rollback{
 my ($self) = @_;
 my $_dbh= $self->{_dbh};
 $_dbh->rollback();

}

sub bGaA{
 my ($self, $seqname, $rec) = @_;
 return if $rec && $rec >1;
 my $_dbh= $self->{_dbh};
 $seqname="$self->{tb}_seq" if not $seqname;
 my @row;
 if($_dbh->do("UPDATE sequence_counters set seqno= LAST_INSERT_ID(seqno+1) where name = ?", undef, $seqname) != 0) {
 	my $sth = $_dbh->prepare_cached("SELECT LAST_INSERT_ID()");
 	$sth->execute();
 	@row = $sth->fetchrow_array;
 	$sth->finish();
 }
 if((not @row) || $row[0] <=0) {
 	$_dbh->do("INSERT INTO sequence_counters (seqno, name) values(1, ?)", undef, $seqname);
	return $self->bGaA($seqname, $rec++);
 }
 return $row[0];
}

sub nextSeq{
 return bGaA(@_);
}

sub bFaA {
 my ($self, $tb) = @_;
 my $_dbh = $self->{_dbh};
 $tb = $self->{tb} if not $tb;
 return $tab_desc{$tb} if $tab_desc{$tb};
 my $stmt = "select * from $tb where 0=1";
 my $sth = $_dbh->prepare_cached($stmt);
 $sth->execute();
 $tab_desc{$tb} = [map{lc($_)}@{$sth->{NAME}}];
 $precision_desc{$tb} = [@{$sth->{PRECISION}}];
 $nullable_desc{$tb} = [@{$sth->{NULLABLE}}];
 $sth->finish();
 return $tab_desc{$tb};
	
}

sub bLaA{
 my ($self, $maxsize, $skips, $includes) = @_;
 my $tb = $self->{tb} ;
 my $len = @{$tab_desc{$tb}};
 my @fs=();
 for( my $i=0; $i<$len; $i++) {
	my ($field, $prec, $null) = ($tab_desc{$tb}->[$i], $precision_desc{$tb}->[$i], $nullable_desc{$tb}->[$i]); 
	next if ($skips && $skips->{$field});
	next if $maxsize>0 && $prec > $maxsize;
	push @fs, $field ;
 }
 return @fs;

}

sub bNaA{
 my ($self, $id, $maxsize) = @_;
 my $fields = undef;
 if(defined($maxsize)) {
 $fields = [ $self->bLaA($maxsize)];
 }
 my $t = ref $self;
 my $cD;
	if($t eq 'zDa') {
 	$cD  = $t->new($self->{tb}, $self->{aHaA});
	}else {
 	$cD  = $t->new($self->{aHaA});
 }
 return $cD->aPaA("where id=?", [$id], $fields)?$cD:undef;
}
sub yDz{
	my ($str, $len) = @_;
 my $abs = substr($str, 0, $len);
 $abs =~ s/\s+\S+$//;
	$abs .= "..." if $len < length($str);
 return $abs;
}

sub bCa{
 my ($self) = @_;
 my $str = $self->{tb}.":\n";
 for(@{$self->{fields}}) {
	$str .= $_."=$self->{$_}\t";
 }
 $str;
}

sub aWaA{
 my $where= shift;
 $where = lc($where);
 $where =~ s/where/_by/gi;
 $where =~ s/(\s|=|\?)+/_/g;
 $where =~ s/_+$//g;
 return $where;
}

sub nsp{
 my $str = shift;
 $str =~ s/\s+/ /g;
 $str =~ s/^\s+//;
 $str =~ s/\s+$//;
 return $str;
}

sub aGaA {
 my @gHz;
 push @gHz,"%zDa::_sql_procs= (\n";
 for(my ($sql, $k) = each %zDa::sqls) {
 if($_sql_procs{$k} && nsp($_sql_procs{$k}) ne nsp($sql) ) {
 $k.="_1";
 } 
 next if $k !~ /\w/;
 $_sql_procs{$k} = $sql;
 }
 for (sort keys %_sql_procs) {
 next if $_ !~ /\w/;
 push @gHz, $_, "=> \nq{";
 push @gHz, $_sql_procs{$_};
 push @gHz, "},\n\n";
 }
 push @gHz, "\n);\n";
 open DF, ">/tmp/bill2.pl";
 print DF @gHz;
 close DF;
 chmod 0777, "/tmp/bill2.pl"; 
}

sub zQa {
 do "/tmp/bill2.pl" if -f "/tmp/bill2.pl";
 unlink "/tmp/bill2.pl";
 unlink "/tmp/bill.pl";
 for(my ($k, $v) = each %_sql_procs) {
 $sqls{$v} = $k;
 }
}
sub aFaA{
 my ($self, $where, $tag) = @_;
 return  aNaA($self, $self->{fields}, $where, $tag);
}

sub aNaA {
 my ($self, $fieldsref, $where, $tag)=@_;
 my $stmt;
 $stmt = "select ". join (",\n", map{ (defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1: $_} @{$fieldsref});
 $stmt .= "\nfrom $self->{tb} \n$where";
 $sqls{$stmt}= $tag || "fetch_$self->{tb}".aWaA($where);
 #   print STDERR $stmt, "\n";
 return $stmt;
}
sub aVaA {
 my ($self, $fieldsref, $where, $kvhash, $tag)=@_;
 my $stmt = "update $self->{tb}\n";
 my $cnt = @{$fieldsref};
 my $k;
 $kvhash = $self if not $kvhash;
 for(my $i=0; $i<$cnt; $i++) {
 $stmt .= "set " if $i==0;
 $k = $fieldsref->[$i];
	if($kvhash->{$k} =~ /^sqlfunc:(.*)/i) {
		$stmt .="$k = $1";
	}else {
		$stmt .= "$k = ?";
 }
 $stmt .=",\n" unless $i == $cnt-1;
 }
 $stmt .= "\n$where";
 $sqls{$stmt} = $tag ||"update_$self->{tb}_".join("_", map {lc($_)} @$fieldsref )."_".aWaA($where);
 #   print STDERR $stmt,"\n";
 return $stmt;
}

sub bJaA{
 my $t = shift;
 $t = time() if not $t;
 my @tms = localtime($t);
 my $mon_year=join("", sprintf("%02d", $tms[4]+1), 1900+$tms[5]);
 my $day = $tms[3];
 return wantarray? ($mon_year, $day) : $mon_year;
}
 
sub aQaA {
 my ($self, $where, $tag)=@_;
 my $stmt="delete from $self->{tb} $where";
 $sqls{$stmt}= $tag || "delete_$self->{tb}".aWaA($where);
 return $stmt;
}

sub bAaA{
 my ($t, $len) = @_;
 $t = time() if not $t;
 my @tms = localtime($t);
 my $str = sprintf("%04d%02d%02d%02d%02d%02d", 1900+$tms[5], $tms[4]+1, $tms[3], $tms[2], $tms[1], $tms[0]);
	return substr($str, 0, $len) if $len;
	return $str;
}

sub aKaA{
	my $str = shift;
 $str =~ /(\d\d\d\d)(\d\d)(\d\d)(\d\d)(\d\d)(\d\d)/;
	my ($y, $m, $d, $h, $min, $sec) = ($1, $2, $3, $4, $5, $6);
	return "$y-$m-$d, $h:$min:$sec";
}
 
sub clone {
 my $self = shift;
 my $nobj = $self->SUPER::clone();
 $nobj->{aHaA} = $self->{aHaA};
 $nobj->{_dbh} = $self->{_dbh};
 return $nobj;
}
	
sub bHaA{
 my ($self, $tag) = @_;
 my $stmt = "insert into $self->{tb}\n(\n". join (",\n  ", @{$self->{fields}});
 $stmt .= "\n)\nvalues (\n" .join(",\n", 
 map {(defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1 : '  ?'} @{$self->{fields}});
 $stmt .= ")";
 $sqls{$stmt} = $tag || "insert_$self->{tb}";
 return $stmt;
}
	
sub bDaA{
 my ($self, $tag) = @_;
 my $stmt = "insert into $self->{tb}";
 $stmt .= "\nvalues (\n" .join(",\n", 
 map {(defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1 : '  ?'} @{$self->{fields}});
 $stmt .= ")";
 $sqls{$stmt} = $tag || "insert_$self->{tb}";
 return $stmt;
}

sub aPaA{
 my ($self, $where, $params, $fieldsref, $tag) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aNaA($fieldsref, $where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $rowhashref =  $sth->fetchrow_hashref;
 $sth->finish();
 $self->aTaA($rowhashref) if ref($rowhashref) eq 'HASH';
 return ref($rowhashref) eq 'HASH'? $rowhashref: undef; 
}

sub eQaA {
 my ($self, $hashref, $fieldsref) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my $stmt = "select ". join (",\n", map{ (defined $self->{$_}) && $self->{$_} =~ /^sqlfunc:(.*)/i ? $1: $_} @{$fieldsref});
 $stmt .= "\nfrom $self->{tb} \n";
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $stmt .= " where $where" if $where;
 print STDERR $stmt, "\n";
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($stmt);
 $sth->execute(@{$hashref}{@bindvarrs});
 my $rowhashref =  $sth->fetchrow_hashref;
 $sth->finish();
 $self->aTaA($rowhashref) if ref($rowhashref) eq 'HASH';
 return ref($rowhashref) eq 'HASH'? $rowhashref: undef; 
}
 

sub bMaA{
 my ($self, $where, $params, $tag) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aFaA($where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $jRa =  $sth->fetchrow_arrayref;
 $sth->finish();
 $self->aEaA(undef, $jRa) if ref($jRa) eq 'ARRAY';
 return ref ($jRa) eq 'ARRAY'? $jRa: undef; 
}

sub aSaA{
 my ($self, $where, $params, $fN, $fieldsref, $tag) = @_;
 my $objs=[];
 my $_dbh = $self->{_dbh};
 $fieldsref = $self->{fields} if (not defined($fieldsref)) || scalar(@$fieldsref)==0;
 my $sql = $self->aNaA($fieldsref, $where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 $fN = 1024*10 if not defined($fN);
 $params? $sth->execute(@$params) : $sth->execute();
 my $hashref;
 my $cnt;
 my $t = ref($self);
 while(($hashref =  $sth->fetchrow_hashref) && ++$cnt <= $fN) {
 	   my $obj = $t->new($self->{tb});
 	   $obj->aTaA($hashref) if $hashref;
	   push @$objs, $obj;
 }
 $sth->finish();
 return $objs; 
}

sub aYaA{
 my ($self, $where, $params, $tag) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->aFaA($where, $tag);
 my $sth = $_dbh->prepare_cached($sql);
 if($params) {
 		$sth->execute(@$params);
 }else {
 		$sth->execute();
 }
 my $allref =  $sth->fetchall_arrayref;
 $sth->finish();
 return ref ($allref) eq 'ARRAY'? $allref: undef; 
}

sub aCaA{
 my ($self, $where, $params) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = "select count(*) from $self->{tb} $where";
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my @rarr = $sth->fetchrow_array();
 my $cnt = $rarr[0];
 $sth->finish();
 return $cnt; 
}

sub aJaA{
 my ($self, $sql, $params) = @_;
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my $all_ref = $sth->fetchall_arrayref();
 $sth->finish();
 return $all_ref; 
}

sub aXaA{
 my ($self, $where, $params, $fieldsref) = @_;
 my $_dbh = $self->{_dbh};
 $fieldsref = $self->{fields} if not $fieldsref;
 my $sql = "select ". join(", ", @$fieldsref). " from $self->{tb} $where";
 my $sth = $_dbh->prepare_cached($sql);
 $params? $sth->execute(@$params) : $sth->execute();
 my $all_ref = $sth->fetchall_arrayref();
 $sth->finish();
 return $all_ref; 
}

sub rRa{
 my ($self, $fieldsref, $where, $params, $tag) = @_;
 $fieldsref = $self->{fields} if not $fieldsref;
 my @fs = grep { (not defined $self->{$_}) || $self->{$_} !~ /^sqlfunc:/i } @{$fieldsref};
 my @ps = (@$self{@fs}, @$params);
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($self->aVaA($fieldsref, $where, undef, $tag));
 $sth->execute(@ps);
 $sth->finish();
}

sub aZaA{
 my ($self, $jRa,  $where, $params, $tag) = @_;
 my $fieldsref = $self->{fields};
 my @ps = (@$jRa, @$params);
 my $_dbh = $self->{_dbh};
 my $sth = $_dbh->prepare_cached($self->aVaA($fieldsref, $where, undef, $tag));
 $sth->execute(@ps);
 $sth->finish();
}

sub aIaA{
 my ($self, $kvhash, $where, $params, $tag) = @_;
 my @fs = grep { (not $kvhash->{$_}) ||  $kvhash->{$_} !~ /^sqlfunc:/i } @{$self->{fields}};
 my @ps = (@$kvhash{@fs}, @$params);
 	my $_dbh = $self->{_dbh};
 	my $sth = $_dbh->prepare_cached($self->aVaA(\@fs, $where, $kvhash, $tag));
 	$sth->execute(@ps);
 	$sth->finish();
}

sub sHa{
 my ($self, $where, $params, $tag) = @_;
 	my $_dbh = $self->{_dbh};
 	my $sth = $_dbh->prepare_cached($self->aQaA($where, $tag));
 	$sth->execute(@$params);
 	$sth->finish();
}

sub aBaA {
 my ($self, $id) = @_;
 $self->sHa("where id=?", [$id], undef);
}

sub aLaA {
 my ($self, $id) = @_;
 $self->aPaA("where id=?", [$id]);
}
 
sub bEaA {
 my ($self, $fields,  $id) = @_;
 $self->rRa($fields, "where id=?", [$id]);

}

sub tEa{
 my ($self, $tag) = @_;
 my @fs = grep { (not defined $self->{$_}) ||  $self->{$_} !~ /^sqlfunc:/i } @{$self->{fields}};
 my $_dbh = $self->{_dbh};
 my $sql = $self->bHaA($tag);
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@$self{@fs});
 $sth->finish();
}

sub bIaA{
 my ($self, $varr) = @_;
 my $_dbh = $self->{_dbh};
 my $sql = $self->bDaA();
 my $sth = $_dbh->prepare_cached($sql);
 $sth->execute(@$varr);
 $sth->finish();
}

sub aUaA{
 my ($self) = @_;
 my $t = ref ($self);
 no strict "refs";
 my $vf = eval "\$$t\:\:VERFS";
 return $vf;
}
sub bCaA {
	my ($self, $fm, $where, $params) = @_;
 my @modfs=();
 my @ids = $fm->fXa();
 for my $k ( @ids ) {
		next if not exists $self->{$k};
		next if $self->{$k} eq $fm->{$k};
		push @modfs, $k;
		$self->{$k} = $fm->{$k};
 }
 return if not scalar(@modfs); 
	$self->rRa(\@modfs, $where, $params);
 
}

sub dGaA {
 my ($self, $fm, $hashref) = @_;
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $where = " where $where" if $where;
 my @params = @{$hashref}{@bindvarrs};
 $self->bCaA($fm, $where, \@params);
}
 
sub dEaA {
 my ($self, $hashref) = @_;
 my $where;
 my @bindvarrs;
 for my $k (keys %$hashref) {
	push @bindvarrs, $k;
 }
 $where = join (" and ", map { "$_ = ?" } @bindvarrs );
 $where = " where $where" if $where;
 my @params = @{$hashref}{@bindvarrs};
 $self->sHa($where, \@params);
}   
1;

=item
my $dbo = zDa->new("UTSchool");
my $arr= $dbo->aSaA();

for my $o(@$arr) {
	print ref($o), "-", $o->bCa(), "\n";;
}

=cut
use Clone;
package Object;
@Object::ISA=qw(Clone);
use 5.005;
use strict;
use vars qw($VERSION $AUTOLOAD );

$VERSION = 1.00;

sub new {
 my ($type, $phash) = @_;
 my $self;
 $self = {};
 no strict "refs";
 #print STDERR "making $type\n";
 for(@{"$type\:\:fs"}) {
	$self->{$_} = $phash->{$_};
	
 } 
 return bless $self, $type;
}

sub AUTOLOAD {
 my ($self, $arg) = @_;
 my $class = ref $self;
 my $field = $AUTOLOAD;
 $field =~ s/^.+::(.+)$/$1/;
 if ( $field && !exists($self->{$field}) ) {
 my (undef, $file, $line) = caller(0);
 die "Undefined function $AUTOLOAD ".caller(). ",". caller(1). ", ". caller(2). ", ". caller(3);
 }
 if (@_ == 2) {
 $self->{$field} = $arg;
 }
 return $self->{$field};
}

sub DESTROY {
 return undef;
}
sub set_by_hash{
 my ($self, $hash) = @_;
 no strict "refs";
 my $type = ref $self;
 while(my ($k, $v) = each %$hash) {
		$self->{$k} = $v ;
		#$self->{$k} = $v if exists $self->{$k};
 } 
}
	
sub dump {
 my $self = shift;
 #local $Storable::forgive_me = 1;
 # my $clone = Storable::dclone($self);
 # $clone->_purge_logs;
}

1;
package qWa;
use strict;

#IF_AUTO use AutoLoader 'AUTOLOAD';

BEGIN {
@qWa::siteidx_cfgs=(
[siteidx_info=>'head', "Local site index configuration", ""],
[siteidx_method=>'radio', "http=HTTP Spiding (Slower but safe)\nfile=File scan (faster)", "Local index scan method", "file"],
[siteidx_url0=>'text', "size=64", "Full URL of the starting index page", ""],
[siteidx_topdir=>'text', "size=64", "Physical directory of the URL above", ""],
[siteidx_ref0=>"text", "size=64", "Local site refresh interval (in hours)",  72],
[siteidx_depth0=>"text", "", "Maximum index depth",   "100"],
[siteidx_info2=>'head', "Additional site(s) index configuration (HTTP only)", ""],
[siteidx_tit1=>'text', "size=64", "Site 1 Title", "News"], 
[siteidx_url1=>'text', "size=64", "Site 1 URL (must start with http://)", ""], 
[siteidx_ref1=>'text', "size=64", "Site 1 refresh interval (in hours)", "5"], 
[siteidx_depth1=>'text', "size=64", "Site 1 scan depth", "8"], 
[siteidx_tit2=>'text', "size=64", "Site 2 Title", ""], 
[siteidx_url2=>'text', "size=64", "Site 2 URL (must start with http://)", ""], 
[siteidx_ref2=>'text', "size=64", "Site 2 refresh interval (in hours)", "48"], 
[siteidx_depth2=>'text', "size=64", "Site 2 scan depth", "8"], 
[siteidx_tit3=>'text', "size=64", "Site 3 Title", ""], 
[siteidx_url3=>'text', "size=64", "Site 3 URL (must start with http://)", ""], 
[siteidx_ref3=>'text', "size=64", "Site 3 refresh interval (in hours)", "48"], 
[siteidx_depth3=>'text', "size=64", "Site 3 scan depth", "8"], 
[siteidx_tit4=>'text', "size=64", "Site 4 Title", ""], 
[siteidx_url4=>'text', "size=64", "Site 4 URL (must start with http://)", ""], 
[siteidx_ref4=>'text', "size=64", "Site 4 refresh interval (in hours)", "48"], 
[siteidx_depth4=>'text', "size=64", "Site 4 scan depth", "8"], 
[siteidx_info3=>'head', "Index constraints", ""],
[siteidx_filematch=>"text", "size=64", "Local file match pattern",  '\.(htm|html|txt|asp|php|jhtml|shtml)$'],
[siteidx_fileskip=>"text", "size=64", "URL skip pattern",  '/cgi-bin/'],
[siteidx_maxfiles=>"text", "", "Maximum number of files to scan",   "25600"],
[siteidx_multibyte=> "checkbox", '1=', "Spidered pages are non-western", "0"],
[siteidx_wsplit=>"text", "size=60", "Word split pattern",   ""],
[siteidx_info4=>'head', "Search result page configuration", ""],
[siteidx_maxmatch=>"text", "", "Maximum number of matches to return from a search", "20"],
[siteidx_header=> "textarea", 'rows=8 cols=60 wrap=soft', "Result page header, starting from &lt;html&gt;", qq(<HTML>
<head><title>PowerSearch Results</title>
<style type="text/css">
<!--
body {  font-family: Arial, Helvetica, sans-serif; font: 12px  "arial", serif; margin-left: 6pt; margin-top: 2pt}
 TABLE {
 font: 12px "arial", serif;
 }
 
 TABLE TR {
 font: 12px "arial", serif;
 }

 TABLE TD {
 font: 12px "arial", serif;
 }
.inputfields { COLOR: #666666; FONT-WEIGHT: bold; BACKGROUND-COLOR: #ffffff; FONT-FAMILY: Verdana, Helvetica, Arial; BORDER-BOTTOM: #666666 thin solid; BORDER-LEFT: #666666 thin solid; BORDER-RIGHT: #666666 thin solid; BORDER-TOP: #666666 thin solid  }
.buttonstyle  { FONT-SIZE: 12px;}
-->
</style>
</head>
<BODY bgColor=#ffffff>
)
],

[siteidx_banner=> "textarea", 'rows=4 cols=60 wrap=soft', "Result page banner", qq(<H2><font size="4" color="#336633">Power Search Results</font></H2>)],
[siteidx_footer=> "textarea", 'rows=4 cols=60 wrap=soft', "Result page footer", "</body></html>"],
[siteidx_info3=>'head', "Index creation confirmation", ""],
[siteidx_conf=> "checkbox", '1=', "Checking this box causes PowerSearch to spider the site(s) and create the indexes upon submission of the form", "1"],
[pwsearchcmd=>"hidden", "", "", "indexsite"],
);

@qWa::sitesearch_cfgs= (
[find_info =>"head", "Search Web Site"], 
[tK=> "text", 'maxlength=40', "Search words", ""],
[pwsearchcmd=>"hidden", "", "", "searchsite"],
);

$qWa::cEaA =
qq(1a2ac71a3ac73c7cc75b4cc78cbbab3fc73d6a8b3cc73abbc73aabc73a1ac71cbcc74dadc72d1debdac7bb2fc73acac73afbc752c7ac7cc7fb9c2d4dc75d2e0cfec74c7c0cfec7dc8a9bdfc78c7e9bbfc7bc4e8cbbc75bbaac7cc7cb8c8cbbc78c7e4bbcc7eb9b8cbbc72d4dab3fc7ac9b3d3cc74b3d0c4bc71b8d0dbec75d2e1d9fc7ac7cc78c7eabecc7cb0b6c4ec7cbba6c4e);

};

%qWa::bK= (
 siteidxform=>[\&eWa, 'ADM'],
 sitesearchform=>[\&eZa],
#x2
#x2
);

sub sVa::gYaA(@);

#IF_AUTO 1;
#IF_AUTO __END__

sub new {
 my ($type, $argh) = @_;
 my $self = {};
 $self->{siteidx}= $argh->{siteidx};
 $self->{siteidxcfg}= $argh->{siteidxcfg};
 $self->{cgi}= $argh->{cgi};
 $self->{cgi_full}= $argh->{cgi_full};
 $self->{img_top} = $argh->{img_top};
 $self->{input} = $argh->{input};
 $self->{homeurl} = $argh->{homeurl};
 return bless $self, $type;
}

sub cFaA{
	my ($self, $adm) = @_;
	$self->{uTa} = $adm;
}

sub cJaA{
	my ($self, $kQz) = @_;
	$self->{wOa} = $kQz;
}

sub bUaA{
	my ($self, $url) = @_;
	$self->{wCa} = $url;
}

sub bTaA{
	my ($self, $url) = @_;
	$self->{uQa} = $url;
}

sub bWaA{
	my ($self, $link) = @_;
	$self->{vSa} = $link;
}
sub rCa{
 my ($self, $idx) = @_;
 return $self->{siteidx}.$idx;
}

sub eVa{
 my ($self) = @_;
 return $self->{uTa} && ( $self->{uTa} eq  $self->{wOa});
}

sub tSa{
 my ($self) = @_;
 return $self->{wOa};

}

sub tJa{
	my ($self) = @_;
	print "Location: $self->{wCa}\n\n";
	sVa::iUz();
}

sub rDa{
 my ($self, $mf, $idx, $url, $dir, $nA, $no_verbose) = @_;

 return if not ($url || $dir);
	my ($dirs, @urls);

 $dirs = [$dir] if  -d $dir;
	push @urls,  $url if $url =~ /^http/i;
	my $i=0;

	my $search = new eCa { 
		IndexDB 	=> $self->rCa($idx),
		FileMask	=> $mf->{siteidx_filematch},,
		Dirs 		=> $dirs,
		IgnoreLimit	=> 4,
		Verbose 	=> $no_verbose?0:1,
 multibyte       => $mf->{siteidx_multibyte},
 wsplit          => $mf->{siteidx_wsplit} || pack("h*", $qWa::cEaA),
		URLs		=> \@urls,	
		Level  		=> $mf->{"siteidx_depth$idx"} || 50,
		MaxEntry        => $mf->{siteidx_maxfiles},
		UrlExcludeMask => $mf->{siteidx_fileskip}
	
	};

	print $nA "<h2>Indexing in progress, please wait for it to finish ($url $dir) </h2>";
	print $nA "<pre>";
	my @deads;
#x2
 print $nA "</pre><a name=EOF_IDX>";
 #print $nA qq(<script>location="#EOF_IDX";</script>);
	print $nA "<h1>Indexing finished</h1>";
	my $pge;
	my @rows;
	for $pge (@deads) {
		my ($url, $dlink) = @$pge;
		next if not @$dlink;
		print $nA "<h3>Errors for $url</h3>";
		for(@$dlink) {
			my ($e, $link, $plink) = split /\t/, $_;
			next if not ($e && $link);
			push @rows, [$e, sVa::cUz($link, $link), sVa::cUz($plink, $plink)];
		}
	}
 print $nA &sVa::fMa(rows=>\@rows, ths=>["Error", "Error URL", "In page"], sVa::oVa());
}

sub fFa{
	my ($self) = @_;
	sVa::error("dM", "Wrong login/password") if(not $self->eVa()) ;
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->aAa($self->{input});

	$mf->store($self->{siteidxcfg});
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 if(not $mf->{siteidx_conf}) {
		print $mf->form(1);
 	print "</body></html>";
		return;
 }
		
	my ($dir, @urls);
 $dir = $mf->{siteidx_topdir} if $mf->{siteidx_method} eq 'file';
	push @urls,  [0, $mf->{siteidx_url0}] if $mf->{siteidx_method} eq 'http';
	my $i=0;

	for($i=1; $i<6; $i++) {
		push @urls, [$i, $mf->{"siteidx_url$i"}] if $mf->{"siteidx_url$i"};
	}

 $mf->{siteidx_wsplit} =~ s/\|+$//;
 $mf->{siteidx_wsplit} =~ s/^\|+//;
 for(@urls) {
		$self->rDa($mf, $_->[0], $_->[1], undef, \*STDOUT);
	}
	$self->rDa($mf, 0, undef, $dir, \*STDOUT) if $dir;

	$mf = new aLa('idx', \@qWa::sitesearch_cfgs, $self->{cgi});
 print $mf->form();
 print "</body></html>";
}

sub eZa{
 my($self) = @_;
	my $mf = new aLa('idx', \@qWa::sitesearch_cfgs, $self->{cgi});
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
	$mf->yQa('GET');
 print $mf->form();
 print "</body></html>";
}

sub eWa{
	my ($self) = @_;
	sVa::error("dM", "Wrong login/password") if(not $self->eVa()) ;
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->load($self->{siteidxcfg});
 if(not $mf->{siteidx_url0}) {
		$mf->dNa('siteidx_url0', $self->{homeurl});
 }
	sVa::gYaA "Content-type: text/html\n\n";
 print "<html><body>";
 print $mf->form();
 print "</body></html>";
}

sub qPa{
	my $self = shift;
 my $mf = shift;
	my $t0 = time();

	my ($dir, @urls);

	my $i=0;
 if($t0 - (stat($self->rCa($i)))[9] > 3600*$mf->{"siteidx_ref$i"}) {
 	$dir = $mf->{siteidx_topdir} if $mf->{siteidx_method} eq 'file';
		push @urls,  [0, $mf->{siteidx_url0}] if $mf->{siteidx_method} eq 'http';
 }
	for($i=1; $i<6; $i++) {
		next if not $mf->{"siteidx_url$i"};
		next if $t0 - (stat($self->rCa($i)))[9] < 3600*$mf->{"siteidx_ref$i"};
		push @urls, [$i, $mf->{"siteidx_url$i"}] if $mf->{"siteidx_url$i"};
	}

 $mf->{siteidx_wsplit} =~ s/\|+$//;
 $mf->{siteidx_wsplit} =~ s/^\|+//;
	open F, ">"."$self->{siteidx}.log";
 for(@urls) {
		$self->rDa($mf, $_->[0], $_->[1], undef, \*F, 1);
	}
	$self->rDa($mf, 0, undef, $dir, \*F, 1) if $dir;
	close F;
}

sub fAa {
	my ($self)=@_;
	my $t0 = time();
	my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $self->{cgi});
	$mf->zOz();
	$mf->load($self->{siteidxcfg});
	sVa::gYaA "Content-type: text/html\n\n";
 my $multibyte =$mf->{siteidx_multibyte};

 my @files;
 my $i=0;
 my $line = $self->{input}->{tK};
 my $pagenum = $self->{input}->{pagenum};

 my $search;
 my $err="";
 my $totmatch=0;

 for($i=0; $i<6; $i++) {
		next if not -f $self->rCa($i);
		$search = eCa->new($self->rCa($i), 0);

		my $result;
		if ($line =~ /\band\b|\bor\b/i) {
			$result = $search->eIa($line,1);
		} else {
			$result = $search->query([split /\s+/, $line], $multibyte);
		}
		my $cnt = int  @{ $result->{files} };
		$totmatch += $cnt;	 
		push @files, [$i, $result->{files}] if $cnt;;
		$err .="<br>".$search->errstr() if $search->errstr();
 }
	my $k;
	my $method = $mf->{siteidx_method};
	my $topdir = $mf->{siteidx_topdir};
	my $topurl = $mf->{siteidx_url0};
	my $pgsz = $mf->{siteidx_maxmatch} || 10;
	my $nLz = int ($totmatch/$pgsz);
	if($totmatch%$pgsz >0) {
		$nLz ++;
	}
	print $mf->{siteidx_header};
 print qq(
<table width="82%" border="0" height="92" cellpadding="0" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$self->{img_top}/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$self->{img_top}/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$self->{cgi}" method="GET">
 <td width="42%" height="40" bgcolor="#CC9900" valign="middle"> 
	\&nbsp;
 <input type="text" class="inputfields" name="tK" value="$line">
 <input type=hidden value=searchsite name="pwsearchcmd">
 <input class="buttonstyle" type=submit value="Search" name="x">
 </td>
 </form>
 <td width="31%" height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>Search 
 powered by <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$self->{img_top}/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
);
	print $mf->{siteidx_banner};
	my $t = time() - $t0;
 my $idx=0;
	my ($sidx, $eidx);
	$sidx = $pgsz * $pagenum;
	$eidx = $sidx + $pgsz;
	$eidx = $totmatch  if $eidx > ($totmatch-1);
	my @cHaA;
	my $bQaA;
	my $fre = sVa::cIaA($line);
 for($bQaA =0; $bQaA <$nLz; $bQaA++) {
		my $i = $bQaA +1;
		if($bQaA == $pagenum) {
			push @cHaA, 	"<b>$i</b>";
		}else {
			push @cHaA, sVa::cUz($self->{cgi}."?pwsearchcmd=searchsite&tK=$fre&pagenum=$bQaA", $i);
		}
	} 
	for(@files) {
		my $filename;
		my $score;
		my $title;
		my $count = int  @files;
		print "<!--$t seconds -->\n";
		print "<ul>";
 my %shownf;
		my ($i, $flist) = @$_;
		my $topdir = $mf->{siteidx_topdir};
		my $topurl = $mf->{"siteidx_url$i"};
 last if $idx >= $eidx;
		for $k( sort { $b->{score} <=>  $a->{score} } @$flist) {
			$idx ++;
			if ($idx-1<$sidx ) {
				next;
 } 
 	last if $idx-1 >= $eidx;
			$filename = $k->{filename};
			if($method eq 'file') {
				$filename =~ s/^$topdir//;
				$filename =~ s/^\///;
			}
			$score = $k->{score};
			my ($title, $abs, $chk, $sz, $lmt) = split("\t", $k->{title});
			$title =~ s/($line)/<b>$1<\/b>/ig;
			$abs=~ s/($line)/<b>$1<\/b>/gi;
			my $url = dDa::eAa($topurl, $filename);
 next if $shownf{$url};
 $shownf{$url} = 1;
			$title= $url if not $title;
#x2
 print $abs, " <b>....</b><br>";
			$sz = $sz /1024;
		        print qq(<font color=green size=1>$url -- ), sprintf("%.2fK", $sz), "-- $lmt</font>";	
			print "</li><p>";
			
		}
		print "</ul>";
		print "$totmatch matches found. Showing ", scalar(keys %shownf), " matches\n";
	}
 if(not scalar(@files)) {
		print "No matches found.\n";

 }else {
		print "<p>Page ", join(" ", @cHaA);
	}
	print "Error: ", $search->errstr, "\n" if $err;
 print "</td></tr></table>";

	print qq(
<table width="82%" border="0" height="92" cellpadding="1" cellspacing="0">
 <tr> 
 <td rowspan="2" height="76" valign="bottom" width="27%">
<a href="http://netbula.com">
<img border="0" src="$self->{img_top}/search_logo.jpg" width="185" height="60" align="bottom">
</a>
</td>
 <td height="14" bgcolor="#FFFFFF" colspan="2" valign="bottom"><img src="$self->{img_top}/hline_mblue.gif" width="100%" height="3"></td>
 </tr>
 <tr> 
 <form action="$self->{cgi}">
 <td height="40" bgcolor="#CC9900" valign="middle">  \&nbsp;
 <input type="text" name="tK" class="inputfields">
 <input type=hidden value=searchsite name="pwsearchcmd">
 <input class="buttonstyle" type=submit value="Next search" name=x>
 </td>
 </form>
 <td height="40" valign="middle" bgcolor="#CC9900"><font color="#FFFFFF"><b>
 <a href="http://netbula.com/">PowerSearch</a></b></font> 
 </td>
 </tr>
 <tr> 
 <td colspan="3" valign="top" height="1"><img src="$self->{img_top}/hline_mblue.gif" width=100% height="3"> 
 </td>
 </tr>
</table>
<p>&nbsp;</p>
);
	print $mf->{siteidx_footer};
	$self->qPa($mf);
}

1;
package jW;
use strict;

#IF_AUTO use AutoLoader 'AUTOLOAD';

BEGIN {
eval q(use Fcntl ':flock');
use vars qw($iG $UDMAGIC %locks $bYaA);
use vars qw($AUTOLOAD $aZz %zW);
use vars qw(
$hW $cI $aN $oK $uT $dD
$pF $bR $aI $js $lV $post_filter
$jUz $bNz $wN
$aL $aV $tP $sI $tO $fNz $golink $rS $uA $qOz $qJz $plink $chatlink $reloadlink $gflink
$gP
$archfile
$passwd_cnt 
$hash_cnt
$tW
$tV
$gVz
$gWz
$gTz
$top_tag
$gUz
$mbar_width_tag
$zAz
$mbar_bg_tag
$gXz
@bgs
$pTz $pEz $pYz $oDz $oRz $pKz $FHASLNK $FNOHTML $FTAKPRIVO $FFANCY
$trash_sep
$yDa
%bK
);

%bK = (
usercp=> [\&eIaA, ''],
delpmentry=> [\&dFaA, ''],
changemsgstat=>[\&fTaA, ''],
gHaA=>[\&gHaA, ''],
gGaA=>[\&gGaA, ''],
convertfromw3b=>[\&hEaA,''],
rss =>[\&get_rss_xml,''],
);

sub sVa::hCaA(@);
sub sVa::gYaA(@);

$jW::no_flock =1 if $@;
eval ' sub LOCK_SH {1}; sub LOCK_EX {2}; sub LOCK_UN {8}' if $jW::no_flock;
$jW::UDMAGIC="AB_UDB_EXPORT";
$jW::archfile = "archive";
$jW::passwd_cnt = 32; 
$jW::hash_cnt    = 99;
$jW::tW="<!--gen_tie-->";
$jW::tV="<!--hui_tie-->";
$jW::gVz="<!--huida-->";
$jW::gWz="<!--yuanzuo-->";
$jW::gTz="<!--lun_tan-->";
$jW::top_tag="<!--thr_top-->";
$jW::gUz="<!--jYz-->";
$jW::mbar_width_tag="<!--mbw-->";
$jW::zAz="<!--mbo-->";
$jW::mbar_bg_tag="<!--mbg-->";
$jW::gXz="<!--zuozhe-->";
@jW::bgs= @abmain::bgs;
($jW::pTz, $jW::pEz, $jW::pYz, $jW::oDz, $jW::oRz, $jW::pKz, $jW::FHASLNK, $jW::FNOHTML, $jW::FTAKPRIVO, $jW::FFANCY)=(1, 2, 4, 8, 16, 32, 64, 128, 256, 512);
$jW::trash_sep ='ABMSGSEP2001DONTUSETHISSTRORFAIL';

}

BEGIN {

%jW::hNa =(
rss => "rss",
trash    => ".databak",
msglist  => ".msglist",
sdb      =>  "tfmdb",
lastmsg => ".msglast",
msgcnt   =>".cnt",
archcnt   =>".acnt",
archlist => ".archlist",
dmsglist => ".fJ",
pstat    => ".poststat",
aLz  => ".aLz",
update   => ".modmlist",
admlog   => ".nadmlog",
telllog  => ".recommlog",
usrlog   => ".usrlog",
onlineusr =>".uol",
flist     =>".flist",
failpostlog=> ".failpost",
fU      => ".forum_cfg",
usrfonts=>".usrattrib",
overcfg  => ".override",
catidx   => ".catidx",
siteidxcfg =>  "siteidxcfg",
fixcfg=>'fixcfg',
leadcfg=>'leadcfg',
bannerfile=>'bannerfile',
siteidx=>  "siteidx",
cfg_bak  => ".fcfg_bak",
hM   => "posts", 
dbdir => "db",
mK  => "archive", 
iC  => "postdata", 
grpdir   => "groups",
evedir   => "events", 
chat     => "chat", 
links    => ".links", 
passdir  => ".fYz",
updir    => "uploads", 
qUz  => "polls", 
rating   => ".rat", 
arch     => "archive",
cLaA    => "data.txt",
lock     => ".lock",
cday     => '.cday',
mtd      => '.mtd',
totcnt   => '.totcnt',
news     => 'news.rot',
newsjs     => 'newsrot.js',
forums   =>'forums.lst',
leadcache   =>'.leadca',
skey  =>'.skey',
actlog => 'act.log'
);

};
#IF_AUTO 1;
#IF_AUTO use aLa;
#IF_AUTO __END__

sub new {
 my $type = shift;
 my %fH = @_;
 my $self = {};

 $self->{eD} = $fH{eD}?$fH{eD}:$abmain::eD;
 $self->{eD} =~ s#/?$#/#;
 $self->{eD} =~ s!\\!/!g if $^O =~ /win/i;

 $self->{pL} = $fH{pL};
 $self->{pL} =~ s#/?$#/#;

 $self->{rbaseurl} = $fH{rbaseurl};
 $self->{rbaseurl} =~ s#/?$#/#;

 $self->{cgi} = $fH{cgi};
 $self->{cgi_full}=$fH{cgi_full};
 $self->{cgi} = $self->{cgi_full} if not $self->{cgi};
 $self->{cgi_full} = $self->{cgi} if not $self->{cgi_full};
 $self->{name} = $fH{name};
 $self->{vcook}= $abmain::fvp;
 $self->{vcook} =~ s/\W//g;
 $self->{_fvp_str} = $abmain::cZa;
 $self->{_fvp} = $abmain::fvp;
 $self->{_fvp} =~ s!/?$!/!;
 $self->{_top_dir} = $self->{eD};
 $self->{_top_dir} =~ s/$abmain::fvp$//;
 $self->{_off_web} = $fH{offweb};
 $self->{_no_pi} = $fH{nopi};

 if($abmain::off_webroot) {
 	$self->{pL} = "$self->{cgi_full}?".$abmain::cZa;
 }
 my $fU;
 foreach $fU (values %abmain::eO) {
 	foreach (@{$fU->[1]}) {
 		  $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 	}
 }

 foreach (@abmain::bO) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 foreach (@abmain::vC) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 foreach (@abmain::lQa) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 $self->{eN}= new lB;
 $self->{dA} = {};
 $self->{fYz} = {};

 if($self->{cgi}) {
 @lB::mP = ($self->{qP}, $self->{qQ});
 @lB::eK = ($self->{sM}, $self->{sN});
 @lB::dR=($self->{sP}, $self->{sQ});
 }
 $yDa = time();
 $bYaA = $abmain::bYaA;
 return bless $self, $type;
}
sub fGz {
 my ($self, $str, $tag) = @_;
 my $font = $self->{$tag};
 return $str if not $font;
 return "<font $font>$str</font>";
}
sub mJa{
	my ($font, @strs) = @_;
	return @strs if $font eq '';
	return map { qq(<font $font>$_</font>) } @strs;

}
sub lJz{
 my ($self) = @_;
 my $eS =  $self->nDz('msglist'); 
 my $mnofile =  $self->nDz('cLaA'); 
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $len = $db->pXa();
 my $h = {};

 open F, "<".$self->nDz('cday');
 my @lA=<F>;
 close F;
 chomp @lA;
 
 $h->{cday}= $lA[0];
 $h->{list}= $lA[1];
 $h->{mcnt} = $len;
 $h->{lunixtime}= (lstat($eS))[9];
 $h->{lunixtime}= (lstat($mnofile))[9] if not $h->{lunixtime};
 $h->{ltime} = &abmain::dU('DAY', $h->{lunixtime}, 'oP');
 if(time() < $h->{lunixtime} + 60*$self->{kF} ) {
	      $h->{ltime} = qq(<font color="$self->{new_msg_color}"><b>).$h->{ltime}. qq(</b></font>);
 }
 $h->{ctime}= &abmain::dU('DAY', $h->{cday}, 'oP');
 $h->{desc} = $self->{forum_desc};
 $h->{name}= $self->{name};
 $h->{gAz} = $self->{gAz};
 $h->{name} =~ s/</\&lt;/g;
 $h->{name} =~ s/>/\&gt;/g;
 $h->{admin} = $self->{admin};
 $h->{admin} =~ s/</\&lt;/g;
 $h->{admin} =~ s/>/\&gt;/g;
 $h->{admin}= $self->fGz($h->{admin}, 'cRz');
 $h->{admin_email}= $self->{admin_email};
 $h->{admin_email} =~ s/</\&lt;/g;
 $h->{admin_email} =~ s/>/\&gt;/g;
 $h->{moders} = join(", \t",sort keys %{$self->{moders}}) if (keys %{$self->{moders}});
 $h->{nolistmoder} = $self->{no_list_moders};
 $h->{xIz} = $self->xIz();
 $h->{pL} = $self->{pL};
 $h->{fC} = $self->fC();
 $h->{no_list} = $self->{no_list_me};
 $h->{sort_idx} = $self->{forum_idx} || $self->{name};
 $h->{icon} = $self->{forum_logo};
 $h->{forum_cat} = $self->{forum_cat};
 return $h;
}
sub hDaA {
 my($self) = @_;
 my @dirs;
 push @dirs, $self->{eD};
 push @dirs, ($self->nDz('hM'),
	       $self->nDz('iC'),
 $self->nDz('mK'),
 $self->nDz('updir'),
 $self->nDz('qUz'),
 $self->nDz('evedir'),
 $self->nDz('chat'),
 $self->nDz('dbdir'),
 $self->nDz('grpdir'),
 );
 push @dirs, $self->nDz('passdir');
 my @err;
 for my $e (@dirs) {
	push @err, $e if not abmain::nZa($e);
 }
 return @err;
}

sub eP {
 my($self, $gF, $nam, $adm, $cJz, $fU, $lic) = @_;
 eval 'use File::Path'; 
 abmain::error('sys', "Unable to load standard module File::Path ($@).") if $@;
 my $eD= $self->{eD};
 my @dirs= ($self->nDz('hM'),
	       $self->nDz('iC'),
 $self->nDz('mK'),
 $self->nDz('updir'),
 $self->nDz('qUz'),
 $self->nDz('evedir'),
 $self->nDz('chat'),
 $self->nDz('dbdir'),
 $self->nDz('grpdir'),
 );
 my $dVz = $self->nDz('passdir');

 if($gF eq 'rm' && not ($abmain::allow_board_deletion || $self->{allow_del_board} )) {
 abmain::error('deny', "This function must be enabled by setting the \$abmain::allow_board_deletion variable to 1");
 }
 my $hR = 'mkpath';
 if($gF eq 'rm') {
 $hR  = 'rmtree';
 }else {
 $gF = "create";
 }
 abmain::error('inval', "Directory $eD already exists. Please choose another directory name.") if (-d $eD && $gF ne 'rm');

 my $cL = abmain::cLz($fU);
 if(-f $cL) {
 $self->cOz($cL);
 }

 my $oA;
 if($gF ne 'rm' && $abmain::validate_admin_email){
 	abmain::jJz(\$adm);
 	$self->{name}=$nam;
 	$self->{admin}=$adm;
 	$self->{admin_email}=$cJz;
 	$self->{oA}="";
 	$self->{iGz}=$lic;
 	$self->{notifier}=$abmain::master_admin_email;
 	$oA = (int time()*rand())%100000 + 1;
 	$self->{oA} = abmain::lKz($oA);
 	$self->xI("Welcome to AnyBoard, $adm", qq(
I have created the forum: $self->{name}. The following are some important information.

Admin login URL: $self->{cgi_full}?@{[$abmain::cZa]}cmd=log
Admin login ID : $adm
Password       : $oA
URL to request new admin password:  $self->{cgi_full}?@{[$abmain::cZa]}cmd=lKa

Please login and change your password.
Best regards,

AnyBoard

)

) if $cJz; 
 	abmain::error('sys', "Error e-mail to $cJz: ". $abmain::wH)
 	    if ($cJz && $abmain::wH);
 }

 $eD =~ s#/$##;
 my $cmd = qq/File::Path::$hR(['$eD'])/;
 my @path=eval $cmd or abmain::error('sys', "When $gF directory $eD: $@");

 return if $gF eq 'rm';

 local $_;
 for(@dirs) {
 $_ =~ s#/$##;
 	mkdir ($_, 0755) or abmain::error('sys', "When $gF directory $_: $!, $@");
 open XFILE, ">$_/index.html";
 close XFILE;
 }
 $dVz =~ s#/$##;
 mkdir ($dVz, 0700) or abmain::error('sys', "When $gF directory $dVz: $!, $@");

 open F, ">".$self->nDz('cday') or abmain::error('sys', "When create file: $!");
 print F time(), "\n";
 print F "1\n";
 close F;
 $self->hL();
 $self->{qH} =0;
 $self->{_noreload_cfg} =1;
 $self->cCz("Welcome to $self->{name}, $adm!", "AnyBoard", 
	qq@
 <b>I will help you succeed in the 21st century.  Enjoy!</b><p>
	The following is a message from the AnyBoard development team:
<div style="background-image: Url(/abicons/hlbg.gif)">
	AnyBoard can be configured in almost any way you want.
	The default interface is kept to be very simple, to change it, please use the configuration functions in the admin panel,
 or load one of the templates come with your AnyBoard distribution.
</div>
 @,
 time());
 $self->cR();
 $self->eG();
 $self->nSa();
 
 $self->{notifier}=$cJz;
 $self->xI("Welcome to $self->{name}, $adm", "Admin login URL: $self->{cgi_full}?@{[$abmain::cZa]}cmd=log\n\nAdmin login ID=$adm\nPassword=$oA") 
	if $cJz && not $abmain::validate_admin_email; 
 return @path;
}
sub kKz{
 my $d=shift;
 $d =~ s/\s+//g;
 my ($k, $c) = split /\./, $d;
 $c and $c == unpack("%16C*", $k);
}
sub iJz {
 my ($self, $msg) = @_;
 $self->xI("test msg", $msg); 
 if ($abmain::wH){
 abmain::error('sys', "Error sending e-mail: ". $abmain::wH)
 }else {
 abmain::cTz("Email sent");
 }
}
sub yTa{
	my ($self, $auto) = @_;
	my $mpath = $self->dFz();
 my $u_t = (stat($mpath))[9];
	if($auto && $u_t > time() -15) {
		return;
	}
	my ($msg, $cnt) = $self->nKa();
 if(not $auto) {
 	abmain::cTz($msg);
	}
	return if not $cnt >0;
	if((not $auto) || $u_t < time() - 30) {
 		$self->aT();
 		$self->eG();
	}
}
sub lHa {
	my ($self, $img) = @_;
	my $imgf = abmain::kZz($self->nDz('updir'), $img);	
	my $iconf = abmain::kZz($self->nDz('updir'), "i_$img");	
	if(not -f $iconf) {
		abmain::lIa($imgf, $iconf, $self->{iconsize});
	}
 	my $t = $img;
	$t =~ s/^[^.]*//;
	$t ||= "gif";
	sVa::gYaA "Content-type: image/$t\n\n";
	binmode STDOUT;
	local *F;
	open F, "<$iconf";
	binmode F;
	print <F>;
	close F;

}
sub dKaA{
	my ($f) = @_;
 	$f =~ s|([^a-zA-Z0-9\-\.])|sprintf '%%%.2X' => ord $1|eg;

}

sub eXz {
 my ($self, $filelist, $sep)=@_;
 my $str = qq(<div class="MessageAttachment">\n);
 my @files = split /\s+/, $filelist;
 my $file;
 $sep = ' &nbsp;' if not $sep;
 foreach $file (@files) {
 my $fpath = abmain::kZz($jW::hNa{updir}, $file);
 	my $fsize = sVa::fWaA((stat(abmain::kZz($self->{eD}, $fpath)))[7]);
 my $urlimg = $self->lMa($fpath);
 my $urlicon = "$self->{cgi}?@{[$abmain::cZa]}cmd=lHa;img=$file";
 	if($file =~ /\.(gif|jpg)$/i) {
 if($self->{yRz}) {
 $str.=qq(<a href="$urlimg" target=_picwin><img src="$urlicon" ALT="click to view $file \($fsize\)"></a>);
 }else {
 	   	$str .= qq(<img src="$urlimg" ALT="$file \($fsize\)">);
	   }
 	}else {
 	   $str .= abmain::cUz($urlimg, $file ).$fsize;
 	}
 	$str .= $sep;
 }
 $str .="</div>";
 my $str2 = $self->{message_attachment_layout};
 $str2 =~ s/UPLOADED_FILES/$str/g;
 return $str2;
}
 
sub fZz{
 my($self, $user) = @_;

 $user = lc($user);
 my $fIz = $self->fRz($user);
 my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz)});
 my $linesref = $db->iQa({noerr=>1, where=>"userid='$user'", filter=>sub { return $_[0]->[0] eq lc($user); } });
 
 my $sq = '&#39;';
 local $_;
 while ($_ = pop @$linesref) {
 my ($n, $p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme) = @$_;
 $fSz =~ s/'/$sq/ge;
 $fUz =~ s/'/$sq/ge;
 $fXz =~ s/'/$sq/ge;
	  next if $self->{fYz}->{$n};
	  if($n =~ /\S+/ && $p ne '') { 
	  	$self->{fYz}->{$n} = $p;   
	  	$self->{gFz}->{$n} = [$p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme];
	  }
 }
 if($self->eOaA() && $self->{local_control} ) {
 	my $fIz = $self->eLaA($user);
 	my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 	my $linesref = $db->iQa({noerr=>1, where=>"userid='$user'", filter=>sub { return $_[0]->[0] eq lc($user); } });
	my $lineref = undef;
	if($linesref && scalar(@$linesref)) {
		my $len =  scalar(@$linesref);
		$lineref = $linesref->[$len-1];
 	my ($n, $p2, $e2, $ct, $hp2, $st2, $vk2, $utype2, $fXz, $fSz, $add2noti2, $showme2) = @$lineref;
		my $oldline = $self->{gFz}->{$n};
 	my ($p, $e, $fUz, $gDz, $gIz, $fMz, $add2noti, $showme) ;
 	( $p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme) = @$oldline if $oldline;
 	$fSz =~ s/'/$sq/ge;
 	$fUz =~ s/'/$sq/ge;
 	$fXz =~ s/'/$sq/ge;
	  	$self->{gFz}->{$n} = [$p, $e, $ct, $hp2, $st2, $vk2, $utype2, $fXz, $fSz, $add2noti2, $showme2];
	}else {
	  	$self->{gFz}->{lc($user)} = undef;

	}
 
 }
}
sub pWa{
 my($self, $email) = @_;
 abmain::jJz(\$email);

 return $self->{_email_to_usr}->{lc($email)} if $self->{_email_to_usr}->{lc($email)};

 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  next if ((not -f $_ ) && (not $abmain::use_sql));
	  my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1, where=>"email='$email'", filter=>sub {lc($_[0]->[2]) eq lc($email); } });
	  push @xlines, @$linesref if $linesref;
 }

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my %user_emails=();
 my @vcards;
 my %seen_user=();
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_; 
	  if (lc($e) eq lc($email)) {
 		$self->{_email_to_usr}->{lc($email)}  = $_;
	  	return $_;
	  }
 
 }
}
sub hWz{
 my($self, $pattern, $full, $valid, $after, $before, $innoti) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  next if ((not -f $_ ) && (not $abmain::use_sql));
	  my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1});
	  push @xlines, @$linesref if $linesref;
 }

 my $ct = time();
 my $sti = $ct - $after * 24 * 3600;
 my $eti = $ct - $before * 24 * 3600;

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my %user_emails=();
 my @vcards;
 my %seen_user=();
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_; 
 next if ($after && $t < $sti) || ($before && $t > $eti); 
	  next if !$n =~ /\S+/;
 next if $seen_user{$n};
 $seen_user{$n}=1;
 next if $innoti && !$noti;
	  next if $user_emails{$n};
 if($pattern) {
 next if not ($n =~ /$pattern/i || $e =~ /$pattern/i
 || $fXz =~ /$pattern/i || $fSz =~ /$pattern/i
 );
 }
 next if $valid && $gDz ne 'A';
 next if not $e =~ /\@/;
 if($full) {
 	$user_emails{$n} = "$n\&lt;$e\&gt;" ;
 }else {
 $user_emails{$n} = $e;
 }
 if($self->{gRa}) {
		push @vcards, $self->fYa($n);
 }
 
 }
 if($self->{gRa}) {
 my %mail;
 	$mail{To} = $self->{gRa};
 $mail{From} = $self->{notifier};
 $mail{Subject} = "$self->{name} vcards";
 $mail{Body} = "See attached card files for details.";
	abmain::mXz(\%mail, "anyboard.vcf", @vcards);
 if ($abmain::wH){
 abmain::error('sys', "Error sending e-mail: ". $abmain::wH)
 }
 }
 return join(', ', values %user_emails);
}
sub qF {
 my($self, $pattern, $after, $before, $partial, $type, $stat, $ifnoti) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $_;
	  }
 my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1} );
	  push @xlines, @$linesref;
 }
 my %allusers=();
 my %users=();

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my $ct = time();
 my $sti = $ct - $after * 24 * 3600;
 my $eti = $ct - $before * 24 * 3600;
 my $ucnt=0;
 my $tot =0;
 local $_;
 while ( $_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
 $n =~ s/\b(\w)/uc($1)/ge;
	  next if exists $allusers{$n};
	  next if $ifnoti && $noti != $ifnoti;
 $allusers{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 for(keys %allusers) {
 	  $tot ++;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$allusers{$_}};
	  next if $type && $type ne $fMz;
	  next if $stat && $stat ne $gDz;
 next if ($after && $t < $sti) || ($before && $t > $eti); 
 if($pattern) {
 next if $partial==1 && lc($n) ne lc($pattern);
 next if not ($n =~ /$pattern/i || $e =~ /$pattern/i
 || $fXz =~ /$pattern/i || $fSz =~ /$pattern/i);
 }
 next if $partial && $gDz ne 'A';
 $users{$n} = $allusers{$n};
 $ucnt ++;
 }
 my $ustr;
 my   $dstr;
 $dstr  = "since ". abmain::dU('LONG', $sti, 'oP') if $after >0;
 $ustr = "( $ucnt members $dstr )" if not ($partial && $pattern); 
 $self->eMaA( [qw(other_header other_footer member_list_banner)]);
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>Member information (Total $tot)</title>\n$self->{sAz}\n$self->{other_header}$self->{member_list_banner}
 );
 print abmain::oWa();
 print qq(<DIV class="ABMEMBERLIST">);
 my @ths= ("Name", "Mod time", "Status", "Home page", "Type", "Location", "Description");
 my @rows;
 my $usrname;
 foreach $usrname (sort keys %users) {
 my @row;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$users{$usrname}};
	  if($e =~ /\S+/ && not ($self->{gNz} && $partial) ) {
	       push @row, abmain::cUz("mailto:$e", $n);
	  }else {
	       push @row,  $n;
	  }
	  my $dlink= sVa::cUz(sVa::sTa($abmain::jT, {docmancmd=>'fVaA', kQz=>$usrname, dir=>'/public'}), "<small>Files</small>");
 my $uenc = abmain::wS($usrname);
	  push @row, "<small>".abmain::dU('SHORT', $t, 'oP')."</small>";
 push @row,
 qq($gDz \&nbsp;\&nbsp;). abmain::cUz($self->{cgi}."?@{[$abmain::cZa]}cmd=admregform;kQz=$uenc", "<small>Modify</small>", "_dw").
 "\&nbsp; ". abmain::cUz($self->{cgi}."?@{[$abmain::cZa]}cmd=delregform;kQz=$uenc", "<small>Delete</small>", "_dw");
 push @row,  abmain::cUz("$fUz", ($fUz=~ m#^http://..#i) ? $fUz:""). ' &nbsp; '.
	  	abmain::hFa($self->{mp_enabled}? "$self->{cgi}?@{[$abmain::cZa]}cmd=viewmp;kQ=$uenc":"", "<small>more</small>").' &nbsp; '.
	  	abmain::hFa($self->{mp_enabled}?"$self->{cgi}?@{[$abmain::cZa]}cmd=viewmp;kQ=$uenc;vcf=1":"", "<small>vcard</small>"). " ".
	  	abmain::hFa($self->{mp_enabled}?"$self->{cgi}?@{[$abmain::cZa]}cmd=mform;kQ=$uenc":"", "<small>edit</small>"). " ".
		$dlink." ".
	  	abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=form;kQz=$uenc", "<small>private</small>");
 push @row, $fMz, $fXz, $fSz;
	  push @rows, [@row];
 }
 my $colsel;
 if($partial) {
	if($self->{short_reg_form}) {
		$colsel = [0, 3];
	}else {
		$colsel = [0, 3, 5, 6];
	}
 }else {
	if($self->{short_reg_form}) {
		$colsel = [0, 1, 2, 4];
	}
 }
 
 print sVa::fMa(rows=>\@rows, ths=>[jW::mJa($self->{cfg_head_font}, @ths)], $self->oVa(), colsel=>$colsel); 
 
 print "\n</DIV>";
 if( $partial && $pattern) {
	print "<center>";
 	$self->vLz($pattern) if $self->{pstat_in_reginfo}; 
	print "</center>";
 	$self->bVa($pattern) if $self->{mp_enabled} && $self->{mp_in_reginfo}; 
 }
 print qq!<center>$ustr</center>!;

 my $mf = new aLa('mem', \@abmain::search_member_form, $self->{cgi});
 print $mf->form();
 print "</center>";

=item
<form action="$self->{cgi}" method="POST"> @{[$abmain::cYa]}
<input type="hidden" name="cmd" value="kPz">
<input type="hidden" name="regmatch" value="1">
<input type="submit" class="buttonstyle" name="show" value="Find"> members that match pattern(*) 
<input type="text" name="pat" size="16" value=""><br/>
Registration day range: from <input type="text" size="4" name="hIz" value="7"> days ago, to <input type="text" size="4" name="hJz" value="0"> days ago)
</form>
</center>
!;
=cut
 
 print "$self->{other_footer}";
}
sub sKa {
 my($self) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $_;
	  }
 my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1} );
	  push @xlines, @$linesref;
 }
 my %allusers=();
 my %users=();

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my $ucnt=0;
 my $tot =0;
 local $_;
 while ( $_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
 $n =~ s/\b(\w)/uc($1)/ge;
	  next if exists $allusers{$n};
 $allusers{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 for(keys %allusers) {
 	  $tot ++;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$allusers{$_}};
 next if  $gDz ne 'A';
 $users{$n} = $allusers{$n};
 $ucnt ++;
 }
 return sort keys %users;
}
sub oFa {
 my ($self, $wW, $cG, $aK, $cat) = @_;
 my $f = abmain::wTz('news').$cat;
 my $node = lB->new($aK, 0, $cG);
 my $url = $node->nH($self, -1);
 $self->fZa(\$wW);
 $wW =~ s/\t/ /g;
 $bYaA->new($f, {index=>1, schema=>"AbNewsIndex"})->iSa(
 [$wW, $url, $self->{eD}, $self->{name}, $self->fC(), $cG, $self->{_fvp}, time()]
 );
}
sub bKa {
 my($self, $nt) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for my $f(@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $f;
 }
 my $linesref = $bYaA->new($f, {schema=>"AbUser", paths=>$self->dHaA($f) })->iQa({noerr=>1} );
	  if(not $abmain::use_sql) {
 	unlink $f if $bYaA->new("$f.bak", {schema=>"AbUser"})->iRa($linesref)>0;
	  }
	  push @xlines, @$linesref;
 }
 my %users=();
 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
	  next if $users{$n};
 $users{$n} = [$n, $p, $e, $fUz, $gDz, $gIz, $nt, $fXz, $fSz, $noti];
 }  
 my $cnt=0;
 my $usrname;
 foreach $usrname (sort keys %users) {
 	  $self->aG(@{$users{$usrname}});
 $cnt ++;
 }
 return $cnt;
}
sub wZz {
 my($self) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for my $f (@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $f;
	  }
 my $linesref = $bYaA->new($f, {schema=>"AbUser", paths=>$self->dHaA($f) })->iQa({noerr=>1} );
	  push @xlines, @$linesref;
 }
 my %users=();

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
	  next if $users{$n};
 $users{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 sVa::gYaA "Content-type: application/octet-stream\n";
 print "Content-Disposition: attachment; filename=abuserdb.txt\n\n";
 print $UDMAGIC, "\n";
 foreach my $usrname (sort keys %users) {
 print join ("\t", @{$users{$usrname}}), "\n";
 }
}
sub vRz {
	my ($self, @xlines) = @_;
 	my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti);
 my $cnt=0;
 my $line1 = shift @xlines;
 abmain::error('inval', "First line of data file must be the magic string <i>$UDMAGIC</i>") unless $line1 =~ /$UDMAGIC/;
	foreach (@xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti) = split /\t/;
	  next if !$n =~ /\S+/;
 $p = abmain::lKz($n) if not $p;
 	  $self->aG(lc($n), $p, $e, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $noti);
 $cnt ++;
 }
 return $cnt;
}
sub gOa{
 my ($self, $user, $global) = @_;
 abmain::error("miss", "No data supplied") if not $user; 
 abmain::gOa($global?$abmain::master_cfg_dir: $self->{eD}, $user);
}
sub dP {
 my($self, $user, $qD) = @_;
 my $fIz = $self->fRz($user);
 my $db= $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 my %cC;
 my $cnt= $db->jLa([lc($user)]);
 unlink $self->bJa($user);
 return $cnt unless $qD; 
 $self->gOa($user,0);
 return $cnt;
}
sub pHa {
 my ($self, $kQz) = @_;
 my @subjs = split /\n+/, $self->{welcome_subjs};
 my $cnt = @subjs;
 my $wW = $subjs[int (rand()*$cnt)];
 my $msg = $self->{welcome_msg};
 $wW =~ s/{USERNAME}/$kQz/g;
 my $kNz=qq($self->{cgi}?@{[$abmain::cZa]}cmd=kPz;pat=).abmain::wS($kQz);
 my $kOz = qq(<a href="$kNz">$kQz</a>);
 $msg  =~ s/{USERNAME}/$kOz/g;
 $self->{_noreload_cfg} =1;
 $self->cCz($wW, $self->{admin}, $msg, time(), $self->{welcome_cat});
 if($self->{aWz}) {
 	$self->{aGz}=1;
 	$self->{aIz}=0;
 $self->aQz();
 }
 $self->aT();
 $self->eG();
}
sub dJ {
 my ($self, $n, $p, $e, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $add2noti, $showme) = @_;

 if(not ( $self->{gBz}  || $self->{gAz})) {
 abmain::error('inval', "User registration was not enabled for $self->{name}");
 } 
 $self->fZz($n);
 my $cE = $self->{fYz}->{lc($n)};
 if ($cE ) {
 abmain::error('inval', "$n already registered, please choose another name")
 unless (lc($self->{fTz}->{name}) eq lc($n) && $self->{fTz}->{reg});
 }
 $abmain::iG = abmain::lKz($p);
 my $jK;
 if($e =~ /$abmain::uD/) {
 $jK = $1;
 }

 if( (!$jK) && ($self->{rH} || $self->{require_email_nv})) {
 abmain::error('miss', "A valid e-mail address is required for registration");
 }elsif( not $self->{rH}) {
 $gIz = 0;
 }

 if($self->{rH}) {
 	&abmain::error('inval', "The email address $e is not acceptable") if($self->{allowed_emails} && $e !~ /$self->{allowed_emails}/i);
 	&abmain::error('inval', "The email address $e is not acceptable") if($self->{jDz} && $e =~ /$self->{jDz}/i);
 }
 $self->aG(lc($n), $abmain::iG, $jK, $fUz, $gDz, $gIz, $ut, $fXz, $fSz, $add2noti, $showme);
 my $err = $self->wI($n, $p, $e, $gIz);
 my $gQ=0;
 if($self->{rH}) {
 	if($err) {
	    $self->dP(lc($n));
 $gQ =1;
 	    &abmain::error('sys', "Fail to send validation e-mail, user record not created.<br/>Error: $err");
 	}
 }
 $self->save_user_passwd($n, $p) if not $gQ;
}
sub xI {
 my ($self, $wW, $message, $admonly) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 if($admonly) {
 	$mail{To} = $self->{admin_email};
 }else {
 	$mail{To} = join(", ", $self->{admin_email}, split("\t", $self->{moderator_email}));
 }
 $mail{To} =~ s/,$//;
 $mail{Subject} =$self->{name}. ": ". $wW;
 $mail{Body} = $message;
 $mail{Body} .="\n\n----------------\n".$self->fC();
 $mail{Smtp}=$self->{cQz};
 &abmain::vS(%mail);
}
sub iTz {
 my ($self, $wW, $message) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 $mail{To} =  "Members";
 $mail{To} =~ s/,?$//;
 $mail{Subject} =$self->{name}. ": ". $wW;
 $mail{Body} = $message;
 $mail{Smtp}=$self->{cQz};
 $mail{Mlist}= $self->hWz();
 &abmain::vS(%mail);
}
sub sJa {
 my ($self, $to, $wW, $message) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 $mail{To} =  $to;
 $mail{To} =~ s/,?$//;
 $mail{Subject} =$self->{name}. ": ". $wW;
 $mail{Body} = $message;
 $mail{Smtp}=$self->{cQz};
 &abmain::vS(%mail);
}
sub wI{ 
 my ($self, $n, $p, $e, $gIz) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 $mail{To} = $e;
 $mail{Subject} = "Welcome to $self->{name}, $n";
 $mail{Cc} = $self->{admin_email} if $self->{fBz}; 
 my $on =$n;
 $n = &abmain::wS($n);

 $mail{Body} = qq(
 Welcome, $on!
 You are registered with $self->{name} 
 Username: $on 
 Password: $p
 Email:    $e
 URL:      @{[$self->fC()]}
 );
 $mail{Body} .=qq(

 To activate your account, please visit the following URL 
 $self->{cgi_full}?@{[$abmain::cZa]}cmd=activate;uname=$n;vkey=$gIz

 Some email programs may corrupt the long URL above, in that case,
 please go the page 
 $self->{cgi_full}?@{[$abmain::cZa]}cmd=tIz 
 and enter Username: $on, Validation key: $gIz
 
 After activating your account, you will be asked to use your user name and password to login.

 If you do not know what this is about, please contact the forum administrator. 
 $self->{cgi_full}

 ) if $gIz;

 $mail{Body} .= $self->{welcome_email};

 $mail{Smtp}=$self->{cQz};

 $abmain::wH = "E-mail validation disabled";
#x1
#x1
 return $abmain::wH;
} 
sub wG {
 my ($self, $n, $gIz) = @_;
 $self->fZz($n);
 if($self->{gFz}->{lc($n)}->[5] != $gIz) {
 	 &abmain::error('inval', "Invalid activation information");
 }else {
 $self->aG(lc($n), @{$self->{gFz}->{lc($n)}}[0, 1, 3], 
 $self->{user_init_stat}||'A', 0, @{$self->{gFz}->{lc($n)}}[6..9]);
 }
}
sub mTz {
 my ($self, $n, $e) = @_;
 my $np = (int rand() * time())%99999 + 100;
 $self->iMz($n, $np, $e, 0, 1);
 my %mail;
 $mail{From} = $self->{admin_email};
 $mail{To} = $e;
 $mail{Smtp}=$self->{cQz};
 $mail{Subject} = "Password for $self->{name}";
 $mail{Body}  = "Your new password is:\n$np\n\nThanks";
 abmain::vS(%mail);
 if($abmain::wH) {
 abmain::error('sys', $abmain::wH. " -- Send mail failed. Please contact admin at $self->{admin_email} to reset your password.");
 }else {
 abmain::cTz("Password has been sent to you by email");
 }
}
sub iMz {
 my ($self, $n, $p, $e, $c, $matche) = @_;
 $self->fZz($n);
 my $np = abmain::lKz($p);
 
 my $isadm =  lc($n) eq lc($self->{admin});

 if(not $self->{gFz}->{lc($n)}) {
 	 &abmain::error('inval', "User $n not found") if not $c;
 my $fMz = $self->{user_init_type}||'E';
 	 my $ustat = $self->{user_init_stat} || 'A';
	 if($isadm) {
		$fMz = 'E';
		$ustat = 'A';
	 }
 $self->{gFz}->{lc($n)}->[4]= $ustat;
 $self->{gFz}->{lc($n)}->[6]= $fMz;
 }

 my $err;
 if($err=abmain::jVz($n)) {
 abmain::error('inval', $err);
 }
 if(length($n) > $self->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($self->{sO})} characters");
 }

 if ($e ne $self->{gFz}->{lc($n)}->[1]  && $matche) {
 	&abmain::error('inval', "Incorrect email address");
 }

 $e = abmain::xJz($e) || $self->{gFz}->{lc($n)}->[1];
 abmain::error('miss', "A valid email address is required") if ($self->{rH} && (not $e) && (not $isadm));
 $self->aG(lc($n), $np, $e, @{$self->{gFz}->{lc($n)}}[3..9]);
 $self->save_user_passwd($n, $p);
}
sub wA {
 my ($self, $n, $gIz) = @_;
 $self->fZz($n);
 if($self->{gFz}->{lc($n)}->[5] != $gIz) {
 	 &abmain::error('inval', "Invalid activation information");
 }
 sVa::gYaA "Content-type: text/html\n\n";
 my @rules;
 if($self->{rules}) {
 @rules = ($self->{rules});
 }elsif($self->{rule_file} ){
 if( open(RULEFILE, "<$self->{rule_file}")) {
 @rules = <RULEFILE>;
 close RULEFILE;
 }else {
 @rules=("<i>Can not open rule file $self->{rule_file}</i>");
 }
 }else {
 }
 $self->eMaA( [qw(other_header other_footer)]);
 print qq(<html><head>\n$self->{sAz}\n<title>$self->{name}: Acceptance of the rules</title>$self->{other_header}
 <center>
 <h1>$self->{name}: Acceptance of the rules</h1>
 </center>
 <pre>@rules</pre>
 <p>
 <hr>
 <form action="$self->{cgi}" method="POST">
 @{[$abmain::cYa]}
 <center> 
 <input type="hidden" name="name" value="$n">
 <input type="hidden" name="vkey" value="$gIz">
 <input type="hidden" name="cmd" value="vO">
 <input type="checkbox" name="yJ" value="1">
 I have read the rules above carefully, 
 and <input type="submit" class="buttonstyle" name="accept" value="I accept the rules">
 </form>
 <br/> 
 <a href="/"> No thank you, goodbye</a> 
 </center>
 <hr>
$self->{other_footer}
 );
}
 
sub aG{
 my($self, $n, $p, $e, $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme) = @_;
 $self->fZz($n);
 my $fIz = $self->fRz($n);
 my $pfile2 = $self->eLaA($n);
 my $cE = $self->{fYz}->{lc($n)};
 my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 my $db2 = $bYaA->new($pfile2, {schema=>"AbUser", paths=>$self->dHaA($pfile2) });
 if($cE eq "") {
if($db->pXa()>11*5) { return; } 
 	$db->iSa(
 	    [$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]
 	);
	if($self->eOaA() && $self->{local_control}) {
 	  $db2->iSa(
 	    [$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]
	  );
	}
 }else {
	if($self->eOaA() && $self->{local_control}) {
 	  $db2->jXa(
 	    [[$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]]
 	  );
	  my $oldline = $self->{gFz}->{$n};
 my ($p2, $e2, $ct2, $hp2, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2) ;
 if ($oldline) {
 	( $p2, $e2, $ct2, $hp2, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2) = @$oldline;
		if($vkey ==0 && $vk2>0 && $st2 eq 'C' && $gDz eq 'A') {
			$vk2 =0;
			$st2 = 'A';
		}
 	  	$db->jXa(
 	  	  [[$n, $p, $e, time(), $fUz, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2]]
 	  	);
 }
 }else {
 	  $db->jXa(
 	    [[$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]]
 	  );
 }
 }
}

sub wRz {
 my($self, @cB) = @_;
 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 	   my $fU = $_->[0];
 next if ($_->[1] eq 'head' || $_->[1] eq 'const' || $_->[1] eq 'fixed');
 $self->{$fU} = undef;
 	}
 }
 
}
sub cJ {
 my($self, $cL, @cB) = @_;
 my %fL;
 my ($k, $v, $pos);
 open lW, "<$cL" or abmain::error('sys', "On reading file $cL: $!") ;
 while(<lW>){
 chomp;
 $pos = index $_, '=';
 $k = substr $_, 0, $pos;
 $v = substr $_, $pos+1;
 if($abmain::do_untaint) {$v =~ /(.*)/s; $v=$1;}
	  $jW::mid = pack("h*", $v) if($k eq '-');
	  if($k) {
		$v =~ s/\r$//;
 $v =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge; 
 $fL{$k} = $v;
	  }
 }
 close lW;
 if($self->{_blind_cfgs}) {
	for(keys %fL) {
		$self->{$_} = $fL{$_};
 }
	return;
 }
 
 my $fF;
 my $sq = '&#39;';
 foreach $fF (@cB) {
 next if not $fF;
 	foreach  (@{$fF}) {
 	   my $fU = $_->[0];
 	   next if not exists $fL{$fU}; 
 next if ($_->[1] eq 'head' || $_->[1] eq 'const' || $_->[1] eq 'fixed');
 	   $self->{$fU} = $fL{$fU} if exists $fL{$fU}; 
 $self->{$fU} =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/chr(hex($1))/ge; 
 $self->{$fU} =~ s/'/$sq/ge if($_->[1] eq 'text' || $_->[1] eq 'color') ;
 $self->{$fU} = pack("h*", $self->{$fU}) if($_->[1] eq 'htext') ;
 	}
 }
 
}
sub test_pattern{
	my $pat = shift;
	return 1 if $pat eq "";
	my $ok1 = eval { "" =~ /$pat/; 1};
	return if not $ok1;
	return ('a' =~ /$pat/)? 0: 1;
}

sub iA {
 my($self, @cB) = @_;
 $self->{eF} = {};
 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 next if($_->[1] eq 'head');
 next if($_->[1] eq 'const');
 next if($_->[1] eq 'fixed');
 	   my $fU = $_->[0];
 next if $self->{xcfgfs} && not $self->{xcfgfs}->{$fU};
	   if($_->[1] eq lc("password") ) {
 	        $self->{eF}->{$fU} = $abmain::gJ{$fU} if $abmain::gJ{$fU};
 }elsif ($_->[1] eq 'date') {
 	        $self->{$fU} = abmain::xUz(\%abmain::gJ, $fU); 
 }elsif( $_->[1] eq 'perlre') {
 	$abmain::gJ{$fU}=~ s/^\|+//;
 	$abmain::gJ{$fU} =~ s/\|+$//;
		if( test_pattern($abmain::gJ{$fU}) ) {
 	        	$self->{$fU} = $abmain::gJ{$fU}; 
		}else {
			abmain::error('inval', "Invalid pattern: $abmain::gJ{$fU}");
		}
	   }else { 
 $abmain::gJ{$fU} =~ s/</\&lt;/g if($self->{iPa} && $_->[1] =~ /^text/);
 &jEz(\$abmain::gJ{$fU}) if($self->{hZa} && $_->[1] =~ /^text/);
 	        $self->{$fU} = $abmain::gJ{$fU}; 
 }
	  
 	}
 }
}
sub yIz {
 my($self, $vf, @jS) = @_;
 for my $c (@jS) {
 $self->{$c} = $vf->{$c} if $vf->{$c} ne "";
 }
}
sub pJa {
	my $self = shift;
	my $dir = $self->{eD};
	$dir =~ s!/!-!g;
	$dir =~ s!:!_!g;
	$dir =~ s!\\!-!g;
	return "ABF$dir";
}
sub pDa {
	my ($self, $cfgf) = @_;
 $cfgf = $self->nDz('fU') if !$cfgf;
	$cfgf =~ s!/!-!g;
	$cfgf =~ s!:!_!g;
	$cfgf =~ s!\\!-!g;
	return abmain::kZz($abmain::master_cfg_dir, $cfgf);
}
sub shadow_cfg {
 my ($self, $cfgf) = @_;
 $cfgf = $self->nDz('fU') if !$cfgf;
 my $scfgf = $self->pDa($cfgf);
 local *F;
 chmod 0600, $cfgf;
 open F, "<$cfgf" or return;
 local $/ = undef;
 binmode F;
 my $line = <F>;
 close F;
 chmod 0000, $cfgf;
 open F, ">$scfgf" or return;
 binmode F;
 print F $line;
 close F;
 chmod 0600, $scfgf;
 return 1;
}
sub nCa{
 my ($self, $bak) = @_;
 my $cfgf = $bak ? $self->nDz('cfg_bak') : $self->nDz('fU');
 return $cfgf if not $abmain::shadow_cfg;
 my $scfgf = $self->pDa($cfgf);
 $self->shadow_cfg($cfgf)  if not -f $scfgf;
 return $scfgf;
}
sub cR{
 my($self, $cfgf, $blind) = @_;
 $cfgf = $self->nCa() if !$cfgf;
 my @eE;
 if($blind ) {
	$self->{_blind_cfgs}=1;
 }else {
 	for(values %abmain::eO) {
 	     push @eE, $_->[1];
 	}
	$self->{_blind_cfgs}=0;
 }
 
 $self->cJ($cfgf, @eE, \@abmain::bO, \@abmain::vC);
 $self->{_loaded_cfgs}=1;
 if($cfgf eq $self->nCa()) {
 $self->cJ(abmain::wTz('overcfg'), @eE, \@abmain::bO)
 if -r abmain::wTz('overcfg');
 $self->cJ($self->nDz('overcfg'), @eE, \@abmain::bO)
 if -r $self->nDz('overcfg');
 }

 $self->hack_headers();
 $self->lP();

 my @moders = split ("\t", $self->{moderator});
 my @jTz=split("\t", $self->{moderator_email});
 my @kFz=split("\t", $self->{vI});
 my @jHz=split("\t", $self->{vM});
 my @mod_can_polls=split("\t", $self->{mod_can_dopoll});
 my @jOz=split("\t", $self->{vN});
 my $mcnt = @moders;
 my $i;
 for($i=0; $i<$mcnt; $i++) {
 $self->{moders}->{$moders[$i]} = [$jTz[$i], $kFz[$i], $jHz[$i], $jOz[$i], $mod_can_polls[$i]];
 }
 $self->{lVz} = 1 if $self->{mAz};
 $abmain::tz_offset = $self->{tz_offset};
 for(keys %abmain::cP) {
 $abmain::cP{$_} = [ $self->{$_."_e0"}, $self->{$_."_e1"}, $self->{$_."_e2"}];
 };
 $abmain::msg_bg = $self->{msg_bg};
 $jW::random_seq = $self->{random_seq};
 $jW::random_seq = 0 if $abmain::use_sql;
 $self->{iW} = 16 if $self->{iW} <=0;
 $self->{aC} = 'index.html' if $self->{aC} eq '';
 $self->{idx_file} = 'gindex.html' if $self->{idx_file} eq '';
 $self->{ext} = 'html' if $self->{ext} eq '';
 @jW::bgs=($self->{cbgcolor0}, $self->{cbgcolor1});
}
 

sub hack_headers{
 my ($self) = @_;
 if($self->{forum_footer} ne "" || $self->{forum_layout}) {
	$self->{forum_header} = qq(<html><head></head><body>) if $self->{forum_header} !~ /<html>/i;
	$self->{forum_layout} = qq(FORUM_TOP_BANNER<br/>FORUM_MSG_AREA<br/>FORUM_BOTTOM_BANNER)
			 if $self->{forum_layout} !~ /FORUM_MSG_AREA/;
	$self->{forum_layout_new} = $self->{forum_header}.$self->{forum_layout}.$self->{forum_footer}; 
 }
 $self->{forum_layout_new} =~ /(<html>.*?<body.*?>)(.*)$/is;
 $self->{forum_layout} = $2;
 $self->{forum_header} = $1;

 if($self->{other_footer} ne "" || $self->{other_header} ne "") {
	$self->{other_page_layout} = qq(<html><head>).$self->{other_header}.qq(PAGE_CONTENT).$self->{other_footer}; 
 }
 $self->{other_page_layout} =~ /<html>.*?<head>(.*?)\bPAGE_CONTENT\b(.*)$/is;
 $self->{other_header} = $1;
 $self->{other_footer} = $2;

 if($self->{msg_footer} ne "" || $self->{msg_header} ne "") {
	$self->{msg_template} = qq(<html><head>).$self->{msg_header}.qq(PAGE_CONTENT).$self->{msg_footer}; 
 }
 $self->{msg_template} =~ /<html>.*?<head>(.*?)\bPAGE_CONTENT\b(.*)$/is;
 $self->{msg_header} = $1;
 $self->{msg_footer} = $2;
}
sub jLz {
 my $self = shift;
 my ($m, $p, @moders , @jTz, @kFz, @jHz, @jOz, @mod_can_polls);
 while( ($m, $p) = each  %{$self->{moders}}) {
 push @moders, $m;
 push @jTz, $p->[0];
 push @kFz, $p->[1];
 push @jHz, $p->[2];
 push @jOz, $p->[3];
 push @mod_can_polls, $p->[4];
 }
 $self->{moderator}= join("\t", @moders);
 $self->{moderator_email}= join("\t", @jTz);
 $self->{vI}= join("\t", @kFz);
 $self->{vM}=join("\t", @jHz);
 $self->{vN}=join("\t", @jOz);
 $self->{mod_can_dopoll}=join("\t", @mod_can_polls);
}

sub fetch_usr_attrib{
 my $self = shift;
 return if (time()-$self->{_attrib_compiled}) < 30;
 my $attrf = $self->nDz('usrfonts');
 my $oldct;
 my $lck = jPa->new($attrf, jPa::LOCK_EX());
 local *FF;
 my $nc=0;
 if(open FF, $attrf) {
		binmode FF;
		my @gHz = <FF>;
		$oldct = join("", @gHz);
		close FF;
 }
 
 my @gHz;
 if(length($self->{user_fonts_url}) > 10) {
	my $uf = abmain::mGa($self->{user_fonts_url});
	if($uf eq $oldct) {
		$nc =1;
	}else {
		open FF, ">$attrf";
		binmode FF;
		print FF $uf;
		close FF;
		

	}
	push @gHz, split /\n\r?/, $uf;
	
 }
 for my $l (@gHz) {
	my ($t, $f) = split /\s+/, $l, 2;
	my ($u, $v) = split '=', $f, 2;
	next if not $u;
 	abmain::jJz(\$u);
	my $lu = lc($u);
	$self->{_usr_fonts}->{$lu} = $v;
 	if(not $nc) {
		$self->fZz($lu);
		$self->{_adm_mod_reg} =1;
		$self->{gFz}->{$lu} ->[6] = $t;
		my @uinfo = @{$self->{gFz}->{$lu}}[0,1, 3..10]; 
		$self->aG($lu, @uinfo);

 	}
 }
 $self->{_attrib_compiled} = time();
 
}
sub hVz{
 my $self = shift;
 return if (time()-$self->{_fonts_compiled}) < 30;
 my $uf = $self->{user_fonts};
 my @gHz = split "\n", $uf;
 for(@gHz) {
	my ($u, $v) = split '=', $_, 2;
	next if not $u;
 	abmain::jJz(\$u);
	$self->{_usr_fonts}->{lc($u)} = $v;
 }
 $uf = $self->{user_subj_fonts};
 $self->fetch_usr_attrib();
 @gHz = split "\n", $uf;
 for(@gHz) {
	my ($u, $v) = split '=', $_, 2;
	next if not $u;
 	abmain::jJz(\$u);
	$self->{_usr_subj_fonts}->{lc($u)} = $v;
 }
 $self->{_fonts_compiled} = time();
}
sub rAa {
 my($self, $old, $new) = @_;

 my @eE;
 $old = "\Q$old\E";
 for(values %abmain::qJa) {
	my $eE = $_->[1];
 for(@$eE) {
		my $k = $_->[0];
		$self->{$k} =~ s/$old/$new/g;
	}
 }
}
sub cOz{
 my($self, $cL, $sec, $negate) = @_;
 $sec = "All" if not $sec;
 $cL = $self->nCa() if !$cL;
 my @eE;
 for(values %abmain::qJa) {
 if(!$negate) {
 	next if $sec ne "All" && $_->[0] ne $sec;
 }else {
 	next if ($sec eq "All" || $_->[0] eq $sec);
 }
 push @eE, $_->[1];
 }
 $self->cJ($cL, @eE);
 $self->lP();

 $self->hack_headers();
}
sub cNz{
 my($self, $cL) = @_;
 $cL = $self->nCa() if !$cL;
 my @eE;
 for(values %abmain::gRz) {
 push @eE, $_->[1];
 }
 $self->cJ($cL, @eE, \@abmain::bO, \@abmain::vC);
}
sub lP {
 my($self) = @_;
 @lB::mP = ($self->{qP}, $self->{qQ});
 @lB::eK = ($self->{sM}, $self->{sN});
 @lB::dR=($self->{sP}, $self->{sQ});
}
sub cW {
 my($self, $cL, @cB) = @_;

 for(@abmain::rC) {
	my $k = $_->[0];
	if($self->{$k} =~ /\|/) {
		abmain::error('inval', "Configuration value cannot contain pipe symbol.");
 }

 }
 local *lW;
 chmod 0600, $cL;
 open lW, ">$cL" or abmain::error('sys', "On writing file $cL: $!") ;

 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 next if ($_->[1] eq 'head');
 next if ($_->[1] eq 'const');
 	    print lW $_->[0], "=";
 my $v = $self->{$_->[0]};
 if ($_->[1] eq 'htext'){
		print lW unpack("h*", $v);
 }elsif(1||$_->[1] eq 'textarea' || $_->[1] eq 'htmltext') {
 $v =~ s/\r\n/\n/g;
 print lW abmain::wS($v)  or abmain::error('sys', "On writing file $cL: $!") ;
 }else {
 print lW $v or abmain::error('sys', "On writing file $cL: $!") ;
 }
 print lW  "\n";
	}
 }
 close lW;
}
sub hL {
 my($self, $cL, $noids) = @_;

	$self->{forum_header}=undef;
	$self->{forum_footer}=undef;
	$self->{forum_layout}=undef;
	$self->{other_header}=undef;
	$self->{other_footer}=undef;
	$self->{msg_header}=undef;
	$self->{msg_footer}=undef;

 my @eE;
 for(values %abmain::eO) {
 push @eE, $_->[1];
 }
 $cL = $self->nDz('fU') if not $cL;
 if($noids) {
 	$self->cW($cL, @eE);
 }else {
 	$self->jLz;
 	$self->cW($cL, @eE, \@abmain::bO, \@abmain::vC);
 }
 if($cL eq $self->nDz('fU') && $abmain::shadow_cfg) {
	$self->shadow_cfg();
 }
}
sub iKz {
 my ($self, $name) = @_;
 if($self->{moders}->{$name}) {
 abmain::error("inval", "Moderator $name exists already");
 }
 $self->{moders}->{$name} = ["", "", "", ""];
 $self->hL();
}
sub iLz {
 my ($self, $name) = @_;
 if(not $self->{moders}->{$name}) {
 abmain::error("inval", "Moderator $name does not exist");
 }
 delete $self->{moders}->{$name}; 
 $self->hL();
}
sub mR {
 my($self) = @_;
 $self->bI();

 my @jS= split '-', $abmain::gJ{by};
 if($abmain::gJ{xcfgfs}) {
 	my @xcfgs= split '-', $abmain::gJ{xcfgfs};
 	for(@xcfgs) {
 		$self->{xcfgfs}->{$_}=1;
 	}
 }
 for(@jS) {
 next if not $_;
 my $fU= $abmain::eO{$_};
 $self->iA($fU->[1]) ;
 }
 $self->lP();
 $abmain::tz_offset = $self->{tz_offset};
}
sub lI {
 my($self) = @_;
 $self->bI();
 abmain::vA();
 $self->iA(\@abmain::bO);
 my $sf = $self->nDz('skey');
 my $ptmp = "";
 if(open SF, $sf) {
	$ptmp =<SF>;
	$ptmp =~ s/\s//g;
	close SF;
 }
 if($self->{eF}->{mS} ne $self->{eF}->{dQz} ) {
	     	abmain::error('inval', "New passwords do not match.");
 }
 my $cE = abmain::lKz($self->{eF}->{oA}, $self->{oA});
 if($self->{oA} ne $cE && $self->{oA} ne "") {
 #sleep(1);
	     	abmain::error('dM', "Wrong admin password.") 
			unless $ptmp && $ptmp eq $cE;
 }
 $self->{oA}=abmain::lKz($self->{eF}->{mS});
 unlink $sf;
 
}

sub gHaA{
 my($self, $input) = @_;
 $self->cR();
 $self->bI();
 abmain::vA();
 my @opts = split("\0", $input->{_baseopts});
 $self->{core_opts} = join (" ", @opts);
 $self->hL();
 abmain::cTz("Options saved");
}

sub gGaA {
	my ($self, $input) = @_;
 	my @all_cfgs;
 	for(values %abmain::qJa) {
 	     push @all_cfgs, @{$_->[1]};
 	}
 my @ocfgs;
 $self->cR();
	$self->gRaA();
	for(@all_cfgs) {
		if($_->[1] eq 'head') {
			push @ocfgs, $_;
		}else {
			my $v = $self->{_core_opts}->{$_->[0]} ? $_->[0] : undef;
			
			push @ocfgs, ['_baseopts', 'checkbox', "value=".$_->[0], $_->[3], undef, $v];
		}
 }
 	$self->jI(\@ocfgs, "gHaA", "Choose basic forum options");

}

sub hEaA{
 my($self, $input) = @_;
 $self->cR();
 $self->bI();
 abmain::vA();
 abmain::error('inval', "You must check the confirmation box") if not $input->{kIz};
 require WWWB2AB;
 my $ok = WWWB2AB::convert_wwwforum(abmain::kZz($input->{w3bbasedir}, "messages"), $self->{eD});
 $self->nU(1) if $ok;
}

sub gRaA {
	my ($self) = @_;
	my @opts = split /\s/, $self->{core_opts};
	my $opt_hash = {};
	for(@opts, @abmain::core_cfgs) {
		$opt_hash->{$_}=1;
	}
 $self->{_core_opts} = $opt_hash;
}

sub jMz{
 my($self) = @_;
 $self->bI();
 $self->iA(\@abmain::vC);
 $self->{vI}=abmain::lKz($self->{eF}->{vI});
 if(not $self->{moders}->{$self->{moderator}}) {
 abmain::error('inval', "Moderator does not exist");
 }
 $self->{moderator_email} =~ s/\s//g;
 $self->{moders}->{$self->{moderator}}= 
 [ $self->{moderator_email}, $self->{vI}, $self->{vM}, $self->{vN}, $self->{mod_can_dopoll}];
}
sub cNaA {
 my ($self, $kQ) = @_; 
 my $url = $self->fC();
 my $str = qq(<table border="0" cellpadding="5" width=60% align=center class="UserControlPanel">);
 my $i=0;
 $str .= jW::nKz($bgs[$i++%2], qq(<a href="$url"> Go to $self->{name} </a>) ); 
 my $palert;
 if($self->{kWz}) {
 my ($mycnt, $myt) = $self->wUz($kQ);
 my $str2;
 my $d = int $myt /24/60;
 my $h = int (($myt - $d * 24*60) /60);
 my $m = $myt % 60;
 my $t;
 $t = "$d days " if $d >0;
 $t = "$h hours " if ($h >0 && not $t);
 $t = "$m minutes" if ($m >0 && not $t);
 $t = "0 minutes" if not $t;
 $str2 = ", updated $t ago" if $mycnt >0;
 $palert = $self->mYa($kQ);
 $str .= jW::nKz($bgs[$i++%2],  
 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "Go to $self->{kRz}"). " ($mycnt messages $str2)<br/>$palert");
 my $pmb = $self->eKaA(lc($kQ));
 $str .= jW::nKz($bgs[$i++%2], $pmb) if $pmb; 
 }
 
 if($self->{gFz}->{lc($kQ)}->[4]) {
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=xV", "Modify your registration"));
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=mform", "Edit your profile, such as signature"))
 if $self->{mp_enabled}; 
 }
 if(!$self->{no_user_doc}) {
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}docmancmd=fVaA", "Manage your documents"));
 }
 if($self->{login_msg}) {
 $str .= qq(<tr bgcolor="$self->{cfg_head_bg}"><td align="center"><h2><font $self->{cfg_head_font}>Message from forum administrator</font></h2></td></tr>
 <tr><td>$self->{login_msg}</td></tr>);
 }
 $str .="</table>";
 return $str;
}
sub gOaA {
 my ($self, $noerr) = @_;
 my $ipok = 1;
 my $ippass = 0;
 my $dmok = 1;
 my $dmpass = 0;
 my $isadm =0;
 if($self->{xD} && $ENV{'REMOTE_ADDR'} =~ /$self->{xD}/){
	$ipok = 0;
 }
 $ippass = 1 if ($self->{allowed_ips} && $ENV{REMOTE_ADDR} =~ /$self->{allowed_ips}/); 
 
 if ($self->{lDz} || $self->{allowed_dms}) { 
 	$self->{_cur_user_domain} = abmain::lWz(undef, 1) ;
 }
 if ($self->{lDz} && $self->{_cur_user_domain} =~ /$self->{lDz}/i) {
		$dmok =0;
 }
 $dmpass = 1 if ($self->{allowed_dms} && $self->{_cur_user_domain} =~ /$self->{allowed_dms}/i); 

 if( not ( ($ipok && $dmok) || ($ippass|| $dmpass) ) ){
 		my $isadm = $self->yXa();
		return 1 if $isadm;
		abmain::error('deny') if not $noerr;
		return 0;
 }
 return 1;
 
}

sub kB {
 my($self) = @_;
 abmain::error('iT', 'Cookie not received') unless ($abmain::fPz{test_cook} || not $self->{force_cookie}) ;
 $self->iA(\@abmain::pP);
 abmain::jJz(\$self->{kQ});
 $self->fZz($self->{kQ});
 if($self->{gFz}->{lc($self->{kQ})}->[5] >0) {
 	  abmain::error("inval", "You must activate your account first.");
 }
 my $ustat = $self->{gFz}->{lc($self->{kQ})}->[4];
 abmain::error('inval', "User is not activated")
	             if($ustat ne '' && $ustat ne 'A');
 my $qIz = abmain::wS($abmain::gJ{qIz})  if($abmain::gJ{qIz}) ;
 my $cE= $self->{fYz}->{lc($self->{kQ})};
 my $auth_stat = $self->auth_user($self->{kQ}, $self->{eF}->{nC});
 if($auth_stat eq 'NOUSER' && $self->{gAz}) {
 my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV;qIz=$qIz", $self->{sK});
 abmain::error("dM", "User not found. Please $tP.");
 }
 if($auth_stat eq 'AUTHFAIL'){
 $self->wNz(0, $self->{kQ}, $self->nDz('usrlog'));
 my $req;
 $req = "<br/>". abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=reqpassform", "Request lost password") if($self->{mWz});
	 
	abmain::bP("Incorrect password.$req");
	return;
 }
 if(not $self->gOaA(1)) {
 $self->wNz(0, $self->{kQ}, $self->nDz('usrlog'));
 abmain::error('deny');
 }
 $self->wNz(1, $self->{kQ}, $self->nDz('usrlog'));
 my $uid_c = unpack("h*", $self->{kQ});
 $cE = unpack("H*", $self->{eF}->{nC});
 my $url = $self->fC();
 my $cookexp="";
 if($self->{rem_upass}) {
 $cookexp=abmain::dU('pJ', 10*3600*24);
 }
 my $cVz;
 my $i;
 if($abmain::gJ{qIz}) {
 $cVz=qq(<META HTTP-EQUIV="refresh" CONTENT="2; URL=).$abmain::gJ{qIz}.'">';
 }

 $self->eMaA( [qw(other_header other_footer)]);
 sVa::gYaA "Content-type: text/html\n";
 print abmain::bC('fOz', "$uid_c\&$cE", '/',$cookexp), "\n";
 print qq(<html><head>$cVz\n$self->{sAz}\n$self->{other_header}
 <center>
 <table border="0" cellpadding="5" width=60%><tr rowspan=2 bgcolor="$self->{cfg_head_bg}"><th><font $self->{cfg_head_font}>Logged onto $self->{name}</font></th></tr></table>
		</center>
 );
 print $self->cNaA($self->{kQ});
 print "$self->{other_footer}";
 $self->fSa($self->{kQ}, "Login");
}

sub eIaA {
	my ($self, $input) = @_;
 $self->cR();
	$self->{yLz} = 'POST';
	$self->{tHa} = 1;
	$self->gCz();
 $self->eMaA( [qw(other_header other_footer)]);
 	sVa::gYaA "Content-type: text/html\n\n";
 	print qq(<html><head>$self->{sAz}\n$self->{other_header}
 <center>
 <table border="0" cellpadding="5" width=60%><tr rowspan=2 bgcolor="$self->{cfg_head_bg}"><th><font $self->{cfg_head_font}>User control panel</font></th></tr></table>
		</center>
 );
 	print $self->cNaA($self->{fTz}->{name});
 	print "$self->{other_footer}";
}
sub fTaA {
	my ($self, $input) = @_;
}

sub dFaA{
	my ($self, $input) = @_;
 $self->cR();
	$self->{yLz} = 'POST';
	$self->{tHa} = 1;
	$self->gCz();
 $self->eMaA( [qw(other_header other_footer)]);
 	sVa::gYaA "Content-type: text/html\n\n";
 	print qq(<html><head>$self->{sAz}\n$self->{other_header});
	my $pms = $input->{pmurl};
	my @urls = split "\0", $pms;
	for my $url (@urls) {
		$self->dYaA($self->{fTz}->{name}, $url);
	}
 	print qq(
 <center>
 <table border="0" cellpadding="5" width=60%><tr rowspan=2 bgcolor="$self->{cfg_head_bg}"><th><font $self->{cfg_head_font}>User control panel</font></th></tr></table>
		</center>
 );
 	print $self->cNaA($self->{fTz}->{name});
 	print "$self->{other_footer}";
}

sub dRaA {
	my ($self, $rdir) = @_;
	$rdir =~ s/^\.\.$//g;
	my $dir = sVa::kZz($self->{eD}, $rdir);
 	opendir DIR, "$dir";
 	my @entries = readdir DIR;
 	closedir DIR;
	my @drows;
	my @frows;
	my @ds = sort { lc($a) cmp lc($b) } @entries;
	for my $de (@ds) {
		my $path = sVa::kZz($self->{eD}, $de);
		my @stats = stat($path);
		my $owner = eval 'getpwuid($stats[4])';
		my $perm = sprintf("%04o", $stats[2] & 07777);
		my $size = $stats[7];
		my $mt = $stats[9];
		if(-d $path) {
		}else {
		}
	}	
}
sub wNz {
 my ($self, $ok, $kQz, $file) = @_;
 my $gDz = $ok? "OK": "<font color=red>FAIL</font>";
 $gDz = $ok if $self->{yLz} eq 'POST';
 my $cook = $abmain::ab_track;
 if ($self->{yLz} eq 'POST') {
	$gDz = $ok;
 $cook .= '@'.$abmain::agent;
 }
 chmod 0600, $file;
 $kQz = $abmain::ab_id0 if not $kQz;
 $bYaA->new($file, {schema=>"AbLoginLog", index=>2, paths=>$self->zOa('login') })->iSa(
 [$kQz, $gDz, time(), abmain::lWz(), $cook]
 );
 chmod 0000, $file;
}
sub sLa{
 my ($self) = @_;
 my $qIz=abmain::wS($abmain::orig_url);
 return "$self->{cgi}?@{[$abmain::cZa]}cmd=dW;qIz=$qIz"
}
#return 'AUTHOK' if user exists and OK, 'NOUSER' if user does not exist, 'AUTHFAIL' if user exists but password is not OK

sub auth_user {
	my ($self, $gJz, $passwd)= @_;
 	return 'NOUSER' if ($self->{fYz}->{lc($gJz)} eq  '');
 	return $self->{fYz}->{lc($gJz)} eq  abmain::lKz($passwd, 'ne') ? 'AUTHOK':'AUTHFAIL';
}

sub save_user_passwd{
	my ($self, $gJz, $passwd)= @_;
}

sub gCz {
 my($self, $noerr, $logop) = @_;
 my $gEz = $abmain::fPz{fOz};
 my $qIz=abmain::wS($abmain::orig_url);
 my  $fNz= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=dW;qIz=$qIz", $self->{fKz});
 if(!$gEz) {
 if(($self->{force_login_4read} || $self->{tHa} ||($self->{yLz} eq 'RATE' && $self->{rRz})) && !$noerr) {
	      sVa::hCaA "Location: $self->{cgi_full}?@{[$abmain::cZa]}cmd=dW;qIz=$qIz\n\n";
 	      &abmain::iUz;
	  }
 return;
 }
 my ($gJz, $fJz) = split/\&/, $gEz;
 $gJz = pack("h*", $gJz);
 $fJz = pack("H*", $fJz);
 $self->fZz($gJz);

 my $auth_stat =  $self->auth_user($gJz, $fJz);
 if( $auth_stat eq 'AUTHFAIL') {
 		abmain::error('dM', "You need to $fNz.") unless $noerr;
 return;
 }
 if($self->{gAz} && $auth_stat eq 'NOUSER'){
 	abmain::error('dM', "You need to relogin: $fNz.") unless $noerr;
 return;
 }
 abmain::error('inval', "User is not activated")
	             if($self->{gAz} && $self->{gFz}->{lc($gJz)}->[4] ne 'A');

 abmain::error('deny', "This operation is enabled for adminitrator only.")
 if($self->{_admin_only} && lc($gJz) ne $self->{admin});

 $self->oXa($gJz);
 return 1;
}
sub oXa {
 my ($self, $uid1) = @_;
 my $gJz = lc($uid1);
 $self->{fTz}->{name}=$uid1;
 $self->{fTz}->{email}=$self->{gFz}->{$gJz}->[1];
 $self->{fTz}->{reg}=0;
 $self->{fTz}->{status} = $self->{gFz}->{$gJz}->[4];
 $self->{fTz}->{type} = $self->{gFz}->{$gJz}->[6];
 $self->{fTz}->{wO} = $self->{gFz}->{$gJz}->[3];
 if(length($self->{fYz}->{$gJz})>0) {
 $self->{fTz}->{reg}=1;
 }
 $self->{fWz} = 1;
}
sub cPz {
 my ($self, $ufile)=@_;
 return abmain::kZz($self->nDz('updir'),$ufile);
}
sub bOa {
 my ($self, $ufile)=@_;
 my @files = split /\s+/, $ufile;
 my @paths = map { abmain::kZz($self->nDz('updir'),$_) } @files;
 return @paths;
}
sub qZz {
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz.".pol");
}
sub rJz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz.".dat");
}
sub qTz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz.".js");
}
sub xQz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz.".$self->{ext}");
}
sub xFz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz."_res.$self->{ext}");
}
sub rKz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz."_res.js");
}
sub qYz{
 my ($self, $qQz)=@_;
 return abmain::kZz($self->nDz('qUz'),$qQz.".sum");
}
sub dIz{
 my($self, $gV) = @_;
 return $self->dMz() if $gV;
 my $pre="";
 $pre = "f" if $self->{dDz};
 return $pre.$self->{aC};
}
sub dMz{
 my($self) = @_;
 my $pre="";
 $pre = "f" if $self->{dDz};
 return $pre.$archfile.".".$self->{ext};
}
sub dGz {
 my($self) = @_;
 return $self->{eD} .  $self->dIz();
}
sub jWz {
 my($self, $pgno, $ofp) = @_;
 $pgno ="" if not $pgno;
 return $self->{eD} .  $pgno.$ofp.$self->dIz();
}
sub dHz {
 my($self) = @_;
 return $self->{eD} .  $self->dMz();
}
sub kBz {
 my($self, $pg, $ofp) = @_;
 return $self->{eD} . $pg. $ofp. $self->dMz();
}
sub lMa{
 my ($self, $file, $r, $chk) = @_;
 my $suf = ""; $suf = rand() if $r;
 if((not $self->{_off_web}) && (not $abmain::off_webroot) && (not $self->{dyna_forum}) && (not ($chk && $self->{mFa}) )) {
 if(not $r) {
 		return abmain::kZz($self->{pL} , sVa::cIaA($file));
 }else {
 		return abmain::kZz($self->{pL} , sVa::cIaA($file)."?$suf");
 }
 }else {
	my $f = dZz::nBz($file);
	$f =~ s/\n$//;
	$f =~ s/\r$//;
	$f = abmain::wS($f);
	$file =~ s!.*/!!;
	my $cgi = $self->{cgi_full};
	if((not $abmain::no_pathinfo) && (not $self->{_no_pi}) ) {
		#$cgi= abmain::kZz($cgi, $abmain::bRaA,$file);
 }
 	return "$cgi?@{[$abmain::cZa]}cmd=retr;vf=$f";
 }
}
sub dKz {
 my($self) = @_;
 return $self->lMa($self->dIz(),0, 1);
}
sub hFz {
 my($self, $pgno, $ofp) = @_;
 $pgno ="" if not $pgno;
 return $self->lMa($pgno.$ofp. $self->dIz(), 0, 1);
}
sub dCz {
 my($self) = @_;
 return $self->lMa($self->dMz(), 0, 1);
}
sub kCz {
 my($self, $pgno, $ofp) = @_;
 $pgno ="" if not $pgno;
 return $self->lMa($pgno.$ofp.$self->dMz(), 0, 1);
}
sub zR {
 my($self, $sufix) = @_;
 my $cook = $self->{_fvp};
 $cook =~ s#/##g;
 return $cook.$sufix;
} 
sub fC {
 my($self, $ab) = @_;
 if($self->{allow_user_view}) {
 	return "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=0";
 }
 return $self->lMa($self->{aC},0,1);
}
sub sPz {
 my($self) = @_;
 return $self->lMa(abmain::kZz("chat", "index.html"), 1); 
}
sub kTz {
 my($self, $name) = @_;
 $name = abmain::wS($name);
 return "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=A;kQz=$name";
}
sub dFz{
 my($self) = @_;
 return $self->{eD} . $self->{aC};
}
sub xMz{
 my($self) = @_;
 my $pre;
 $pre = "g" if $self->{aC} eq $self->{idx_file};
 return abmain::kZz($self->{eD}, $pre.$self->{idx_file});
}
sub xIz{
 my($self) = @_;
 return $self->fC() if not $self->{enable_grp_intf};
 my $pre;
 $pre = "g" if $self->{aC} eq $self->{idx_file};
 return $self->lMa($pre.$self->{idx_file});
}
sub dRz {
 my($self, $gV, $attr) = @_;
 return $gV?
 abmain::cUz($self->pRa(), $self->{qKz}, $self->{dDz}?'_parent':'', $attr):
 abmain::cUz($self->fC(), $self->{tF}, $self->{dDz}?'_parent':'', $attr);
}

 

sub dOz {
 my($self) = @_;
 return "" if $self->{hide_flink};
 if(-f $self->nCa()) {
 	return abmain::cUz($self->fC(), $self->{name}, $self->{dDz}?'_parent':'');
 }else {
 	return abmain::cUz("javascript:history.go(-1)", "Back", $self->{dDz}?'_parent':'');
 }
}

 
sub dEz {
 my($self) = @_;
 return abmain::kZz($self->{eD},  $archfile.".".$self->{ext});
}
sub tmpfile {
 my($self) = @_;
 return $self->{eD} . time(). ".tmp";
}
sub fQz {
 my($self) = @_;
 if ($self->{passd}) {
 $self->{passd} =~ s#/?$#/#;
 return $self->{passd};
 }
 return $self->{bUz}? $self->nDz('passdir') : $abmain::oC;
}

sub eOaA{
 my ($self) = @_;
 return 1 if not $self->{bUz};
 return 1 if $self->{passd} && $self->{passwd} ne $self->nDz('passdir');
 return 0;
}

sub dBaA{
 my ($self) = @_;
 return $self->nDz('passdir');
}
sub bPa{
	my ($kQz)=@_;
 	$kQz = lc($kQz);
 	$kQz =~ s/(\W+)/unpack("h*", $1)/e;
	return $kQz;
}
sub bJa {
 my($self, $kQz, $ext) = @_;
 $kQz = lc($kQz);
 $kQz = jW::bPa($kQz);
 $ext = "prf" if not $ext;
 if( ! -d $self->fQz()) {
 	mkdir $self->fQz, 0755 or abmain::error("Fail to create directory ".$self->fQz().": $!");
 }
 my $profd = abmain::kZz($self->fQz(), "members.dir");
 if( ! -d $profd) {
 	mkdir $profd, 0755 or abmain::error("Fail to create directory $profd: $!");
 }
 return abmain::kZz($profd, $kQz.".$ext");
}
sub gTaA {
 my($self, $kQz) = @_;
 $kQz = lc($kQz);
 $kQz = jW::bPa($kQz);
 my $ext = "doc";
 my $profd = abmain::kZz($self->fQz(), "members.dir");
 if( ! -d $profd) {
 	mkdir $profd, 0755 or abmain::error("Fail to create directory $profd: $!");
 }
 my $docd=  abmain::kZz($profd, $kQz.".$ext");
 if( ! -d $docd) {
 	mkdir $docd, 0755 or abmain::error("Fail to create directory $docd: $!");
 }
 return $docd;
}

sub pRa {
 my($self) = @_;
 return $self->lMa($archfile . ".".$self->{ext});
}
sub nDz {
 my ($self, $which, $dir)=@_;
 my $wf = $jW::hNa{$which};
 abmain::error('sys', "File for $which is not set!") if $wf eq "";
 if(($^O=~/win/i && $abmain::new_win32_user) || $abmain::no_dot_file) {
	$wf =~ s/^\.//;
 }
 return abmain::kZz($dir||$self->{eD}, $wf);
}
sub mZa{
 my ($self, $cG, $suf)=@_;
 my $wf = $jW::hNa{'rating'};
 if(($^O=~/win/i && $abmain::new_win32_user) || $abmain::no_dot_file) {
	$wf =~ s/^\.//;
 }
 my $code = ($cG%$jW::hash_cnt) || 0;
 $suf ||="";
 if($abmain::use_sql) {
 	return $self->nDz('msglist') if not $suf; 
 	return $self->nDz('archlist') if $suf eq 'a'; 
 	return $self->nDz('dmsglist') if $suf eq 'd'; 

 }
 return abmain::kZz($self->nDz('iC'), $wf.$code.$suf);
}
sub hGa{
 my $self=shift;
 my %hash = @_;
 my @vals = @hash{@lB::mfs};
 $self->mO(@vals);
}
sub mO {
 my $self = shift;
 if($_[1] < 0) {
 return;
 }
 my $eS = $self->nDz('msglist'); 
 $self->oF();
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iSa(
 [@_],
 {kG=> "On writing file"}
 );
 chmod 0600, $eS;
 $self->pG();
 my $entry= lB->new(@_);
 $self->{dA}->{$entry->{fI}} = $entry;
 $self->{eN}->nB($self, $entry);
 push @{$self->{pC}}, $entry;
 $self->{dI}++;
 $self->{uC} = $entry;
}
sub iFa {
 my ($self, $path, $chkmov, $rds) = @_;
 my $ok = $self->gCz(!$self->{force_login_4read});
 
 $path =~ s/^\.\.$//g;
 my $root = $self->{eD};
 $root =~ s/\\/\//g;
 $path =~ s/\\/\//g;
 if($path !~ /^$root/) {
	$path = abmain::kZz($root, $path);
 }
 $path =~ s/`|\|&//g;
 $path =~ /\S+\.([^\.]*)$/;
 
 my $type = lc($1) || "octet-stream";
 my %mimemap=(cac=>'text/html', txt=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg', vcf=>'text/v-card'); 
 my $lRa= $mimemap{$type} || "application/$type";
 $lRa='text/html' if $lRa =~ /(htm|asp|php)/i || $path =~ /\.pv$/g;
 my $olv = $/;
 $/ = undef;
 if(not open F, "<$path") {
	if($chkmov && $path =~ /\.pv$/) {
		my $path2 = $path;
		$path2 =~ s/\.pv$//;
		if( -f $path2) {
			rename $path2, $path if -e $path2;
 			open F, "<$path"  or abmain::error('inval', "$path:: $!");
		}else {
			abmain::error("inval","$path: $!");
		}
 }else {	
		abmain::error("inval","$path: $!");
	}
 } 
 binmode F;
 sVa::gYaA "Content-type: $lRa\n";
 if(not ($lRa =~ /text/i || $lRa =~ /image/i || $lRa =~ /script/i)) {
 	print qq(Content-Disposition: attachment; filename="$path"\n);

 }
 if(not $abmain::fPz{vis}){
 	   print abmain::bC('vis', time, "/", abmain::dU('pJ', 60*3600*24));
 }
 print "\n";
 my $line = <F>;
 close F; 
 $/ = $olv;

 if(not $lRa =~ /text/) {
	binmode STDOUT;
	print $line;
	return;
 }
 my %cUa;
 if($lRa =~ /text/ && $self->{fTz}->{name}) {
	$cUa{LOGIN_USER} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=ulogout", $self->{logout_word}). " <b>" . $self->{fTz}->{name}."</b>";
	$cUa{PRIVATE_MSG_ALERT} = $self->mYa($self->{fTz}->{name});
 }
 if($rds) {
	$cUa{MSG_READERS} = "$self->{readers_lab} <b>".join(",\&nbsp; ", split (/,/, $rds))."</b>"; 	
 }
 $cUa{LOCAL_USER_LIST} = $self->mMa();
 my $all_fs = "";
 $all_fs = abmain::gIaA() if $self->{compute_forum_list};
 $cUa{ALL_FORUMS_LIST} = $all_fs;
 print  jW::mUa($line, \@jW::dyna_tags, \%cUa); 
}
sub jA {

 my ($self, $fI, $type, $gV, $priv) = @_;
 my $mdir = $gV? $jW::hNa{mK}: $jW::hNa{hM};
 my $eS;
 my $suf ="";
 $suf = ".pv" if $priv;

 if($fI>0) {
 $eS= "$fI.". $self->{ext}.$suf;
 }else {
 $eS = $gV? $self->dMz() : $self->dIz();
 $mdir = "";
 }

 if($type eq 'jD') {
 return "$eS";
 }
 elsif($type eq 'kU') {
 return abmain::kZz($mdir, $eS);
 }else {
 return $self->lMa(abmain::kZz($mdir, $eS));
 }
}
sub pIa{
 my $gEz = $abmain::fPz{SSOCookie};
 my $plain_logstr = dZz::fIa($gEz);
 my @entities = split/\|/, $plain_logstr;
 my $gJz = $entities[2];
 return $gJz;
}
sub fA {
 my ($self, $fI, $gV, $pv) = @_;
 $fI =~ /(.*)/; $fI = $1;
 my $suf ="";
 $suf = ".pv" if $pv;
 my $mdir = $gV? $jW::hNa{mK}: $jW::hNa{hM};
 return abmain::kZz($self->{eD} , $mdir,  "$fI.". $self->{ext}).$suf;
}
sub fRz {
 my ($self, $user) = @_;
 $user = lc($user);
 my $hno = abmain::fVz($user, $passwd_cnt) || "0";
 return abmain::kZz($self->fQz(),$hno);
}
sub eLaA {
 my ($self, $user) = @_;
 $user = lc($user);
 my $hno = abmain::fVz($user, $passwd_cnt) || "0";
 return abmain::kZz($self->dBaA(),$hno);
}
sub rD {
 my ($self, $user) = @_;
 my @hTa;
 my $passwdir = $self->fQz();
 my $do_loc = $self->eOaA() && $self->{local_control};
 my $locd= $self->dBaA();
 for(my $i=0; $i<$passwd_cnt; $i++){
 	if($do_loc) {
 	   push @hTa, abmain::kZz($locd,$i);
	}else {
 	   push @hTa, abmain::kZz($passwdir,$i);
	}
 }
 return @hTa;
}
sub cIz {
 my ($self) = @_;
 opendir DIR, $self->nDz('iC') or abmain::error('sys', "Fail to open directory: $!");
 my @files = grep { /\.dat$/ } readdir (DIR);
 closedir (DIR);
 return \@files;
}
sub gN{
 my ($self, $fI) = @_;
 $fI =~ /(.*)/; $fI = $1;
 return abmain::kZz($self->nDz('iC') , "$fI.dat") ;
}
sub nSa{
 my ($self, $gQ) = @_;
 my $f = abmain::wTz('forums');
 my ($fsref, $fshash) = abmain::pTa();
 push @$fsref, [$self->{eD}, $self->{pL}, $self->{cgi_full}, $self->{category}, $abmain::fvp];
 my @rows;
 my %rE;
 for(@$fsref) {
	next if $gQ && $self->{eD} eq $_->[0];
	next if $rE{$_->[0]};
	$rE{$_->[0]} = 1;
	push @rows, $_;
 }
 $bYaA->new($f, {schema=>"AbForumList"})->iRa(\@rows, {kG=>"Fail to open forum list"}); 
}
sub oF {
 my ($self, $qU, $gK, $lockfdir) = @_;
 $gK = "0" if not $gK;
 return if (!$self->{qG});
 #abmain::error('sys', "Your system is missing Fcntl:flock") if $no_flock;
 my $lf = $self->nDz('lock', $lockfdir)."$gK";
 $qU = LOCK_EX if ((!$qU) || not -f $lf);
 my $lock_fh= eval "\\*lT$gK";
 if($qU == LOCK_EX ) {
 	open ($lock_fh, ">>$lf") or abmain::error('sys', "Fail to open file $lf: $!");
 }else {
 	open ($lock_fh, "$lf") or abmain::error('sys', "Fail to open file $lf: $!");
 }
 eval {
 my $rem;
	 local $SIG{ALRM} = sub { die "lock_operation_timeout ($lf)" };
 $rem = eval 'alarm 20' if $abmain::use_alarm;
 flock ($lock_fh, $qU) or abmain::error('sys', "Fail to lock $lf: $!");
 eval "alarm $rem" if $abmain::use_alarm;
 };
 if ($@ =~ /operation_timeout/) { abmain::error('sys', "Lock operation timed out. Go back and retry.<!--$@-->");  }
 $locks{$gK}=1;
}
sub pG {
 my ($self, $gK) = @_;
 $gK = "0" if not $gK;
 return if (!$self->{qG});
 my $lock_fh= eval "\\*lT$gK";
 flock ($lock_fh, LOCK_UN) 
 ;
#x1
 close $lock_fh;
 $locks{$gK}=0;
}
sub lLz{
 my ($self) = @_;
 for(keys %locks) {
 if ($locks{$_}) {
 $self->pG($_);
 # abmain::pEa("lock $_ need unlock\n");
 }
 }
}
sub yO{
 my ($self, $cG) = @_;
 my $aline;
 {
 	my $aB = $self->gN($cG);
	local $/;
	undef $/;
 	open pK, "<$aB" or return "<!--missing data file for message $cG-->";
	$aline = <pK>;
 	close pK;
 }   
 return $aline;
}
sub oV{
 my ($self, $entry, $in, $for_arch) = @_;
 my $aline = $self->yO($entry->{fI});
 $aline =~ s/\?cmd=get\&/\?cmd=geta\&/ if $for_arch;
 $aline =~ s/\?cmd=get;/\?cmd=geta;/ if $for_arch;
 my $yH = lB->new($entry->{aK}, 0, $entry->{jE});
 my $jZz = lB->new($entry->{aK}, 0, $entry->{aK});
 my $yW = $yH->nH($self, $in, $for_arch);
 my $topurl = $jZz->nH($self, $in, $for_arch);
 my $kGz = abmain::cUz($topurl, $self->{top_word}) ||'&nbsp;';
 my $kW;
 my $jUz = $entry->{xE};
 if(!$for_arch && ( $self->{gL} ne "1" && $self->{gL} ne "true") && ($jUz & 4)==0 ) {
	$kW=abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=follow;fu=$entry->{fI}&zu=$entry->{aK};scat=$entry->{scat};upldcnt=$self->{def_extra_uploads}", $self->{uI});
 }
 my $kI= qq/<a href="$yW">/;
 my $tO = $self->dRz($for_arch);
 my $jYz = $self->{msg_sep1};
 my $name = $self->fGz($entry->{hC}, 'fEz');
 my ($mbg, $mba, $mwid);
 $mbg=qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 $mwid= qq(width="$self->{mbar_width}") if $self->{mbar_width};
 $mba= $self->{zBz} if $self->{zBz};
 $name = "" if $self->{no_show_poster};
 $self->{sE} = "" if $self->{no_show_poster};
 $aline =~ s/$tV/$kI/;
 $aline =~ s/$gVz/$self->{sJ}/;
 $aline =~ s/$gWz/$self->{sE}/;
 $aline =~ s/$tW/$kW/;
 $aline =~ s/$gTz/$tO/;
 $aline =~ s/$top_tag/$kGz/;
 $aline =~ s/$gXz/$name/;
 $aline =~ s/$gUz/$jYz/;
 $aline =~ s/$mbar_width_tag/$mwid/;
 $aline =~ s/$mbar_bg_tag/$mbg/;
 $aline =~ s/$zAz/$mba/;
 $self->fZa(\$aline); 
 return $aline;
}
sub kO{
 my ($self, $cG, $body) = @_;
 my $entry = lB->new($cG, $cG, $cG);
 if($entry->load($self)) {
	$entry->{body} = $body;
	$entry->store($self);
 }else {
 	 my $all = $self->yO($cG);
 	 $all =~ s/<!--$cG\{-->(.*)<!--$cG\}-->/<!--$cG\{-->$body\n<!--$cG\}-->/s;
 	 $self->xB($cG, $all);
 	 return;
 }
}


sub gB{
 my ($self, $fI) = @_;

 my $entry = lB->new($fI, $fI, $fI);
 if($entry->load($self)) {
	return $entry->{body};
 }else {
 	my $aline = $self->yO($fI);
 	return ($aline =~ /<!--$fI\{-->(.*)\n<!--$fI\}-->/s)? $1: "";
 }
}

sub eEaA {
 my ($self, $fI,  $eS) = @_;
 $eS =  $self->nDz('msglist') unless($eS);
 my $vH;
 my $top;

 $vH = lB->new($fI, $fI, $fI);
 if($vH->load($self)) {
 }
 my $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK}; }, where=>"tmno=$vH->{aK}" } );

 my @entarr;
 for(@$allinesref)
 {
 my $entry = lB->new (@$_);
 $vH = $entry if $entry->{fI} == $fI;
 push @entarr, $entry;
 }
 $self->lN(\@entarr);
 my @childs;
 $self->jP($fI, \@childs);
 my $wD = join(",", map {$_->{to}} @childs);
 return $wD;
}
sub pO {
 my ($self, $fI,  $eS, $thread, $yB, $get_tops) = @_;
 $eS =  $self->nDz('msglist') unless($eS);
 my $vH;
 my $top;

 $vH = lB->new($fI, $fI, $fI);
 if($vH->load($self)) {
 }else {
 		my $aB = $self->gN($fI);
 		open pK, "<$aB" or return;
 	while(<pK>) {
 	     if(/<!--X=([^\n]+)-->/) {
 		       $vH=  lB->new ( split /\t/, $1);
 		       $self->{dA}->{$vH->{fI}} = $vH;
		       last;
 	    }
 }
 close pK;
 }
 
 if($yB) {
 unless($vH->load($self)) {
 	$vH->{_data} = $self->yO($vH->{fI});
 }
 }
 
 return $vH unless($thread);

 my $allinesref;
 if(not $get_tops) {
 $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK}; }, where=>"tmno=$vH->{aK}" } );
 }else {
 $allinesref = 
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })
	->iQa({noerr=>1, filter=>sub { $_[0]->[0] == $vH->{aK} || $_[0]->[1] ==0; }, where=>"tmno=$vH->{aK} or pmno=0" } );

 }

 my @entarr;
 for(@$allinesref)
 {
 my $entry = lB->new (@$_);
 if($yB) {
 unless($entry->load($self)) {
 	$entry->{_data} = $self->yO($entry->{fI});
 }
 }
 $vH = $entry if $entry->{fI} == $fI;
 #$self->{dA}->{$entry->{fI}} = $entry;
 #$self->{eN}->nB($self, $entry);
 push @entarr, $entry;
 }
 $self->lN(\@entarr);
 return $vH;
}




sub lN {
 my ($self, $aE, $mcut, $tn) = @_;
#x1
 $self->{eN} = lB->new();
 $self->{dA}={};
 keys(%{$self->{dA}}) = scalar(@$aE);

 my ($fI, $aK, $top);
 my $cnt =0;
 for(@{$aE}){
 $cnt ++;
 next if ($mcut && $cnt > $mcut && not $self->{dA}->{$_->{aK}});
 $fI = $_->{fI};
 $self->{dA}->{$fI} = $_;
 $_->{bE}=[]; 
 }

#x1
 for(@{$aE}) {
 $fI = $_->{fI};
 $aK = $_->{aK};
 next if $tn && $tn != $aK;
 next if not $self->{dA}->{$fI};
 next if $self->{hEz} && not $self->{dA}->{$_->{aK}};
 $self->{eN}->nB($self, $_);
 }
 $self->{pC} = $aE;
#x1
}





sub iYa{
 my %cond = @_;
 my @flds = keys %cond;
 my %idxes;
 for(@flds) {
	$idxes{$_} = abmain::oTa(\@lB::mfs, $_);
 }
 my $filter = sub {
 for(@flds) {
		next if not defined($cond{$_});
 my $v = $cond{$_};
 my $i = $idxes{$_};
 my $fv = $_[0]->[$i];
		$fv = lc($fv) if ($_ eq 'hC' || $_ eq 'to');
		return if $fv ne $v;
 }
 return 1;
 };
 return $filter;

}

sub fCaA{
	my($self, $kQz, $force) = @_;
 return $self->{_cached_docman} if(ref($self->{_cached_docman}) && not $force);
	require eUaA;
	$self->gCz(1);
	my $isadm = $self->yXa();
 	my ($is_root, $root) = abmain::eVa() ;
 $self->eMaA( [qw(other_header other_footer)]);
	my $docman;
	my $rootdir;
	if($kQz ne '') {
			$rootdir = $self->gTaA($kQz); 
	}elsif($self->{fTz}->{reg} && !$self->{no_user_doc} ) {
			$rootdir = $self->gTaA($self->{fTz}->{name}); 
	}
	elsif($is_root || $isadm) {
			$rootdir=$self->{eD}, 
 }
	return if ($rootdir eq "" || not -d $rootdir);
	$docman = eUaA->new({
			rootdir=>$rootdir, 
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			home=>$self->{eD}, 
			header=>"<html><head>$self->{sAz}\n$self->{other_header}", 
			footer=>$self->{other_footer},
			kQz=>$kQz||$self->{fTz}->{name},
			jW=>$self
 });

	if($self->{fTz}->{reg} && !$self->{no_user_doc}) {
		$docman->cFaA($self->{fTz}->{name});
		$docman->setShortView(1);
		$docman->setNoPermission(1);
		$docman->setQuota(1024*$self->{user_doc_quota});
	}elsif($is_root || $isadm) {
		$docman->cFaA($self->{admin});
	}
	$docman->bUaA($self->sLa());
	$docman->bWaA($self->rIa());
	$docman->bTaA($self->fC());
 if($self->{fTz}->{reg}) {
		$docman->cJaA($self->{fTz}->{name});
 } elsif($is_root) {
		$docman->cJaA($root);
		$docman->cFaA($root);
 }elsif($isadm) {
		$docman->cJaA($self->{admin});
 }
 $self->{_cached_docman} = $docman;
 return $docman;
}
sub wPa{
	my($self, $force) = @_;
 return $self->{_cached_fmagic} if(ref($self->{_cached_fmagic}) && not $force);
	require rNa;
	my $iC = $self->nDz('dbdir');
	mkdir $iC, 0755 if not -d $iC; 
	$self->gCz(1);
	my $isadm = $self->yXa();
 $self->eMaA( [qw(other_header other_footer)]);
	my $bRaA = rNa->new({
			iC=>$iC, 
			tmpldir =>$abmain::master_dbdef_dir,
			cgi=>$abmain::jT, cgi_full=>$abmain::dLz, 
			home=>$iC, 
			header=>"<html><head>$self->{sAz}\n$self->{other_header}", 
			footer=>$self->{other_footer},
			jW=>$self
 });

	#return if(($abmain::yCa/9 != $abmain::kQa[4] && ($abmain::kQa[4])) && ($abmain::yAa+8*2024*1024) <$abmain::yDa);
	$bRaA->cFaA($self->{admin});
	$bRaA->bUaA($self->sLa());
	$bRaA->bWaA($self->rIa());
	$bRaA->bTaA($self->fC());
 if($isadm) {
		$bRaA->cJaA($self->{admin});
 }elsif($self->{fTz}->{reg}) {
		$bRaA->cJaA($self->{fTz}->{name});
 }
 $self->{_cached_fmagic} = $bRaA;
 return $bRaA;
}
sub wUz {
 my ($self, $kQz, $fast) = @_;
 my $cnt =0;
 my $t = 0;
 $kQz = lc($kQz);
 return (0, 0) if not $kQz;
 my $entry;
 if($fast) {
 for $entry (@{$self->{pC}}) {
 if ((lc($entry->{hC}) eq $kQz && $entry->{to}) || lc($entry->{to}) eq $kQz) {
 $cnt ++;
 $t = $entry->{mM} if $entry->{mM} > $t;
 }
 } 
 }else {
 my $eS =  $self->nDz('msglist');
 my $ppos = abmain::oTa(\@lB::mfs, 'hC');
 my $topos = abmain::oTa(\@lB::mfs, 'to');
 my $tpos = abmain::oTa(\@lB::mfs, 'mM');
 my $privfilter = sub { return (lc($_[0]->[$ppos]) eq $kQz && $_[0]->[$topos]) || jW::sFa($_[0]->[$topos],  $kQz) ; };
 
	my $linesref = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iQa({noerr=>1, filter=>$privfilter, where=>"to_user is not NULL"});
	return if not $linesref;
 for(@$linesref) {
 $cnt ++;
 $t = $_->[$tpos] if $_->[$tpos] > $t;
 }
 }
 return ($cnt, int ((time()-$t)/60.));
}
sub sFa{
	my ($to_str, $kQz) = @_;
	for my $to (split /\s*,\s*/, $to_str) {
		return 1 if lc($kQz) eq lc($to);
 }
	return;
}
sub aT {
#sBz =1 private message only
#sBz =2 no private messages

 my ($self, $pgno, $eS, $zI, $yM, $kQz, $sBz, $sti, $eti) = @_;
 $sBz ||= 0;
 $kQz ||= "";

 $self->xHz();

 $kQz = lc($kQz);
 $eS =  $self->nDz('msglist') unless($eS);

 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $pcnt = $self->{iW}||16;
 my $bcnt;

 $jW::debug_str = "<p>nM = $nM ; ";

 my $gV = ($eS eq $self->nDz('archlist'));



 my $start = 0;
 my $mcnt = $nM; 
 $pgno ||=0;
 $jW::hDz = $pgno || 0;

 $self->{nLz} = int $nM/$pcnt;
 $self->{nLz}++ if ($nM%$pcnt); 

 if(uc($pgno) ne 'A'){
 return if($pgno > ($nM/$pcnt +1)); 
 $bcnt = $pcnt * (1+ $pgno);
 $start = $nM - $bcnt;
 $mcnt = $pcnt;
 if ($start < 0 ) {
 $start = 0;
 $mcnt = $nM % $pcnt;
 }
 }
 my $eidx = ($self->{hEz} || $pgno eq 'A')? $nM: $start+$mcnt;
 my $ppos = abmain::oTa(\@lB::mfs, 'hC');
 my $topos = abmain::oTa(\@lB::mfs, 'to');
 my $mynopos = abmain::oTa(\@lB::mfs, 'fI');
 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $tmpos = abmain::oTa(\@lB::mfs, 'mM');
 my %tops;
 my $cur_cnt=0;
 my $privfilter = sub {
	    return if $sti && $_[0]->[$tmpos] < $sti;
	    return if $eti && $_[0]->[$tmpos] > $eti;
 	    return if $sBz == 1 && not $_[0]->[$topos];
 return if $sBz == 2 && $_[0]->[$topos];
 return if $cur_cnt > $mcnt+50 && not $tops{$_[0]->[$tnopos]};
 $tops{$_[0]->[$mynopos]} = 1 if $_[0]->[$tnopos] == $_[0]->[$mynopos];
	    return 1 if $kQz eq '`';
 if(not $kQz) {
 	$cur_cnt++;
		return 1 if not $_[0]->[$topos];
 }else {
 	$cur_cnt++;
 	return 1 if (lc($_[0]->[$ppos]) eq $kQz && $_[0]->[$topos]) || jW::sFa($_[0]->[$topos], $kQz) ; 
 }
	    return;
 };

 #$privfilter = undef if $kQz eq '`';

 my $jKa;
 if($kQz && $kQz ne '`'){
	my $wh="to_user is NOT NULL";
 	$jKa = $db->iQa({where=>$wh, sidx=>$start, eidx=>$eidx, filter=>$privfilter} ); 
 }else {
 	$jKa = $db->iQa({sidx=>$start, eidx=>$eidx, filter=>$privfilter} ); 
 }
 my ($fI, $entry);
 $cur_cnt=0;
 %tops =();
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 next if $cur_cnt > $mcnt && not $tops{$entry->{aK}};
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 if($yM) {
 next if not &$yM($entry);
 }
#use two flags aGz, aIz to tell whether to load
#reviwed/unreviewed posts
 if($self->{aWz} && not $gV) {
 if ($self->{aLz}->{$entry->{fI}}) {
	   		next if not $self->{aGz};
	   } else {
 	next if not $self->{aIz};
 }
 }
 $tops{$entry->{fI}} = $entry if $entry->{aK} == $entry->{fI};
 push @hS, $entry;
 $cur_cnt ++;
 }

 if($zI) {
 @hS = sort { $a->{mM} <=> $b->{mM} } @hS;
 }
 $nM = @hS;
 $jW::debug_str .= " hS len= $nM;";

 $self->{fV} = $start+1;
 lN($self, \@hS, $mcnt); 
 $jW::debug_str .= " start= $start;";
 1;
}


sub gCa {
 my ($self, $aK, $hC) = @_;
 my $eS =  $self->nDz('msglist');
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $sidx = $nM - 100;
 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $ptpos = abmain::oTa(\@lB::mfs, 'mM');
 my $posterpos = abmain::oTa(\@lB::mfs, 'hC');
 my $dayago = time() - 3600*24;
 my $privfilter;
 my $wh="";
 if(not $aK) {
 $privfilter = sub {
	    return $_[1] > $sidx || $_[0]->[$ptpos] > $dayago || lc($_[0]->[$posterpos]) eq $hC;
 };
 }else {
 $privfilter = sub {
	    return $_[1] > $sidx || $_[0]->[$ptpos] > $dayago || $_[0]->[$tnopos] == $aK || lc($_[0]->[$posterpos]) eq $hC;
 };
 }

 my $jKa = $db->iQa({filter=>$privfilter} ); 
 my ($fI, $entry);

 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS, undef, $aK); 
 1;
}
sub mQa {
 my ($self) = @_;
 my $eS =  $self->nDz('msglist');
 my $jKa = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iQa(); 
 my ($entry);
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS); 
 1;
}
sub qZa{
 my ($self, $tnosarr, $purgemark) = @_;
 my $eS =  $self->nDz('msglist');
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 my $nM = $db->pXa();
 $self->{dI}= $nM;

 my $eidx = $nM - $purgemark if $purgemark;
 return if $eidx < 0; 

 my $tnopos = abmain::oTa(\@lB::mfs, 'aK');
 my $privfilter;
 my %tnohash=();
 if(not $tnosarr) {
 $privfilter =  undef;
 }else {
 	for(@$tnosarr) {
		$tnohash{$_} = 1;

	}
 $privfilter = sub {
	    return $tnohash{ $_[0]->[$tnopos] };
 };
 }
 my $jKa = $db->iQa({filter=>$privfilter, eidx=>$eidx} ); 
 my ($fI, $entry);
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS); 
 return scalar(@hS); 
}
sub fPa{
 my ($self, $board2, $aK, $keepdate, $cat) = @_; 
 my $thr = $board2->pO($aK, undef, 1, 1);
 abmain::error('inval', "Thread $aK not found in $board2->{eD}") if not $thr;
 my $numgen = sub {$self->iU(); };
 $thr->pOa($numgen,0, 0, $cat);
 $self->fOa($thr, $keepdate);
 $self->nU();
}
sub fOa {
 my ($self, $ent, $keepdate, $recur) = @_;
 $ent->{mM} = time() if not $keepdate;
 if($ent->{kRa}) {
 	$self->mO(split /\t/, $ent->nJa());
	$ent->store($self);
 }else {
 	$self->xB($ent->{fI}, $ent->{_data});
 }
 my $ent2;
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in lDa\n";
	return;
 }
 foreach $ent2 (@{$ent->{bE}}) {
	$self->fOa($ent2, $keepdate, 1+$recur);
 }
 $self->bT($ent->{fI}) if not $ent2;
}
sub jP{
 my ($self, $fI, $jIz, $recur) = @_; 
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in gac\n";
	return;
 }
 my $entry = $self->{dA}->{$fI};
 foreach (@{$entry->{bE}}) {
	  next if $_->{fI} <=0;
	  next if $_->{fI} <= $fI;
 push @{$jIz}, $_;
	  $self->jP($_->{fI}, $jIz, 1+$recur);
 }
}
 
sub tQ{
 my ($self, $jPz, $fI, $aK, $recur) = @_; 
 if($recur>2000) {
	print STDERR "exceeded recursion limit, in gac\n";
	return;
 }
 my $entry = $self->{dA}->{$fI};
 if (!$aK) {
 $aK = $fI ;
	$entry->{jE}=0;
 }
 $entry->{aK} = $aK;
 push @{$jPz}, $entry;
 foreach (@{$entry->{bE}}) {
	  $self->tQ($jPz, $_->{fI}, $aK, 1+$recur);
 }
}
sub cBz {
 my ($self) = @_; 
 return if $abmain::use_sql;
 my @pN;
 my $line;
 my $ddir= $self->nDz('iC');
 my $mf= $self->nDz('msglist');
 my $ftmp = $mf."_t";
 open F, ">$ftmp";
 opendir DIR, $ddir or abmain::error('sys', "Fail to open directory: $!");
 local $_;
LOOP2: while($_ = readdir DIR) {
	   next if $_ !~ /\.dat$/;
 my $file= abmain::kZz($ddir, $_) ; 
 	   my $entry = lB->new ();
 if($entry->load($self, 0, $file)) {
		$entry->{body}= undef;
		delete $entry->{body};
		push @pN, $entry;
 print F join("\t", @{$entry}{@lB::mfs}), "\n";
		next LOOP2;
	   }

 open pK, "<$file" or next; 
 while(<pK>) {
 if(/<!--X=([^\n]+)-->/) {
 	       my $entry = lB->new ( split /\t/, $1);
 close pK;
	       $entry->nBa($self);
	       $entry->{body}= undef;
	       delete $entry->{body};
 push @pN, $entry;
 print F join("\t", @{$entry}{@lB::mfs}), "\n";
 next LOOP2;
 }
 }
 close pK;
 }
 close F;
 @pN = sort { $a->{mM} <=> $b->{mM} } @pN;
 $self->oF();
 my @rows;
 for(@pN) {
 push @rows, [@{$_}{@lB::mfs}];
 }
 $bYaA->new($mf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($mf) } )->iRa(\@rows, {kG=>"On writing file $mf: $!"});
 $self->pG();
}
sub jFz{
 my $pat =shift;
 my @pats = split /\s+/, $pat;
 my $expr = join '&&' => map { "m/\$pats[$_]/io" } (0..$#pats);
 return eval "sub { local \$_ = shift if \@_; $expr; }"; 
}

 

sub vUz{
 my ($self, $usr_pat, $iN, $etime) = @_; 

 my $eS = $self->nDz('msglist') ;
 my $aB = $self->nDz('dmsglist') ;
 my $afile = $self->nDz('archlist');
 my $sf = $self->nDz('pstat');
 my ($mt, $dt, $at, $gDz) = map { (stat($_))[9] } ($eS, $aB, $afile, $sf);
 my $entry ;
 my @pN ;

 my $sti;
 my $dstr;
 my %ostats;
 my $force = $abmain::use_sql;
 $self->aFz();
 $self->aFz(undef, "a") if ($at > $gDz || $force);
 $self->aFz(undef, "d") if ($dt > $gDz || $force);
 
 my $linesref = $bYaA->new($sf, {schema=>"AbPostStat", paths=>$self->dHaA($sf) })->iQa({noerr=>1} );
 for (@$linesref) {
	$ostats{$_->[0]} = $_;
 }
	
 my %stats;
 foreach my $file (($eS, $aB, $afile))  {
 my $u_t = (stat($file))[9];
 next if ($u_t < $gDz && not $force);
 my $jKa = $bYaA->new($file, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($file) })->iQa({noerr=>1});
	next if not $jKa;
 	for(@$jKa) {
 	   $entry = lB->new ( @$_ );
 my $hC = $entry->{hC};
	   next if not $hC;
 	   $stats{$hC}->[1] ++;
 	   $stats{$hC}->[2] += $entry->{size};
 my $nloc;
 if($file eq $eS) {
 	   	$stats{$hC}->[3] ++;
 }elsif($file eq $afile) {
 	   	$stats{$hC}->[4] ++;
		$nloc ="a";
 }elsif($file eq $aB) {
 	   	$stats{$hC}->[5] ++;
		$nloc ="d";
 }
 	   $stats{$hC}->[6] ++ if $entry->{eZz};

 my $cG = $entry->{fI};
	   if($self->{ratings2}->{$cG} ) {
 	my ($aUz, $cnt, $ovis, $fpos, $loc, $rds) = split /\t/, $self->{ratings2}->{$cG} ;
 	   	$stats{$hC}->[7] += $ovis;
 	   	$stats{$hC}->[8] += $aUz*$cnt;
 	   	$stats{$hC}->[9] += $cnt;
 if($loc ne $nloc) {
 		$self->{ratings2}->{$cG} = join("\t", $aUz, $cnt, $ovis, $fpos, $nloc, $rds);
 } 
 }
 	}
 }
 for(keys %stats) {
 $stats{$_}->[0] = $_;
 }
 my @posters = sort { $b->[1] <=> $a->[1]} values %stats;
 my @rows;
 for (@posters) {
 my $n = $_->[0];
	my $i;
	for($i=1; $i<10; $i++) {
 		$_->[$i]= ($ostats{$n}->[$i] || 0) if not $_->[$i];
 }
 	push @rows, $_;
 }
 $bYaA->new($self->nDz('pstat'), {schema=>"AbPostStat", paths=>$self->dHaA($self->nDz('pstat')) })->iRa(\@rows);
 $self->aKz() if ($mt > $gDz || $force);
 $self->aKz(undef, "a") if ($at > $gDz || $force);
 $self->aKz(undef, "d") if ($dt > $gDz || $force);
}
sub bVa{
	my ($self, $gJz) = @_;
	my $mf = $self->gXa(lc($gJz));
	$mf->zQz($self->{cgi});
	my $mpic=qq(<img src="$self->{cgi}?@{[$abmain::cZa]}cmd=mimg;kQ=$gJz">);
	$mf->cBa($self->{cfg_head_bg}, $self->{cbgcolor0}, $self->{cbgcolor1}, $self->{cfg_bot_bg});
	$mf->zOz();
	$mf->aCa(['email', "text", "", "Email address"]);
	$mf->aCa(['userid', "text", "", "Email address"]);
	$self->{mplayout} =~ s/MEMBER_PIC/$mpic/g;
	$mf->bSa($self->{mplayout});
 print $mf->form(1, [qw(birthday birthmonth)]);

}
sub fYa{
	my ($self, $gJz) = @_;
 $self->fZz($gJz);
 my $profile = $self->{gFz}->{lc($gJz)};
 return if not $profile;
 my %vcard;
 $vcard{nick}=   $gJz;
	my $mf = $self->gXa(lc($gJz));
	$mf->zQz($self->{cgi});
 $vcard{email} =   $profile->[1];
 $vcard{wO} =   $profile->[3];
 $vcard{phone}= $mf->{day_phone};
 $vcard{fax}   =$mf->{fax};
 $vcard{name}=$mf->{realname};
 $vcard{org}=$mf->{company};
 $vcard{photourl}=$mf->{photourl};
 return abmain::lTa(%vcard); 
}
sub vLz  {
 my ($self, $kQz) = @_; 
 $kQz = lc($kQz);
 my $sf = $self->nDz('pstat');
 my $sfcac = $self->nDz('pstat')."ca";
 if( ! -f $sf || time() > (stat($sf))[9] + $self->{vAz}) {
 $self->oF(LOCK_EX,33);
 $self->vUz()
 		if( ! -f $sf || time() > (stat($sf))[9] + $self->{vAz});
 $self->pG(33);
 }
 my $linesref = $bYaA->new($sf, {schema=>"AbPostStat", paths=>$self->dHaA($sf) } )->iQa({noerr=>1} );
 my @ths = ("Name", "Total posts", "Bytes", "Active",  "Archived", "Deleted", "Uploads", "Views", "Rating", "Rates");
 my @rows;
 for (@$linesref) {
 my @vals = @$_;
 next if $kQz && $kQz ne lc($vals[0]);
 my $usre= abmain::wS(lc($vals[0]));
 $vals[3]= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=find;tK=^$usre\$;hIz=365", $vals[3]);
 $vals[4]= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=finda;tK=^$usre\$;hIz=365", $vals[4]);
	$vals[8] = sprintf("%.2f", $vals[8]/$vals[9]) if $vals[9] >0;
 push @rows, [@vals];
 }
 @ths = jW::mJa($self->{cfg_head_font}, @ths);
 print sVa::fMa(rows=>\@rows, ths=>\@ths, $self->oVa());
}
sub nYa{
 my ($self, $tK, $gV, $wT, $find_img, $sti, $eti, $toponly, $scat) = @_; 

 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist') ;
 my $pN = [];

 abmain::error('inval', "Fail to compile jK $tK: $@") if not defined(eval '/$tK/');
 my $jGz= jW::jFz($tK);

 my $kQz = $self->{kUz};
 if($gV) {
 $self->{aIz} =1;
 }

 my $max_ret=$self->{max_match_cnt};
 
 my $filt = sub  {
 my ($row) = @_;
 my $entry = {};
 @{$entry}{@lB::mfs} = @$row;
 return if $toponly && ($entry->{aK} != $entry->{fI});
 return if $entry->{to} && not (jW::sFa($entry->{to}, $kQz)  || $entry->{hC} eq $kQz);
 return if ($eti && $entry->{mM} > $eti);
 return if ($entry->{mM} < $sti);
 return if ($find_img && ($entry->{xE} & $pTz)==0);
 return if $scat && $entry->{scat} ne $scat;
 if($self->{aWz}) {
 return if ($self->{aLz}->{$entry->{fI}} && (not $self->{aGz}));
 return if (!$self->{aLz}->{$entry->{fI}} && (not $self->{aIz}));
 }
 if(!$tK) {
	return 1;
 }
 if(&$jGz($entry->{hC}) || &$jGz($entry->{key_words}) ||  &$jGz($entry->{wW}) || &$jGz($entry->{pQ}) || &$jGz($entry->{eZz}) || &$jGz($entry->{rhost}) || &$jGz($entry->{track}) || &$jGz(join(" ", $entry->{jE}, $entry->{aK}, $entry->{fI})) ) {
	return 1;
 }elsif($wT && $self->{allow_body_search}) {
 my $data = $self->yO($entry->{fI});
 return 1 if(&$jGz($data));
 }  
 return;
 };

 my $linesref = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) } )->iQa({filter=>$filt, maxret=>$max_ret});
 my $match_cnt=0;
 my $nM = scalar(@$linesref);
 my $sidx =0;
 if($self->{max_match_cnt} >0 && ($nM> $self->{max_match_cnt})) {
	$sidx = $nM- $self->{max_match_cnt};
 }
 
 for(;$sidx<$nM; $sidx++) {
 my $ent = lB->new (@{$linesref->[$sidx]});
 push @$pN, $ent;
 $match_cnt++;
 }
 return ($match_cnt, $pN);

}
sub qXa{
	my ($self) = @_;
 	my $sdb =  $self->nDz('sdb')."_mark";
	return if $self->{sdb_intv}<=1;
return; 
 	return if( (stat($sdb))[9] > time() - 3600*$self->{sdb_intv});
 my $lck = jPa->new($sdb, jPa::LOCK_EX());
 	if( (not -f $sdb) || (stat($sdb))[9] < time() - 3600*$self->{sdb_intv}) {
		local *F;
		open F, ">$sdb" or return;
		print F time();
		close F;
		$self->qOa();
	}

}
sub qOa{
 my ($self) = @_;
 my $sdb =  $self->nDz('sdb');
 my $dirs = [$self->{eD}];
 my $urls =[$self->{pL}];
 my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $abmain::jT);
 $mf->zOz();
 $mf->load(abmain::wTz('siteidxcfg'));
 
 my $search = new eCa { 
		IndexDB 	=> $sdb,
		FileMask	=> $mf->{siteidx_filematch},,
		Dirs 		=> $dirs,
		IgnoreLimit	=> 4,
		Verbose 	=> 0,
 multibyte       => $mf->{siteidx_multibyte},
 wsplit          => $mf->{siteidx_wsplit} || pack("h*", $abmain::cEaA),
		URLs		=> undef,	
		Level  		=> $mf->{"siteidx_depth"} || 50,
		MaxEntry        => undef,
		UrlExcludeMask => 'pv-.*'
	
	};
 my @deads = $search->dUa(); 

}
sub kV{
 my ($self, $tK, $gV, $wT, $find_img, $sday, $eday, $toponly, $scat) = @_; 

 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist') ;

 if($self->{allow_user_view} ) {
 	 my $mf=$self->gXa($abmain::ab_id0);
	 $self->yIz($mf, qw(hG yVz revlist_topic revlist_reply align_col_new iW)); 
 }
 my $sti;
 my $dstr;
 if(not $sday) {
 abmain::mRz($abmain::fPz{$self->{vcook}});
 	my $lastv0 = $abmain::mNz{lastv0};
 $sti = $lastv0;
 $dstr = "since your last visit: ". abmain::dU('LONG', $sti, 'oP');
 }else {
 	$sti = time() - $sday * 24 * 3600;
 $dstr = "since ". abmain::dU('LONG', $sti, 'oP');
 }
 my $eti = time() - $eday * 24 * 3600;
 my ($match_cnt, $pN) = $self->nYa($tK, $gV, $wT, $find_img, $sti, $eti, $toponly, $scat);

 sVa::gYaA "Content-type: text/html\n\n";
print qq@<html><head><title>Search Results for $tK $dstr</title>\n$self->{sAz}\n
<p>
@
;
 pop @$pN if $match_cnt > $self->{max_match_cnt};
 my $morestr;
 $morestr = "There are more matches." if $match_cnt > $self->{max_match_cnt}; 
 my $nM= scalar(@$pN);
 my $match_cond = "";
 $match_cond = "Search pattern:" . "$tK," if $tK;
 $self->{fDz} = 'undef';
 my $cmdbar = $self->bHa(1, $gV, 1);

 print &mTa($self->{other_header}, \@jW::gLa, $self->{_navbarhash});

 print qq(\n<div class="ABMSGAREA">);
 print "\n$cmdbar\n";
 if(0 == $nM) {
 	print qq(<center><h1>No messages found.<br/><small>($match_cond $dstr)</small></h1> </center>);
 }else {
 	print qq(<center><h3>The following $nM messages have been found. $morestr<br/><small>($match_cond $dstr)</small></h3> </center>);
 	$self->lN($pN);
	$self->aFz(undef, $gV? "a":undef);
 	$self->{eN}->jN(iS=>$self, nA=>\*STDOUT, 
 jK=>($self->{aO}?0:-1), hO=>0, gV=>$gV);
 }
 print "</div>";
 print &mTa($self->{other_footer}, \@jW::gLa, $self->{_navbarhash});
 print qq|<!--@{[$abmain::func_cnt]}-->|;
 return;

 my $tO= "\&nbsp;" x 10;
 $tO .= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=qL", $self->{tC});
 print qq|<p><hr width="$self->{cYz}">${\($self->dRz($gV))} $tO
 </div><!--@{[$abmain::func_cnt]}-->|;
}
 
sub nMz {
 my ($self, $gV, $rmne) = @_; 
 return if $abmain::use_sql;
 my $eS = $gV? $self->nDz('archlist') : $self->nDz('msglist');
 my $estr;
 $self->oF();
 my $linesref= $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) } )->iQa({noerr=>1} );
 my %ent_hash;
 my $entry;
 my ($tot, $dupcnt, $badcnt, $rmcnt, $keepcnt, $loopcnt);
 for(@$linesref) {
 next if not $_->[0];
 $tot ++;
 $entry = lB->new (@$_);
 if(exists $ent_hash{$entry->{fI}}){
 	$estr .= "Dupplicate index found for $entry->{fI}\n"; 
 $dupcnt++;
 }
 if ($entry->{size}>=0 && not -e  $self->fA($gV? $entry->{aK}: $entry->{fI}, $gV, $entry->qRa()) && not $self->{aO}) {
 $estr .= "File for index $entry->{fI} does not exist" ;
 $estr .= ", however, data for index $entry->{fI} exist" if -e $self->gN($entry->{aK}) ;
 $estr .="\n";
 $badcnt++;
 if ($rmne) {
 $rmcnt++;
 next;
 }
 }
 unless(($entry->{fI} > $entry->{jE}) || ($entry->{jE}==0 && $entry->{fI} == $entry->{aK})) {
		$loopcnt ++;
	         next;
 }
 $ent_hash{$entry->{fI}} = $entry;
 $keepcnt++;
 }
 $estr .= "\nTotal=$tot\nDup=$dupcnt\nBad=$badcnt\nRemoved=$rmcnt\nRemoved cycle=$loopcnt\nKeep=$keepcnt\n";

 if($rmne) {
 	my @ent_arr=  sort {$a->{mM} <=> $b->{mM}} values %ent_hash;
 my @rows;
 	for $entry (@ent_arr) {
 		push @rows, [@{$entry}{@lB::mfs}];
 	}
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@rows);
 }
 $self->pG();
 $self->aT(0,$eS);
 $self->aFz(undef, $gV? "a" : undef);
 $self->eG(0,0,$gV);
 return $estr;
}
sub iNa{
 my ($self, $jO, $aA, $gLz, $dp) = @_; 
 $self->oF();
 $self->aT('A', $self->nDz('archlist'), 0, 0, '`', $dp);
 if(!$aA) {
 $aA = [];
 if($jO eq 'fI' && $self->{archive_purge_mark}>0) {
 my $del_cnt= $self->{dI}-$self->{archive_purge_mark};
 return 1 if $del_cnt <=0;
 for(@{$self->{pC}}) {
 last if $del_cnt <=0;
 push @{$aA}, $_->{fI};
 $del_cnt --;
 }
 }else {
 return;
 }
 }
 
 my %pD;
 foreach my $k (@{$aA}) {
	if($jO eq 'fI') {
		my $aK;
		($k, $aK) = split /\s+/, $k;
	}
 $pD{$k}=1;
 }

 my $entry ;
 my %hD=();
 my $val;
 my @pN;

 foreach my $entry (@{$self->{pC}}) {
 next if($hD{$entry->{fI}});
 if($jO eq 'mM') {
 $val = abmain::dU('YDAY', $entry->{mM}, 'oP');
 } elsif ($jO eq 'pQ') {
 $val = abmain::pT($entry->{pQ});
 } else {
 $val = $entry->{$jO};
 }
 if($pD{$val}) {
	    my @marr;
 $hD{$entry->{fI}}=$entry;
	    $self->jP($entry->{fI}, \@marr);
	    my $ent;
	    for $ent(@marr) {
	      $hD{$ent->{fI}}= $ent;
	    }
 }
 }
 foreach $entry (@{$self->{pC}}) {
 push @pN, $entry unless ($hD{$entry->{fI}});
 }

 my $estr; 
 my @sort_mref =sort { $a->{mM} <=> $b->{mM} } values %hD;
 $self->lN(\@sort_mref);
 foreach (values %hD) {
 $self->qQa();
 if ($_->{fI} == $_->{aK}) {
		$estr .="Deleted archive thread $_->{fI}: $_->{wW}\n" if (unlink $self->fA($_->{aK}, 1,  $_->qRa()));
 }
 if($gLz && $_->{eZz}) {
		(unlink $self->bOa($_->{eZz})) && ($estr .= "Removed uploaded file $_->{eZz}");
 }
 
 } 

 my $eS =  $self->nDz('archlist') ;
 my @rows;

 while ($entry = shift @pN) {
	  push @rows, [@{$entry}{@lB::mfs}];
		
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@rows);
 $self->pG();

 $self->aT('A', $eS, 0, 0, '`');

 my $delcnt=0;
 $self->aFz(undef, "a");

 my @ds; 
 foreach (values %hD) {
 push @ds, [@{$_}{@lB::mfs}];
 delete $self->{ratings2}->{$_->{fI}};
 $delcnt ++;
 }

 $eS = $self->nDz('dmsglist');
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@ds);
 

 $estr .= "\nDeleted $delcnt messages!\n";
 $self->aKz(undef, "a");
 $self->eG(0,0,1);
 return $estr;
}
sub qQa{
	my ($self) = @_;
	return if not $self->{_show_prog};
	print $jW::prog_step;
	print "<br/>\n\n" if ($self->{_prog_steps}++%20)==0;

}
sub qNa{
 my ($self, $aA,$pI, $eA, $gLz, $backup) = @_; 

 $self->oF();
 my $del_all = 0;
 my @tnos2d;
 my %mnos2d_hash;


 if(!$aA) {
 if($self->{purge_mark}>0) {
		return if not $self->qZa(undef, $self->{purge_mark});
 }else {
 return;
 }
	 my %tnoshsh=();
 	 foreach my $entry (@{$self->{pC}}) {
		$mnos2d_hash{$entry->{fI}}=1;
		$tnoshsh{$entry->{aK}}=1;
	 }
	 @tnos2d = keys %tnoshsh;
 }else {
	for(@$aA) {
		my ($cG, $aK) = split /\s+/, $_;
		$mnos2d_hash{$cG}=1;
		push @tnos2d, $aK;
 }	
 	$self->qZa(\@tnos2d);
 }
 
 my $entry ;

 my %hD=();

 my @pN;
 my @vCz=();

 my @updates=();
 my %updhsh=();

 foreach $entry (@{$self->{pC}}) {
 next if not $mnos2d_hash{$entry->{fI}};
 next if($hD{$entry->{fI}});
 $hD{$entry->{fI}}=$entry;
 push @vCz, $entry->{jE} if ($entry->{jE} > 0); 
 my @marr=();
 if ($pI) {
	          $self->jP($entry->{fI}, \@marr);
		  my $ent;
		  for $ent(@marr) {
		      $hD{$ent->{fI}}= $ent;
		  }
 }
 if(1 || $self->{adopt_orphan}) {
	    	my $ch;
	    	foreach $ch (@{$entry->{bE}}) {
	    	    if (!$hD{$ch->{fI}}){
	    	        $entry->{adopter} = 1 ;
		        $entry->{wW}="";
			$entry->{size}= -1;
 	        push @updates, [@{$entry}{@lB::mfs}];
			$updhsh{$entry->{fI}} =1;
			last;
	             }
 	}
 }
 
 }
#x2
 my $estr;
 my $arc_cnt=0;
 if($eA) {
 my @sort_mref =sort {$a->{mM} <=> $b->{mM}} values %hD;
 my $oldinline= $self->{lJ};
 my $oldflat = $self->{flat_tree};
 $self->{lJ}=1;
 $self->{flat_tree}=0;
 $self->lN(\@sort_mref);
 
 my $ent;
 $self->{_regened_mnos} = {};
 foreach $ent (values %hD) {
 $self->qQa();
 if ($ent->{fI} == $ent->{aK}) {
 	$self->bT($ent->{fI}, 1);
 	$estr .="Archived thread $ent->{fI}: $ent->{wW}\n";
 my $f = $self->fA($ent->{aK}, 1, $ent->qRa());
 if (not -e $f) {
 abmain::error('sys', "Fail to validate archive operation (check #$ent->{aK}, $f)!");
 }
 $arc_cnt++;
 }
 } 
 $self->{_regened_mnos} = {};

 my $eS = $self->nDz('archlist');
 my @as;
 foreach $entry (@sort_mref ) {
		$entry->{status} ='a';
 		push @as, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@as);  
 chmod 0600, $eS;
 $self->{lJ}= $oldinline;
 $self->{flat_tree}= $oldflat;

 }
 
 my $eS =  $self->nDz('msglist') ;
 my $db = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) });
 $db->jXa(\@updates);
 my @mnos2d;
 for(keys %hD) { 
 push @mnos2d, $_ if not $updhsh{$_};
 }
 $db->jLa(\@mnos2d);

 $self->qZa(\@tnos2d);



 $self->{_regened_mnos} = {};
 foreach my $cG (@vCz) {

 next if ($hD{$cG} || $cG==0);
 $self->bT($cG);
 $estr .="Regen message: $self->{dA}->{$cG}->{wW}\n";
 } 
 $self->{_regened_mnos} = {};

 my $delcnt=0;
 $self->{just_deleted} = []; 
 my @des;
 foreach my $ent (values %hD) {
	$self->qQa();
 if($eA && not -e $self->fA($ent->{aK}, 1, $ent->qRa())) {
	       $estr .= "Error: #$ent->{fI} not removed, cannot find corresponding archived file\n";
 next;
 }
 push @{$self->{just_deleted}}, $ent->{fI};
	  $self->nMa($ent->{fI}, $ent->nJa()) if $backup; 
 if( $self->zD($ent->{fI})) {
	       $estr .= "Removed message: $ent->{fI} -- $ent->{wW}\n";
	  }else {
	       $estr .= "Error removing $ent->{fI} $ent->{wW}:  $!\n";
	  }
 if($gLz && $ent->{eZz} && not $eA) {
 (unlink $self->bOa($ent->{eZz})) &&
 ($estr .= "Removed uploaded file $ent->{eZz}");
 }
 
 if(not $eA) {
	     push @des, [@{$ent}{@lB::mfs}];
 delete $self->{ratings2}->{$ent->{fI}};
 }
	  next if($self->{aO});
	  unlink  $self->fA($ent->{fI}, 0, $ent->qRa()) or 1;
 $delcnt ++;
 }
 if (not $eA ) {
 	$eS = $self->nDz('dmsglist');
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@des);
 }
 if($eA) {
 	my $oldinline= $self->{lJ};
 	$self->{lJ}=1;
 	my $eS = $self->nDz('archlist');
 	$self->aT(0, $eS, 0); ##load all, and not sort
 	$self->eG(0, 0, 1);
 	$self->{lJ}=$oldinline;
 }
 $estr .= "\n"."Deleted $delcnt messages!\n";
 $estr .= "\n"."Archived $arc_cnt threads!\n" if $arc_cnt;
 return $estr;
}
sub aQ{
 my ($self, $jO, $aA,$pI, $eA, $gLz, $backup) = @_; 

 $self->oF();
 $self->mQa();


 if(!$aA) {
 $aA = [];
 if($jO eq 'fI' && $self->{purge_mark}>0) {
 my $del_cnt= $self->{dI}-$self->{purge_mark};
 return 1 if $del_cnt <=0;
 for(@{$self->{pC}}) {
 last if $del_cnt <=0;
 push @{$aA}, $_->{fI};
 $del_cnt --;
 }
 }else {
 return;
 }
 }
 


#   my @var_arr = sort @{$val_arr_ref0};
#   my $var_arr_ref = \@var_arr; 
 
 my %pD;
 foreach (@{$aA}) {
 $pD{$_}=1;
 }

 my $entry ;



 my %hD=();

 my $val;

 my %uB;
 my @pN;
 my @vCz=();

 foreach $entry (@{$self->{pC}}) {

 next if($hD{$entry->{fI}});

 if($jO eq 'mM') {
 $val = abmain::dU('YDAY', $entry->{mM}, 'oP');
 } elsif ($jO eq 'pQ') {
 $val = abmain::pT($entry->{pQ});
 } else {
 $val = $entry->{$jO};
 }

 if($pD{$val}) {
 	    if($jO ne 'fI' && !$uB{$val}) {
 	      $self->iU($jW::max_mno);
		      my $ent = lB->new($gP, 0, $gP, $val, "Archive", time());
		      $uB{$val} = $ent;
 $hD{$gP} = $ent;
 $self->{dA}->{$gP} = $ent;
 	    }
 $hD{$entry->{fI}}=$entry;

 push @vCz, $entry->{jE} if ($entry->{jE} > 0); 
 if($jO ne 'fI') {
 	my $vtop = $uB{$val};
 $entry->{jE} = $vtop->{fI};
 $entry->{aK} = $vtop->{fI};
 }
	    my @marr=();
	    if ($pI) {
	          $self->jP($entry->{fI}, \@marr);
		  my $ent;
		  for $ent(@marr) {
		      $hD{$ent->{fI}}= $ent;
		      $ent->{aK} = $uB{$val}->{aK} if $jO ne 'fI';
		  }
 }
	    if($self->{adopt_orphan}) {
	    	my $ch;
	    	foreach $ch (@{$entry->{bE}}) {
	    	    if (!$hD{$ch->{fI}}){
	    	        $entry->{adopter} = 1 ;
		        $entry->{wW}="";
			$entry->{size}= -1;
			last;
	             }
 	}
	    }
 }
 }
#x2
 foreach $entry (@{$self->{pC}}) {
 push @pN, $entry unless ($hD{$entry->{fI}} && not $entry->{adopter});
 }




 my @tR = ();
 if(!$self->{adopt_orphan}) {
 foreach $entry (values %hD) {
	       my $ch;
	       foreach $ch (@{$entry->{bE}}) {
	           last if  $hD{$ch->{fI}};
	           $self->tQ(\@tR, $ch->{fI});
	       }
	  }
 }






 my $estr;
 my $arc_cnt=0;
 if($eA) {
 my $oldinline= $self->{lJ};
 $self->{lJ}=1;
 my @sort_mref =sort {$a->{mM} <=> $b->{mM}} values %hD;
 $self->lN(\@sort_mref);
 my $ent;
 $self->{_regened_mnos} = {};
 foreach $ent (values %hD) {
	$self->qQa();
 if ($ent->{fI} == $ent->{aK}) {
 	$self->bT($ent->{fI}, 1);
 		$estr .="Archived thread $ent->{fI}: $ent->{wW}\n";
 	  if (not -e $self->fA($ent->{aK}, 1, $ent->qRa())) {
 	     abmain::error('sys', "Fail to validate archive operation (check #$ent->{aK})!");
 	  }
 	  $arc_cnt++;
 }
 } 
 $self->{_regened_mnos} = {};

 my $eS = $self->nDz('archlist');
 my @as;
 foreach $entry (@sort_mref ) {
		$entry->{status} = 'a';
 		push @as, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@as);  
 chmod 0600, $eS;
 $self->aT(0, $eS, 0); ##load all, and not sort
 $self->eG(0, 0, 1);
 $self->{lJ}=$oldinline;

 }
 
 my $eS =  $self->nDz('msglist') ;

 my @ms;
 while ($entry = shift @pN) {
 		push @ms, [@{$entry}{@lB::mfs}];
 }
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iRa(\@ms);
 $self->xGz();
 $self->pG();

 $self->aT('A', 0,0,0,'`');



 $self->{_regened_mnos} = {};
 foreach (@vCz) {

 next if ($hD{$_} || $_==0);
	$self->qQa();
 $self->bT($_);
 $estr .="Regen message: $self->{dA}->{$_}->{wW}\n";
 } 
 $self->{_regened_mnos} = {};

 foreach (@tR) {
 next if ($hD{$_->{fI}});
 $self->bT($_->{fI});
 $estr .="Regen message-2: $_->{wW}\n";
 }
 $self->{_regened_mnos} = {};


 my $delcnt=0;

 $self->{just_deleted} = []; 
 my @des;
 foreach (values %hD) {
	$self->qQa();
 if($eA && not -e $self->fA($_->{aK}, 1, $_->qRa())) {
	       $estr .= "Error: #$_->{fI} not removed, cannot find corresponding archived file\n";
 next;
 }
 push @{$self->{just_deleted}}, $_->{fI};
	  $self->nMa($_->{fI}, $_->nJa()) if $backup; 
 if( $self->zD($_->{fI})) {
	       $estr .= "Removed message: $_->{fI} -- $_->{wW}\n";
	  }else {
	       $estr .= "Error removing $_->{fI} $_->{wW}:  $!\n";
	  }
 if($gLz && $_->{eZz} && not $eA) {
 (unlink $self->bOa($_->{eZz})) &&
 ($estr .= "Removed uploaded file $_->{eZz}");
 }
 
 if(not $eA) {
	     push @des, [@{$_}{@lB::mfs}];
 delete $self->{ratings2}->{$_->{fI}};
 }
	  next if($self->{aO});
	  unlink  $self->fA($_->{fI}, 0, $_->qRa()) or 1;
 $delcnt ++;
 }
 if (not $eA ) {
 	$eS = $self->nDz('dmsglist');
 	$bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->kEa(\@des);
 }
 $estr .= "\n"."Deleted $delcnt messages!\n";
 $estr .= "\nArchived $arc_cnt threads!\n" if $arc_cnt;
 return $estr;
}
sub zD{
 my ($self, $cG)=@_;
 if( not $abmain::use_sql ) {
 	return unlink $self->gN($cG);
 }else {
	require zGa;
 	my $mpart = zDa->new('AbMsgPart');
 	my $eS =  $self->nDz('msglist'); 
	my ($p, $s) = @{$self->dHaA($eS)};
 	return $mpart->sHa("where realm=? and msg_no=?", [$p, $cG]);
 }
}
sub yHz {
 my ($self, $gV) = @_;
 my $idx= $self->dIz($gV);
 my $str;
 my $arch_x;
 $arch_x= ";gV=1;hEz=1" if $gV;
 my $pgurl= "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz$arch_x;pgno=";
 $str = "\n".$abmain::lRz;
 $str .= $abmain::kSz;
 $str .= <<"EOF_JS2";
 var cook = new Cookie(document, "$self->{vcook}", 2400, "/");
 cook.load();
 function go_cp(tag) {
 if(!cook.vpage) cook.vpage=0;
 if(cook.vpage == 0) cook.vpage = "";
 url= "$pgurl" + cook.vpage + '&t='+tag +'#'+tag;
 location=url;
 }
EOF_JS2
 $str .= "\n".$abmain::js_end;
 return $str;
}
 

sub bT {
 my ($self,  $cG, $gV, $hO, $no_up, $recur_cnt) = @_;
 my $eC = $self->{dA}->{$cG};
 my $i=0;
 return unless $eC &&  $eC->{fI} == $cG;
 return if $self->{_regened_mnos}->{$cG};

 if( (not $eC->qRa()) && $self->{aO}){
	return;
 }

 $recur_cnt =0 if not $recur_cnt;
 if($recur_cnt > 1000) {
	print STDERR "exceeed recursion limit, possible corruption of index\n";
 }




 if($self->{lJ} ) {
 return if $self->{cXa};
 if($cG != $eC->{aK}) {
 return if not $self->{dA}->{$eC->{aK}};
 return $self->bT($eC->{aK}, $gV, $hO, $no_up, 1+$recur_cnt);
 }
 }

 my $od = $self->{dyna_forum};
 $self->{dyna_forum} = 1 if $eC->{to};
 my $aD = $self->fA($cG, $gV, $eC->qRa());
 my $wW = $eC->{wW};

 if(not $self->{_inited_msg_header}) {
 	$self->eMaA( [qw(msg_header other_footer msg_banner msg_footer)]);
 	$self->{_inited_msg_header} =1;
 }
 my $header =$self->{msg_header};

 open(kE, ">$aD" ) || abmain::error($!. ": $aD");
 print kE qq(<html><head><title>$wW</title>\n$self->{sAz}\n);

 if(length($header)>5) {
 print kE qq(<META HTTP-EQUIV="Expires" CONTENT="0">\n<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">) if($self->{lJ});
 print kE $header;
 }else {
 print kE qq(<META HTTP-EQUIV="Expires" CONTENT="0">\n<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">)
 if($self->{lJ});
 print kE "</head><body>"
 }
 my $ad = abmain::plug_in();

 if($self->{ySz}) {
	    print kE $self->yHz($gV), "\n";
 }

 print kE qq(<center>$ad</center>) if $self->{show_plugin};
 print kE $self->{msg_banner};
 my $pub = 'p' if not $eC->qRa();
 
 my $il_saved;    
 if($eC->qRa()) {
	$il_saved = $self->{aO};
	$self->{aO} = 0;
 }

 $eC->jN(iS=>$self, nA=>\*kE, hO=>0, jK=>$cG, gV=>$gV, pub=>$pub);
 if($self->{_verbose}) {
	print "\@".$eC->{fI}.' ';
 }

 if($eC->qRa()) {
	$self->{aO} = $il_saved;
 }

 my $footer =$self->{msg_footer};
 if(length($footer) > 8) {
 	 print kE $footer, "\n";
 } else {
 	 print kE qq(</center></body></html><!--@{[$abmain::func_cnt]}-->);
 }
 print kE qq(<!--@{[$abmain::func_cnt]}-->);

 close(kE);
 $self->{_regened_mnos}->{$eC->{fI}} =1;

 $self->{dyna_forum} = $od;
 return if $self->{cXa};

 my $sV = $eC->aI($self);
 $self->{dyna_forum} = $od;

 return if not (($sV->{to} && $eC->{to}) || $sV->{to} eq $eC->{to});
 if(not $no_up) {
 	$self->bT($sV->{fI}, $gV, $hO+1, $no_up, 1+$recur_cnt) 
 if $sV && $sV->{fI}>0 ;
 }
 if($self->need_macro_in_msg('SIBLING_MSG_LINKS')) {
 if($hO ==0 && $eC->{aK} ne $eC->{fI} && $sV) {
	for my $node (@{$sV->{bE}}) {
		next if $node->{fI} eq $eC->{fI};
		$self->bT($node->{fI}, $gV, $hO+1, 1, 1+$recur_cnt);
	}
 }
 }
 $self->{dyna_forum} = $od;

}
 

sub nEa{
 my ($self, $cG) = @_;

 my $eC = lB->new($cG, $cG, $cG);
 if($eC->load($self)) {
 }else {
	$eC->{wW} ="Not found";
 }
	
 my $ad = abmain::plug_in();
 
 my $wW = $eC->{wW};
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>$wW</title>\n$self->{sAz}\n);
 print $self->{msg_header};
 print qq(<center>$ad</center>) if $self->{show_plugin};
 print $self->{msg_banner};

 print $self->oOa($eC);

 my $footer =$self->{msg_footer};
 print $footer, "\n";

}
sub dPz{
 my ($self, $gV) = @_;
 my $path = $gV? $self->dEz() : $self->dFz();
 my $iurl = $gV? $self->dCz() : $self->dKz();
 open FIDX, ">$path";
 print FIDX qq(<html><frameset $self->{dAz}>);
 my @frms = ( qq(<frame name="idx" src="$iurl">), qq(<frame name="MSGA" src="$self->{uE}">));
 if($self->{reverse_frame}) {
	print FIDX (reverse @frms);
 }else {
	print FIDX (@frms);
 }
 print FIDX qq(</frameset></html>);
 close FIDX;
}
sub subst {
 my ($str, $tref, $valref) =@_;
 return $str if not ref($tref);
 for my $x (@$tref) {
 my $rep = shift @$valref || "";
 $str =~ s/$x/$rep/gi;
 }
 return $str;
}
sub mUa {
 my ($str, $tref, $bXaA) =@_;
 for my $x(@$tref) {
 my $rep = $bXaA->{$x};
 $str =~ s/<$x>/$rep/gi;
 }
 return $str;
}
sub mTa {
 my ($str, $tref, $bXaA, $skiphash) =@_;
 for my $x (@$tref) {
	next if $skiphash && $skiphash->{$x};
 my $rep = $bXaA->{$x};
 $str =~ s/<$x>/$rep/gi;
 $str =~ s/\b$x\b/$rep/g;
 }
 return $str;
}
sub vPz{
 my ($self) = @_;
 my $path = $self->xMz();
 my $iurl = $self->{cgi}. "?@{[$abmain::cZa]}cmd=gidx";
 my $bbsurl =  $self->fC();
 open FIDX, ">$path" or abmain::error('sys', "Fail to open file $path: $!");
 print FIDX qq(<html><head><title>$self->{name}</title>$self->{sAz}</head><frameset $self->{idx_fset_attr}>
 <frame $self->{idx_tframe_attr} name="gidx" src="$iurl">
 <frame $self->{idx_bframe_attr} name="ginfo" src="$bbsurl">
 </frameset></html>);
 close FIDX;
}
sub wGz{
 my $self=shift;
 my $menusrc=$self->{cgi}. "?cmd=menu.js";
 return qq(<script LANGUAGE="JavaScript1.2" SRC="$menusrc"></script>);
 return qq(<script LANGUAGE="JavaScript1.2" SRC="http://eagle.netbula-lan.com/~yue/menu.js"></script>);
}
sub hCa{
 my ($self, $name) = @_;
 my @menus =(
 ["Today's new messages",  $self->{cgi}. "?@{[$abmain::cZa]}cmd=find;hIz=1"],
 [$self->{kRz},  $self->{cgi}. "?@{[$abmain::cZa]}cmd=myforum"],
 [$self->{uH} => $self->{cgi}. "?@{[$abmain::cZa]}cmd=form"],
 [$self->{sK},  $self->{cgi}. "?@{[$abmain::cZa]}cmd=yV"],
 [$self->{fKz}, $self->{cgi}. "?@{[$abmain::cZa]}cmd=dW"],
 ['Modify registration', $self->{cgi}. "?@{[$abmain::cZa]}cmd=xV"],
 ["Forum Archive", $self->pRa()],
 [$self->{wV} => $self->{cgi}. "?@{[$abmain::cZa]}cmd=log"],
 ['Help', $abmain::uE]
 );
 my $str=qq! function loadMenu$name() { window.m$name = new Menu("$name");!;

 $str .= qq! window.pmenu=new Menu("pm"); window.pmenu.oKz("Click $self->{uH} to add new message"); !;
 for(@menus) {
 next if ($_->[1] =~ /myforum$/) && not $self->{kWz};
 $_->[0] =~ s/'/\\'/g;
 $str.= qq!window.m$name.oKz('$_->[0]', "location='$_->[1]'");!;
 }
 $str .=qq!
 	 m$name.fontColor = "#ffffff";
 	 m$name.bgColor = "#AAAAAA";
 	 m$name.pNz = "#000000";
 	 m$name.nYz = "#6699CC";
 	 m$name.nZz();
 m$name.enableTracker = true;
 !;
 $str .= qq!}\n!;
 
}
sub vYz {
 my ($self, $curpos)= @_;

 my $title = $self->{name};

 my $cgi = $self->{cgi} ."?";
 
 my $header =$self->{idx_tframe_head};
 my $footer =$self->{idx_tframe_foot};

 my $fC = $self->fC();

 if(length($header) >6) {
 }else {
 $header =  qq(<html><head><title>$title</title> 
 <META HTTP-EQUIV="expires" CONTENT="0">
 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
 <META HTTP-EQUIV="pragma" CONTENT="no-cache">
 $self->{sAz}
 </head><body>
 )
 }
 if($header =~ /<head>/i) {
 $header =~ s/<head>/<head>$self->{sAz}\n<base target="ginfo">/i;
 }else {
 $header =~ s!<html>!<html><head>$self->{sAz}\n<base target="ginfo"></head>!i;
 }

 my ($myforumlnk, $tP, $fNz, $uA, $qOz, $qJz, $plink, $chatlink, $surveylnk, $memberlnk, $evelnk, $linkslnk, $statslnk, $fplink);
 for (($myforumlnk, $tP, $fNz, $uA, $qOz, $qJz, $plink, $chatlink, $surveylnk, $memberlnk, $evelnk, $linkslnk)) {
 $_ = '&nbsp;';
 }
 
 $myforumlnk =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}") if $self->{kWz};

 $plink = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=form;upldcnt=$self->{def_extra_uploads}", $self->{uH});
 $fplink = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yEa", $self->{post_form_word});

 my $gKz = $self->{logo_link} || abmain::cUz($abmain::uE, qq(<img border="0" src="${cgi}@{[$abmain::cZa]}cmd=vL"/>), "_top");

 if($self->{gBz}) {
 $tP = abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yV", $self->{sK}, "");
 }
 if($self->{enable_login} || $self->{tHa}) {
 $fNz= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=dW", $self->{fKz});
 }
 my $wholnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Forum;all=1;verbose=1", $self->{online_stats_word});

 $chatlink= sVa::hFa("${cgi}@{[$abmain::cZa]}cmd=gochat", $self->{gochat_word}, 'chatwin') if $self->{enable_chat};
 $uA= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=log", $self->{wV});
 $qOz = $self->dRz(0); 
 $qJz =  $self->dRz(1) if -f  $self->dHz();
 $surveylnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tOz", $self->{survey_word});
 $memberlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=kPz;hIz=365", $self->{members_word});
 $evelnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz", $self->{events_word});
 $linkslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz", $self->{links_word});
 $statslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vJz", $self->{stats_word});
 my $cpl= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=usercp", $self->{usercp_word});
 my $fplink = qq(<a href="$self->{cgi}?@{[$abmain::cZa]}cmd=yEa">$self->{post_form_word}</a>);
 my $dblnk = qq(<a href="$self->{cgi}?@{[$abmain::cZa]}_aefcmd_=wIa">$self->{db_word}</a>);
 my $gbar = mTa($self->{idx_nav_cfg}, \@jW::idx_tags, 
 {
 REGLNK=>$tP, 
		STATSLNK =>$statslnk,
		WHOLNK=>$wholnk,
		DBLNK =>$dblnk,
		FPOSTLINK=>$fplink,
	        LOGINLNK=>$fNz,
		 ADMLNK=> $uA,
		 MAINLNK=> $qOz, ARCHLNK=> $qJz, 
 CHATLNK=> $chatlink, MYFORUMLNK=> $myforumlnk, MEMBERLNK=> $memberlnk,  POSTLNK=>$plink,  
SURVEYLNK=>$surveylnk, EVELNK=>$evelnk, FORUMNAME=>$title, LINKSLNK=>$linkslnk,
USERCPANELLINK=>$cpl}
);
 sVa::gYaA "Content-type: text/html\n\n";
 print $header, "\n", sVa::tWa(), "\n", $gbar, $footer;
}

sub yZa{ 
	my ($self, $fu, $zu, $scat, $xZa) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(0,1);
 my @rids = $bRaA->yUa($xZa);
 my %rhash=();
	for(@rids){
		$rhash{$_}=1;
 }
 my $cgi = qq($self->{cgi}?@{[$abmain::cZa]});
 my     $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td>Reply with:  </td><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="attachfid" onchange="location='$self->{cgi}?@{[$abmain::cZa]}cmd=follow;zu=$zu;fu=$zu;scat=$scat;attachfid='+this.options[this.selectedIndex].value">);
	$golink.=qq(<option value="">Plain message);
	for(@fids) {
		my ($k, $v) = @$_;
		next if not $rhash{$k};
		$golink.=qq(<option value="$k">$v);
 }
 my $imgurl="${cgi}@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink .= qq(</select></font></td><td valign="middle">
<input type="hidden" name="cmd" value="follow">
<input type="hidden" name="zu" value="$zu">
<input type="hidden" name="fu" value="$fu">
<input type="hidden" name="scat" value="$scat">
<input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
}
sub yRa{ 
	my ($self) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(1,0);
 my $cgi = qq($self->{cgi});
 my     $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td>Post with:  </td><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="attachfid" onchange="location='$self->{cgi}?@{[$abmain::cZa]}cmd=form;attachfid='+this.options[this.selectedIndex].value">);
	$golink.=qq(<option value="">Plain message);
	for(@fids) {
		my ($k, $v) = @$_;
		$golink.=qq(<option value="$k">$v);
 }
 my $imgurl="${cgi}?@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink .= qq(</select></font></td><td valign="middle"><input type="hidden" name="cmd" value="form">  <input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
}

sub bHa{
 my ($self, $iD, $gV, $istop)= @_;
 

 my $cgi = $self->{cgi} ."?";
 my $amcnt= $self->{iW};
 $cgi .= "gV=1;hEz=1;" if $gV;
 
 my $pg=0;
 $pg = $jW::hDz if $jW::hDz;
 $abmain::def_link_attr =qq(class="nav");
 my $wholnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Forum;all=1;verbose=1", $self->{online_stats_word});
 my $statslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vJz", $self->{stats_word});

 my ($aL, $aV, $tP, $sI, $tO, $fNz, $golink, $rS, $uA, $qOz, $qJz, $plink, $chatlink, $reloadlink, $gflink, $dblink, $fplink) = ();
 
 for(($aL, $aV, $tP, $sI, $tO, $fNz, $golink, $rS, $uA, $qOz, $qJz, $plink, $chatlink, $reloadlink, $gflink, $dblink, $fplink)){
 $_ = '&nbsp;';
 }
 my $kYz =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}")||'&nbsp;';
 $plink = qq(<a href="${cgi}@{[$abmain::cZa]}cmd=form;upldcnt=$self->{def_extra_uploads}">$self->{uH}</a>);
 $fplink = qq(<a href="${cgi}@{[$abmain::cZa]}cmd=yEa">$self->{post_form_word}</a>);
 $dblink = qq(<a href="${cgi}@{[$abmain::cZa]}_aefcmd_=wIa">$self->{db_word}</a>);
 my $hGz;
 my $gKz = $self->{logo_link} || abmain::cUz($abmain::uE, qq(<img border="0" src="${cgi}@{[$abmain::cZa]}cmd=vL"/>), "_top");

 if(not $self->{kWz}) {
 $kYz  = '&nbsp;';
 }
 if($self->{gBz}) {
 $tP .= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=yV", $self->{sK}, "");
 }
 if($self->{enable_login} || $self->{tHa}) {
 $fNz= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=dW", $self->{fKz});
 }
 if($iD ) {
 my $url = $gV? $self->pRa(): $self->dKz();
 $aL = abmain::cUz($url, $self->{tA}, "_self");
 }
 $hGz = $jW::hDz +1;
 my $kUz = abmain::wS($self->{kUz});
 
 if($self->{fV} > 1) {
 $aV= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=$hGz;kQz=$kUz",$self->{tE}, "_self");
 
 }
 my $vofp= $abmain::gJ{ofpage} ne "" ? "A" : "";
 if( 1 || $self->{nLz} >1) {
 my $imgurl="${cgi}@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};
 $golink = qq(<table border="0" cellspacing=0 cellpadding=0><tr>
<form action="${cgi}" method="GET"><td><font size="-1">
 				@{[$abmain::cYa]}
<select name="pgno" onchange="location='${cgi}@{[$abmain::cZa]}cmd=vXz;kQz=$kUz;ofpage=$vofp;pgno='+this.options[this.selectedIndex].value">);
	 for(my $i=0; $i<4; $i++) {
		my $h = 1.5 * 2**$i;
		my $t = $h/24;
 	$golink .= qq(<option value="-$t">$h hours);
	 }
 	 $golink .= qq(<option value="-1">Today's);
 	 $golink .= qq(<option value="-9999">last visit -);
 for(my $i=0; $i<$self->{nLz}; $i++) {
 my $p = $i+1;
 my $sel= ""; $sel = "SELECTED" if $i == $jW::hDz;
 $golink .= qq(<option value="$i" $sel>page $p);
 }
 $golink .= qq(</select></font></td><td valign="middle"><input type="hidden" name="cmd" value="vXz"> <input type="hidden" name="kQz" value="$kUz">\&nbsp; <input align="middle" type=image alt="Go" name="Go to page" src="$imgurl" border="0"></td></form></tr></table>);
 }

 if($self->{qR}) {
 $rS= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=jB", $self->{tD});
 }

 $chatlink= abmain::hFa("${cgi}@{[$abmain::cZa]}cmd=gochat", $self->{gochat_word}, 'chatwin')
 if $self->{enable_chat};
 my $ofpage=$jW::hDz ||"0";
 if($jW::hDz ne 'A' && $vofp eq ""){
 	$sI= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=A;ofpage=$ofpage;depth=1;kQz=$kUz", $self->{tB}, "_self")
 }else {
 	$sI= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=vXz;pgno=$ofpage;kQz=$kUz", $self->{full_view_word}, "_self")

 }
 $uA= abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=log", $self->{wV});
 $qOz = $self->dRz(0); 
 $qJz =  $self->dRz(1) if -f  $self->dHz();
 $tO= "\&nbsp;" . abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=qL", $self->{tC});
 $gflink= "\&nbsp;" . abmain::cUz("${cgi}@{[$abmain::cZa]}cmd=gfindform", $self->{gfind_word});
 my $tagslink= "\&nbsp;" . sVa::hFa("${cgi}@{[$abmain::cZa]}cmd=viewtags", $self->{tags_word}, "_tags");
 $reloadlink = abmain::cUz("javascript:location.reload()", $self->{reload_word});
 my $tN = $self->{dI};



 my $dL = $self->{pC} ? @{$self->{pC}} : 0;
 my $sW = $self->{fV} + $dL -1;
 my $tT = $self->{fV}."-"."$sW/$tN";
 $tT = $self->fGz($tT, 'msg_cnt_font');

 my $tJ;

 my $kVz="";
 my $navbdcolor; $navbdcolor=qq(bgcolor="$self->{navbdcolor}") if $self->{navbdcolor};
 $kVz ="$self->{kUz}'s " if $self->{kUz};
 $kVz .= $self->fGz($self->{name}, 'fDz') if($self->{dBz});
 my $nbar ;
 my $tit_str=qq(<td>\&nbsp;\&nbsp\&nbsp;<b>$kVz</b> $tT</td>); $tit_str ="" if $self->{fDz} eq 'undef';
 my $x_str = qq(<td>$gKz</td>); $x_str ="" if $gKz eq 'undef';
 my ($navobg, $navibg);
 $navobg= qq(bgcolor="$self->{navbdcolor}") if $self->{navbdcolor} =~ /\S/;
 $navibg= qq(bgcolor="$self->{navbarbg}") if $self->{navbarbg} =~ /\S/;
 my $leftins = $istop? $self->{navbar_ul}: $self->{navbar_bl};
 my $rightins = $istop? $self->{navbar_ur}: $self->{navbar_br};
 
 my $surveylnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tOz", $self->{survey_word});
 my $memberlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=kPz;hIz=365", $self->{members_word});
 my $evelnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz", $self->{events_word});
 my $linkslnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz", $self->{links_word});
 my $usrcpl = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=usercp", $self->{usercp_word});
 my $par_links = abmain::lPz($self->{eD});
 my $all_fs ="";
 $all_fs = abmain::gIaA() if $self->{compute_forum_list};
if(! $gV) {
 $self->{_navbarhash} = {
 POSTLNK=>$plink, FINDLNK=>$tO, OVERVIEWLNK=>$sI, PREVLNK=>$aV, 
 NEWESTLNK=>$aL, REGLNK=>$tP, LOGINLNK=>$fNz, OPTLNK=>$rS, 
 ADMLNK=>$uA, GOPAGEBTN=>$golink, MAINLNK=>$qOz, ARCHLNK=>$qJz, 
		  RELOADLNK=>$reloadlink, MYFORUMLNK=>$kYz, 
		  STATSLNK=>$statslnk, WHOLNK=>$wholnk, TAGSLNK=>$tagslink, QSRCHLNK=>$gflink, DBLNK=>$dblink,
		  FPOSTLINK=>$fplink,
		  LINKSLNK => $linkslnk,
		  MEMBERLNK=>$memberlnk,
		  SURVEYLNK => $surveylnk,
		  EVELNK   => $evelnk,
		  ALL_FORUMS_LIST => $all_fs,
		  CHATLNK  => $chatlink,
		  USERCPANELLINK =>$usrcpl,
		  PAR_LINKS=>$par_links,
		  FORUMNAME=>$self->{name},
		  QSEARCHBOX =>$self->gMaA(),
 }
 ;
 $nbar = mTa($self->{navbar_layout}, \@jW::gLa, $self->{_navbarhash});

$tJ = qq@
<table cellpadding=$self->{navbdsize} cellspacing=0 border="0" $navobg width=$self->{cYz}><tr><td>
<table cellpadding=$self->{navbdpad} $navibg width=100% $self->{navbarattr}>
<tr>
$leftins
$tit_str $nbar $x_str
$rightins
</tr> 
</table>
</td></tr></table>
@;

} else {
	$self->{_navbarhash} = {
 POSTLNK=>$plink, FINDLNK=>$tO, OVERVIEWLNK=>$sI, PREVLNK=>$aV, 
 NEWESTLNK=>$aL, REGLNK=>$tP, LOGINLNK=>$fNz, OPTLNK=>$rS, 
 ADMLNK=>$uA, GOPAGEBTN=>$golink, MAINLNK=>$qOz, ARCHLNK=>$qJz, 
		  RELOADLNK=>$reloadlink, MYFORUMLNK=>$kYz, 
		  STATSLNK=>$statslnk, WHOLNK=>$wholnk, TAGSLNK=>$tagslink, QSRCHLNK=>$gflink, DBLNK=>$dblink,
		  LINKSLNK => $linkslnk,
		  MEMBERLNK=>$memberlnk,
		  SURVEYLNK => $surveylnk,
		  EVELNK   => $evelnk,
		  ALL_FORUMS_LIST => $all_fs,
		  CHATLNK  => $chatlink,
		  USERCPANELLINK =>$usrcpl,
		  PAR_LINKS=>$par_links,
		  FORUMNAME=>$self->{name},
		  QSEARCHBOX =>$self->gMaA(),
 };
 
 
 $nbar = mTa($self->{navbar_layouta}, \@jW::gLa, $self->{_navbarhash});

$tJ = qq@
<table bgcolor="$self->{nNz}" width=$self->{cYz} $self->{navbarattr}>
<tr>
$leftins
$tit_str $nbar
$rightins
</tr></table>
@;
}
 $self->fQaA();
 $abmain::def_link_attr = "";
 return  $tJ;

}

sub eMaA {
	my ($self, $tags, $gV)  = @_;
	if(not $self->{_navbarhash}) {
		$self->bHa(0, $gV, 0);
	}
	for my $htag (@$tags) {
		my $v = $self->{$htag};
		$v = mTa($v, \@jW::gLa, $self->{_navbarhash});
		$self->{$htag} = $v;
	}
	
}

sub gIaA{
 my ($self)= @_;
 my $cf = $self->nDz('flist');;
 my $tt;
 local *F;

 if((not -f $cf) || (stat($cf))[9] < time() - 3600) {
 my $lck = jPa->new($cf, jPa::LOCK_EX());
 if((not -f $cf) || (stat($cf))[9] < time() - 360) {
	      	abmain::hYa(); 
 		$tt= abmain::fKa(1, $self->fC());
		open F, ">$cf" or return "System error when writing file ($cf, $!)";
		print F $tt;
		close F;
	}
 }
 open F, "<$cf";
 local $/=undef;
 $tt = <F>;
 close F;
 return $tt;

}
sub eG {
 my ($self, $nA, $iD, $gV, $aW)= @_;

 $self->aFz(undef, $gV? "a" : undef);

 if($self->{dDz}) {
 $self->dPz($gV);
 }
 $self->vPz() if ((! -f $self->xMz()) || (stat($self->xMz()))[9] < (stat($self->nCa()))[9]); 
 my ($eS, $realfile);
 $self->oF(LOCK_EX, 5);
 my $regen_chk = $self->{iAa};
 if($regen_chk && not &$regen_chk){
 	$self->pG(5);
	return;
 }
 if(!$nA) {
 $eS = $gV?$self->dHz(): $self->dGz();
 if($jW::use_tmp) {
 $realfile =  $self->tmpfile();
 }else {
 $realfile = $eS;
 }
 $realfile =~ s/`|;//g;
 	open iR, ">$realfile" or abmain::error('sys', "On writing file $realfile: $!");
	$nA = \*iR;
 }
 my $title = $self->{name};
 $title .= " Archive" if $gV;

 my $cgi = $self->{cgi} ."?";
 my $amcnt= $self->{iW};
 $cgi .= "gV=1;hEz=1;" if $gV;
 
 my $header =$self->{forum_header};
 my $footer =$self->{forum_footer};

 my $fC = $self->fC();

 my $menus1= $self->wGz() if $self->{show_menu};
 my $menus2 =$self->hCa('X') if $self->{show_menu};

 if(length($header) >6) {
 if( not $header =~ s/<head>/<head>$self->{sAz}/i) {
 		$header =~ s!<html>!<html><head>$self->{sAz}</head>!i;
	       };
 }else {
 $header =  qq(<html><head><title>$title</title> 
 <META HTTP-EQUIV="expires" CONTENT="0">
 <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
 $self->{sAz}
 </head><body>);
 }
 if($self->{dDz}) {
 if($header =~ /<head>/i) {
 $header =~ s/<head>/<head><base target="MSGA"><basefont size="-1">/i;
 }else {
 $header =~ s/<html>/<html><base target="MSGA">/i;
 }
 }
 my $tJ = $self->bHa($iD, $gV, 1);

 my $pg=0;
 $pg = $jW::hDz if $jW::hDz;
 print $nA &mTa($header, \@jW::gLa, $self->{_navbarhash});
 print $nA "\n".$abmain::lRz;

 print $nA $abmain::kSz;
 print $nA <<"EOF_JS";
 var cook = new Cookie(document, "$self->{vcook}", 2400, "/");
 cook.load();
 cook['lastv0'] = cook['lastv1'];
 cook['lastv1'] =  ${\(time())};
 cook['vpage']= "$pg";
 cook.store();
EOF_JS

 print $nA "\n".$abmain::js_end;
 #print $nA "\n", $menus1;

 print $nA "".sVa::tWa();
 my $ad = abmain::plug_in();

 my $forum_ad = '';
 $forum_ad = $ad if $self->{show_plugin};
 my $forum_banner =  &mTa($self->{forum_banner}, \@jW::gLa, $self->{_navbarhash});

 if($self->{show_menu}){
 print $nA <<"KKKK";
<script language="JavaScript1.2">
$menus2
window.onLoad = loadMenuX;
function showm() { window. pOz(window.pmenu); }
function showm2() { window. pOz(window.mX); }
#document.onMouseDown = showm;
</script>
KKKK

}else {
#    print $nA qq(\n<script>function showm2() {}</script>\n); 
}
 #require gPaA;
 #my $msg_a = tie *PRINTBUF, 'gPaA';

 my $tmp2 = $self->tmpfile()."_";
 open PRINTBUF, ">$tmp2" or abmain::error('sys', "On writing to file $tmp2:$!");
 my $fh_b = \*PRINTBUF;
 

 print $fh_b qq(<div class="ABMSGAREA">);
 print $fh_b $tJ if not $self->{iWa};
 my $jK = ($nA == \*STDOUT || $self->{mFa})? -1 :0;
 print $fh_b &mTa($self->{cWz}, \@jW::gLa, $self->{_navbarhash});

 if(@{$self->{eN}->{bE}} ==0 ) {
 print $fh_b "<p><center>Start by clicking on the <b>$self->{uH}</b> link.</center>";
 }else {
 $self->{eN}->jN(iS=>$self, nA=>$fh_b, jK=>$jK, 
 depth=>$self->{hG}, gV=>$gV, kQz=>$self->{kUz},
				     pub=>$self->{kUz}?0:'p');
 }
 if($self->{rV}){
 print $fh_b &mTa($self->{cXz}, \@jW::gLa, $self->{_navbarhash});
 	print $fh_b $self->bHa($iD, $gV, 0);
 }
 print $fh_b "</div>";
 
 close PRINTBUF;
 open PRINTBUF, "<$tmp2";
 my $forum_msg_area= join("", <PRINTBUF>);
 close PRINTBUF;
 unlink $tmp2;
	

#    print $nA "\n", " "x256,  "<!--@{[$abmain::VERSION]}, @{[$abmain::license_key]}/$self->{iGz}-->\n";

 my $forum_bottom_banner =  &mTa($self->{forum_bottom_banner}, \@jW::gLa, $self->{_navbarhash});
 $self->{_navbarhash}->{FORUM_TOP_BANNER}= $forum_banner;
 $self->{_navbarhash}->{FORUM_BOTTOM_BANNER}= $forum_bottom_banner;
 $self->{_navbarhash}->{FORUM_AD}= $forum_ad;
 $self->{_navbarhash}->{FORUM_DESC_FULL}= $self->{forum_desc_full};
 $self->{_navbarhash}->{FORUM_MSG_AREA}= $forum_msg_area;

 if ($self->{forum_layout} !~ /FORUM_MSG_AREA/) {
 	print $nA "Configuration problem: forum layout does not contain FORUM_MSG_AREA";
 $self->{forum_layout} = qq(FORUM_MSG_AREA);
 }
	
 print $nA  &mTa($self->{forum_layout}, \@jW::gLa, $self->{_navbarhash});

 if(length($footer)>6) {
 print $nA &mTa($footer, \@jW::gLa, $self->{_navbarhash});
 }else {
 print $nA qq(<p><hr></body></html><!--@{[$abmain::func_cnt]}-->);
 }
 print $nA qq(<!--@{[$abmain::func_cnt]}-->);
 close $nA;
 if($realfile && $realfile ne $eS ) {
 rename $realfile, $eS or abmain::error('sys', "On renaming to $eS: $!");
 }
 $self->pG(5);
 return if !$aW;

 my $nM = @{$self->{eN}->{bE}};
 for(my $i=$nM-1; $i>=0; $i--) {
 my $cD = $self->{eN}->{bE}->[$i];
	     $self->bT($cD->{fI}, $gV,0,1);
 }
 abmain::pZa();
}

sub gNaA {
 my ($self, $msg, $jK, $depth, $here, $linkit, $nocat) = @_;
 require gPaA;

 local *PRINTBUF;

 my $msg_a = tie *PRINTBUF, 'gPaA';
 my $fh_b = \*PRINTBUF;

 $self->{nolink_here} = 1 if not $linkit;
 my $oldgrp = $self->{grp_subcat};
 $self->{grp_subcat} =0 if $nocat;
 $msg->jN(iS=>$self, nA=>$fh_b, jK=>-1, 
 depth=>$depth, gV=>0, kQz=>$self->{kUz},
				     iZz=>$here,
				     pub=>$self->{kUz}?0:'p');
 my $str = <PRINTBUF>;
 untie *PRINTBUF;
 $self->{nolink_here} = 0;
 $self->{grp_subcat} = $oldgrp; 
 return $str;
}

sub gQaA {
	my ($self, $msg_arr, $jK, $depth, $here, $linkit, $nocat) = @_;
	my $msg = lB->new();
	for my $m(@$msg_arr) {
		$msg->gKaA($self, $m);
	}
	return $self->gNaA($msg, $jK, $depth, $here, $linkit, $nocat);
}
 
sub gI{
 my ($self, $verbose)= @_;
 my @msgs = values %{$self->{dA}};
 $self->{_regened_mnos} = {};
 for my $msg(sort {$a->{aK} <=> $b->{aK}} @msgs) {
	     if(scalar (@{$msg->{bE}})== 0) { 
	     	$self->bT($msg->{fI});
	     	if($verbose) {
			print ": Regened message ($msg->{fI}, $msg->{jE}, $msg->{aK})\n";
		}
 }
 }
 $self->{_regened_mnos} = {};
}
sub zF{
 my ($self)= @_;
 my $mdir = $self->nDz('hM');
 $mdir =~ s#/?$##;
 while(<$mdir/*>) {
 unlink $_;
 }
}
sub nNa{
 my $ta = shift;
 my $tstr = qq(<table bgcolor="#eeeecc" $ta><tr bgcolor="#99cccc">);
 for (@_) {
 $tstr .= qq(<th> <font $abmain::dfa>$_\&nbsp;</font></th>);
 } 
 return $tstr."</tr>";
}
sub yT{
 my $tstr = qq(<table border="0" cellpadding=2 cellspacing="1" bgcolor="#eeeecc"><tr bgcolor="#99cccc">);
 for (@_) {
 $tstr .= qq(<th> <font $abmain::dfa>$_\&nbsp;</font></th>);
 } 
 return $tstr."</tr>";
}
sub nKz{
 my $color = shift;
 $color = qq(bgcolor="$color") if $color;
 my $tstr = qq(<tr $color>);
 for (@_) {
 $tstr .= qq(<td> $_\&nbsp;</td>);
 } 
 return $tstr."</tr>";
}
sub qXz{
 my ($self, $qQz)= @_;
 my $pp = $self->qZz($qQz);
 return "$qQz does not exist" if not -f $pp;
 $self->cJ($pp, \@abmain::qSz);
 return "$self->{rFz}<p>Poll inactive!" if $self->{rBz};
 my @polls = split ("\n", $self->{qRz});
 my @ans=();
 for(@polls) {
 my ($k, $v) = abmain::oPa($_);
 abmain::jJz(\$k);
 $k =~ /(\w+)/;
 $k = $1;
 next if not $k;
 next if not $v;
 push @ans, [$k, $v]; 
 }
 my $vstr=qq(<form ACTION="$self->{cgi_full}" METHOD=POST><input type="hidden" name="cmd" value="vote">
@{[$abmain::cYa]}
 <input type="hidden" name="qQz" value="$qQz">);
 $vstr .=qq(<table $self->{polltabattr}><tr><td bgcolor="$self->{pollhbg}">$self->{rFz}</td></tr>\n);
 my $first = 1;
 my $ans_cnt = scalar(@ans);
 my $vtype="radio";
 $vtype="checkbox" if $self->{fVa};
 for(@ans) {
 $vstr .=qq(<tr><td> <input type="$vtype" name="$qQz" value="$_->[0]"> \&nbsp; $_->[1]</td>);
 $vstr .= qq(</tr>\n);
 $first = 0;
 }
 $vstr .= qq(<tr><td align="left"><input type="submit" class="buttonstyle" name="v" value="Vote"></td></tr>);
 $vstr .="</table></form>\n";
 return $vstr;
}
sub fZa {
 my ($self, $dref, $all) = @_;
 return if not $self->{forum_tag_trans};
 my $trans = $self->fRa($all);
 &$trans($dref); 
}
sub oVa {
	my ($self, $hsh)=@_;
 my %attr;
 my @cols = ($self->{cbgcolor0}, $self->{cbgcolor1});
 $attr{tha} = qq(bgcolor="$self->{cfg_head_bg}");
 $attr{trafunc} = sub { my $i = shift; my $col = $cols[$i++%2]; return $col? qq(bgcolor="$col") : ""; };
 $attr{usebd}=$self->{usebd};
 $attr{tba}=qq(cellpadding="3" cellspacing="1" border="0");
 $attr{thafunc}= sub { my ($col, $ncol) = @_; return qq(bgcolor="$self->{cfg_head_bg}"); };
 $attr{tcafunc}= sub { my ($row, $col) = @_; my $colo=$self->{gridtab}? $cols[($row+$col)%2] : $cols[$row%2]; return qq(valign="top" bgcolor="$colo"); };
 $attr{thfont}= $self->{cfg_head_font}; 
 $attr{width}="90%";
 for(keys %$hsh) {
		$attr{$_} = $hsh->{$_};
 }
 return %attr;
}
sub fQa{
 my $self= shift;
 my @tags = split ("\n", $self->{forum_tag_trans});
 my @tags2 = split ("\n", $self->{kNa});
 my @trans;
 my @res;
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
 	$k=~ s/</&lt;/g; 
	push @trans, [$k, $v];
 }   
 push @trans, ["Tags in message only"];
 for(@tags2) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
 	$k=~ s/</&lt;/g; 
	push @trans, [$k, $v];
 }   
 my @ths = jW::mJa($self->{cfg_head_font}, "Tag", "Displayed As");
 return sVa::fMa(rows=>\@trans, ths=>\@ths, $self->oVa()); 
}
sub fRa {
 my ($self, $all)= @_;
 my $tagt = "iKa$all$self->{eD}"; 
 return $self->{$tagt} if $self->{$tagt};
 my @tags = split ("\n", $self->{forum_tag_trans});
 push @tags, split ("\n", $self->{kNa}) if $all;
 my $trans={};
 my @res;
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
	$trans->{$k} = $v;
 push @res, "\Q$k\E";
 }   
 my $jK = join ("|", @res);
 $self->{$tagt} = sub {
	my $lineref = shift;
 $$lineref =~ s/($jK)/$trans->{$1}/ge; 
 };
 return $self->{$tagt};
}

sub gFaA{
 my ($self)= @_;
 my $tagt = "_ava_trans$self->{eD}"; 
 return $self->{$tagt} if $self->{$tagt};
 my @tags = split ("\n", $self->{avatar_trans});
 my $trans={};
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
	$trans->{$k} = $v;
 }   
 return $self->{$tagt} = $trans;

}
sub uBz {
 my ($self, $eid) = @_;
 my $edir = $self->nDz('evedir');
 my $efile = abmain::kZz($edir, "$eid.eve");
 my $eveform = aLa->new("eve", \@abmain::uHz);
 $eveform->load($efile);

 my @rows;
 push @rows, [$eveform->{eve_subject}];
 push @rows,  ["<b>$self->{tNz}</b>", $eveform->rQa("eve_start")." <b>to</b> ". $eveform->rQa('eve_end') ];
 push @rows,  ["<b>$self->{uJz}</b>", $eveform->rQa('eve_location') ];
 push @rows,  ["<b>$self->{uUz}</b>", $eveform->{eve_description}];
 push @rows,  ["<b>$self->{uDz}</b>", $eveform->{eve_status}];
 push @rows,  ["<b>$self->{uVz}</b>", $eveform->{eve_org}];
 push @rows,  ["<b>$self->{uCz}</b>", $eveform->{eve_contact}];
 push @rows,  [abmain::cUz("#EVETOP",  "Top").'&nbsp; &nbsp;'.
 abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=tQz;eveid=$eid", "Delete") 
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=modeveform;eveid=$eid", "Modify")
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=tYz;eveid=$eid", $eveform->{eve_can_sign}?"Sign up":undef)
 . "\&nbsp;\&nbsp;\&nbsp;"
 . abmain::cUz($self->{cgi}. "?@{[$abmain::cZa]}cmd=vsl;eveid=$eid", $eveform->{eve_can_sign}?"List":undef)
 ]; 
 return sVa::fMa(rows=>\@rows, $self->oVa()); 
}
sub tPz{
 my ($self, $sstamp, $mode, $pat) = @_;
 my $edir = $self->nDz('evedir');
 my $eidx = abmain::kZz($edir, "event.idx");
 my $ecache = abmain::kZz($edir, "event.cac");
 $mode = 'tab' if not $mode;
 my $omode = $mode eq 'tab'? 'list' : 'tab';

 if($sstamp eq "") {
 my $iN = time();
 $sstamp = sVa::bAaA($iN,6);	
 }
 $sstamp = substr($sstamp, 0, 6);
 $sstamp .="00000000";

 my @rows;
 my ($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst);
 if($sstamp =~ /(\d\d\d\d)(\d\d)(\d\d)\d{6}/) {
		$year = $1;
		$mon = $2;
 }else {
	    	($sec,$min,$hour,$nQ,$mon,$year,$mD,$bQ,$isdst) = localtime(time);
		$year +=1900;
		$mon +=1;
 } 
 my $itemhash;

 my $linesref = $bYaA->new($eidx, {schema=>"AbEveIndex", paths=>$self->zOa('eve')})->iQa({noerr=>1, where=>"start_time>'$sstamp'"} );
 my @eves;
 for(@$linesref) {
 next if $pat && not join (" ", @$_) =~ /$pat/i;
 my ($eid, $esub, $etime, $eorg, $eauthor, $ct, $modt)= @$_;
 next if ($sstamp && ($etime cmp $sstamp) <0);
 next if not $eid;
 next if not $esub;
 push @eves, [$eid, $esub, $etime, $eorg, $eauthor, $ct, $modt];
	   $itemhash->{substr($etime, 0, 8)} .= sVa::cUz("#$eid", $esub). "<br/>";
 }
 my @eves_sorted = sort { $a->[2] cmp $b->[2] } @eves;
 my @bgs=($self->{uQz}, $self->{uRz});

 sVa::gYaA "Content-type: text/html\n\n";
 $self->eMaA( [qw(other_header other_footer eve_page_top_banner eve_page_bottom_banner)]);
 print qq(<html><head>\n$self->{sAz}\n);
 print $self->{other_header};
 print $self->{eve_page_top_banner};
 print $self->{uGz};
 my $addel =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=eveform", $self->{eve_add_word});
 my $viewol =  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$omode", $omode eq 'tab'? "Calendar view": "List view");
 print qq(<a name="EVETOP">\&nbsp;</a>);
 my @ths =($self->{tNz}, "Topic", $self->{uVz}, "Comments");
 my $i=0;
 my $comment;
 for(@eves_sorted) {
 $comment="";
 if($_->[6]) {
 $comment = "Modified at ".abmain::dU('SHORT', $_->[6], 'oP');
 }else{
 $comment = "Created at ".abmain::dU('SHORT', $_->[5], 'oP');
 }
 
 push @rows, [sVa::aKaA($_->[2]), abmain::cUz("#$_->[0]", $_->[1]), $_->[3],  "<small>$comment</small>"];
 }
 my %attr = $self->oVa();
 if($mode eq 'tab') {
		my $prevt = sVa::eNaA($year, $mon, -1);
		my $nextt = sVa::eNaA($year, $mon, 1);
 	my $prevlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$mode;sstamp=$prevt", "Previous");
 	my $nextlnk = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=tVz;mode=$mode;sstamp=$nextt", "Next");
 		my $cmdstr = join(" | ", $prevlnk, "<b>".sprintf("%d/%02d", $year, $mon). "</b>", $nextlnk, $viewol, $addel);
		print sVa::tQa($year, $mon, $itemhash, sub { $_[0];}, 
			$cmdstr,
			\%attr );
 }else {
 		my $cmdstr = join(" | ",  $viewol, $addel);
		print "<center>$cmdstr</center>";
 		print sVa::fMa(rows=>\@rows, ths=>\@ths, $self->oVa());
 }
 print $self->{uXz};
 for(@eves_sorted) {
 print qq(<a name="$_->[0]">\&nbsp;</a>);
	   print $self->uBz($_->[0]);
 print $self->{uLz};
 }
 print $self->{eve_page_bottom_banner};
 print $self->{other_footer};
 
}
sub wBz {
 my ($self, $nA, $showdel) = @_;
 $self->cR();
 my $lnkidx = $self->nDz('links');
 my $linesref = $bYaA->new($lnkidx, {schema=>"AbLinks", paths=>$self->dHaA($lnkidx) })->iQa({noerr=>1} );
 
 $self->eMaA( [qw(other_header other_footer lnk_page_banner lnk_page_bbanner)]);

 print $nA "<html><head>", $self->{sAz},
 "<title>$self->{name} related links</title>";
 print $nA $self->{other_header},
 $self->{lnk_page_banner};

 print $nA $self->{lnk_vsep};
 print $nA "<UL CLASSID=ABLINKS>\n";
 local $_;
 while ($_ = pop @$linesref) {
 my ($lid, $lsub, $lurl, $lcat, $lauthor, $ltime, $desc)= @$_;
 print $nA "<LI>", abmain::cUz($lurl, $lsub), $self->{lnk_sd_sep}, $desc;
 if($showdel) {
 	print $nA '&nbsp;' x 5;
 	print $nA "".abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=uOz;lnkid=$lid", "$self->{lnk_del_word}");
 }
 
 }
 print $nA "</UL>";
 print $nA $self->{lnk_page_bbanner},
 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=wMz;adm=1", "$self->{lnk_adm_word}"),
	 '&nbsp;' x 4,
 	 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=uNz", "$self->{lnk_add_word}"),
 $self->{other_footer};
 close $nA;

}
sub init_msg_mac_list{
	my ($self) = @_;
	return if $self->{_inited_msg_mac_list};
	my $txt = join(" ", $self->{mbar_layout}, $self->{mbbar_layout}, $self->{message_page_layout});
	study $txt;
	for my $k (@jW::gLa, @jW::mbar_tags) {
		$self->{_msg_mac_list}->{$k} =1 if $txt =~ /$k/;
	}
	$self->{_inited_msg_mac_list} =1;
	
}

sub need_macro_in_msg {
	my ($self, $mac) = @_;
	if(not $self->{_inited_msg_mac_list}) {
		$self->init_msg_mac_list();
	}
	return $self->{_msg_mac_list}->{$mac};
}

 

sub rMz{
 my ($self, $qQz)= @_;
 my $pp = $self->qZz($qQz);
 my $ps = $self->qYz($qQz);
 return "$qQz does not exist" if not -f $pp;
 $self->cJ($pp, \@abmain::qSz);
 my @polls = split ("\n", $self->{qRz});
 my %qs=();
 for(@polls) {
 my ($k, $v) = abmain::oPa($_);
 abmain::jJz(\$k);
 $k =~ /(\w+)/;
 $k = $1;
 next if not $k;
 $qs{$k} = $v; 
 }
 $self->rAz($qQz) if not -f $ps;
 open F, "<$ps";
 my @gHz = <F>;
 close F;
 my %ans;
 for(@gHz) {
 chop;
 my ($k, $v) = split ('=', $_);
 $ans{$k} = $v if $k ne '';
 $ans{$k} = 0 if not $ans{$k};
 }
 
 my $vstr ;
 if ($ans{total}==0 ) {
 $vstr =  "No votes yet";
 }else {
 	$vstr .=qq(<table $self->{pollrtabattr}>);
 $vstr .=qq(<tr><td bgcolor="$self->{pollhbg}">$self->{rFz}</td></tr>);
 	my $cnt = scalar(keys %qs);
 	my $resi=100;
 	for(keys %qs) {
 $cnt--;
 my $pct = sprintf("%.2f",  $ans{$_}/$ans{total} * 100);
 my $block = rOz(int $pct, 10, $self->{rNz});
 $resi -= $pct;
 $pct += $resi if $cnt == 0;
 my $pct2 = sprintf("%.2f", $pct);
 $vstr .=qq(<tr><td><b>$qs{$_}</b><br/>$block $pct2\%\&nbsp;\&nbsp;($ans{$_} votes)</td></tr>\n);
 	}
 $vstr .=qq(<tr><td align="right">Total votes: $ans{total}</td></tr>\n);
 	$vstr .="</table>\n";
 }
 open F, ">".$self->rKz($qQz);
 print F abmain::rLz($vstr);
 close F;
 open F, ">".$self->xFz($qQz);
 $self->eMaA( [qw(other_header other_footer)]);
 print F "<html><head>\n$self->{sAz}\n$self->{other_header}\n$vstr\n$self->{other_footer}";
 close F;
 return $vstr;
}
sub rOz {
 my ($w, $h, $c) = @_;
 return "" if $w == 0 || $h == 0;
 return qq(<table border="0" cellspacing=0 cellpadding=0 width="$w" height="$h" bgcolor="$c" class="ProportionBlock"><tr><td>\&nbsp;</td></tr></table>);
}

 

sub tS {
 my ($self, $cmd, $sBz, $fromarch)= @_;
 my $title = $self->{name};
 my $cgi = $self->{cgi};
 my $jO = $abmain::gJ{by};  
 my $action;
 if($cmd eq 'arch') {
 $action = "Archive";
 }elsif($cmd eq "gQ") {
 $action = "Delete";
 }elsif($cmd eq "moder") {
 $action = "Approve";
 $self->{yBz} =0;
 }
 my $depth = $action eq "Archive"? 1: 0;
 $self->{min_rate}=0;

 $self->aFz(undef, $fromarch? "a" : undef);
 $self->eMaA([qw(other_header other_footer)]);

print qq@<html><head><title>$action From $title</title><BASE TARGET=nwin>
$abmain::mC
$self->{sAz}
$self->{other_header}
<a href="${\($self->fC())}"><small>${\($self->{name})}</small></a>
<hr><p>
@
;

 my $eS = $fromarch? $self->nDz('archlist'): $self->nDz('msglist');

print <<DEL_FORM;
<center><h1>$action from $title</h1> </center>
<form action="$cgi" method="POST" target=dwin onsubmit="hB('dwin', this);return true;">
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
${\(&yT("Check the boxes on the left of the messages, and submit", ""))}
DEL_FORM

 $self->{hEz}= 1 if $cmd eq 'arch';

 if(($abmain::gJ{pat} || $abmain::gJ{hIz} || $abmain::gJ{hJz}) ) {
 my $pat = $abmain::gJ{pat};
 my $yM;
 my $sti = time() - $abmain::gJ{hIz}* 24 * 3600;
 $sti = -1 if not $abmain::gJ{hIz};
 my $eti = time() - $abmain::gJ{hJz}* 24 * 3600;
 $pat = ".?" if not $pat;
 $yM = sub { my ($e)=@_; 
 return ($fromarch? $e->{aK} == $e->{fI} :1) && ($e->{hC}=~ /$pat/i || $e->{fI} =~ /$pat/i || $e->{wW}=~/$pat/i || $e->{track} =~ /$pat/i || &abmain::pT($e->{pQ}) =~ /$pat/i) && ($e->{mM}>=$sti && $e->{mM} <= $eti);
 };
 
 	$self->aT('A', $eS, 0, $yM,'`', $sBz, $sti, $eti);
 }else {
 	$self->aT('A', $eS, 0, 0,       '`', $sBz);
 }
	       

 if($jO ne 'fI') {
 my %iF;
 for (values %{$self->{dA}}) {
 if($jO eq 'mM') {
	               $iF{abmain::dU('YDAY', $_->{mM}, 'oP')}++;
	          }elsif($jO eq 'pQ') {
	               $iF{abmain::pT($_->{pQ})}++;
	          }else {
	               $iF{$_->{$jO}} ++;
	          }
 }
#      print qq(<table border=1 align="center">);
 for(sort keys %iF) {
	       my $cnt = $iF{$_};
 print qq(<tr><td><input type="checkbox" name="fJ" value="$_">$_</td>);
 print qq(<td> $cnt messages </td></tr>);
	  }
#   print qq(</table>);
 }else {
 print qq(<tr><td colspan=2>);
 $depth= $abmain::gJ{depth} if($depth ==0); 
 $self->{eN}->jN(iS=>$self, nA=>\*STDOUT, jK=>-1, hO=>0, gQ=>1, depth=>$depth, gV=>$fromarch);
 print qq(</td></tr>);
 }
 print qq(<tr bgcolor="#cccccc"><td align="center">);
 print qq(<input type="hidden" name="cmd" value="$cmd">);
 print qq(<input type="hidden" name="by" value="$jO">);
 print qq(<input type="hidden" name="fromarch" value="$fromarch">);
 print qq(<input type="submit" class="buttonstyle" name="submit" value="$action">);
 print qq(\&nbsp;\&nbsp<input type="submit" class="buttonstyle" name="submit" value="Delete">
 confirm deletion <input type="checkbox" name="confdel" value="1">
 ) if $action eq "Approve";

 print qq@\&nbsp;\&nbsp;\&nbsp;\&nbsp;<a href="javascript:window.kEz(document.forms[0], 1);" target=_self> Check all</a>@;
 print qq@\&nbsp;\&nbsp;\&nbsp;\&nbsp;<a href="javascript:window.kEz(document.forms[0], 0);" target=_self> Uncheck all</a>@;
 print qq(</td><td bgcolor="ddddff" align="left"> Including threads);


 unless ($fromarch) {
 	 if($self->{inline_followups} || $action eq "Archive") {
 	 	print qq(<input type="hidden" name="thread" value="1">);
 	 }else {
 	 	print qq(<input type="checkbox" name="thread" value="1" checked>);
 	 }
 	 print qq(\&nbsp;\&nbsp;Backup deleted messages<input type="checkbox" name="backup" value="1">);
 	 if($self->{take_file}) {
 	     print qq(\&nbsp;\&nbsp;Including uploaded files <input type="checkbox" name="gLz" value="1">); 
 	 } 
 }

 print qq(</td></tr></table></form>);
 $self->{other_footer};
}
sub yLa {
 my ($self, $form) = @_;
 $self->eMaA( [qw(other_header other_footer form_banner)]);

my $header =$self->{other_header};
my $footer =$self->{other_footer};
my $xstyle ;
$xstyle = abmain::htmla_code() if $abmain::htmla;
my $gU = qq(<html> <head><title>Post: $self->{name}</title>);
if(length($header)< 5 ) {
$gU .= qq( 
$self->{sAz}
$xstyle
</head><body> <center>
<h1> <font COLOR="#DC143C">$self->{name}</font> </h1>
<HR NOSHADE WIDTH="80%"> </center>
<br/>
);
}else {
 $header =~ s!</head>!$self->{sAz}$xstyle</head>!i;
 $gU .= $header;
}
$gU .= $self->{form_banner};
 

$gU .= qq@
 <a name="post"></a>
@;

$gU .= $form;

my $inithtmla;
if($abmain::htmla) {
	$inithtmla=qq!\n<script type="text/javascript" defer="1"> HTMLArea.replace("htmlbody");</script>\n!;
}
$gU .= $inithtmla;

if(length($footer)<10) {
	$gU .= qq(<p><hr><p></body></html>);
}else {
 $gU .= $footer;
}

return $gU;

}
sub yHa{
	my ($self) = @_;
	my $bRaA = $self->wPa();	
	my @fids = $bRaA->yVa(1,1);
	my $hdr ="<h1>Please choose one of the following forms</h1>";
	my $form_start = qq(<form name="postmsg" method="POST" action="$self->{cgi}"> @{[$abmain::cYa]});
	$form_start .=qq(
			<input type=hidden name="cmd" value="form">
			<input type=hidden name="upldcnt" value="$self->{def_extra_uploads}">
			<input type=hidden name="shortform" value="1">
			);
	for(@fids) {
		my ($k, $v) = @$_;
		$form_start.=qq(<li><input type="radio" name="attachfid" value="$k">$v);
	}
	$form_start .=qq(<br/><input type="submit" name=x value="Submit">);
	$form_start .="</form>";
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->yLa("<center>$hdr".$self->yRa()."</center>");
}

sub yFa {
	my ($self, $xZa, $cG) = @_;
 my ($is_root, $root) = abmain::eVa() ;
 abmain::error('inval', "Invalid message id") if $cG <=0;
 my $msg= $self->pO($cG); 	

 my $name;
	my $bRaA = $self->wPa();	
	$name = $bRaA->{wOa};

	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author ($msg->{hC}) of the message can modify it ($name)")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
	}
 
 my $link= abmain::cUz($self->nGz($cG, $msg->{aK}, 0, 0, $msg->qRa()), $msg->{subject});

 my $form = $bRaA->yOa($xZa, 0, undef, {_ab_attach2mno=>$cG});
	sVa::gYaA "Content-type: text/html\n\n";
	print $self->yLa($link."<br/>".$form->form());
}

sub yGa{
 my ($self, $cG, $xZa, $objid, $msgstr, $design) = @_;
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz(1);
 }

 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

	abmain::error('inval', "Invalid message id") if $cG <=0;
	$self->pO($cG, undef, 1, 0);
	my $msg = $self->{dA}->{$cG};

 my $name;
	if($self->{fWz} || $is_root) {
	     $name = $self->{fTz}->{name};
	}

	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author ($msg->{hC}) of the message can modify it ($name)")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
 }

	$msg->load($self, 1);
	$msg->{attached_objtype} =$xZa;
	$msg->{attached_objid} = $objid;
	$msg->{status} = "ok";
	if($design->{allowedreaders} ne "") {
		my $oldto = $msg->{to};
	        my $th = jW::eFaA($oldto);	
	        my $th2 = jW::eFaA($design->{allowedreaders});	
		my (@nus, $nu);
		for my $u (keys %$th2) {
			push @nus, $u if not $th->{$u};
		}
		$nu = join(", ", @nus);
		$msg->{to} = join(", ", keys %$th, keys %$th2) if $nu ne "";
		$self->cMaA($msg, $nu) if $nu ne '';
	}
	$msg->store($self);
 $self->vWz($msg);
	$self->bT($cG);
	my $aK = $self->{dA}->{$cG}->{aK};
	my $sub = $self->{dA}->{$cG}->{wW};
 my $murl= $msg->nH($self, -1);
 my $link= abmain::cUz($murl, "<small>$sub</small>");
 $self->rSz(-10);
	abmain::cTz("<h1> Posted data to $link </h1><p>$msgstr", "Response", $murl);
}

sub eFaA{
	my ($tostr) = @_;
	my $h = {};
	for my $to1 (split /\s*,\s*/, $tostr) {
		next if $to1 !~ /\S/;
		$h->{$to1} = 1;
	}
	return $h;
}
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
sub oHa{
 my ($self) = @_;
 my $catspec= join("\n", $self->{catopt}, $self->{hBa});
 abmain::wDz(\$catspec);
 my $selmak = aLa::bYa(['scat', 'select',  $catspec]);
 return sub {
	my $cat = shift;
	return $selmak->aYa($cat, qq(onchange="location='#cat'+this.options[this.selectedIndex].value"));
 };

}
sub gU {
 my ($self, $aK, $par, $upldcnt, $privusr, $attachfid) = @_;
 my ($gD, $fE, $fT, $iH, $hF, $oto, $xE);

 if($par>0) {
	  my $sV = $self->pO($par);
 abmain::error('inval', "Reply to this message is disabled") if $sV->{xE} & $pYz;
 ($gD, $fT, $iH, $hF, $oto)
 = ($sV->{wW}, $sV->{hC}, 
	         abmain::dU('S', $sV->{mM}, 'oP'),
 $self->jA($par),
 $sV->{to}
	        );
 $xE = $sV->{xE};
	$fE = $self->gB($sV->{fI});
 	$self->fZa(\$fE, 1); 
 	$fE =~ s/\cM//g;
 	$fE =~ s/\n\n/<p ab>/g;
	my ($xZa, $oid);
	if($sV->{attached_objtype}) {
		($xZa, $oid) = ($sV->{attached_objtype}, $sV->{attached_objid});
 	}
 	if($xZa && $oid ne "") {
		my $bRaA = $self->wPa();	
		my $astr =  $bRaA->yNa($xZa, $oid);
		$fE .= $astr;
 	}

 }

 my $gO = $par>0? "${\($self->{uI})}:  $gD by $fT": $self->{name};
 my $cgi        = $self->{cgi}; 
 my $fC        = $self->fC();
 if($par >0) {
 my $igflag = $self->mWa(lc($fT), lc($self->{fTz}->{name}));
 	if($igflag ==1 ) {
		abmain::error('inval', "You are being ignored by $fT");
 	}elsif($igflag == 2) {
		abmain::error('inval', "You are ignoring $fT");
 	}
 }
 if($privusr ne "" && not $self->{kWz}) {
		abmain::error('deny', "Private messaging disabled");
 }
	
$self->eMaA([qw(other_header other_footer form_banner)]);

my $header =$self->{other_header};
my $footer =$self->{other_footer};

my $xstyle ;
$xstyle = abmain::htmla_code() if $self->{try_wysiwyg};
my $spelljs;
if($abmain::enable_speller) {
 $spelljs= $abmain::spell_js;
}
my $gU = qq(<html> <head> $spelljs <title>Post: $gO</title>);
if(length($header)< 5 ) {
$gU .= qq( 
$self->{sAz}
$xstyle
</head><body> <center>
<h1> <font COLOR="#DC143C">$gO</font> </h1>
<HR NOSHADE WIDTH="80%"> </center>
<br/>
);
}else {
 $header =~ s!</head>!$self->{sAz}\n$xstyle</head>!i;
 $gU .= $header;
}

$gU .= $self->{form_banner};
 
if($par >0) {
 $gU .= qq@
 <table width="90%" cellspacing="1" align="center">
 <tr>
 <th align="left" bgcolor="$self->{cfg_head_bg}"><font $self->{cfg_head_font}>$self->{sB}$self->{rK}: \&nbsp; $gD</font></th></tr>
 <tr><td  bgcolor="$self->{bIz}">
 $fE
 $self->{msg_sep2}
 </td></tr></table><p>
 @ if $self->{pZz};
}

$gU .= qq@
 <a name="post"></a>
@;

$gU .= $self->nO($aK, $par, $gD, $fE, $fT, $oto, $upldcnt, $privusr, $xE, $attachfid);

my $inithtmla;
if($self->{try_wysiwyg} && $self->{fTz}->{use_fancy} ne 'no') {
	$inithtmla=qq!\n<script type="text/javascript" defer="1"> HTMLArea.replace("htmlbody");</script>\n!;
}

$gU .= $inithtmla;
if(length($footer)<10) {
	$gU .= qq(<p><hr><p></body></html>);
}else {
 $gU .= $footer;
}

return $gU;

}
sub nK {
 my ($self) = @_;
 $self->eMaA([qw(other_header other_footer)]);
 my $cgi        = $self->{cgi}; 
 sVa::gYaA "Content-type: text/html\n";
 my $t=time;
 print "Set-Cookie: test_cook=a$t; path=/\n\n";
 print qq(
 <html><head>
$self->{sAz}
<meta http-equiv="Expires" content="0">
$self->{other_header}
 <table width=604 align="center" border="0" cellspacing=0 cellpadding=0 >
 <tr><td height=40>&nbsp;</td></tr>
 <tr><td>
 <form action="$cgi" METHOD="POST">
 				@{[$abmain::cYa]}
 <input type="hidden" name="cmd" value="login">
 <table width=604 align="center" border=1 cellspacing=0 cellpadding=6 >
 <tr><td>
 <table width=600 align="center" cellspacing=0 border =0 cellpadding="4" BGCOLOR="$self->{xM}">
 <tr rowspan=1><td colspan=2 align="center">
 <font size="+1" color=#000000><b>Administer $self->{name}</b></font>
	</td></tr>
 <tr ><td bgcolor="$self->{cfg_head_bg}" colspan=2 height=50 align="center">
 <font $self->{cfg_head_font} size="2"><b>Enter Admin Login Info</b></font>
	</td></tr>
 <tr><td height=20 colspan=2>&nbsp;</td></tr>
 <tr BGCOLOR="$self->{xM}"><td align="right">Name: </td><td align="left">
 <input type="text" name="fM" size="32" value="" ></td></tr>
 <tr BGCOLOR="$self->{xM}" align="center"><td align="right">Password: </td>
 <td align="left"><input type="password" name="oA" size="32" ></td></tr>
 <tr align="center"><td>&nbsp;</td><td height="40"> <input type="submit" class="buttonstyle" name=Send value=Login></td> 
 </tr>
 <tr><td valign=bottom align="left" width=200><small>If you have questions about AnyBoard(TM)
 , <a href="http://netbula.com/anyboard/">
	click this link for help.</a></small></td>
 <td valign=bottom align="right"><a href="http://netbula.com">Netbula LLC</td>
 </tr>
 </table>
 </td></tr>
 </table>
 </form>
 </td></tr>
 </table>
$self->{other_footer}
 );
}  
sub mE{
 my  $str = shift;
 my $sum;
 my @arr = unpack("C*", $str);
 for(@arr){ $sum += $_;};
 $hW = "a"."$sum";
}
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

=item

print qq(
<form action="$cgi" method="POST">
@{[$abmain::cYa]}
<input type="hidden" name="cmd" value="changemsgstat">
<input type="hidden" name="cG" value="$cG">
<table bgcolor="$self->{xM}" width="$self->{pform_tb_width}" $self->{pform_tb_attr}>
<tr><td colspan=2><h2 align="center">
<select name=showit>
<option value="1">Display 
<option value="0">Hide 
</select> 
<i>$gD</i></h2></td></tr>
<tr><td>$nameline</td></tr>
<tr><td colspan=2>
<input type="submit" class="buttonstyle" name="submit" value="Change Message Display Status">\&nbsp;\&nbsp; $cG
</td></tr></table>
</form>
<pr>
) if $isadm || $is_root;

=cut

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
sub bI{
 my $self = shift;
 my $logit=0;
 my $dM = 0;
 $abmain::g_is_root =0;
 my ($is_root, $root) = abmain::eVa() ;
 my $kWa =undef;
#x2
 goto FOR_ROOT if $is_root && $root ne "";
 if(@_) {
 ($oK, $dD) = @_; 
 $cI= unpack("H*", $oK);
 $aN = unpack("H*", $dD);
 mE($abmain::fvp);
 $logit = 1;
 }else {
 mE($abmain::fvp);
 if(not defined($abmain::fPz{$hW})) {
 	abmain::error('iT', "You need to relogin!") if(not $self->{hRa});
 return;
 }
 ($cI, $aN) = split /:/, $abmain::fPz{$hW};
 $oK = pack("H*",  $cI);
 $dD = pack("H*",  $aN);
 }
 my $p = $self->{oA};
 my $ptmp = "";
 my $p2 = $self->{admin};
 my $sf = $self->nDz('skey');
 if(open SF, $sf) {
	$ptmp =<SF>;
	$ptmp =~ s/\s//g;
	close SF;
 }
 my $inp = abmain::lKz($dD, $dD);

 if ($oK eq $self->{admin} && (($inp eq $p) || ($ptmp && $inp eq $ptmp) || $p eq "")){
 $uT = $kWa||"adm";
 }elsif ($self->{moders}->{$oK} && $inp eq $self->{moders}->{$oK}->[1]) {
 ($self->{moderator_email}, $self->{vI}, $self->{vM}, $self->{vN}, $self->{mod_can_dopoll})
 = @{$self->{moders}->{$oK}};
 $uT = "mod";
 } else {
 $logit = 1;
 $dM =1;
 
 }
 if($logit) {
 if($dM) {
 $self->wNz(0, "???", $self->nDz('admlog'));
 return if $self->{hRa};
 		abmain::error($self->{scare_adm_msg}, "Wrong admin password. Failed attempt logged <b> $abmain::ab_id0</b>");
 }
 $self->wNz(1, $uT, $self->nDz('admlog'));
 }
 return 1;
FOR_ROOT:
 $uT = $kWa||"adm";
 $oK = $root;
 $abmain::g_is_root =1;
 $self->wNz(1, $uT, abmain::wTz('admlog'));
 return 1;
}
sub yXa{
 my $self = shift;

 mE($abmain::fvp);
 if(not defined($abmain::fPz{$hW})) {
 return;
 }
 ($cI, $aN) = split /:/, $abmain::fPz{$hW};
 $oK = pack("H*",  $cI);
 $dD = pack("H*",  $aN);
 my $p = $self->{oA};
 my $inp = abmain::lKz($dD, $dD);

 if ($oK eq $self->{admin} && (($inp eq $p))){
 $uT = "adm";
		return 1;
 }
 return;
}
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
sub nW {
 my ($self) = @_;
 my ($uname, $pass) = ($abmain::gJ{uname}, $abmain::gJ{passwd});
 my  @pass_ent = getpwnam($uname) or abmain::error('dM', "Who are you?");
 my  $salt = substr($pass_ent[1], 0, 2);
 if (crypt($pass, $salt) ne $pass_ent[1]) {
 abmain::error('dM', "Invalid user name or password for $pass_ent[0]");
 }
 $self->jI();
}
sub dNaA{
 my ($self, $form) = @_;
 $self->eMaA( [qw(other_header other_footer)]);
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head>\n$self->{sAz}\n$self->{other_header});
 $form->zQz($self->{cgi});
 print $form->form();
 print $self->{other_footer};
}

sub lM{
 my ($self) = @_;
 $self->cR();
 $self->bI($abmain::gJ{fM}, $abmain::gJ{oA});
 if($self->{oA} eq "" && not $abmain::g_is_root) {
		my $cook = abmain::bC($hW, "$cI:$aN", '/');
 		$self->jI(\@abmain::bO, "bV", "You must change admin password first", 0, 0, undef, undef, $cook);
 		return;
 }
 $self->aU();
 $self->yTa(1) if $self->{takepop};
 $self->qXa();
}
sub nU {
 my ($self, $cO, $hIz, $hJz, $zA) = @_; 
 $self->cR();
 $self->bI() if ($zA);
 my $lck = jPa->new($self->nDz('msglist'), jPa::LOCK_EX());
 if($self->{aWz}) {
 	$self->{aGz}=1;
 	$self->{aIz}=0;
 $self->aQz();
 }
 if($cO) {
 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 my $yM;
 $yM = sub { my ($e)=@_; 
 return ($e->{mM}>=$sti && $e->{mM} <= $eti);
 };
 	$self->aT('A', 0, 0, $yM, undef, undef, $sti, $eti);
 if($zA) {
 $self->zF();
 }
 $self->oF(LOCK_EX,13);
 	$self->gI($self->{_verbose});
 $self->pG(13);
 }
 $self->aT();
 $self->eG();
};
sub rSz {
	my ($self, $oldage) = @_;
 $oldage = 600 if not $oldage;
 my $idx = $self->dGz();
	if( (stat($idx))[9] < time() - $oldage) {
#IF_AUTO abmain::hOa();
 abmain::hYa(); 
	       $self->cR();
	       $self->{iAa} = sub {(stat($idx))[9] < time() - $oldage};
	       $self->nU();
	}
}

 

sub rIa{
	my ($self) = @_;
	return abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=ulogout", $self->{logout_word});
}
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
sub gMaA {
 my ($self) = @_;
 
 my $imgurl="$self->{cgi}?@{[$abmain::cZa]}cmd=vL;img=1";
 $imgurl = $self->{gobtn_url} if $self->{gobtn_url};

 return qq(
<form action="$abmain::jT" method="GET" style="display:inline">
<input type=hidden name="svp" value="$abmain::fvp">
<input type=hidden name="cmd" value="searchfs">
<table class="SEARCHFORM">
<tr><td><input type=text size=12 name=tK class="searchfield"></td><td><input align="middle" type=image alt="Go" name="Search" src="$imgurl" border="0"></td></tr></table></form>);
}
sub aFz {
 my ($self, $cG, $suf, $one) = @_;
	return $abmain::use_sql? $self->zBa($cG, $suf, $one) : $self->zNa($cG, $suf, $one);
}

sub zNa {
 my ($self, $cG, $suf, $one) = @_;
 
 my @nums;
 if(defined $cG) {
 push @nums, ($cG%$jW::hash_cnt) || 0;
 }else {
	   @nums = (0..$jW::hash_cnt);
 }
 my $rf = $self->nDz('rating');
 my @linesx;
 if ( -f $rf) {
		my $linesref = $bYaA->new($rf, {schema=>"AbRatings"})->iQa({noerr=>1} );
 	return if not $linesref;
		push @linesx, @$linesref;
 }else {
		for(@nums) {
			my $f = $self->mZa($_, $suf);
			my $linesref = $bYaA->new($f, {schema=>"AbRatings"})->iQa({noerr=>1} );
 		next if not $linesref;
			push @linesx, @$linesref;
		}
 }
 for(@linesx) {
 my ($mno2, $rate, $cnt, $viscnt, $fpos, $loc, $readers) = @$_;
 next if not $mno2;
 $self->{ratings2}->{$mno2}= join("\t", $rate, $cnt, $viscnt, $fpos, $loc, $readers);
 }
 if ( -f $rf) {
		$self->aKz();
		unlink $rf;
 }
 1;
}
sub zBa{
 my ($self, $cG, $suf, $one) = @_;
 
 if($one) {
		my $msg= zDa->new('AbMsgList');
		my $paths = $self->zOa('');
		my $p = $paths->[0];
		$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
 	$self->{ratings2}->{$cG}= join("\t", $msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
		return 1;
		
 }
 1;
}

sub rXz{
 my ($iS) = @_;
 $iS->{aGz} = 1;
 $iS->{aIz} = 0;
 $iS->aQz();
}
sub aQz{
 my ($self) = @_;
 $self->oF(LOCK_SH, 4);
 open aOz, "<@{[$self->nDz('aLz')]}" or return;
 my @gHz = <aOz>;
 close aOz;
 $self->pG(4);
 my @aRz = split /\s+/, join ("", @gHz);
 for(@aRz) {
 next if not $_;
 $self->{aLz}->{$_} = 1;
 }
 1;
}
sub mLa{
}
sub iTa{
 my ($d, $dir)=@_;
 my ($k, $c) = split /\./, $d;
 my $ist =( $c and $c == unpack("%16C*", $k));
 my $suf = ($^O =~ /win/i)? '.A':'. -';
 if(not $ist) {
 my $f = kZz($dir, $suf);
 if(not open F, $f) {
 open F, ">$f";
 print F time();
 close F;
 chmod 0400, $f;
 }else {
 $d = <F>;
 close F; 
 chomp $d;
 return int(48+($d-time())/60/720+12);
 }
 }
 return 1;
}
sub xHz {
 my ($self) = @_;
 $self->oF(LOCK_SH, 7);
	my $uf = $self->nDz('update');
 my $linesref = $bYaA->new($uf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($uf)})->iQa({noerr=>1} );
	return if not $linesref;
 if(@$linesref) {
 	my $updf = $self->nDz('msglist')."_upd";
 $bYaA->new($updf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($updf) })->kEa($linesref);
 	unlink $self->nDz('update');
 }
 $self->pG(7);
}
sub vWz {
 my ($self, $entry) = @_;
	my $mf = $self->nDz('msglist');
 $bYaA->new($mf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($mf) })->jXa(
 [[@{$entry}{@lB::mfs}]]
 );
 	if($entry->{to}) {
		$self->dSaA($entry->{fI});
		$self->hKa($entry);
 	for my $to (split /\s*,\s*/, $entry->{to}) {
			$self->cOaA($entry->{fI}, $to, {modify_time=>time(), msg_subj=>$entry->{wW}});
		}
	}
}

sub dMaA {
 my($self, $cG) = @_;
	my $entry = $self->pO($cG);
	if($entry->{to}) {
		$self->dSaA($entry->{fI});
		$self->hKa($entry);
 	for my $to (split /\s*,\s*/, $entry->{to}) {
			$self->cOaA($entry->{fI}, $to, {modify_time=>time(), msg_subj=>$entry->{wW}});
		}
 }
}
sub xGz{
 my ($self) = @_;
 unlink $self->nDz('update');
 unlink $self->nDz('msglist')."_upd";
}
sub aVz{
 my ($self) = @_;
 $self->oF(LOCK_EX, 4);
 my $mf = $self->nDz('aLz'); 
 open aOz, ">$mf" or 
 abmain::error('sys', "On writing file $mf: $!");
 print aOz join("\t", keys %{$self->{aLz}});
 close aOz;
 $self->pG(4);
 1;
}
sub vHz{
 my ($self, $cG) = @_;
 $self->{aLz}->{$cG}=1;
 $self->oF(LOCK_EX, 4);
 my $mf = $self->nDz('aLz'); 
 open aOz, ">>$mf" or 
 abmain::error('sys', "On writing file $mf: $!");
 print aOz "\t", $cG;
 close aOz;
 $self->pG(4);
 1;
}
sub aKz{
 my ($self, $cG, $loc, $one) = @_;
	return $abmain::use_sql? $self->zFa($cG, $loc, $one):$self->zCa($cG, $loc, $one);

}

sub zCa{
 my ($self, $cG, $loc, $one) = @_;
	if(0&&$one) {
		my $hsh = ($cG%$jW::hash_cnt) || 0;
 	my @rata = split /\t/, $self->{ratings2}->{$cG};
		my $i;
		for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
		}
 	my $db = $bYaA->new($self->mZa($hsh, $loc), {schema=>"AbRatings"});
 if($rata[2]>1) {
 		$db->jXa([[$cG, @rata]]);
 }else {
 		$db->kEa([[$cG, @rata]]);
 }
		return;
 }

 my %rat_hash;
 for (keys %{$self->{ratings2}}) {
 next if not $_;
 my $hash_code=  ($_%$jW::hash_cnt) || 0;
 my @rata = split /\t/, $self->{ratings2}->{$_}||"";
 my $oloc = $rata[4];
	   my $i;
	   for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
	   }
 push @{$rat_hash{$hash_code}}, [$_, @rata] if $loc eq $oloc;
 }

 my @nums;
	if(defined $cG) {
		push @nums, ($cG%$jW::hash_cnt) || 0;
	}else {
		@nums = keys %rat_hash;
 }
 for(@nums) {
 	$bYaA->new($self->mZa($_, $loc), {schema=>"AbRatings"})->iRa($rat_hash{$_});
	}
}
 
sub zFa{
 my ($self, $cG, $loc, $one) = @_;
	if($one) {
 	my @rata = split /\t/, $self->{ratings2}->{$cG};
		my $i;
		for($i=0; $i<6; $i++) {
			$rata[$i]= undef if not defined($rata[$i]);
		}
		my $msg= zDa->new('AbMsgList');
		my $paths = $self->zOa('');
		my $p = $paths->[0];
		$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
		return 1;
 }
	return 1;
}

sub zK{
 my ($self, $cG, $aCz, $wt, $arch) = @_;
	return $abmain::use_sql? $self->zJa($cG, $aCz, $wt, $arch) : $self->zEa($cG, $aCz, $wt, $arch);
}
sub zEa {
 my ($self, $cG, $aCz, $wt) = @_;
 $wt = 1 if not $wt;
	$self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
	   abmain::error('iT', "Please send Cookies to $self->{name}");
	} 
 	$self->gCz() if $self->{rRz};
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? undef: "a";
 $self->aFz($cG, $cloc);
 $self->aFz($cG) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $fpos, $loc, $readers) =  split "\t", $self->{ratings2}->{$cG};
 $aUz = ($aUz*$cnt + $aCz*$wt)/($cnt+$wt); 
 $cnt += $wt;
 $self->{ratings2}->{$cG}=join("\t", $aUz, $cnt, $ovis, $fpos, $loc, $readers);
 $self->aKz($cG, $loc);
 $self->pG(9);
 	$self->rSz();
}
sub zJa {
 my ($self, $cG, $aCz, $wt, $arch) = @_;
	require zGa;
 $wt = 1 if not $wt;
 $self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
	   abmain::error('iT', "Please send Cookies to $self->{name}");
	} 
 	$self->gCz() if $self->{rRz};

	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
 my ($aUz, $cnt) = ($msg->{rate}, $msg->{cnt});
 $aUz = ($aUz*$cnt + $aCz*$wt)/($cnt+$wt); 
 $cnt += $wt;
	$msg->{rate}=$aUz;
	$msg->{cnt}=$cnt;
	if($msg->{realm}) {
		$msg->rRa(["rate", "cnt"],"where realm =? and msg_no=?", [$p, $cG]);
 		$self->rSz();
	}
}

sub gSa {
 my ($self, $cG, $fpos, $val) = @_;;
	return $abmain::use_sql? $self->dTaA($cG, $fpos, $val) : $self->dIaA($cG, $fpos, $val);
}

sub dIaA{
 my ($self, $cG, $fpos, $val) = @_;

	$self->gOaA();
	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
#	   abmain::error('iT', "Please send Cookies to $title");
	} 
#       	$self->gCz() if $self->{rRz};
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? "": "a";
 $self->aFz($cG, $cloc, 1);
 $self->aFz($cG, undef, 1) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $ofval, $oloc, $rds) = split /\t/, $self->{ratings2}->{$cG};
	my $nfval = $ofval;
	my $f = 1<<($fpos -1);
 if($val) {
 $nfval |= $f;
 }else {
		$nfval &= ~$f;
 }
		
	if ($ofval == $nfval) {
 	$self->pG(9);
		return;
	}
 $self->{ratings2}->{$cG}= join("\t", $aUz, $cnt, $ovis, $nfval, $oloc, $rds);
 $self->aKz($cG, $oloc, 1);
 $self->pG(9);
 	$self->rSz();
}
sub dTaA{
 my ($self, $cG, $fpos, $val) = @_;

 $self->gOaA();

	if(!$abmain::fPz{zN} && !$abmain::fPz{$self->{vcook}}){
#	   abmain::error('iT', "Please send Cookies to $title");
	} 
#      $self->gCz() if $self->{rRz};

	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);

	my $nfval = $msg->{fpos};
	my $ofval = $msg->{fpos};
	my $f = 1<<($fpos -1);
 if($val) {
 $nfval |= $f;
 }else {
		$nfval &= ~$f;
 }
		
	if ($ofval == $nfval) {
		return;
	}
	$msg->{fpos}= $nfval;
	$msg->rRa(["fpos"],"where realm =? and msg_no=?", [$p, $cG]);
 	$self->rSz();
}

sub dSaA{
 my ($self, $cG) = @_;
	return $abmain::use_sql ? $self->ePaA($cG) : $self->dWaA($cG);
}

sub dWaA{
 my ($self, $cG) = @_;
 $self->oF(LOCK_EX, 9);
 my $df = $self->gN($cG);
 my $cloc = (-f $df) ? "": "a";
 $self->aFz($cG, $cloc, 1);
 $self->aFz($cG, undef, 1) if $cloc && not $self->{ratings2}->{$cG};
 my ($aUz, $cnt, $ovis, $ofval, $oloc, $rds) = split /\t/, $self->{ratings2}->{$cG};
 $self->{ratings2}->{$cG}= join("\t", $aUz, $cnt, $ovis, $ofval, $oloc, undef);
 $self->aKz($cG, $oloc, 1);
 $self->pG(9);
}
sub ePaA{
 my ($self, $cG) = @_;
	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
	$msg->{readers}="";
	$msg->rRa(["readers"],"where realm =? and msg_no=?", [$p, $cG]);
}

sub dXaA{
 my ($self, $cG, $vcnt, $readers) = @_;
	my $msg= zDa->new('AbMsgList');
	my $paths = $self->zOa('');
	my $p = $paths->[0];
	$msg->aPaA("where realm =? and msg_no=?", [$p, $cG]);
	$msg->{readers}= $readers;
	$msg->{viscnt}=$vcnt;
	$msg->rRa(["readers", "viscnt"],"where realm =? and msg_no=?", [$p, $cG]);
}
sub vMz{
 my ($self) = @_;
 return abmain::vKz($self->nDz('qUz'), 'pol');
}
sub wKz{
 my ($self) = @_;
 my @ids = $self->vMz();
 return abmain::zSz('qQz', \@ids);

}
sub rQz { 
 my ($self) = @_;
 my $pd = $self->nDz('qUz'); 
 opendir DIRF, $pd; 
 my @files = grep /\.pol$/, readdir DIRF; 
 closedir DIRF;
 my $pollstr= qq(<table align="center" border="0" width="90%" bgcolor="$abmain::msg_bg" class="PollsTable"><tr bgcolor="$self->{cfg_head_bg}"><td align="center"><h2><font $self->{cfg_head_font}>Poll</font></h2></td><td align="center"><h2><font $self->{cfg_head_font}>Result</font></h2></td></tr>\n);
 my $pollcnt=0;
 for (@files ) {
 my $f = abmain::kZz($pd, $_);
 	 my $iS = new jW(eD=>$self->{eD}, cgi=>$self->{cgi}, cgi_full=>$self->{cgi_full}, pL=>$self->{pL}); 
 	 $iS->cJ($f, \@abmain::qSz) if -r $f;
 	 next if not $iS->{polllisted};
 	 my $votestr = $iS->qXz($iS->{qQz});  
 	 my $resstr = $iS->rMz($iS->{qQz});  
 	 $pollstr .= qq(<tr><td width="50%" valign=top>$votestr</td><td width="50%" valign=top>$resstr</td></tr>\n);
 $pollcnt++;
 }
 $pollstr .= qq(<tr><td align="center" colspan=2>No listed polls</td></tr>\n) if $pollcnt == 0;
 $pollstr .= qq(</table>\n);
 return $pollstr;
}
sub vOz {
 my ($self) = @_;
 my $pf =abmain::kZz($self->nDz('qUz'), $self->{pollidxfile}||"index.html");
 $self->rPz() if (-z $pf || not -f $pf);
 my $purl =$self->lMa(abmain::kZz("polls", $self->{pollidxfile}||"index.html"));
 sVa::hCaA "Location: $purl\n\n";
}
sub rPz {
 my ($self) = @_;
 $self->oF(LOCK_EX, 6);
 my $srf = abmain::kZz($self->nDz('qUz'), $self->{pollidxfile}||"index.html");
 open F2, ">$srf" or abmain::error('sys', "On writing file $srf: $!");
 $self->eMaA( [qw(other_header other_footer)]);
 print F2 "<html><head>$self->{sAz}\n<title> Polls for $self->{name}</title>$self->{other_header}";
 my $all= eval { $self->rQz() };
 print F2 $all;
 print F2 $self->{other_footer};
 close F2;
 $self->pG(6);
 $self->oF(LOCK_EX, 6);
 open F2, ">".abmain::kZz($self->nDz('qUz'), "index.js");
 print F2 abmain::rLz($all);
 close F2;
 $self->pG(6);
}
sub rGz {
 my ($self, $qQz, $ans) = @_;
 my $pp = $self->qZz($qQz);

 $self->cJ($pp, \@abmain::qSz);
 abmain::error('deny', "Poll not activated!") if $self->{rBz};
 if ($self->{pollreqlog}){ 
 	$self->gCz();
 }
 if($self->{fVa}) {
		my @ans = split "\0", $ans;
		$ans = join(" ", @ans) if @ans;
 }
 $self->gOaA();

 my $domain;
 $domain=  abmain::lWz("",1) if $self->{qVz};
 abmain::error('deny') if $self->{rIz} && not $domain ;

 my $pd = $self->rJz($qQz);
 if($self->{qWz}) {
 	    my $jKa =  $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz) })->iQa({noerr=>1, where=>"raddr='$ENV{REMOTE_ADDR}' and poll_id='$qQz'"});
 for my $row(@$jKa) {
 my $pQ = $row->[2];
 abmain::error('inval', "Duplicated vote detected") if $pQ eq $ENV{REMOTE_ADDR};
 }
 }
 
 $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz)})->iSa(
 [$ans, time(), $ENV{REMOTE_ADDR}, $domain,  $self->{fTz}->{name}, $abmain::ab_track, $qQz]
 );
 if( (stat($self->qYz($qQz)))[9] < time() - 30 || $abmain::use_sql ) {
 	$self->rAz($qQz); 
 		$self->rPz();
 }
}
sub rAz {
 my ($self, $qQz) = @_;
 my $pp = $self->qZz($qQz);
 $self->cJ($pp, \@abmain::qSz);
 my $pd = $self->rJz($qQz);
 my $ps = $self->qYz($qQz);
 my %ans=();
 my $tot =0;
 my $jKa =  $bYaA->new($pd, {schema=>"AbVotes", paths=>$self->zOa($qQz) })->iQa({noerr=>1});
 for my $jRa (@$jKa) {
 next if $jRa->[0] eq '';
 my @myans = split " ", $jRa->[0];
 @myans = ($jRa->[0]) if not @myans;
 for(@myans) {	
 	$ans{$_}++;
 	$tot ++;
 }
 }
 open F, ">$ps" or abmain::error('sys', "On writing file $ps: $!");
 print F "total=$tot\n";
 for (keys %ans) {
 print F "$_=$ans{$_}\n";
 }
 close F;
 return $tot;
}
 

sub nGz { 
 my($self, $cG, $aK, $arch, $jK, $priv)=@_;
 my ($xm, $xt) = (unpack("h*", $cG), unpack("H*", $aK)); 
 $jK =0 if not $jK;
 my $lDa;
 $lDa=";domod=1" if $self->{_doing_moder};
 return "$self->{cgi}?@{[$abmain::cZa]}cmd=get;cG=$xm;zu=$xt;v=2;gV=$arch;p=$priv$lDa" if $jK >=0 ;
 return "$self->{cgi_full}?@{[$abmain::cZa]}cmd=get;cG=$xm;zu=$xt;v=2;gV=$arch;p=$priv$lDa";
}
sub tGz {
 my ($self, $nousrchk) = @_;

	$self->gOaA();
 if($self->{lDz}) {
 $self->{bXz}->{rhost}= $self->{_cur_user_domain};
 }
	return if $nousrchk;
 my $title = $self->{name};
	&abmain::dE($abmain::master_cfg_dir);
	&abmain::dE($self->{eD});
	$self->gCz($abmain::gJ{fM});
 abmain::error('deny', "Access restricted.") if $self->{fTz}->{type} eq 'A' || $self->{fTz}->{type} eq 'B';
}
sub mMa{
 my ($self, $where, $maxintv) = @_;
 my ($ul, $ths)= $self->fTa($where, undef, 300);
 return if not @$ul;
 return abmain::qAa(ncol=>4, tba=>qq(cellpadding="3" cellspacing="1" bgcolor="$self->{cbgcolor0}"), 
	tha=>qq(bgcolor="$self->{bgmsgbar}"), th=>$self->{online_users_lab}, usebd=>1, 
 vals=>[map {abmain::cUz(
 "$self->{cgi}?@{[$abmain::cZa]}cmd=form;kQz=".abmain::wS($_->[0]), "<b>$_->[0]</b>").": <small>".$_->[1]."</small>"} @$ul ] );
}
sub fTa{
 my ($self, $where, $uf, $maxintv) = @_;
 my $chatuf = $uf || $self->nDz('onlineusr');
 $maxintv=900 if not $maxintv;
 my $t = time();
 my $to = $t -$maxintv;
 my @ulist=();
 my %namtrack=();
 my $linesref = $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iQa({noerr=>1} );
 my $l;
 while($l = pop @$linesref) {
		my ($n, $in, $t0, $addr, $loc, $fn, $track) = @$l;
		next if $t0 < $to;
		next if not $in;
 next if $where && $in ne $where;
		$self->fZz(lc($n)) if  (not $uf) && (not exists $self->{gFz}->{lc($n)});
		next if $where ne "Chat" and $self->{gFz}->{lc($n)}->[10];
 push @ulist,  [$n, $in, sprintf("%.2fmin", ($t-$t0)/60), $addr, abmain::cUz($loc, $fn||$loc), $track];
 }
 my @ths=("User", "Action", "Time", "IP", "Location", "Track");
 return (\@ulist, [jW::mJa($self->{cfg_head_font}, @ths)]);
}
sub fSa{
 my ($self, $name, $where, $uf) = @_;
 my $chatuf = $uf || $self->nDz('onlineusr');
 my $maxintv=900;
 my $t = time();
 my $to = $t -$maxintv;
 $self->oF(LOCK_EX, 14);
 my $linesref = $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iQa({noerr=>1} );
 my @linesx=();
 my @ulist=();
 for(@$linesref) {
		my ($n, $in, $t0, $addr, $loc, $xO, $track) = @$_;
		next if $t0 < $to;
		next if not $in;
 next if lc($n) eq lc($name) && $in eq $where && $loc eq $self->fC();
		push @linesx, $_;
 }
 push @linesx, [$name, $where, $t,  $ENV{REMOTE_ADDR}, $self->fC(), $self->{name}, $abmain::ab_track];
 $bYaA->new($chatuf, {schema=>"AbOnlineU", paths=>$self->dHaA($chatuf) })->iRa(\@linesx);

 $self->pG(14);
 if($self->{publish_ulist} && $chatuf ne abmain::wTz('onlineusr')) {
		$self->fSa($name, $where, abmain::wTz('onlineusr'));
 } 
} 
sub sEz {
 my ($self, $name, $msg, $sysm, $mood) = @_;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 $msg =~ s/>/&gt;/g;
 $msg =~ s/</&lt;/g;
 $msg =~ s/\t/ /g;
 $msg =~ s/\n/ /g;  
 $self->mXa($msg, $name);
 $sysm = 0 if not $sysm;
 $self->oF(LOCK_EX, 10);
 if($name) {
 $bYaA->new($chatdf, {schema=>"AbChatMsg", paths=>$self->zOa('chat') })->iSa([$name, $msg, time(), $sysm, $mood]);
	if($bYaA ne 'jEa') {
 	jEa->new($chatdf, {schema=>"AbChatMsg"})->iSa([$name, $msg, time(), $sysm, $mood]);
	}
 }
 $self->sSz();
 $self->pG(10);
} 

sub zOa {
	my ($self, $type, $stype) = @_;
	return [$self->{_fvp}, join('-', $type, $stype)];
}

sub dHaA{
	my ($self, $fpath ) = @_;
	my ($p, $s) = sVa::zHa($fpath, $self->{_fvp}, $self->{_top_dir});
	return [$p, $s];
}
sub nGa {
 my $self = shift;
 my ($hIz, $hJz, $pat) = @_;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 my $linesref = $bYaA->new("$chatdf.txt", {schema=>"AbChatMsg", paths=>$self->zOa('chat') })->iQa({noerr=>1} );
sVa::gYaA "Content-type: text/html\n\n";
 print  qq! 
<html><head>
$self->{sAz}
</head>
<body bgcolor="$self->{tEz}">\n
$self->{yOz}
<DIV class="CHATAREA">
$self->{yPz}
!;

 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 my ($nf, $mf) = ($self->{sVz}, $self->{sOz});
 my ($d, $h, $m, $s);
 my $td;
 my @gAa;
 my @lsref = sort {$a->[2] <=> $b->[2]} @$linesref;
 for(@lsref) {
 my ($n, $msg, $t, $sys, $mood) = @$_;
 next if $t > $eti && not $sys;
 next if $t < $sti;
	    next if $pat && not $msg." ".$n =~ /$pat/i;
 my $tstr="";
 if($sys == 1) {
 $tstr = abmain::dU('LONG', $t, 'oP'),
 }
 &jEz(\$msg, "target=iIa");
	    $self->fZa(\$msg, 1);
 push @gAa,  qq(<span class="ChatUserName"><font $nf><b>$n</b></font></span>$self->{sHz}<span class="ChatMessageLine">title="$tstr"><font $mf>$msg</font></span><br/>\n); 
 }
 print join($self->{yMz}, @gAa);
 print  $self->{yQz};
 print  "\n</DIV>\n";
 print  $self->{yNz};
 print  qq(</body></html>\n);
} 
sub sSz {
 my $self = shift;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 my $chathf = abmain::kZz($self->nDz('chat'), "index.html");
 $self->{tDz} = $abmain::min_chat_refresh if($self->{tDz} < $abmain::min_chat_refresh);
 my $t2 = $self->{tDz} +5;
 my $sPz = $self->sPz();
 my ($initloc, $scroll) = ("#eof", 99999);
 if($self->{hLa}) {
		$initloc="#bof";
 $scroll=0;
 }
 open F, "<$chatdf";
 my @gHz = <F>;
 close F;
 open F, ">$chathf";
 print F qq! 
<html><head>
<META HTTP-EQUIV="Expires" CONTENT="0"> <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="refresh" CONTENT="$t2; URL=$sPz">
<script>
function xbeep(){ /*java.awt.Toolkit.getDeafultToolkit.beep();*/}
function dx() {
min_refresh_intv = $self->{tDz};
refresh_intv = min_refresh_intv;
if(parent.sYz.refresh_time >= min_refresh_intv)
refresh_intv = parent.sYz.refresh_time;
location = "$initloc";
window.scroll(0, $scroll);
setTimeout("location.reload()", refresh_intv*1000);
xbeep();
}
</script>
$self->{sAz}
</head>
<body bgcolor="$self->{tEz}" onload="dx()">\n
<a name="bof"></a>
$self->{yOz}
<DIV class="CHATAREA">
$self->{yPz}
!;

 my $dcnt = $self->{tCz};
 $dcnt = 30 if $dcnt <=0;
 my $nM = @gHz;
 my $sidx = $nM-$dcnt;
 $sidx = 0 if $sidx <0;
 my ($nf, $mf) = ($self->{sVz}, $self->{sOz});
 my ($daysec, $hrsec, $msec) = (60*60 *24, 60*60, 60);
 my ($d, $h, $m, $s);
 my $ct = time();
 my $td;
 my @gAa;
 my $i;
 for($i=$sidx; $i< $nM; $i++) {
	    my $line = $gHz[$i];
 chomp($line);
 my ($n, $msg, $t, $sys, $mood) = split /\t/, $line;
 $td = $ct - $t;
 next if $td > $self->{chat_max_age} && not $sys;
 next if $td > 4 * $self->{chat_max_age};
 my $tstr="";
 if($sys == 1) {
 $m = sprintf("%.2f", $td/60);
 $tstr = " [<small><i>$m minutes ago</i></small>]";
 }
 &jEz(\$msg, "target=iIa");
	    $self->fZa(\$msg, 1);
 my $md="";
 $md = $self->{$mood}." " if $mood;
 push @gAa, qq(<span class="ChatUserName"><font $nf><b>$n</b></font></span>$self->{sHz}$md<span class="ChatMessageLine" title="$tstr"><font $mf>$msg</font></span><br/>\n); 
 }
 if($self->{hLa}) {
		print F join($self->{yMz}, reverse @gAa);
 }else {
		print F join($self->{yMz}, @gAa);
 }
 print F $self->{yQz};
 print F "\n</DIV>\n";
 print F $self->{yNz};
 print F qq(\n<a name="eof"></a></body></html>\n);
 close F;
 if($nM > 2 * $dcnt) {
 open F, ">$chatdf";
 print F @gHz[$sidx..$nM];
 close F;
 open F, ">>$chatdf.txt";
 $sidx--;
 print F @gHz[0..$sidx];
 close F;
 }
} 
sub sLz{
 my $self=shift;
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html>
<head><title>$self->{name} chat room</title></head>
<frameset rows="*, $self->{sFz}">
 <frameset cols="*, $self->{chat_usr_width}">
	<frame name="sXz" src="@{[$self->sPz()]}">
 <frame name="chat_usr" src="$self->{cgi}?@{[$abmain::cZa]}cmd=bRa;from=Chat;where=Chat;refresh=60">
 </frameset>
<frame name="sYz" src="$self->{cgi}?@{[$abmain::cZa]}cmd=sQz"></frameset></html>
 ); 
} 
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

 

sub gXa{
 my ($self, $gJz) = @_;
	my $mf = new aLa('mem', \@abmain::member_profile_cfgs);
	return $mf if $gJz eq "";
	$mf->aCa(['avatar', 'radio', $self->{avatar_trans}, "Avatar"]);
	$mf->zOz();
 my $pf = $self->bJa($gJz);
 my ($p, $s) = @{$self->dHaA($pf)};
 if(not $abmain::use_sql) {
		$mf->load($pf);
	}else {
		my $dbo= zDa->new('AbUserProfile');
		$dbo->aPaA("where userid=? and realm=? and srealm=?", [lc($gJz), $p, $s]);
		$mf->rWa($dbo);
 }
	return $mf;
}
sub zMa{
 my ($self, $mf, $gJz) = @_;
	$gJz = lc($gJz);
 my $pf = $self->bJa($gJz);
 my ($p, $s) = @{$self->dHaA($pf)};
 if(not $abmain::use_sql) {
		$mf->store($pf);
	}else {
		require zDa;
		my $dbo= zDa->new('AbUserProfile');
		if($dbo->aPaA("where userid=? and realm=? and srealm=?", [$gJz, $p, $s])) {
			$dbo->bCaA($mf, "where userid=? and realm=? and srealm=?", [$gJz, $p, $s]);
		}else {
			$dbo->aTaA($mf);
			$dbo->{realm}= $p;
			$dbo->{srealm}= $s;
			$dbo->{userid}=$gJz;
			$dbo->tEa();
		}
		
 }
	return $mf;
}

sub nVa{
	my ($str) = @_;
	my @uids = split /\n+|\|/, $str;
	my %ighash=();
	for(@uids) {
		abmain::jJz(\$_);
		next if not $_;
		$ighash{lc($_)} = 1;
	}
	return %ighash;
}
sub mWa {
	my ($self, $usr1, $usr2) = @_;
	abmain::jJz(\$usr1);
	abmain::jJz(\$usr2);
	return 0 if not ($usr1 && $usr2);
	my $mf1= $self->gXa($usr1);
	my $mf2= $self->gXa($usr2);
	my %ig1 = jW::nVa($mf1->{ignores});
	my %ig2 = jW::nVa($mf2->{ignores});
	return 1 if $ig1{$usr2};
	return 2 if $ig2{$usr1};
	return 0;
}

sub gWaA{
 my ($sref) = @_;
 $$sref =~ s/>/&gt;/g;
 $$sref =~ s/</&lt;/g;
}

sub get_rss_xml {
	my ($self, $input) = @_;
	$self->cR();
	my $rssfile = $self->nDz('rss');
	my $sday = $input->{sday};
	my $eday = $input->{eday};
	my $fN = $input->{fN};
	my $rssfile2 = "$rssfile-$sday-$eday.xml";
	my $mtime = (stat($rssfile2))[9];
	my $rgen= (time() - $mtime) > 120;
	my $iN = $sday > 0? time() - 3600*24*$sday: 0;
	my $etime =  time() - 3600*24*$eday;
	local *F;
	if($rgen) {
 	my $lck = jPa->new($rssfile, jPa::LOCK_EX());
		my $str = $self->gen_rss_xml({iN=>$iN, etime=>$etime, fN=>$fN});
		open F, ">$rssfile2" or abmain::error('sys', "$rssfile2:$!");
		print F $str;
		close F;
	}
	open F, "<$rssfile2";
	print "Content-type: text/xml\n\n";
	print <F>;
	close F;
}

sub gen_rss_xml {
	my ($self, $input, $cnt, $objs) = @_;
	my ($iN, $etime, $fN) =  @{$input}{qw(iN etime fN)};
	my $furl = $self->fC();
	my $xO = $self->{name};
	my $desc = $self->{forum_desc};
 gWaA(\$desc);
 gWaA(\$xO);

	my $enc="";
	if($self->{txt_encoding} =~ /\w/) {
		$enc = qq( encoding="$self->{txt_encoding}");
	}
	my $start =qq(<?xml version="1.0"$enc ?>\n<rss version="0.91">\n);
	my $chan = qq(<channel>\n<title>$self->{name}</title>\n<link>$furl</link>\n<description>$desc</description></channel>\n);
	if($cnt <=0) {
 	($cnt, $objs) = $self->nYa(undef, 0, 0, 0, $iN, $etime, 1, undef);
	}
	my $idx = 0;
	$fN = 15;
	if($fN >0 && $cnt >$fN) {
		$idx = $cnt - $fN;
	}
	my $i=$idx;
	my @itemstrs;
	for(;$i<$cnt; $i++) {
		my $obj = $objs->[$i];
		next if length($obj->{body}) < 256;
		my $tit = $obj->{wW};
		my $url = $obj->nH($self, -1);
		$url =~ s/&/&amp;/g;
 	my $text= $obj->{body};
		$text =~ s/&nbsp;/ /gi;
		$text =~ s!<br/>|<p>!\n!gi;
 	$text =~ s/<[^>]*>//gs;   
		my $abs = substr $text, 0, 200;

 gWaA(\$tit);
 gWaA(\$abs);

		push @itemstrs, 
			qq(<item>\n<title>$tit</title>\n<link>$url</link>\n<description>$abs</description>\n</item>\n);
	}
	return join("", $start, $chan, @itemstrs, "</rss>");

}

sub mYa{
	my ($self, $kQz) = @_;
 	return if not $kQz;
 	my $f = $self->bJa($kQz, 'msg');
 return if not -f $f;
	my $ent = lB->new();
 $ent->load($self, 0, $f);
 return if $ent->{hC} eq $ent->{to};
	return "$self->{qLa} from <b>$ent->{hC}</b>:<br/><b>$ent->{wW}</b> <br/>".abmain::dU('STD', $ent->{mM}, 'oP'). "<br/>Click to view: "
 .abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "$self->{kRz}");

}
sub nTa{
	my ($self, $notime) = @_;
 	my $f = $self->nDz('lastmsg');
 return if not -f $f;
	my $ent = lB->new();
 $ent->load($self, 0, $f);
 return if $ent->{body} eq "";
 my $text= $ent->{body};
	$text =~ s/&nbsp;/ /gi;
	$text =~ s!<br/>|<p>!\n!gi;
 $text =~ s/<[^>]*>//gs;   
 $text =~ s/<//gs;   
	my $abs = substr $text, 0, 200;
 	if($self->{auto_href_abs}) {
 		&jW::jEz(\$abs, $self->{xZz});
 }
 my $wW = $ent->{wW};
 $self->fZa(\$wW); 
	if($notime) {
		return "<b>$wW</b>-- $ent->{hC}<br/>"
 .$abs; 
	}else {
		return "<b>$wW</b> -- $ent->{hC} (".abmain::dU('STD', $ent->{mM}, 'oP'). ")<br/>"
 .$abs; 

	}

}

sub eKaA {
 my ($self, $kQ) = @_; 
 my $f = $self->bJa($kQ, 'mbox');
 my $jKa = $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 })->iQa({noerr=>1, where=>"rcptuid='$kQ'"});
 my @rows;
 return  if not ($jKa || scalar(@$jKa));
 my $cbox;
 for my $jRa (@$jKa) {
 	my ($cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime) = @$jRa;
	my $cbox =qq(<input type=checkbox name="pmurl" value="$url">);
 my $mt  = $modtime||$postime;
 my $pd  = $self->fGz(abmain::dU('STD', $mt, 'oP'), 'date_font_msg');
 my $readstat = $readtime > $mt? "READ": "Not read";
 my $repstat = $replytime > $mt? "Replied": "Not replied";
	my $lnk = abmain::cUz($url, $wW);
	push @rows, [$cbox, $lnk, $senderuid, $pd, $readstat, $repstat, $readtime, $mt];
 }
 my @rows2 = sort { $b->[7] <=> $a->[7]} @rows;
 push @rows2, [qq(<input type="submit" class="buttonstyle" value="Delete checked entries">)];
 my $colsel = [0, 1, 2, 3,4, 5 ];
 my @ths = ("", "Subject", "Sender", "Time", "Read status", "Reply status");
 my $tT = "";
 if(scalar(@rows)) {
 	$tT = sVa::fMa(rows=>\@rows2, ths=>[jW::mJa($self->{cfg_head_font}, @ths)], $self->oVa(), colsel=>$colsel); 
 }
 return qq( <form action="$self->{cgi}" method=POST>
 		@{[$abmain::cYa]}
 		<input type="hidden" name="cmd" value="delpmentry">
		$tT
		</form>);
 
}
sub dYaA {
 my ($self, $kQ, $url) = @_; 
 my $f = $self->bJa($kQ, 'mbox');
 $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5})
		->jLa([$url]);
}

sub cOaA {
	my ($self, $cLaA, $to, $infohash) = @_;
 	my $f = $self->bJa($to, 'mbox');
	my $db = $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 });
	my $filter = sub { $_[0]->[0] == $cLaA && lc($_[0]->[1]) eq lc($to); };
	my $jKa = $db->iQa({noerr=>1, filter=>$filter, where=>qq(msg_no=$cLaA and rcptuid='$to') });
 	return  if not ($jKa && scalar(@$jKa));
 my $jRa = $jKa->[0];
	if(exists ($infohash->{read_time})) {
		$jRa->[9] = $infohash->{read_time};
 }
	if(exists ($infohash->{reply_time})) {
		$jRa->[10] = $infohash->{reply_time};
 }
	if(exists ($infohash->{modify_time})) {
		$jRa->[11] = $infohash->{modify_time};
 }
	if(exists ($infohash->{msg_subj})) {
		$jRa->[4] = $infohash->{msg_subj};
 }
	$db->jXa([$jRa]);
}

sub cMaA{
	my ($self, $vH, $to) = @_;
 my ($cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime);
	$senderuid = $vH->{hC};
	$senderdomain = $self->{eD};
	$cLaA = $vH->{fI};
	$wW = $vH->{wW};
	$url = $vH->nH($self, -1);
	$cat = $vH->{scat};
	$status = "new";
	$postime = $vH->{mM};
	$readtime = 0;
	$replytime = 0;
	$modtime = $vH->{mtime};
 for my $to1 (split /\s*,\s*/, $to) {
		next if $to1 !~ /\S/;
		$rcptuid = $to1;
 		my $f = $self->bJa($to1, 'mbox');
		$bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5 }) ->iSa([$cLaA, $rcptuid, $senderuid, $senderdomain, $wW, $url, $cat, $status, $postime, $readtime, $replytime, $modtime]);
 }
}

sub hKa {
 my ($self, $vH) = @_;
 return if not $vH->{to};
 for my $to (split /\s*,\s*/, $vH->{to}) {
 	my $f = $self->bJa($to, 'msg');
 	$vH->store($self, $f);
 }
}
sub oGa {
 my ($self, $vH) = @_;
 return if $vH->{to} || not $vH->{aK} == $vH->{fI};
 my $f = $self->nDz('lastmsg');
 $vH->store($self, $f);
}
sub gNa {
 my ($self, $kQz) = @_;
 return if not $kQz;
 my $f = $self->bJa($kQz, 'msg');
 unlink $f;
}
sub iVa{
	my ($self, $f) = @_;
 	$self->oF(LOCK_SH,99);
 my $cnt =0; 
	my $buf;
 local *F;
	open F, "<$f";
 while(sysread F, $buf, 4096*4) { $cnt += ($buf =~ tr/\n//);}
 close F;
 	$self->pG(99);
	return $cnt;
}
sub uW {
 my $self = shift;
 $self->cR();
	$self->fetch_usr_attrib();
#x1
	$self->{yLz} = 'POST';

 $self->gOaA();
 if($self->{lDz}) {
 $self->{bXz}->{rhost}= $self->{_cur_user_domain};
 }

 my $title = $self->{name};
	my $aI ;
	&abmain::dE($abmain::master_cfg_dir);
	&abmain::dE($self->{eD});
	if($self->{force_cookie} && !$abmain::fPz{$abmain::cH} && !$abmain::gJ{fM}){
	   abmain::error('iT', "Please send Cookies to $title");
	   return;
	} 
	my $g_ok=0;
	if($abmain::gJ{gpassword} ne '' && $abmain::gJ{gpassword} eq $abmain::g_post_pw) {
		$g_ok = 1;
	}
	$self->gCz($abmain::gJ{fM}) unless $g_ok;

	$self->yA(\%abmain::gJ);
#x1

 my $name = $self->{bXz}->{name};

	my $ustat = $self->{gFz}->{lc($name)}->[4];
 abmain::error('inval', "User is not activated") if($ustat ne '' && $ustat ne 'A');

	if($self->{fWz}) {
	     $name = $self->{fTz}->{name};
	} elsif(not $g_ok) {
	  if($self->{gBz} || $self->{gAz}) {
	     $self->fZz($name);
	     my $auth_stat = $self->auth_user($name, $abmain::gJ{passwd});
 abmain::error('inval', "User is not activated")
	             if($auth_stat eq 'AUTHOK' && $self->{gFz}->{lc($name)}->[4] ne 'A');

	     if($self->{gAz} &&  $auth_stat eq 'NOUSER') {
 if($self->{gBz}) {
 my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV", $self->{sK});
	             abmain::error('dM', "You must register with a name and password: $tP")
 }else {
	             abmain::error('dM', "User not found!")
 }
	     }
 	     $iG = abmain::lKz($abmain::gJ{passwd}, 'ne') if $abmain::gJ{passwd};
	     $iG = $abmain::fPz{iG} unless $iG;
	     if($auth_stat ne 'NOUSER') {
 my $req;
 $req = "<br/>". abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=reqpassform", "Request lost password") 
 if($self->{mWz});
	          abmain::error('dM', "Correct password required for registered user <b>$name</b>. $req")
 if $auth_stat eq 'AUTHFAIL';
 $self->oXa($name);
	     }elsif($abmain::gJ{passwd}){
 $iG = "";
	     }
 }
	}
	abmain::error('dM', "Poster must be authenticated by http server")
 if($self->{force_http_auth} && not $ENV{REMOTE_USER});

	abmain::error('dM', "User does not have posting privilege")
 if($self->{gAz} && $self->{fTz}->{type} eq 'A');

#x1

 my $to = $self->{bXz}->{to};
 my $od = $self->{dyna_forum};
 my $to_cnt=0;
 if($to) {
 my @tos;
	     my %tos_hash;
 for my $to1 ( split /\s*,\s*/, $to) {
		next if $to1 eq "";
 	if($self->{tHz}) {
	     		$self->fZz($to1);
 		abmain::error('inval', "$to1 is not a registered user.") if not $self->{fYz}->{lc($to1)};
 	}
		$tos_hash{$to1} =1;
		$to_cnt ++;
	     }
 }
 abmain::error('inval', "The maximum number of private recipients is $self->{priv_recip_max}") if $to_cnt > $self->{priv_recip_max};
 $self->{dyna_forum} = 1 if $to;

 my $wD = $abmain::gJ{oauthor} || $to;
 my $igflag = $self->mWa(lc($wD), lc($name));
 	if($igflag ==1 ) {
		abmain::error('inval', "You are being ignored by $wD");
 	}elsif($igflag == 2) {
		abmain::error('inval', "You are ignoring $wD");
 	}

 my $post_approved = 0; 
 if($self->{fTz}->{type} ne 'C' || not $self->{aWz}) {
 $post_approved = 1; 
 }
 if($self->{no_moder_priv} &&  $to) {
 $post_approved = 1; 
 }
 $self->fSa($name, "Post");

#x1
 
 if($post_approved ) {
 	$self->{aGz} = 1;
 }else {
 	$self->{aIz} = 1;
 	$self->{aGz} = 1;
 }
 $self->aQz() if $self->{aWz};
#x1

 my $iphex = abmain::bW($ENV{'REMOTE_ADDR'}); 

 my $t = time();

 my $lcname = lc($name);
 $self->gCa($abmain::gJ{zu}||-1, $lcname);
	my @rata = split /\t/, $self->{ratings2}->{$abmain::gJ{zu}}||"";
	abmain::error("inval", "Thread closed")
		 if $abmain::gJ{zu} > 0 && $rata[3] & 2;

#x1

	$self->iU($jW::max_mno);
 $pF = $abmain::gJ{fu} > 0 ? $abmain::gJ{fu}:0;
 $bR = $abmain::gJ{zu} > 0 ? $abmain::gJ{zu}:$gP;
 if($gP < $pF) {
 $bR = $gP;
 $pF = 0;
 }
 if($self->{gMz} && $pF ==0) {
 abmain::error('deny', "Only administrator can post new thread")
 unless ($name eq $self->{admin} || $self->{moders}->{$name});
 } 

 ($self->{fTz}->{mycnt}, $self->{fTz}->{mytime}) = $self->wUz($name) 
		if $self->{kWz};
	my $nM = @{$self->{pC}};
	my $cnt=0;
 my $subject = $self->{bXz}->{wW};
	my $iL;
	my ($ono, $otno, $i, $lstr);
 my $iHz = kKz($self->{iGz}||$abmain::license_key);
	for($i=$nM-1; $i>0 && $cnt <20; $i--, $cnt++) {
	      $iL = $self->{pC}->[$i];
	      if((not $iL->{to}) && $iL->{wW} eq $subject && $iL->{pQ} eq $iphex && not $self->{yR}){
	        ($ono, $otno) = ($iL->{fI}, $iL->{aK});
 $lstr = abmain::cUz($self->nGz($ono, $otno), "<b>$subject</b>");
	      	abmain::error('inval', "$lstr topic already exists.", "Go back and change the subject." );
	      }
 if($iL->{pQ} eq $iphex && time()<$iL->{mM}+$self->{yN}) {
 sleep(1);
 abmain::error('inval', "System unavailable, repost after $self->{yN} seconds");
 }
	}
 
 my $ct = time();
 my $iBz=24*3600;
 my $ct_1 = $ct - $iBz;
 my ($iEz, $iCz, $postcnt_tot) = (0,0,0);
 my $thr_cnt = 0;
 my $thr_tot =0;
 my @user_post_nos=();
 for($i=$nM-1; $i>0; $i--) {
	      $iL = $self->{pC}->[$i];
 if($iL->{mM} > $ct_1) {
 	if($thr_tot < 10 && $iL->{aK} == $iL->{fI}) {
	            $thr_tot ++; 
 $thr_cnt ++ if lc($iL->{hC}) eq $lcname;
 	}
 	next if lc($iL->{hC}) ne $lcname;
 	$iEz ++;
 	$iCz++ if $iL->{eZz};
 }
 if(lc($iL->{hC}) eq $lcname){
 	$postcnt_tot++;
		push @user_post_nos, join ("\t", $iL->{fI}, $iL->{aK});
	      }
 }
 abmain::error('inval', "Exceeded daily posting limit ($self->{iAz})") 
#x1
 abmain::error('inval', "Exceeded daily upload limit ($self->{iDz})") 
#x1
 if($thr_tot >= 10 && $self->{yKz} >0 && $lcname ne lc($self->{admin}) && $self->{bXz}->{to} eq "" ) {
 	abmain::error('inval', "Exceeded presence ratio ($self->{yKz})") if $thr_cnt/$thr_tot > $self->{yKz};
 }

 my $hOaA =0;
 if ($self->{hPaA} && $self->{hPaA} <= $postcnt_tot ) {
 if (not $self->{hQaA}) {
#x1
	     }else {
		$hOaA = $postcnt_tot +1 - $self->{hPaA};
 }
	}

 my $wL=99999999;
 if($nM>20) {
 $wL = $self->{pC}->[$nM-1]->{mM} - $self->{pC}->[$nM-20]->{mM};
 }
 if($nM>20 &&$wL >0 && $wL <  $self->{yU}) {
 $self->xI("20 posts arrived in $wL seconds!");
 }
 $jUz |= $oDz if($iG || $self->{fTz}->{reg}); ## user is registered or not
	$jUz |= $jW::FNOHTML if $self->{bXz}->{nohtml};
 if($self->{oXz} && ($self->{fTz}->{name} eq $self->{admin} || not $self->{nTz})) {
 $jUz |= $pKz if $self->{bXz}->{repredir};
 $jUz |= $oRz if $self->{bXz}->{repmailattach};
 }
 $self->{bXz}->{rhost} = abmain::lWz("",1) if $self->{record_rhost} && not $self->{bXz}->{rhost};

#x1

 my $status="ok";
 	if($abmain::gJ{attachfid} ne "") {
		$status ="tmp";
	}
	$self->mO($bR, $pF, $gP, $subject, 
 $name, time(), length($self->{bXz}->{body}), abmain::bW($ENV{'REMOTE_ADDR'}),
 $jUz, $self->{bXz}->{email}, $self->{bXz}->{eZz}, $self->{bXz}->{to}, 
 $self->{bXz}->{mood}, $self->{bXz}->{url}, $self->{bXz}->{rhost}, "", 
 $self->{bXz}->{scat}, $abmain::ab_track, $abmain::VERSION||8, undef,
 undef, $status, undef, 0,
		             undef, undef, undef, $self->{bXz}->{sort_key}, $self->{bXz}->{key_words}); 
	$aI = $self->{dA}->{$pF};
	$self->kA($post_approved);

#x1

 if($hOaA >0) {
	     my $len = scalar(@user_post_nos);
	     my @mnos = @user_post_nos[-$hOaA .. -1];
#x1
 }
 if($self->{purge_mark}>0 && $self->{dI}> $self->{purge_mark} && $gP%10==0 && not $hOaA ) {
#x1
 }
 if($post_approved && $self->{aWz}) {
 $self->vHz($gP);
 $self->{bXz}->{oked}=1;
 }
 $self->{dyna_forum} = $od;
 if($post_approved ) {
		$self->nU();
 }
#x1
 
	$self->eV($aI);
#x1
 print join("\n", "<!--", @abmain::ticks, "-->");
	$self->qXa() if (($gP%15)==0);
}

sub gDaA {
	my ($self) = @_;
	return if not $self->{bXz};
	my @rows;
	push @rows, ["Subject", $self->{bXz}->{wW}];
	push @rows, ["Message", $self->{bXz}->{body}];
 return sVa::fMa(rows=>\@rows, ths=>[jW::mJa($self->{cfg_head_font}, ("Post information"))], $self->oVa()); 
}
sub cCz {
 my ($self, $wW, $name, $body, $pt, $cat, $attachs) = @_;
 $self->cR() if not $self->{_noreload_cfg};
 my $title = $self->{name};
	my $gP = $self->iU();
	my $nM = @{$self->{pC}};
 my $iphex = abmain::bW($ENV{'REMOTE_ADDR'}); 
 my $bXz = $self->{bXz} = {};
 my $idx = int rand() * $nM;
 $bXz->{name} = $name;
 $bXz->{wW} = $wW;
 $bXz->{body}= $body;
 $bXz->{url}="http://netbula.com/anyboard";
 $bXz->{url_title}="AnyBoard";
 $bR =$gP;
 $pF = 0;
 if($nM >0) {
 $idx = -1 if rand() < 0.15;
 }
	$aI = $self->{pC}->[$idx] if $idx >=0 ;
 if($idx >=0 && $aI) {
 $pF = $aI->{fI} ;
 $bR=$aI->{aK};
 }
 for(@$attachs) {
 		my $fattach = $_;
		next if not $_->[0];
 		my $cA = $self->cPz($fattach->[0]);
 		open(kE, ">$cA" ) or next;
 		binmode kE;
 		print kE $fattach->[1];
 		close kE;
 }
 
 if($self->{aWz}) {
		$self->vHz($gP);
	}
 
	$self->hGa(aK=>$bR, jE=>$pF, fI=> $gP, wW=>$wW,hC=>$name, 
 mM=>$pt, size=>length($body), pQ=>abmain::bW($ENV{'REMOTE_ADDR'}), scat=>$cat, kRa=>$abmain::VERSION||8); 
	$self->kA(1,1);
 
}
sub auto_post {
 my ($self, $wW, $name, $body, $pt, $cat, $attachs) = @_;
 $self->cR();
 my $title = $self->{name};
	my $gP = $self->iU();
 my $iphex = abmain::bW($ENV{'REMOTE_ADDR'}); 
 my $bXz = $self->{bXz} = {};
 $bXz->{name} = $name;
 $bXz->{wW} = $wW;
 $bXz->{body}= $body;
 $bR =$gP;
 $pF = 0;
 for(@$attachs) {
 		my $fattach = $_;
		next if not $_->[0];
 		my $cA = $self->cPz($fattach->[0]);
 		open(kE, ">$cA" ) or next;
 		binmode kE;
 		print kE $fattach->[1];
 		close kE;
 }
 
 if($self->{aWz}) {
		$self->vHz($gP);
	}
 
	$self->hGa(aK=>$bR, jE=>$pF, fI=> $gP, wW=>$wW,hC=>$name, 
 mM=>$pt, size=>length($body), pQ=>abmain::bW($ENV{'REMOTE_ADDR'}), scat=>$cat, kRa=>$abmain::VERSION||8); 
	$self->kA(1,1);
 
}

sub yA {
 my ($self, $vf, $formod) = @_;

 $abmain::js = $vf->{'abc'};

 my ($name, $to);
 if ($vf->{'name'}) {
 $name = "$vf->{'name'}";
 my $err;
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }
 abmain::jJz(\$name);
 
 $self->{bXz}->{name}=$name;
 $self->{bXz}->{name} = $ENV{REMOTE_USER} if $self->{http_auth_only};

 my $n_re = $self->{forbid_names};
 if($n_re) {
 &abmain::error('inval', "The name you used is not allowed") if $name =~ /$n_re/i;
 }

 if(length($name) > $self->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($self->{sO})} characters");
 }

 $abmain::jH = $abmain::fPz{$abmain::dS};
 
 if($abmain::jH > $self->{sF} || $abmain::hI{$abmain::ab_id1} || $abmain::hI{$abmain::ab_track}|| $abmain::hI{$name}) {
 &abmain::error('nG', "$name has $abmain::jH violations") if($abmain::js ne 'hV');
 &abmain::error('deny');
 }
 }
 else {
 &abmain::error('miss', "Name is missing") if !$self->{fWz};
 }
 $to = $vf->{to} || $vf->{priv_reply};
 abmain::jJz(\$to);
 $self->{bXz}->{to}= $to;
 $self->{bXz}->{take_priv_only} = $vf->{take_priv_only};

 if ($vf->{'email'} =~ /.*\@.*\..*/) {
 my $email = $vf->{'email'};
 $self->{bXz}->{email}=$email;
 }

 if ($vf->{'subject'}) {
 my $subject = "$vf->{'subject'}";
 if(length($subject) > $self->{qJ}){
 &abmain::error('iK', "Subject must be less than ${\($self->{qJ})}");
 }
 $subject =~ s/\&/\&amp\;/g;
 $subject =~ s/"/\&quot\;/g;
 $subject =~ s/>/&gt;/g;
 $subject =~ s/</&lt;/g;
 $subject =~ s/\t/ /g;
 $subject =~ s/\n/ /g;
 $self->{bXz}->{wW}=$subject;
 }
 else {
 &abmain::error('miss', "Subject is missing");
 }

 $jUz = 0;

 $vf->{'url'} =~ s/^\s+//;
 $vf->{'url'} =~ s/\s+$//;
 if ($vf->{'url'}) {
 my $url = $vf->{'url'};
 if(length($url) > 4*$self->{qJ}){
 &abmain::error('iK', "URL must be less than ${\(4*$self->{qJ})}");
 }
 $url = "" unless $url =~ /.*tp:\/\/.*\..*/;
 $self->{bXz}->{url}=$url;
 $self->{bXz}->{url_title}=  $vf->{url_title} if $url;
 $jUz |= $FHASLNK if $url; 
 }

 $self->{bXz}->{sort_key} = $abmain::gJ{sort_key};
 $self->{bXz}->{key_words} = $abmain::gJ{key_words};
 $self->{bXz}->{upfiles}= \%abmain::mCa;
 if ($self->{auto_rename_file}) {
	for(values %abmain::mCa) {
	     my $fn = $_->[0];
 my $i=1;
 while(-f $self->cPz($_->[0])) {
		$_->[0] =   $i."_".$fn;
		$i++;
	     };
	}
 }

 my @upfile_names;
 for(values %abmain::mCa) {
 	 if ($_->[0]) {
 	    &abmain::error('inval', "Attempt to upload disallowed file type, must be of type $self->{upfile_ext}")
 	    if($self->{upfile_ext} &&  not $_->[0] =~ /\.$self->{upfile_ext}$/i); 
	     $_->[0] = "pv-".$_->[0] if $to;
 
 	    &abmain::error('inval', "Uploaded file must be smaller than $self->{upfile_max} KB")
 	    if ($self->{upfile_max} >0 && length($_->[1]) > $self->{upfile_max}*1024); 
	    push @upfile_names, $_->[0];
 
 	 }
 }

 &abmain::error('inval', "Attempt to upload too many files") if scalar(@upfile_names) > 1 + $self->{max_extra_uploads};

 $self->{bXz}->{eZz} = join(" ", @upfile_names);

 if ($vf->{'img'} =~ /.*tp:\/\/.*\..*/i ) {
 my $img = "$vf->{'img'}";
 $self->{bXz}->{img}= $img;
 }
 if ($self->{bXz}->{img} || $self->{bXz}->{eZz} =~ /\.(gif|jpg)( |$)/i) {
 $jUz |= $pTz;
 }
 if ($self->{bXz}->{take_priv_only} ) {
 $jUz |= $FTAKPRIVO;
 }
 if($vf->{used_fancy_html}) {
 $jUz |= $FFANCY;
 }
 
 
 if($vf->{dUz}) {
 $jUz |= $pEz;
 }
 if($vf->{allow_no_reply}) {
 $jUz |= $pYz;
 }
 
 if($vf->{fM}=~/[a-z]/i){
 $self->{nT} = $vf->{fM};
 }
 $self->{bXz}->{repredir} = $vf->{repredir};
 $self->{bXz}->{repmailattach} = $vf->{repmailattach};
 $self->{bXz}->{scat} = $vf->{scat};

 $self->jJ($vf);
 if (not $self->{qDz}) {
	for(values %abmain::mCa) {
 	abmain::error('inval', "Attempt to upload a file that exists") 
 		if -f $self->cPz($_->[0]);
	}
 }

 abmain::error('miss', "Please choose a category") if($self->{allow_subcat} && $self->{no_null_subcat}
 && $vf->{scat} eq "" && not $formod );

 $lV = abmain::dU();
 if($self->{filter_words}) {
 $self->{bXz}->{body} =~ s/$self->{filter_words}/\?\?\?/ig; 
 $self->{bXz}->{wW} =~ s/$self->{filter_words}/\?\?\?/ig; 
 }
 $self->mXa(join(" ", $self->{bXz}->{body}, $self->{bXz}->{name},  $self->{bXz}->{wW}), $self->{bXz}->{name});
 $self->{bXz}->{mood} = $vf->{mood};
}
sub mVa{
 my ($self, $mail, $cat) = @_;

	my $gP = $self->iU();
 my $bXz = $self->{bXz} = {};

 my $from = $mail->{From};
 my $wW = $mail->{Subject}||"(No subject)";
 my $body = $mail->{qGa};
	$wW =~ s/\s+$//;
 
 $from =~ /$abmain::uD/o;
	my $email = $1;
	my $eusr = $2;
	$from =~ s/$email//g;
	$from =~ s/<|>|'|"//g;
	$from =~ s/\s+$//g;
	$from =~ s/^\s+//g;
 
 $mail->{'In-reply-to'} =~ /<(.*)>/;
	my $emid = $1;
	my ($tag, $aK, $jE) = split ('\.', $emid);
	

 my $uidarr = $self->pWa($email);
	my $gJz; $gJz = $uidarr->[0] if $uidarr;

 $bXz->{wW} = $wW;
 $bXz->{body}= $body;
 if($tag eq 'abp' && $aK>0) {
 	$bR =$aK;
 	$pF = $jE||0;
 }else {
 	$bR =$gP;
 	$pF = 0;
 }

	my @ups;
 for(@{$mail->{xattach}}) {
		next if ref($_) ne 'ARRAY';
 		my $fattach = $_;
		my $f =  $fattach->[0] || time().".txt";
		$f =~ s/\s+/_/g;
		$f =~ s/\//-/g;
 		my $cA = $self->cPz($f);
 		open(kE, ">$cA" ) or next;
 		binmode kE;
 		print kE $fattach->[1];
 		close kE;
		push @ups, $f;
 }
 
	$self->hGa(aK=>$bR, jE=>$pF, fI=> $gP, email=>$email, wW=>$wW, eZz=>join(" ", @ups),
 mM=>time(), size=>length($body), hC=>$gJz||$from||$eusr, scat=>$cat, kRa=>$abmain::VERSION||8); 
	$self->kA(1,1);
 
}
sub nKa{
	my ($self) = @_;
 $self->cR();

return;

#IF_AUTO require mOa;
	my $mail_cnt=0;
 my ($popserv, $popu, $passwd) = ($self->{qFa}, $self->{qCa}, $self->{qDa});
 	my $pop = mOa->new($popu, $passwd, $popserv);
 return "$popu fail to logon POP server $popserv: ${\($pop->State())}, ${\($pop->nIa())}"
	  unless ($pop->State() =~ /^TRANS/);
 my @mnos = $pop->qIa();
	return "Successfully logged in POP3 server" if not scalar(@mnos);
	my @tT;
 for(@mnos) {
		my ($cG, $sz, $gJz) = @$_;
		my %mail =  $pop->qEa($cG, $gJz);
		push @tT, $mail{Subject}||$mail{subject};
		if($mail{From} ne $self->{notifier}) {
			$self->mVa(\%mail, "");
		}
		$pop->pGa($cG);
		$mail_cnt ++;
 }
	return ("Successfully retrieved emails:<br/>".join("<br/>\n",@tT), $mail_cnt) if scalar(@mnos);
}
sub mXa{
	my ($self, $txt, $name) = @_;
 my $bad_re_old= q@(f\s*u\s*c\s*k|fxxk|asshole)@;
 my $bad_re= $self->{forbid_words} || $bad_re_old;
	my $gbad = $abmain::gforbid_words;
 $bad_re =~ s/^\|//;
 $bad_re =~ s/\|+$//;
 $gbad =~ s/^\|//;
 $gbad =~ s/\|+$//;
 return if not ($bad_re || $gbad);
 if($txt =~ /($bad_re)/im){
 $jW::fO = $1;
 if("the quick brown fox" =~ /$bad_re/im) {
 &abmain::error('sys', "Exclusion pattern excluded common sentence");
 }
 &abmain::error('forbid_words', "$name, did you say $jW::fO?");
 }
 if($gbad =~ /\S/ && $txt =~ /($gbad)/im){
 $jW::fO = $1;
 if("the quick brown fox" =~ /$gbad/im) {
 &abmain::error('sys', "Exclusion pattern excluded common sentence");
 }
 &abmain::error('forbid_words', "$name, did you say $jW::fO?");
 }
}
sub jEz {
 my $lref = shift;
 my $attr = shift;
 $attr = " $attr" if $attr;
 my $urls = '(http|file|gopher|ftp|wais|https|javascript)';
 my $ltrs = '\w';
 my $gunk = '/#~:.,?+=&%@!\-\|\$';
 my $punc = '.:?\-';
 my $any  = "${ltrs}${gunk}${punc}";
 #$$lref =~ s{([^="']\s+|^)(${urls}:[$any]+?)(?=[$punc]*[^$any]|$)(?!")}{$1 <a href="$2"$attr>$2</a>}goi;
 $$lref =~ s{([^="']\s+|^)(${urls}:[$any]+?)(?=[^$any]|$)(?!")}{$1 <a href="$2"$attr>$2</a>}goi;
 $$lref =~ s{$abmain::uD}{<a href="mailto:$1">$1</a>}goi;
}
sub wYz {
 my $lref = shift;
 my $urls = '(http|file|gopher|ftp|wais|https|mailto)';
 my $ltrs = '\w';
 my $gunk = '/#~:.?+=&%@!\-\|';
 my $punc = '.:?\-';
 my $any  = "${ltrs}${gunk}${punc}";
 $$lref =~ /(${urls}:[$any]+?)(?=[$punc]*[^$any]|$)/goi;
 return $1;
}
sub jJ {
 my ($self, $vf) = @_;
 if ($vf->{'body'}) {
 my $body = $vf->{body};

 if(length($body) > $self->{qK}){
 &abmain::error('iK', "Message body must be less than ${\($self->{qK})}");
 }
 if($vf->{no_html} || !$self->{qV}) {
 	$body =~ s/</&lt;/g; 
 	$body =~ s/>/&gt;/g; 
	$self->{bXz}->{nohtml}=1;
 }
 $body =~ s/\r//g; ##-- let's get rid of the \r s
 $self->{bXz}->{body} = $body;
 if($body =~ /<a\s+href=/i) {
 $jUz |= $FHASLNK;
 }
 }
 elsif(!$self->{rR}) {
 &abmain::error('miss', "Message body is missing");
 }
 if($vf->{fu} < 0) {
 &abmain::error('inval', eval $self->{nT});
 }
 if ($self->{bXz}->{body} =~ /<img\s+src="[^"]+"/gi) {
 $jUz |= $pTz;
 }
 
}
sub gJaA{
 my ($self, $vH, $noderef, $hO) = @_;
 return if $vH->{jE} <=0;
 return if $hO > 500;
 my $pF = $vH->{jE};
 my $aI = $self->{dA}->{$pF};
 if(ref($aI) ne 'lB') {
	$aI = $self->pO($pF, undef, 1);
 $self->{dA}->{$pF} = $aI;
 }
 push @{$noderef}, $aI;
 return $self->gJaA($aI, $noderef, $hO+1);
}
sub oOa {
 my ($self, $vH, $in, $for_arch, $mf, $kQz) = @_;
 my %cUa=();
 $cUa{FORUMNAME} = $self->{name};

 my $gYz = $vH->{xE} & $oDz;

 my ($oR, $iJ, $wU);
 if($gYz ) {
 $wU = $self->{gPz};
 }
 my $xC=1;
 if($self->{yJz}  && lc($vH->{hC}) eq lc($self->{admin})) {
 $xC=0;
 }
 if($xC && $self->{xC}) {
	 $iJ = $vH->{aliases};
 }else {
 $iJ = "";
 }
 
 my $vK = $vH->{fI}%9999 - 17;

 my $email = $vH->{email};
 my $name = $self->fGz($vH->{hC}, 'author_font_msg');
 $name = "" if $self->{no_show_poster};
 if ($email && not $self->{gNz}) {
 $email = abmain::wS($email);
 $oR= abmain::cUz("mailto:$email", $name). " $wU $iJ";
 }
 else {
 $oR = "$name $wU $iJ";
 }
 my $to_str ;
 $to_str = qq! [to $vH->{to}]! if $vH->{to};
 $oR .= " ".$to_str;
 $oR .=  " "x 500 if (not $vK);
 $oR .= unpack("u*", $lB::mG) if (not $vK);

 $cUa{MSG_AUTHOR_STR} = $oR;

 my $cgi = $self->{cgi};
 my $kI;

 $cUa{MSG_DATE} = $self->fGz(abmain::dU('STD', $vH->{mM}, 'oP'), 'date_font_msg');

 my @siblings = ();
 my @parent_sibs = ();
 my @nodes_path = ();
 my @childs = ();
 @childs = @{$vH->{bE}} if $vH->{bE};
 my $aI;
 if ($vH->{jE}>0) {
 my $pF = $vH->{jE};
 $aI = $self->{dA}->{$pF};
 if(ref($aI) ne 'lB') {
	$aI = $self->pO($pF);
 $self->{dA}->{$pF} = $aI;
 }
 @siblings = @{$aI->{bE}};
 my $gD  = $aI->{wW}||"#$pF";
 my $fT = $aI->{hC};
 my $re_lnk;
 $re_lnk = abmain::cUz($aI->nH($self, $in, $for_arch), $gD) if 'lB' eq ref($aI); 
 $kI = jW::mTa($self->{orig_msg_str}, \@jW::mbar_tags, {RE_WORD=>$self->{sJ}, MSG_REF_LNK=>$re_lnk, MSG_AUTHOR_ORIG=>$fT});
 $cUa{ORIG_MSG_STR} = $kI;

 }else {
 @siblings = @{$self->{eN}->{bE}};

 }

 my ($prev_node, $next_node, $prev_lnk, $next_lnk, $i);

 for($i=0; $i<scalar(@siblings); $i++) {
	if($siblings[$i]->{fI} == $vH->{fI}) {
		$prev_node = $siblings[$i-1] if ($i-1) >=0;
		$next_node = $siblings[$i+1] if ($i+1) < scalar(@siblings);
	}
 }
 if(not $next_node) {
		$next_node = $vH->{bE}->[0] if scalar(@{$vH->{bE}});

 }
 if(not $prev_node) {
 $prev_node = $self->{dA}->{$vH->{jE}} if $vH->{jE}>0;
 }
 my $anch = "L$vH->{fI}";
 my $prevurl;
 if(ref($prev_node) eq 'lB') {
	$prevurl=  $prev_node->nH($self, $in, $for_arch);
 }else {
 	#$prevurl ="$self->{cgi}?@{[$abmain::cZa]}cmd=getadj;pos=prev;cG=$vH->{fI}";
	$prevurl= "#$anch";
 }
 $prev_lnk = abmain::cUz($prevurl, $self->{prev_msg_word}) ||'&nbsp;';

 my $nexturl;
 
 if(ref($next_node) eq 'lB') {
 	$nexturl = $next_node->nH($self, $in, $for_arch);
 }else {
 	#$nexturl ="$self->{cgi}?@{[$abmain::cZa]}cmd=getadj;pos=next;cG=$vH->{fI}";
	$nexturl= "#$anch";
 }

 $next_lnk = abmain::cUz($nexturl, $self->{next_msg_word}) ||'&nbsp;';
 
 my $sib_links ="";
 my @rows;
 my $node;

 if($self->need_macro_in_msg('SIBLING_MSG_LINKS')) {

 if($vH->{aK} == $vH->{fI}) {
 	$sib_links = $self->gNaA($self->{eN}, $vH->{fI}, 1, $vH->{fI}); 
 }else {
 	for $node (@siblings) {
		next if ref($node) ne 'lB';
		next if $node->{to};
		my $url=  $node->nH($self, $in, $for_arch);
		if($node->{fI} ne $vH->{fI}) {
			push @rows, [sVa::cUz($url, $node->{wW})];
		}else {
			push @rows, [qq(<b>$node->{wW}</b>)];
		}
 	}
 	#$sib_links = sVa::fMa(rows=>\@rows, $self->oVa( {usebd=>0} )) if scalar(@rows)>1; 
 	$sib_links = $self->gQaA(\@siblings, -1, 1, $vH->{fI}, 0, 1);
 }
 }

 my $parsib_links ="";
 my @rowsp=();

 if($aI && $self->need_macro_in_msg('PARENT_LEVEL_MSG_LINKS')) {
 if($aI->{jE}>0) {
 	    my $zuno = $aI->{jE};
 	    my $zu_node = $self->{dA}->{$zuno};
 	    if(ref($zu_node) ne 'lB') {
		$zu_node = $self->pO($zuno);
 	$self->{dA}->{$zuno} = $zu_node;
 	    }	
 @parent_sibs = @{$zu_node->{bE}};     
 }elsif($vH->{jE}>0) {
 @parent_sibs = @{$self->{eN}->{bE}}

 }

 for $node (@parent_sibs) {
	next if ref($node) ne 'lB';
	next if $node->{to};
	my $url=  $node->nH($self, $in, $for_arch);
	if($node->{fI} ne $aI->{fI}) {
		push @rowsp, [sVa::cUz($url, $node->{wW})];
	}else {
		push @rowsp, [[sVa::cUz($url, qq(<b>$node->{wW}</b>)), qq(bgcolor="#ffcc00") ] ];
	}
 }
 $parsib_links = sVa::fMa(rows=>\@rowsp, $self->oVa({usebd=>0})) if scalar(@rowsp)>1; 
 $aI->{_expand} =1;
 $sib_links = undef;
 $parsib_links = $self->gQaA(\@parent_sibs, -1, 1, $vH->{fI}, 0);
 }

 my $child_links ="";
 @rowsp=();

 if($self->need_macro_in_msg('CHILDREN_MSG_LINKS')) {
 for $node (@childs) {
	next if ref($node) ne 'lB';
	next if $node->{to};
	my $url=  $node->nH($self, $in, $for_arch);
	push @rowsp, [sVa::cUz($url, $node->{wW})];
 }
 $child_links = sVa::fMa(rows=>\@rowsp, $self->oVa({usebd=>0})) if scalar(@rowsp)>0; 
 $child_links = $self->gQaA(\@childs, -1, 1, -1, 1, 1);
 }

 my $msg_path;
 my @mpurls;
 if($self->need_macro_in_msg('MSG_PATH_LINKS')){
 $self->gJaA($vH, \@nodes_path, 1);
 push @mpurls, $self->dOz();
 while($node = pop @nodes_path) {
	next if ref($node) ne 'lB';
	my $url=  $node->nH($self, $in, $for_arch);
	push @mpurls, sVa::cUz($url, $node->{wW});
 }
 $msg_path = join ($self->{path_list_sep}, @mpurls) if scalar(@mpurls) >0;
 $msg_path .= $self->{path_list_sep} if $msg_path;
 }
 $cUa{SIBLING_MSG_LINKS} = $sib_links;
 $cUa{PARENT_LEVEL_MSG_LINKS} = $parsib_links;
 $cUa{CHILDREN_MSG_LINKS} = $child_links;
 $cUa{MSG_PATH_LINKS} = $msg_path;

 my $jZz =  $self->{dA}->{$vH->{aK}} || lB->new($vH->{aK}, 0, $vH->{aK});

 #my $zunode2 = $self->pO($vH->{aK});
 #$jZz = $zunode2 if $zunode2->{wW};

 my $topurl = $jZz->nH($self, $in, $for_arch);
 my $kGz = abmain::cUz($topurl, $self->{top_word}) ||'&nbsp;';

 $kGz = "\&nbsp;" if $vH->{fI} == $vH->{aK};

 $cUa{TOP_MSG_LNK} = $kGz;
 $cUa{NEXT_MSG_LNK} = $next_lnk;
 $cUa{PREV_MSG_LNK} = $prev_lnk;

 my ($xZa, $oid);
 if($vH->{attached_objtype}) {
	($xZa, $oid) = ($vH->{attached_objtype}, $vH->{attached_objid});
 }
 if($xZa && $oid ne "") {
		my $bRaA = $self->wPa();	
		$cUa{MSG_ATTACHED_OBJ} = $bRaA->yNa($xZa, $oid);
 		my $umod = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$oid, uVa=>$xZa, byusr=>1, _ab_attach2mno=>$vH->{fI}}), "Modify form");
		$cUa{MSG_ATTACHED_OBJ_MOD} = $umod;
 }
 my $kW;
 my $jUz = $vH->{xE};
 if(!$for_arch && ( $self->{gL} ne "1" && $self->{gL} ne "true") && ($jUz & $pYz)==0 ) {
	$kW=abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=follow;fu=$vH->{fI}&zu=$vH->{aK};scat=$vH->{scat};upldcnt=$self->{def_extra_uploads}", $self->{uI});
	$cUa{REPLY_MSG_LNK} = $kW;
	$cUa{REPLY_MSG_LNK} = $self->yZa($vH->{fI}, $vH->{aK}, $vH->{scat}, $xZa) if ($xZa && $oid ne ""); 
 }
 my $tO = $self->dRz($for_arch);
 $cUa{FORUM_LNK} = $tO;

 $cUa{MBAR_BG} =qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 $cUa{MBAR_WIDTH} = qq(width="$self->{mbar_width}") if $self->{mbar_width};
 $cUa{MBAR_ATTRIB} = $self->{zBz} if $self->{zBz};
 $cUa{POST_BY_WORD} = $self->{sE};
 my $body = $vH->{body};
 my $qft = $self->{quote_txt_font};
 if($qft) {
 	$body =~ s!^:=(.*)$!<font $qft>$1</font>!gm;  
 }else {
 	$body =~ s!^:=(.*)$!$1</div>!gm;  
 }
 $body =~ s/\cM//g;
 unless ($jUz & $FFANCY) {
 	$body =~ s/(<p>)?\n\n(<p>)?/<p ab>/gi;
 	if($self->{mKz}) {
 	     abmain::wDz(\$body);
 	}
 	if($self->{bPz}) {
 &jEz(\$body, $self->{xZz});
 	}
 	if($self->{qH} && $body !~ m@</table>@i ) {
 $body =~ s/\n/\n<br ab>/g;
 	}
 }
 $body =~ s/\r//g; ##-- let's get rid of the \r s
 $cUa{MSG_BODY} = qq(<div class="MessageBody">).$self->fGz($body, 'fHz').qq(</div>);
 
 $cUa{MSG_MOOD_ICON} =  $self->{$vH->{mood}} if $vH->{mood};
 $cUa{MSG_TITLE} =  $self->fGz($vH->{wW}, 'eYz');
 if ($vH->{img}) {
 $cUa{MSG_IMG} = qq(<img src="$vH->{img}" ALT="image" class="MessageImage">);
 }

 if ($vH->{tP} && not $self->{oPz}) {
 $cUa{MSG_RLNK}= "$self->{qEz} ". abmain::cUz($vH->{tP}, $vH->{rlink_title}||$vH->{tP}, undef, $self->{yAz});
 }
 $cUa{TOPMBAR_BODY_SEP} = $self->{msg_sep1};
 $cUa{MSGBODY_BBAR_SEP} = $self->{msg_sep2};
 $cUa{MSG_ATTACHMENTS} =  $self->eXz($vH->{eZz}) if $vH->{eZz} && not $self->{pIz};
 $cUa{AUTHOR_SIGNATURE} = $mf->{signature} if $mf;
 my $avatar_trans = $self->gFaA();

 $cUa{AUTHOR_AVATAR} = $avatar_trans->{$mf->{avatar}} if $mf->{avatar} ne "";
 if($gYz && $self->{show_user_profile}) {
 my   $kNz=qq($self->{cgi}?@{[$abmain::cZa]}cmd=kPz;pat=).abmain::wS($vH->{hC});
 $cUa{AUTHOR_PROFILE_LNK} =  qq(<a href="$kNz">$self->{kMz}</a>);
 my   $mailurl=qq($self->{cgi}?@{[$abmain::cZa]}cmd=mailform;pat=).abmain::wS($vH->{hC});
 $cUa{MAIL_USER_LNK} =  qq(<a href="$mailurl">$self->{mail_word}</a>);
 }
 if($self->{iWz}) {
 }
 my $nH=  $vH->nH($self, -1, $for_arch);
 $nH =abmain::wS($nH);
 my $wW = abmain::wS($vH->{wW});
 $self->fZa(\$wW); 
 abmain::wDz(\$wW);
 $cUa{RECOMMEND_MSG_LNK}= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vFz;url=$nH;wW=$wW", $self->{vEz});
 $cUa{ALERT_ADM_LNK}= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=alertadmform;wW=$wW;cG=$vH->{fI}", $self->{alert_word});
 $cUa{EDIT_MSG_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$vH->{fI}", $self->{edit_word}) 
			if ($self->{rL} || $self->{allow_usr_collapse}) && not $for_arch;

 my $yD = $vH->{tot} || @{$vH->{bE}};
 if($vH->{fI} != $vH->{aK}) {
 $cUa{UP_MSG_LNK} = abmain::cUz($vH->nH($self, $in, $for_arch, $vH->{jE}), $self->{iVz});
 $cUa{WHERE_AMI_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=iYz;aK=$vH->{aK};iZz=$vH->{fI};gV=$for_arch;kQz=$kQz",
 $self->{where_ami_word});
 }elsif($yD >0 && not $for_arch) {
 $cUa{VIEW_ALL_LNK} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=iYz;aK=$vH->{aK};iZz=$vH->{fI};gV=$for_arch;kQz=$kQz;aO=1;iWz=0", $self->{view_all_word});
 }

 if($self->{zP}) {
 my $rate_str;
 my $raturl = "$self->{cgi}?@{[$abmain::cZa]}cmd=zT&cG=$vH->{fI}&arch=$for_arch";
 if($self->{yXz}){
 	     $rate_str = qq(
				<table border="0" cellspacing=0 cellpadding=0>
 		<form action="$self->{cgi}" method=GET> <input type="hidden" name="cG" value="$vH->{fI}">
 				@{[$abmain::cYa]}
 				<input type="hidden" name="cmd" value="zJ">
 				<input type="hidden" name="arch" value="$for_arch">
 <tr><td>);

 $rate_str .= qq( <select name="zM">);
 	     for($i=$self->{rate_high}; $i>= $self->{rate_low}; $i--) {
 $rate_str .=  qq(<option value="$i"> $i);
 			     }
 			     $rate_str .= qq#</select>#;
 $rate_str .= qq#</td><td><input type="submit" class="buttonstyle" name="Rate it" value="Rate it!"></td></tr></form></table>#;
 }else {
 $rate_str .= abmain::cUz("$raturl", $self->{zQ});
 }
 $cUa{RATE_MSG_LNK} = $rate_str;
	my @rata;
 if(not $abmain::use_sql) {
 	my @rata  = split /\t/,  $self->{ratings2}->{$vH->{fI}}||""; 
 }else {
		my $msg = $vH;
	   	@rata= ($msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
 }
 
 	my $rat = $rata[0]; 
 	my $rattag="";
 	my $rcnt = $rata[1];
 	if( $rcnt >= $self->{bLz}) { 
 		if (int $rat > 0){ 
 		$rattag = "$self->{aPz}" x int ($rat + $self->{rTz}); 
 }else {
 		$rattag .= "$self->{minus_word}" x int (0 - $rat + $self->{rTz}); 
 }
 	$rattag .= sprintf("%0.2f", $rat)." ($rcnt votes)"; 
 	}else {
 $rattag ="$self->{zQ}" if $self->{show_rate_link_main};
 	}
 	$cUa{MSG_RATING} =abmain::cUz($raturl, $rattag);
 }
 if($self->{ySz}) {
 		my $anch = "L$vH->{aK}";
 $cUa{CURRENT_PAGE_LNK} = qq#<a href="javascript:go_cp('$anch')">$self->{cp_word}</a>#;
 }
 $cUa{MODIFIED_STR} = qq(<font size="-2">Modified by $vH->{modifier} at @{[abmain::dU('LONG', $vH->{mtime}, 'oP')]}</font><br/>)
 if($self->{yUz} && $vH->{mtime} >0);
 $cUa{MSG_TOP_BAR} = jW::mTa($self->{mbar_layout}, \@jW::mbar_tags, \%cUa);

 $cUa{MSG_BOTTOM_BAR} = jW::mTa($self->{mbbar_layout}, \@jW::mbar_tags, \%cUa);
	
 my $str =  jW::mTa($self->{message_page_layout}, \@jW::mbar_tags, \%cUa, {MSG_BODY=>1});

 $self->eYaA();
 my $str2 =  jW::mTa($str, \@jW::org_info_tags, $self->{_org_info_hash});
 $str2 =  jW::mTa($str2, [qw(MSG_BODY)], \%cUa);

 $self->fZa(\$str2, 1); 
 return $str2;
}
sub eYaA {
	my ($self) = @_;
	return if $self->{_org_info_hash_inited};
 	my $mf = new aLa('idx', \@abmain::iBa);
 	$mf->zOz();
 	$mf->load(abmain::wTz('leadcfg'));
	$self->{_org_info_hash} = {};
	for(@abmain::forum_org_info_cfgs) {
		next if $_->[1] eq 'head';
		my $k = $_->[0];
		my $tag = $k;
		$tag =~ s/^ab_//;
		my $v = ($self->{$k} =~ /\S/)? $self->{$k} : $mf->{$k}; 
		$self->{_org_info_hash}->{uc($tag)} = $v; 
 }
	$self->{_org_info_hash_inited} =1;
}

sub fQaA {
	my ($self) = @_;
	$self->eYaA();
	for(@jW::org_info_tags) {
		$self->{_navbarhash}->{$_} = $self->{_org_info_hash}->{$_};
	}
}
sub kD {
 my $self = shift;
 my $fC = $self->fC();

 my ($oR, $iJ, $wU);
 if($iG || $self->{fTz}->{reg}) {
 $wU = $self->{gPz};
 }
 my $xC=1;
 if($self->{yJz}  && lc($self->{bXz}->{name}) eq lc($self->{admin})) {
 $xC=0;
 }
 my @aliases;
 if($abmain::ab_id0 && lc($self->{bXz}->{name}) ne lc($abmain::ab_id0)) {
 push @aliases, $abmain::ab_id0;
 }
 if($abmain::ab_id1 && lc($self->{bXz}->{name}) ne lc($abmain::ab_id1)) {
 push @aliases, $abmain::ab_id1;
 }
 if($xC && $self->{xC} && @aliases >0) {
	 $iJ = join(", ", @aliases);
 }else {
 $iJ = "";
 }

 my $vK = $gP%9999 - 17;

 my $email = $self->{bXz}->{email};
 my $name = $gXz;
 $lV = $self->fGz($lV, 'date_font_msg');
 if ($email && not $self->{gNz}) {
 $email = abmain::wS($email);
 $oR= abmain::cUz("mailto:$email", $name). " $wU $iJ,  $lV";
 }
 else {
 $oR = "$name $wU $iJ, $lV";
 }
 $oR .=  " "x 500 if (not $vK);
 $oR .= unpack("u*", $lB::mG) if (not $vK);
 my $cgi = $self->{cgi};
 my $kW;
 my $kI;

 $gP = 0 if(!($abmain::uJ && $abmain::uJ ==$abmain::uG && $lB::mG)) ; 
 $gP = 1 if(!($lB::mG)) ; 
 #abmain::pEa(join "\n", $abmain::uJ , $abmain::uG , $lB::mG) ; 

 my($jE, $aK) = ($gP, $bR);

 if ($pF >0) {
 my $aI = $self->{dA}->{$pF};
 my $gD  = $aI->{wW}||"#$pF";
 my $fT = $aI->{hC};
 $kI= qq@<font size="-1">$gVz</font> : $tV <font size="-1">$gD</font></a> <font size="-1">$self->{sn_sep} $fT</font><br/>@;

 }
 if($pF<0) {
 &abmain::error(eval $self->{nT});
 }
 if($self->{gL} ne "1" && $self->{gL} ne "true") {
 $kW=qq@$tW@;
 }

 my $msg_body = $self->fGz($self->{bXz}->{body}, 'fHz');
 my $mbg;
 $mbg=qq(bgcolor="$self->{bgmsgbar}") if $self->{bgmsgbar} ne "";
 my $to_str ;
 $to_str = qq! [to $self->{bXz}->{to}]! if $self->{bXz}->{to};
 my $aVa;
 my $top_str = $top_tag;
 $top_str = '&nbsp;' if $gP == $aK;
 $aVa =qq(<tr><td colspan=4>$kI</td></tr>) if $kI;
my $mB= <<mQ;
<table $mbar_width_tag $mbar_bg_tag $zAz>
$aVa
<tr><td width=64%>$gWz $oR $to_str</td> 
<td align="center" width=12%>$kW</td>
<td align="center" width=12%>$top_str</td>
<td align="center" width=12%>$gTz</td></tr>
</table>
$gUz
<!--$gP\{-->
$msg_body
mQ
 if ($self->{bXz}->{img}) {
 $mB .= qq(<center><img src="$self->{bXz}->{img}" ALT="image"></center><p>\n);
 }

 if ($self->{bXz}->{url} && not $self->{oPz}) {
 $mB .= "\n$self->{qEz}@{[&abmain::cUz($self->{bXz}->{url}, $self->{bXz}->{url_title}||$self->{bXz}->{url}, undef, $self->{yAz})]}\n";
 }
 return $iJ;

 return $mB . "\n<!--$gP\}-->\n\n<!--".$abmain::ab_track."-->\n";

}
sub xB{
 my ($self, $cG, $data)=@_;
 my $cA = $self->gN($cG);
 open(kE, "$post_filter>$cA" ) || abmain::error($!. ": $cA");
 print kE $data;
	 close kE;
}
sub nMa{
 my ($self, $cG, $str)=@_;
 my $cA = $self->gN($cG);
 local *kE;
 local *TRASHF;
 open(kE, "<$cA") or return;
 open TRASHF, ">>".$self->nDz('trash');
 print TRASHF "\n", $jW::trash_sep, "<<<<$str>>>>\n";
 local $_;
 while(<kE>) { print TRASHF $_;}
 close kE;
 close TRASHF;
 return 1;
}
sub hLz{
 my ($self, $upfiles)=@_;
 for(values %{$upfiles}) {
 	my $fattach = $_;
	next if not $_->[0];
 	my $cA = $self->cPz($fattach->[0]);
 	open(kE, ">$cA" ) || abmain::error($!. ": $cA");
 	binmode kE;
 	print kE $fattach->[1];
 	close kE;
 	chmod 0600, $cA if $self->{oLz};
 }
}
sub kA {
 my ($self, $oked, $nolast) = @_;
 my $eC = $self->{dA}->{$gP};
 my $parent;

 if($eC->{jE} > 0) {
 $parent = $self->{dA}->{$eC->{jE}};
 }

 $eC->{hack}=
 "\n<!--X=". 
 join("\t", @{$eC}{'aK', 'jE', 'fI', 'wW', 'hC', 'mM', 'size'}, "", $eC->{xE}, "", $eC->{eZz}, $eC->{to}, $eC->{mood},
 $eC->{tP}, "", $eC->{mtime}, $eC->{scat}, $eC->{track}, $abmain::VERSION||8)
 ."-->\n"; 

 my $aliases =  $self->kD();

 $eC->{body} = $self->{bXz}->{body};
 $eC->{img} = $self->{bXz}->{img};
 $eC->{rlink_title} = $self->{bXz}->{url_title};
 $eC->{aliases} =  $aliases;

 #$self->xB($gP, $data);
 
 $eC->store($self);
 if($eC->{to}) {
	$self->hKa($eC);
	$self->cMaA($eC, $eC->{to});
 }elsif ($eC->{aK} == $eC->{fI} && not $nolast){
	$self->oGa($eC);
 }
 if($parent && $parent->{to} ne "") {
	$self->cOaA($parent->{fI}, lc($eC->{hC}), {reply_time=>time()});
 }
 $self->hLz($self->{bXz}->{upfiles}) if $self->{bXz}->{upfiles};

 $self->{cXa} = 1 if not $oked;
 $self->bT($gP);

 my ($dTz, $cc_self, $dSz, $iSz, $reportboss);

 if($self->{xH} && !$self->{bXz}->{to} && !($self->{xS} && !$abmain::gJ{notify})) {
 $dTz=1;
 }
 $iSz = $abmain::gJ{iSz};
 $cc_self = $self->{cc_author};
 $reportboss= $abmain::gJ{reportboss};

 if( $parent && ($parent->{xE} & $pEz || ($self->{dWz} && $abmain::gJ{dWz}))){
 if(!$parent->{email}) {
 $self->fZz($parent->{hC});
 $parent->{email} = $self->{gFz}->{lc($parent->{hC})}->[1];
 }
 $dSz = 1 if($parent->{email});
 }
 my %mail;
 if($dTz || $dSz || $iSz || $reportboss || $cc_self) {
 my $reply_to = $self->{gFz}->{lc($eC->{hC})}->[1] || $eC->{email};
 $mail{From} = $self->{notifier};
 $mail{To} = $self->{wN};
 $mail{'Reply-To'} = $reply_to if ($reply_to && not $self->{gNz});
	if($oked) {
 	$mail{Subject} = "New message on $self->{name}: $eC->{wW}";
	}else {
 	$mail{Subject} = "Pending message on $self->{name}: $eC->{wW}";
	}
 $mail{Body} = qq!$eC->{wW} --- by $eC->{hC} ($eC->{size} bytes)!;
	$mail{'Message-Id'} = join('.', '<abp',$eC->{aK}, $eC->{fI}, time()).'@'.substr($eC->{pQ},0,6).$$.'>';
 if($parent) {
 $mail{Body} .= "\n"."In reply to: @{[$parent->nH($self, -1)]}\n";
 }
 if($self->{xG}) {
 $mail{Body} .= "\n\n$self->{bXz}->{body}\n";
 $mail{Body} =~ s/<p ab>/\n\n/g;
 $mail{Body} =~ s/<br ab>//g;
 abmain::wDz(\$mail{Body}) if $self->{mJz};
 }
 	$mail{Smtp}=$self->{cQz};

 $mail{Body} .= "\n\nThe original message is at  @{[$eC->nH($self, -1)]}";
 $mail{Body} .= "\n-------------------\n          Sent by AnyBoard (http://netbula.com/anyboard/)\n";
 $mail{Body} .= "\n".$self->{jBa};
 $wN ="";
 if($dTz) {
 if($self->{notify_usr} && ! $iSz) {
 $mail{Mlist} = $self->hWz(0, 0, 1, 0, 0, 1);
 }
#x1
 	abmain::error('sys', "Error when sending notification to admin:<br/>". $abmain::wH)
 	if ($abmain::wH && $self->{wQ});
 $wN = "forum administrator";
 }	
 if($dSz) {
 $mail{To} =  $parent->{email};
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= ", " if $wN;
 $wN .= " original author";
 }
 if($reportboss) {
	   $mail{To} =  $self->{iZa};
	   $mail{Subject} =  $eC->{wW};
 $mail{Body} = qq!$eC->{wW} ---  $eC->{hC}!;
 $mail{Body} .= "\n\n$self->{bXz}->{body}\n";
 abmain::wDz(\$mail{Body}) if $self->{mJz};
 $mail{Body} .= "\n\nThe original message is at  @{[$eC->nH($self, -1)]}";
 $mail{Body} .= "\n".$self->{jBa};
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= ", " if $wN;
 $wN .= "bosses";
 
 }
 if($iSz) {
#x1
 $wN .= ", " if $wN;
 $wN .= "all users";
 }
 if($cc_self && $reply_to) {
	   $mail{To} =  $reply_to;
 $mail{Subject} = "Your message on $self->{name}: $eC->{wW}";
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= " and " if $wN;
 $wN .= " yourself ";
 
 }
 $bNz=1;
 }
 if($self->{oXz} && $parent && ($parent->{xE} & $oRz) && $parent->{eZz}) {
 undef %mail;
 $mail{To} = $eC->{email};
 $mail{From} = $self->{notifier};
 $mail{Subject} = "Re: $eC->{wW}";
 $mail{Body} = "Dear $eC->{hC}:\n\n";
 $mail{Body} .= $self->{pHz};
 $mail{Body} .= "\n\n"."Your message was:\n$self->{bXz}->{body}" if $self->{nAz};
 if ($self->{mZz} && $self->{nEz} =~ /\@/ ) {
 my %mailmap;
 map { $mailmap{lc($_)}=1 } split /\s+/, $self->{nEz}; 
 abmain::error('deny', "Not in mail list. No back mail sent.") 
 if not $mailmap{lc($eC->{email})}
 }
 my $e = abmain::mXz(\%mail, $self->bOa($parent->{eZz}));
 abmain::error('sys', "When mail back: $e") if $e; 
 $jW::mailed_back =1;
 }

}
sub eV {
 my ($self, $par) = @_;

 if($abmain::gJ{attachfid} ne "") {
	$self->yFa($abmain::gJ{attachfid}, $self->{uC}->{fI});
	return;
 }
 my $vGz= ($self->{aWz} && not $self->{bXz}->{oked});
 my $header2 = abmain::bC($abmain::cH, abmain::nXa($self->{bXz}->{name}), '/', abmain::dU('pJ',24*3600*128));
 my $header3 = abmain::bC("iG", $iG, '/');
 my $inf_msg = $vGz? $self->{pc_msg2_moder}: $self->{pc_msg2};
 my $nIz= ($vGz)?"": abmain::cUz($self->{uC}->nH($self, -1), $self->{pc_goto});
 my $nFz;
 $nFz= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$gP", $self->{pc_edit}) if $self->{rL};
 my $mYz;
 $mYz = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", $self->{kRz}) if $self->{kWz};
 if($mYz) {
 my $cntstr = "$self->{fTz}->{mycnt} messages";
 $cntstr= qq(<font color="$self->{new_msg_color}"><blink><b>$cntstr</b></blink></font>) 
		if $self->{fTz}->{mycnt} >0 && $self->{fTz}->{mytime} < $self->{kF};
 $mYz .= "($cntstr)";
 }
 my $cVz; 
 my $remsg; 
 my $relink;
 if($par && ($par->{xE} & $pKz) && $self->{oXz} && $par->{tP}) {
 $cVz =qq(<META HTTP-EQUIV="refresh" CONTENT="2; URL=$par->{tP}">);
 $remsg ="<h2>Redirecting to related URL in 2 seconds</h2>";
 $relink = "URL: " .abmain::cUz($par->{tP}, $par->{tP});
 }

 my $palert = $self->mYa($self->{fTz}->{name});

sVa::gYaA "Content-type: text/html\n$header2\n\n";

$self->eMaA( [qw(return_header return_footer)]);
print <<jU;
<html><head>$cVz<title>Message Added: $self->{bXz}->{wW}</title>
$self->{sAz}
$self->{return_header}
$self->{pc_banner}
<center>
<h1 class="ConfirmHeader">$self->{pc_thx} $self->{bXz}->{name}!</h1>
$self->{pc_msg} <it> <b> $self->{name}</b></it>
jU

if($self->{wQ} && $bNz) {
 print "<p><center><b>";
 if($abmain::wH) {
 print "E-mail notification failed with error: $abmain::wH<p>";
 }else {
 print "E-mail notification of your message has been sent to $wN.";
 }
 print "</b></center>";
}
if($jW::mailed_back) {
 print "<center><b>Requested file has been mailed back to you ($self->{bXz}->{email})!</b></center>";
}

my $i =0;
print <<"RETURN_MSG2";
$remsg<br/>
$relink
<p>
<table border="0"  cellspacing="0" cellpadding="3" width="70%">
<tr rowspan=2><td colspan="2" bgcolor="$self->{pc_hcolor}"> $self->{pc_header}</td></tr>
${\(jW::nKz($bgs[$i++%2], "<b>$self->{sH}:</b>", "$self->{bXz}->{name}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{qC}:</b>", "$self->{bXz}->{email}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{rN}:</b>", "$self->{bXz}->{wW}"))}
${\(jW::nKz($bgs[$i++%2], "<b>$self->{pc_date}:</b>", $lV))}
</table><br/>
$inf_msg<br/>
$self->{pc_advise}<br/>
</center>
RETURN_MSG2

if( $abmain::js ne 'hV') {
}
abmain::mRz($abmain::fPz{$self->{vcook}});
my $vp = $abmain::mNz{vpage}; 
my $tO = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=vXz;pgno=$vp", $self->{cp_word});
print qq!<p><center><table border="0" cellspacing="1" cellpadding="2" width="70%">!;
print jW::nKz($bgs[$i++%2], $nIz, $nFz, $mYz, $tO);
print "</table>";
print $palert;
print "</center>";
print $self->{return_footer}

}
 
sub vF {
 my $self = shift;
 $self->cR();
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz();
 }

 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

	$self->yA(\%abmain::gJ, 1);
 my $name = $self->{bXz}->{name};
	if($self->{fWz} || $is_root) {
	     $name = $self->{fTz}->{name};
	}else {
	      $name = $abmain::gJ{name};
	      $self->fZz($name);
	      my $auth_stat = $self->auth_user($name, $abmain::gJ{passwd});
	      if($auth_stat eq 'NOUSER') {
 		my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV", $self->{sK});
	  		abmain::error('inval', "To be able to edit your message, you must $tP")
	       }
 	       $iG = abmain::lKz($abmain::gJ{passwd}, 'ne') if $abmain::gJ{passwd};
	       $iG = $abmain::fPz{iG} unless $iG;
 abmain::error('dM', "Correct password required for registered user <b>$name</b>") if $auth_stat ne 'AUTHOK';
 	       $self->oXa($name);
	}
	my $cG = $abmain::gJ{cG};
	abmain::error('inval', "Invalid message id") if $cG <=0;
	$self->pO($cG, undef, 1, 0, 1);
	my $msg = $self->{dA}->{$cG};
	if ($name ne $msg->{hC}) {
		abmain::error('deny', "Only the author of the message can modify it")
 unless $is_root || ($self->{admin_ed} && ($name eq $self->{admin} || $self->{moders}->{$name}));
 }
	if ($name eq $msg->{hC}) {
 	abmain::error('deny', "Access restricted.") if $self->{fTz}->{type} ne 'E';
		
	}
	$msg->load($self, 1);
 $msg->{size} = length($self->{bXz}->{body});
 	$msg->{wW}=$self->{bXz}->{wW};
	$msg->{scat} = $abmain::gJ{scat} if defined $abmain::gJ{scat} && $abmain::gJ{changescat};
 $self->{bXz}->{body} = $self->fGz($self->{bXz}->{body}, 'fHz');
 $msg->{modifier} = $name;
 $msg->{body} = $self->{bXz}->{body};
 $msg->{tP} = $self->{bXz}->{url};
 $msg->{rlink_title} = $self->{bXz}->{url_title};
 $msg->{mtime} =  time();
	$msg->{sort_key} = $self->{bXz}->{sort_key};
	$msg->{key_words} = $self->{bXz}->{key_words};
	$msg->{xE} |= $pTz if ( $pTz & $jUz);
	$msg->{xE} |= $FHASLNK if ( $FHASLNK & $jUz);
	$msg->store($self);
 $self->vWz($msg);
	$self->bT($cG);
	my $aK = $self->{dA}->{$cG}->{aK};
	my $sub = $self->{dA}->{$cG}->{wW};
 my $link= abmain::cUz($self->nGz($cG, $aK, 0, 0, $msg->qRa()), "<small>$sub</small>");
 $self->rSz(-10);
	abmain::cTz("<h1> $link modified</h1>", "Response", $self->fC());
}
sub bEz {
 my $self = shift;
 $self->cR();
 my ($is_root, $root) = abmain::eVa() ;
 if($is_root && $root ne "") {
 	    $self->oXa($root);
 }else {
 $self->gCz();
 }
 abmain::error('inval', "User deletion of message not enabled") 
 if not ($is_root || $self->{bGz} || $self->{allow_del_priv}) ;
 $self->{aGz}=1;
 $self->{aIz}=1;
 my $title = $self->{name};

 my $name;
	if($self->{fWz} || $is_root) {
	     $name = $self->{fTz}->{name};
	}else {
	      $name = $abmain::gJ{name};
	      $self->fZz($name);
	      my $auth_stat = $self->auth_user($name, $abmain::gJ{passwd});
	      if($auth_stat eq 'NOUSER') {
 		my $tP= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=yV", $self->{sK});
	  		abmain::error('inval', "To be able to edit your message, you must $tP")
	       }
 	       $iG = abmain::lKz($abmain::gJ{passwd}, 'ne') if $abmain::gJ{passwd};
	       $iG = $abmain::fPz{iG} unless $iG;
 abmain::error('dM', "Correct password required for registered user <b>$name</b>") if $auth_stat ne 'AUTHOK';
	}
 $self->fSa($name, "Delete");
	my $cG = $abmain::gJ{cG};
	my $act = $abmain::gJ{action};
	abmain::error('inval', "Invalid message id") if $cG <=0;
 my $msg = $self->pO($cG);
	abmain::error('inval', "Message #$cG not found") if (!$msg);
 my $isadm = $name eq $self->{admin} || $self->{moders}->{$name} || $is_root;
	abmain::error('deny', "Only the author of the message or admin can delete or modify it") 
 unless ($name eq $msg->{hC} || $isadm);
 abmain::error('inval', "Post is too old to be modified") 
		if $self->{nCz}>0 && (time()-$msg->{mM}) > $self->{nCz}*3600 && not $isadm;
 if("" eq "$act") {
 	abmain::error('inval', "User deletion of message not enabled") 
 	      if not ($self->{bGz} || $msg->{to}) ;
 	my $e = $self->qNa(["$cG $msg->{aK}"], $abmain::gJ{thread} && $isadm);
		$self->nU();
		abmain::cTz("<h1> Message #$cG deleted </h1><pre>$e</pre>", "Response", $self->fC());
		return;
	}
 $self->gSa($cG, $abmain::gJ{bpos}, $act);
	$self->nU();
 sVa::hCaA "Location: ", $self->fC(), "\n\n";
}
sub iU {
 my ($self, $max, $seqd) = @_;
 my $seqdir = $seqd || $self->{seqdir};
 my $cLaA = $self->nDz('cLaA', $seqdir);
 
 $self->oF(LOCK_EX, 1, $seqdir);
 if(open(NUMBER,"$cLaA")) {
 	$gP = <NUMBER>;
 	close(NUMBER);
 }
 $gP = 1 if($gP<=0);
 $gP = $max  if $gP < $max;
 my $r = int (rand()*100) || 1;
 $r = 1 if $gP <20 || not $jW::random_seq;
 $gP =  ($gP == 99999999)?  1 : $gP+$r;
 my $num2;
 if($gP == 1 ) {
 	if(open(NUMBER,"${cLaA}2")) {
 		$num2 = <NUMBER>;
 	$gP = $num2 + 5 if $num2>1;
 		close(NUMBER);
 }
 }
 open(NUM,">$cLaA") || abmain::error('sys', "On writing file $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 open(NUM,">${cLaA}2") || abmain::error('sys', "On writing file $cLaA: $!");
 print NUM "$gP";
 close(NUM);
 $self->pG(1);
 return $gP;
}
1;
package lB;
use strict;

#IF_AUTO use AutoLoader 'AUTOLOAD';
#IF_AUTO use sVa;
use vars qw($AUTOLOAD $aZz %zW);

use vars qw(@mP @eK @dR $hA);
BEGIN{
use vars qw($mG @mfs @mfs2 $ablink);
use vars qw($pTz $pEz $pYz $oDz $oRz $pKz $FHASLNK $FHASALERT $FNOHTML $FTAKPRIVO $FFANCY);
($pTz, $pEz, $pYz, $oDz, $oRz, $pKz, $FHASLNK, $FHASALERT, $FNOHTML, $FTAKPRIVO, $FFANCY)=(1, 2, 4, 8, 16, 32, 64, 128, 256, 512);
$ablink=qq(c3160286275666d32286474707a3f2f2e656472657c616e236f6d6f216e69726f6162746f222e3c366f6e647023796a756d313e314e69724f6162746c3f266f6e647e3c3f216e3);
$mG =<<'XXY9';
M/&EM9R!B;W)D97(],"!W:61T:#TQ(&AE:6=H=#TQ('-R8STB:'1T<#HO+V%N
?>6)O87)D+FYE="]C9VDM8FEN+VQO9V]?<RYC9VDB/@``

XXY9

;

@mfs = qw(aK jE fI wW hC mM size pQ xE email eZz 
to mood tP rhost mtime scat track kRa attached_objtype attached_objid status rate cnt viscnt fpos readers sort_key key_words);
@mfs2 = qw(rlink_title img aliases body hack modifier);

@lB::msg_macs= qw(
MSG_STAT_TAG
MSG_MOOD
MSG_LINK
MSG_POSTER
MSG_ABS
MSG_NUMBER
MSG_FLAGS
MSG_RATE_LNK
MSG_READS
MSG_READ_STATUS
MSG_REPLY_CNT
MSG_SIZE
MSG_SPACER
MSG_TIME
);

}

#IF_AUTO 1;
#IF_AUTO __END__

sub new {
 my $type = shift;
 my $self = {};
 @{$self}{@mfs} = @_;
 $self->{jE} = 0 if ($self->{jE}||0) == ($self->{fI}||0);
 $self->{bE} = [];
 $self->{to}=~ s/^\s+//;
 $self->{to}=~ s/\s+$//;
 $self->{to}=~ s/^,+$//;
 return bless $self, $type;
}




sub qRa{
 my $self = shift;
 return $self->{to} ? 1:0;

}
sub nJa{
 my $self = shift;
 return join("\t", @{$self}{@mfs});
}
sub pOa {
	my ($self, $numgen, $jE, $aK, $cat) = @_;
 my $istop = $self->{fI} == $self->{aK};
	$self->{fI} = &$numgen();
 if ($aK==0) {
 	$self->{aK} = $self->{fI};
	}else {
 	$self->{aK} = $aK;
	}
 $self->{jE} = $jE;
 $self->{scat} = $cat if defined $cat; 
 my $chld;
	for $chld (@{$self->{bE}}) {
		$chld->pOa($numgen, $self->{fI}, $self->{aK}, $cat);
	}
}
sub nBa {
 my ($self, $iS)=@_;
 $self->{body} = $iS->gB($self->{fI});
 $self->{kRa} = $abmain::VERSION||8;
 $self->store($iS);

}

sub store{
 my ($self, $iS, $file)=@_;
 return $abmain::use_sql? $self->zPa($iS, $file): $self->zIa($iS, $file);
}

sub zPa{
 my ($self, $iS, $file)=@_;
 require zDa;
 require zGa;
 my $mpart = zDa->new('AbMsgPart');
 my $eS =  $iS->nDz('msglist'); 
 my ($p, $s) = @{$iS->dHaA($eS)};
 $mpart->sHa("where realm=? and msg_no=?", [$p, $self->{fI}]);
 $mpart->aTaA({
	rlink_title =>$self->{rlink_title},
	img => $self->{img},
	aliases =>$self->{aliases},
	body =>$self->{body},
	hack=>$self->{hack},
	modifier=>$self->{modifier},
	msg_no=>$self->{fI},
	realm=>$p,
 }
 );
 $mpart->tEa();
}

sub zIa{
 my ($self, $iS, $file)=@_;
 $file =$iS->gN($self->{fI}) if not $file;
 local *F;
 open F, ">$file" or abmain::error('sys', "On writing file $file: $!");;
 print F "AB8DF\n";
 my @fs = (@mfs, @mfs2);
 my $lRa = dZz->zVz("message_data");
 $lRa->hEa($self, \@fs);
 print F $lRa->bCa();
 close F;
 
}
sub load {
 my ($self, $iS, $conver, $file)=@_;
 return $abmain::use_sql? $self->zQa($iS, $conver, $file): $self->zLa($iS, $conver, $file);
}
 

sub zLa{
 my ($self, $iS, $conver, $file)=@_;
 $conver = 0 if $file;
 $file = $iS->gN($self->{fI}) if not $file;
 local *F;
 open F, "<$file" or return;
 my $line1 = <F>;
 chomp $line1;
 if($line1 !~ /^AB8DF/){
 close F;
	if($conver) {
		$self->nBa($iS);
		return $self->load($iS);
	}
 return;
 }
 my @gHz = <F>;
 close F;
 my $lRa = dZz->new(\@gHz);
 $lRa->parse();
 for my $f (@mfs, @mfs2) {
	$self->{$f} = $lRa->gVa($f);
 }
 return 8;

}

 
sub zQa{
 my ($self, $iS, $conver, $file)=@_;
 $conver = 0 if $file;
 require zDa;
 my $mpart = zDa->new('AbMsgPart');
 my $eS =  $iS->nDz('msglist'); 
 my ($p, $s) = @{$iS->dHaA($eS)};
 $mpart->aPaA("where realm =? and msg_no=?", [$p, $self->{fI}]);
 my $row = zGa->new($eS, {index=>2, schema=>"AbMsgList", paths=>$iS->dHaA($eS) })->kCa($self->{fI});

 @{$self}{@mfs} = @$row;
 for my $f (@mfs2) {
	my $k = lc($f);
	$self->{$f} = $mpart->{$k};
 }
 return 8;
}
sub nB {
 my ($self, $iS, $entry) = @_;
 return if $entry->{fI} <=0;
 if($iS->{flat_tree}) {
 	push @{$self->{bE}}, $entry;
	return;
 }
	
 my $aI = $iS->{dA}->{$entry->{jE}};
 my $try_grp = $iS->{yBz};

 if($iS->{allow_subcat} && ($entry->{scat} eq '') && $iS->{scat_fix} ne "") { 
		$entry->{scat} = $iS->{scat_fix};
 } 
 if(not $aI) {
 if($entry->{jE} ==0 || not $try_grp){
 $aI = $self;
 }else {
 $aI = $iS->pO($entry->{jE});
 if(not $aI) {
 	$aI = new lB($entry->{aK}, $entry->{aK}, $entry->{jE},
				 ($entry->{jE} == $entry->{aK})? $iS->{top_word}: $iS->{iVz}, "", $entry->{mM});
 }else {
		$aI->{jE} = $entry->{aK} if $aI->{jE} != 0;
		$aI->{aK} = $entry->{aK};
 }
	    $aI->{scat} = $entry->{scat} if not $aI->{scat};
	    $aI->{body} = undef;
 $iS->{dA}->{$entry->{jE}} = $aI;
	    $self->nB($iS, $aI);
 }
 }
 my $top = $iS->{dA}->{$entry->{aK}};
 if($aI) {
 		$aI->{yTz} = $entry->{mM} if  $entry->{mM} >0 && $entry->{mM} > ($aI->{yTz}||0);
 }
 if(defined $top) {
		$top->{tot} ||=0;
 		$top->{tot}++ if($entry->{aK} != $entry->{fI}); 
 		$top->{yTz} = $entry->{mM} if  $entry->{mM} >0 && $entry->{mM} > ($top->{yTz}||0);
		$top->{zCz} = (($top->{zCz}||0) * $top->{tot} + $entry->{mM})/($top->{tot}+1);
 }
 return if not $aI;
 return if ($aI->{fI}||0) == ($entry->{fI}||0);
 return if $aI->{fI} >= $entry->{fI};
 push @{$aI->{bE}}, $entry;
}
sub gKaA {
 my ($self, $iS,  $entry) = @_;
 return if $entry->{fI} <=0;
 if($iS->{allow_subcat} && (not defined($entry->{scat})) && $iS->{scat_fix} ne "") { 
		$entry->{scat} = $iS->{scat_fix};
 } 
 my $aI = $self;
 for( @{$aI->{bE}}) {
	if($_->{fI} eq $entry->{jE}) {
 		push @{$_->{bE}}, $entry;
		return;
	}
 }
 push @{$aI->{bE}}, $entry;
}
sub aI {
 my ($self, $iS) = @_;
 return $iS->{dA}->{$self->{jE}};
}
sub rQ {
 my ($self, $iS) = @_;
 return $iS->{dA}->{$self->{aK}};
}
sub nH {
 my ($self, $iS, $jK, $gV, $cG, $noredir, $forcepriv)=@_;



 my $in = $cG || $self->{fI};
 my $cLaA = $in;
 my $yYz=0;
 my $priv = $self->qRa()||$forcepriv;

 if($iS->{aO}) {
 $in = 0;
 	   $yYz=1;
 } elsif ($iS->{lJ} || $gV){
 $in = $self->{aK};
 	   $yYz=1;
 }
 my ($url, $tag);
 if($in >=0) {
 
 $tag = '#'.$cLaA;

 if ($jK == $in) {
	 return $tag;
 }

 if(($abmain::off_webroot || $iS->{allow_user_view} || $iS->{bMz} || $iS->{qKa} || $iS->{force_login_4read}) ||$iS->{dyna_forum} || $priv && not $noredir){
 $url = $iS->nGz($cLaA, $self->{aK}, $gV, $jK, $priv);
 }elsif($jK<0 || $iS->{mFa}) {
 $url = $iS->jA($in, "AB", $gV, $priv);
 }elsif($jK >0) {
 $url = $iS->jA($in, "jD", $gV, $priv);
 }
 elsif($jK == 0) {
 $url = $iS->jA($in, "kU", $gV, $priv);
 }
 $tag ="" if not $yYz;
 return $url.$tag;

 }else { ## this may never apply
 if(($iS->{bMz} || $iS->{qKa} || $iS->{allow_user_view} || $iS->{force_login_4read} || $iS->{dyna_forum} || $priv) && not $noredir){
 $url = $iS->nGz($cLaA, $self->{aK}, $gV, $jK, $priv);
 }
 if($jK ==0 ){
 $url = $iS->jA($cLaA, "kU", $gV, $priv);
 }
 elsif($jK >0) {
 $url = $iS->jA($cLaA, "jD", $gV, $priv);
 } 
 elsif($jK <0) {
 $url = $iS->jA($cLaA, 'AB', $gV, $priv);
 }
 return $url;
 }
}
sub vK {
 my ($self, $iS, $gV)=@_;



 my $in = $self->{fI};

 if($iS->{aO}) {
 $in = ($iS->{dyna_out}?-1: 0);
 } elsif ($iS->{lJ} || $gV){
 $in = ($iS->{iDa})? -1 : $self->{aK};
 }
 return $in;
}
sub jN {
 my $self = shift;
 my %fH = @_;






 my ($iS, $nA, $jK,  $hO, $gQ, $gV, $depth, $jAz, $iZz, $kQz, $pub) = 
 ($fH{iS}, $fH{nA}, $fH{jK}||0, $fH{hO}||0, 
	  $fH{gQ}||0, $fH{gV}||0, $fH{depth}||0, $fH{jAz}||0, $fH{iZz}||0, $fH{kQz}||"", $fH{pub});

 my ($selmak, $catjumper);
 $selmak = aLa::bYa(['scat', $iS->{scat_use_radio}?'radio':'select',  join("\n", $iS->{catopt}, $iS->{hBa})]) if $iS->{allow_subcat};
 $catjumper = $iS->oHa();

 $iS->hVz();
 my @uN=();
 my @gHz=();
 my $loop_cnt=0;
 my $top = $iS->{dA}->{$self->{aK}};
 my $max_loop = ($top->{tot} + scalar(@{$self->{bE}}) )* 10 + 1000;;
 $kQz = "" if $kQz eq '`';
 my $od = $iS->{dyna_forum};
 $iS->{dyna_forum} = 1 if $kQz;


#array elements: msgnode, level(depth), idx in the thread, tag
 my ($sw, $nw, $dw)= ($iS->{qLz}, $iS->{qMz}, $iS->{qPz});
 $sw = 'width="60%"' if not $sw;
 $nw = 'width="15%"' if not $nw;
 $dw = 'width="25%"' if not $dw;

 my ($bdcolor, $bdextpad, $bdinspace) = 
 ($iS->{bdcolor} ne "" ? qq( bgcolor="$iS->{bdcolor}") :" ", 
 qq(cellpadding="$iS->{bdsize}"), qq(cellspacing=$iS->{lZz})
 );
 print $nA sVa::gXaA();

 push @uN, [0, 0, 0, "</DIV>\n"];

 push @uN, [$self, $hO, 0, ""];

 push @uN, [0, 0, 0, qq(<DIV class="ABMSGLIST">\n)];

 my $msg_row_col_cnt;
 if($iS->{align_col_new}) {
	$msg_row_col_cnt++ while ($iS->{msg_row_layout} =~ m!/td>!gi);
 }
 $lB::sL= unpack("u*", $mG);
 my $vD;
 my $stack_log={};
 while($vD= pop @uN) {
 if( $loop_cnt++ >$max_loop ) {
 print STDERR join("-", caller)." exceeded $max_loop\n" if $loop_cnt++ >$max_loop;
	abmain::iUz(-2);
 }
 my $mtag = $vD->[3];
 
 if($mtag) {
 print $nA $mtag;
 next;
 }
 my $uL = $vD->[1];

#      next if ($uL > $depth && $depth>0);

 my $vH= $vD->[0];

 next if ($vH->{status} eq 'tmp' && not $gQ);
 next if $pub eq 'p' && $vH->{to} =~ /\S/;

 my $hA = $vD->[2];

 if($abmain::debug) {
 abmain::pEa("hO=$uL #=$vH->{fI}\n");
 } 

 if($vH->{fI} >0 ) {
	    last if $stack_log->{$vH->{fI}};
	    $stack_log->{$vH->{fI}}=1;
	    my $bc ="";
	    my $fc ="";
 my $in = $vH->vK($iS, $gV);
 my $dH = ($jK == $in && not $jAz);

 my $url = $vH->nH($iS, $jK, $gV);
 #next if((!$dH) && $jK > 0 && $jK != $vH->{fI} && $iS->{no_links_inmsg});

 my $gYz = ($vH->{xE}||0) & $oDz;

	    my %msg_hash = ();
	    my @print_buf=();

 my $wW = $vH->{wW};
 my $hC = $vH->{hC} || '&nbsp;';
 $wW = abmain::yDz($wW, $iS->{xVz}) if $iS->{xVz} >0 && $vH->{hC};
	    $iS->fZa(\$wW) if $iS->{kMa};
	    my $sfont = $iS->{_usr_subj_fonts}->{lc($hC)};

 if($sfont) {
		$wW = qq(<font $sfont>$wW</font>);
 }else {
 	$wW = $iS->fGz($wW, $vH->{fI} == $vH->{aK}? 'topic_font': 'eSz');
	    }
 my $nc =  $vH->{hC} && $vH->{size} ==0 && not ($vH->{tP} || $vH->{eZz} || ($vH->{xE} & $pTz) );
 my $nolink = $nc && $uL > 1 && $jK <=0 && $iS->{nolink_nt};

 #my $hC = ($kQz && $vH->{hC} eq $kQz)? "To $vH->{to}" : $vH->{hC};
	    my $pfont = $iS->{_usr_fonts}->{lc($hC)};
 if($pfont) {
		$hC ="<font $pfont>$hC</font>";
 } 
 elsif(lc($hC) eq lc($iS->{admin})) { 
 $hC = $iS->fGz($hC, 'cRz');
 }elsif($iS->{moders}->{$hC}) { 
 $hC = $iS->fGz($hC, 'moder_font');
 }else { 
 $hC = $iS->fGz($hC, $gYz?'reg_author_font':'fEz');
 }
 my $wU=""; 
	    $wU = $iS->{gPz} if ($iS->{gSz} && $gYz);

 my $tf='LONG';
 if($iS->{posix_date}) {
		 $tf = 'POSIX';
 }elsif($iS->{day_date}) {
	         $tf='DAY';
 }elsif($iS->{bKz}) {
 $tf = 'SHORT';
 }elsif($iS->{jCa}) {
 $tf = 'STD';
 }
 my $pt = $iS->fGz(abmain::dU($tf, $vH->{mM}, 'oP', $iS->{posix_df}), 'fCz');
	    #$pt = qq!<script>document.write(unix_date_conv($vH->{mM}));</script><noscript>$pt</noscript>!;

 if($iS->{bOz}) {
 $wW = "<b>$wW</b>";
 }

	    $msg_hash{MSG_SUBJECT} = $wW;

	    if(time() < ($vH->{mtime}||0) + 60*$iS->{kF} ) {
	            $pt = qq(<font color="$iS->{mod_msg_color}"><b>). "$pt". qq(</b></font>);
 } elsif(time() < $vH->{mM} + 60*$iS->{kF} ) {
	            $pt = qq(<font color="$iS->{new_msg_color}"><b>). "$pt". qq(</b></font>);
	    }else {
	         #   $pt = qq(<i>). "$pt". qq(</i>); #let's don't do this
	    }
 
 $msg_hash{MSG_TIME} = $pt;

	    my $yD = $vH->{tot} || @{$vH->{bE}};
	    my $dF="";
 if ($iS->{bJz} && $yD > 0) {
 	$dF = " +$yD $iS->{fc_tag}";
 $dF = $iS->fGz($dF, 'followcnt_font');
 }
 $msg_hash{MSG_REPLY_CNT} = $yD;

	   my @mtags = ();
 if($iS->{xJ} && ($vH->{xE} || 0) & $pTz) {
 $dF = "$iS->{bQz} $dF";
		    push @mtags, $iS->{bQz};
 }
 if($iS->{show_has_attach} && $vH->{eZz} ne "") {
 $dF = "$iS->{attach_tag_word} $dF";
		   push @mtags, $iS->{attach_tag_word};
 }
 if($iS->{show_has_lnk} && ($vH->{xE} ||0) & $FHASLNK) {
 $dF = "$iS->{lnk_tag_word} $dF";
		   push @mtags, $iS->{lnk_tag_word};
 }
	
 my @rata = (); 
	   if(not $abmain::use_sql) {
	   	@rata= split /\t/, $iS->{ratings2}->{$vH->{fI}} if $iS->{ratings2}->{$vH->{fI}};
	   }else {
		my $msg = $vH;
	   	@rata= ($msg->{rate}, $msg->{cnt}, $msg->{viscnt}, $msg->{fpos}, undef, $msg->{readers});
 }
 $iS->{aSz}->{$vH->{fI}}->[3] = $rata[3];
 $vH->{yTz} ||=0;
	   if((not $gV) && $iS->{collapse_age}>0 && $vH->{yTz} > 0 && time() - $vH->{yTz} > 3600*$iS->{collapse_age}) {
 	$iS->{aSz}->{$vH->{fI}}->[3] |= 1;
	   }
		
 if($yD >0 && ($iS->{aSz}->{$vH->{fI}}->[3] || 0) & 1 && $jK ==0 && $uL >0) {
 	$dF = "$iS->{aUa} $dF";
			push @mtags, $iS->{aUa};
	   }

 if($iS->{rM}) {
 my $eUz = $iS->fGz(sVa::fWaA($vH->{size}), 'eVz');
	           $dF = "$iS->{dsz_sep} $eUz $iS->{szo_sep} $dF";
		   $msg_hash{MSG_SIZE} = $eUz;
 }

 if($iS->{bMz} && !$gV && $jK <= 0) {
 my $reads =$rata[2] || 0;
 my $fAz = "$reads reads";
 if($reads > $iS->{fFz}) {
 $fAz = "<font color=red>$fAz</font>";
 }
	           $fAz =  $iS->fGz($fAz, 'eTz');
	           $dF = "(". $fAz. ") $dF";
 $msg_hash{MSG_READS} = $fAz;
 }

 if($gQ && $vH->{to}) {
 $dF .= "<font color=red>Private</font>";
		   push @mtags, "<font color=red>Private</font>";
 }

	   my $readtag = ""; 
 if($vH->{to}) {
		if(jW::sFa($rata[5], $iS->{fTz}->{name}) || lc($vH->{to}) eq lc($iS->{fTz}->{name})) {
			$readtag=$iS->{old_word};
		}else {
	   		$readtag= $iS->{notread_word};
		}
 }
 my $rateinsubj="";
 if($iS->{zP} && $jK <=0 ) {
 my $rat = $rata[0]; 
 $dF .= qq(\&nbsp;) x 2;
 my $raturl = qq($iS->{cgi}?@{[$abmain::cZa]}cmd=zT;cG=$vH->{fI};rate=$rat);
 my $rattag="";
		   my $tit;
 my $rcnt = $rata[1] ||0;
 if( $rcnt >= $iS->{bLz}) { 
 next if $rata[0] < $iS->{min_rate} && $rcnt > $iS->{rYz} && not $gQ;
 	if (int $rata[0] > 0){ 
 		$rattag = "$iS->{aPz}" x int ($rata[0] + $iS->{rTz}); 
 }else {
 		$rattag .= "$iS->{minus_word}" x int (0 - $rata[0] + $iS->{rTz}); 
 }
 }else {
 $rattag ="$iS->{zQ}" if $iS->{show_rate_link_main};
 }
 $tit = "Number of times rated: $rcnt" if $rcnt>0; 
 if ($iS->{show_rate_link_main}){
		       $msg_hash{MSG_RATE_LNK} = abmain::cUz($raturl, $rattag, undef, qq(title="$tit") );
 if($iS->{dAa} ) {
			        $rateinsubj ="\&nbsp;\&nbsp;".$msg_hash{MSG_RATE_LNK};
 }else {
 		$dF .= $msg_hash{MSG_RATE_LNK};
			}
 }else {
 if($iS->{dAa} ) {
			  $rateinsubj = '&nbsp;&nbsp;'.$rattag;
 }else {
 	  $dF .= $rattag;
 }
		       $msg_hash{MSG_RATE_LNK} = qq(<span class="MsgRating" title="$tit">$rattag</span>);
 }
 }
	   $dF .= $readtag;

 $msg_hash{MSG_READ_STATUS} = $readtag;
	   $msg_hash{MSG_AUTHOR_REGSTAT} = $wU;
			

#should be ( $uL>1 && (!$dH || $iS->{mJ}));  

 my ($tdins0, $tdins1, $tdins2, $tdins3)=('', '','','');
 ($tdins0, $tdins1, $tdins2, $tdins3)=("<tr><td $sw>", qq(</td><td $nw>), 
 qq(</td><td $dw>), "</td></tr>\n") if $iS->{mAz};

 if($uL ==1) {
 $tdins0="";
 $tdins3="";
 }

 $iS->{lVz} = 1 if ($iS->{mAz} || $iS->{align_col_new});
 push @print_buf,  $tdins0 if $iS->{mAz} && $uL >0;

 if ( $uL>1 && !($dH && !$iS->{mJ}) && !$iS->{fW}){
 if($iS->{lVz} ) {
 $msg_hash{MSG_SPACER}=  $iS->{lUz} x ($uL-1);
 push @print_buf,  $msg_hash{MSG_SPACER};
 }else {
 	     if (not $iS->{no_li}){  
 	      $msg_hash{MSG_SPACER} = "<li>";  
 push @print_buf,  $msg_hash{MSG_SPACER};
		     }
 }
 }
 
 my $row_cls;

	   my $thr_closed = $rata[3] & 2;

 if($uL==1) {
		  my $po =$hA%2;
		  $bc =$mP[$po];
		  $fc =$eK[$po];
		  $row_cls = ('ThreadRow0', 'ThreadRow1')[$po];
 push @print_buf,   qq(<tr class="$row_cls" );
		  push @print_buf,   qq(bgcolor="$bc" ) if $bc;
 $sw = 'width="100%"' if not $iS->{mAz};
 if($vH->{fI} == $vH->{aK}) {
		      if($thr_closed) {
		  	push @print_buf,   "><td $sw>$iS->{closed_tag}" ;
			$msg_hash{MSG_STAT_TAG} = $iS->{closed_tag};
		      }else {
		  	push @print_buf,   "><td $sw>$iS->{topic_tag}" ;
			$msg_hash{MSG_STAT_TAG} = $iS->{topic_tag};
 }
 }else {
		  	push @print_buf,   "><td $sw>";
 if($iS->{hSa}) {
			  $msg_hash{MSG_STAT_TAG} = abmain::cUz($iS->nGz($vH->{aK}, $vH->{aK}, $gV, $jK, $vH->qRa()), $iS->{sub_topic_tag});
			  push @print_buf,  $msg_hash{MSG_STAT_TAG};
 }else {
 push @print_buf,  $iS->{sub_topic_tag};
			  $msg_hash{MSG_STAT_TAG} = $iS->{sub_topic_tag};
 }
 }
		  push @print_buf,   qq(<font color="$fc"> ) if $fc && $jK != $in;
 }
	    my $del_chk="";
	    my $here_mark="";
	    if($gQ) {
	         $del_chk =   qq!<input type="checkbox" name="fJ" value="$vH->{fI} $vH->{aK}" title="$vH->{fI}">!;
	         push @print_buf,  $del_chk;
	    }

	    if( $iS->{link_edit} && ($iS->{rL} || $iS->{allow_usr_collapse}) && !$gV &&(!$iS->{gZz} || $gYz)) {
	              $hC = abmain::cUz("$iS->{cgi}?@{[$abmain::cZa]}cmd=rA;cG=$vH->{fI}", $hC, undef, $iS->{xXz});
	    }
 if($gQ) {
 $hC .= " \&nbsp;[". abmain::pT($vH->{pQ})." ". $vH->{rhost}. " <font size=1 color=#006600>".$vH->{track}."</font>]";
 }

 my $mood="";
 $mood = $iS->{$vH->{mood}} if $vH->{mood};
	    if(($vH->{size}||0)<0) {

	    }
	    elsif($dH) {

#not used
	    }else {  ## not inline text
		
 my $abs = "";
 if($vH->{fI} == $vH->{aK} && $iS->{top_abstract_len} > 40){
		    my $text= $iS->gB($vH->{fI});
		    $text =~ s/&nbsp;/ /gi;
		    $text =~ s!<br>|<p>!\n!gi;
 $text =~ s/<[^>]*>//gs;         
 $text =~ s/<//g;          
		    $abs = substr $text, 0, $iS->{top_abstract_len};
 	            if($iS->{auto_href_abs}) {
 		&jW::jEz(\$abs, $iS->{xZz});
 }
		
		    
		    if(length($abs)>10) {
		    	$abs = $iS->fGz($abs, 'abs_font');
			if($iS->{read_more_abs}) {
	                 	  my $lnk= abmain::cUz($url, $iS->{read_more_word}, undef,  $iS->{xYz});
				  $abs .= " ($lnk)";
			}
		    	$abs = $iS->{abs_begin}.$abs.$iS->{abs_end};
			$msg_hash{MSG_ABS} = $abs;
 }
		 }
 if($iS->{show_msgnos4sub} || ($vH->{fI} == $vH->{aK} && $iS->{show_msgnos4top})) {
 	push @print_buf,  "<b>$vH->{fI}</b>\&nbsp;\&nbsp;";
			$msg_hash{MSG_NUMBER} = $vH->{fI};
		 }
 if($vH->{fI} == $iZz ) {
			$here_mark =  $iS->{jRz};
 	push @print_buf,  $here_mark;
		 }
 push @print_buf,  "<!--$vH->{fI}-->" if($iZz eq 'HERETMP');
 push @print_buf,  qq(<a name="L$vH->{fI}"></a>);

		 $msg_hash{MSG_MOOD} = $mood;

 if($nolink) {
 	push @print_buf,   "$mood  $wW ", abmain::cUz($url, $iS->{nt_word}, undef,  $iS->{xYz}), $rateinsubj;
			$msg_hash{MSG_LINK} = "$wW ". abmain::cUz($url, $iS->{nt_word}, undef,  $iS->{xYz}). $rateinsubj;
 }else {
 	push @print_buf,   "$mood  <a $iS->{xYz} href=\"$url\">$wW</a>", $rateinsubj;
 push @print_buf,   " $iS->{nt_word}" if $nc;
 if($vH->{fI} == $iZz  && $iS->{nolink_here}) {
			$msg_hash{MSG_LINK} = "<b>".$wW."</b>";
 }else {
			$msg_hash{MSG_LINK} = "<a $iS->{xYz} href=\"$url\">$wW</a>". $rateinsubj;
			$msg_hash{MSG_LINK} .= " $iS->{nt_word}" if $nc;
		     }
 }
		 if ($iS->{no_show_poster}) {
		 	$hC = $wU = undef ;
			$msg_hash{MSG_POSTER} = undef;
 }else {
			$msg_hash{MSG_POSTER} = "<b>$hC</b> $wU";
		 }
		 if ($iS->{no_show_time}) {;
		 	$pt = $dF = "";
			$msg_hash{MSG_TIME} ="";
		 }
		 $msg_hash{MSG_FLAGS} = join(" ", @mtags);
 push @print_buf,   $iS->{sn_sep} if not $iS->{mAz};
 push @print_buf,   "<br>$abs" if $iS->{mAz};
 push @print_buf,  "$tdins1<b>$hC </b> $wU $tdins2 $iS->{nd_sep} $pt $iS->{ds_sep} $dF $tdins3\n";
		 push @print_buf,  "<br>$abs" if $abs && not $iS->{mAz};
 if ( ($iS->{fW} || $iS->{lVz} || $iS->{no_li}) && not $iS->{mAz} ) {
 	push @print_buf,   "<br>";
		 }
	      }

	      if($dH && $vH->{size}>=0) {
 if($vH->load($iS,1)) {
 	     my $mf;
	    	     if ($gYz ) {
	    	            $mf = $iS->{gKa}->{$vH->{hC}} || $iS->gXa($vH->{hC});
	    		    $iS->{gKa}->{$vH->{hC}} = $mf if not $iS->{gKa}->{$vH->{hC}};	
 	     }
 push @print_buf,   qq(<a name="$vH->{fI}"></a>\n);
 push @print_buf,  $iS->oOa($vH, $jK, $gV, $mf, $kQz); 
		     $vH->{body} = undef;
 } 
 }
	      if ($uL==1) {
		push @print_buf,   qq(</font> ) if ($fc && !$iS->{fW} && $jK != $in);
 	push @print_buf,   "</td></tr>\n";  
	      }
	      if($iS->{align_col_new} && not $dH) {
		if($del_chk) {
			$msg_hash{MSG_LINK} = $del_chk . $msg_hash{MSG_LINK};
		}
		if($here_mark) {
			$msg_hash{MSG_LINK} = $here_mark. $msg_hash{MSG_LINK};
		}
		my $layout = $iS->{msg_row_layout};
 		my $l = jW::mTa($layout, \@lB::msg_macs, \%msg_hash);
		my $po =  $hA%2;
		my $cls ;
		my $col;
		if($uL ==1) {
			$cls = ('ThreadRow0', 'ThreadRow1') [$po];
			$col = $mP[$po];
		}else{
			$cls = ('ThreadFollow0', 'ThreadFollow1') [$po];
			$col = $dR[$po];
		}
		my $cs;
		$cs = " bgcolor=$col" if($col);
		print $nA qq(<tr $cs class="$cls">$l</tr>\n);
			
	      }else {
	      	print $nA @print_buf;
	      }

 }  



 if ($jK > 0  && $jK == $vH->{fI} &&  $iS->{no_links_inmsg} ){
		next;
 }

 my $fpos = $iS->{aSz}->{$vH->{fI}}->[3] || 0;
 next if $jK ==0 && $fpos & 1;

 my $nM = 0;
 $nM = @{$vH->{bE}} if ref($vH->{bE});

 next if $nM <=0;



 if ($uL==0){
 if ($jK > 0  && ($iS->{lJ} || not $iS->{no_links_inmsg})){

 
 print $nA  qq(<div style="margin-left:10px">\n) if $iS->{xP};
 print $nA  $iS->{qE}, "\n";

	       print $nA  qq(\n<table width=$iS->{cYz} border="0" $bdcolor $bdextpad cellspacing=0><tr><td>\n);
	       print $nA  qq(<table width=100% border="0" cellpadding=$iS->{padsize} $bdinspace class="MsgFollowups");
 if ($iS->{follow_bg}) {
 	  print $nA  qq(bgcolor="$iS->{follow_bg}");
 }elsif ($bdcolor){
 print $nA  qq(bgcolor="#ffffff");
 }
 print $nA  qq( border="0" name=fl>);
 push @uN, [0, $uL, $hA, "</table>\n"];
 push @uN, [0, $uL, $hA, "</td></tr></table>\n"];
 
 push @uN, [0, $uL, $hA, "</div>\n"] if $iS->{xP};
	   $uL ++;
 
 }else {
	  if($iS->{align_col_new}  && not $iS->{aO}) {
	    print $nA qq(<table width="$iS->{cYz}" cellspacing=1 cellpadding="$iS->{padsize}" $bdcolor class="MsgListTable">);
	    if($iS->{msg_row_header}) {
		print $nA qq(\n<tr class="MsgRowHeader">$iS->{msg_row_header}</tr>\n);
	    }
	    if($iS->{msg_row_header_bottom} && $iS->{msg_row_header}) {
	       unshift @uN, [0,0,0, qq(\n<tr class="MsgRowHeaderBottom">$iS->{msg_row_header}</tr>\n)];
	    }
	    unshift @uN, [0,0,0, "\n</table>\n"];
 }

 }
 }

 # this is for the followup links
 if($uL ==1 ) {
		if(not ($iS->{mAz} || $iS->{align_col_new}) ) {
 print $nA  "<tr><td>\n";
 push @uN, [0, $uL, $hA, "</td></tr>\n"] ;
	        }	
 }

 my $nS = ($iS->{aO} && !$iS->{mJ})||
			   ($iS->{lJ} && $jK == $vH->{aK} && !$iS->{mJ}) || 
 $iS->{fW};

 my $ultype = "";
 $ultype=" type=square" if $iS->{use_square};
 if ($uL && !$nS) {
 print $nA  "\t" x $hO, "<ul$ultype>\n" if not $iS->{lVz};
 push @uN, [0, $uL, $hA, "</ul>\n"] if not $iS->{lVz};
 }
 my $me;
 my @lXz=();
 next if $iS->{no_links_inmsg} && $uL >=0 && $jK >0;
 
 
 if($uL==0) {
 my @yWz = @{$vH->{bE}};
 my $sort_func;
		if($iS->{yVz} eq 'mM') {
		   if ($iS->{allow_subcat} && $iS->{grp_subcat}) {
			@yWz = sort { $b->{scat} cmp $a->{scat} or 
				        ($iS->{revlist_topic}? $b->{mM}<=>$a->{mM}: $a->{mM} <=> $b->{mM}) 
 } @yWz ;
 }else {
			@yWz = sort {  ($iS->{revlist_topic}? $b->{mM}<=>$a->{mM}: $a->{mM} <=> $b->{mM}) 
					} @yWz;

 }
			@{$vH->{bE}}= @yWz;
		
		}else {
			for my $chld (@yWz) {
				$chld->{yTz} = 1 if $chld->{yTz} <=0;
			}
 if($iS->{yVz} eq 'yTz' ||$iS->{yVz} eq 'zCz' || $iS->{yVz} eq 'size' || $iS->{yVz} eq 'fI') {
 if($iS->{allow_subcat} && $iS->{grp_subcat}) {
					@yWz = sort {$b->{scat} cmp $a->{scat} or
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} <=> $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} <=> $b->{$iS->{yVz}}
 )
 } @yWz;
				}else {
					@yWz = sort {
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} <=> $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} <=> $b->{$iS->{yVz}}
 )
 } @yWz;
				}
			}else{
 if($iS->{allow_subcat} && $iS->{grp_subcat}) {
					@yWz = sort {$b->{scat} cmp $a->{scat} or
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} cmp $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} cmp $b->{$iS->{yVz}}
 )
 } @yWz;
				}else {
					@yWz = sort {
					   	       ($iS->{revlist_topic}?
 	           		$b->{$iS->{yVz}} cmp $a->{$iS->{yVz}}:
 	           		$a->{$iS->{yVz}} cmp $b->{$iS->{yVz}}
 )
 } @yWz;
				}
 }
			@{$vH->{bE}}= @yWz;
 }
 }
		
 my $shown_cat=0;
 my $scatname="";
 my $scatjump="";
 my $catlab="";
 my $scat="";
 my $cat="";
 
 next if ($uL >= $depth && $depth>0 && not $vH->{_expand});

 foreach $me (@{$vH->{bE}}) {
 next if ($me->{fI}||0) == ($vH->{fI}||0);
	      if($uL ==0) {
		    $catlab ="";
		    my $scatn="";
		    $scatn = $selmak->bDa($me->{scat}) if $selmak;
 my $catjump = $catjumper->($me->{scat});
 $cat= $me->{scat};
		    if($scatn ne $scatname) {
 if ($scatname) {
			    if($iS->{align_col_new} && not $iS->{aO}) {
				my $csp1 = int( $msg_row_col_cnt /2) || $msg_row_col_cnt;
				my $csp2 = $msg_row_col_cnt - $csp1;
 	$catlab=qq(\n<tr $iS->{scat_tb_attr}><td colspan="$csp1"><a name="cat$scat"></a><font $iS->{scat_font}>$scatname</font></td>);
				if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right" colspan="$csp2"> Go to $scatjump</td></form>) if $csp2>0;
				}else {
				  $catlab .= qq(<td align="right" colspan="$csp2"> &nbsp; </td>) if $csp2>0;
				}
 $catlab .=qq(</tr>\n);

 }else {
 	$catlab=qq(<a name="cat$scat"></a><table width="$iS->{cYz}" cellspacing="0" $iS->{scat_tb_attr}><tr><td><font $iS->{scat_font}>$scatname</font></td>);
				if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right"> Go to $scatjump</td></form>);
				}
 $catlab .=qq(</tr></table>);
			    }
 }
			$shown_cat = $scatname;
			$scatname = $scatn;
			$scatjump = $catjump;
			$scat = $cat;
		    }
 my $po = $hA%2;
 my $col=$dR[$po];
		    my $cls = ('ThreadTable0', 'ThreadTable1')[$po];
 my $str =qq(<table width="$iS->{cYz}" cellspacing=0 $bdextpad $bdcolor><tr><td>);
 $str .=qq(<table width="100%" $bdinspace cellpadding=$iS->{padsize} class="$cls" );
 $str .= qq(bgcolor="$col" ) if $col;
 $str .= " name=om>\n";
		    my $banner="";
 if($iS->{banner_freq}>0 && ($hA % $iS->{banner_freq}) ==0 && $hA >0) {
			$banner = abmain::mNa(time());
 }
 if(($me->{fI}==$me->{aK} || !$iS->{sub_top_bottom})) {
 	push @uN, [0, $uL, $hA, $catlab] if ($catlab && $iS->{grp_subcat});
 	push @uN, [0, $uL, $hA, $iS->{rP}] if $iS->{rP};
			if ($banner ) {
				if(not $iS->{align_col_new}) {
					push @uN, [0, $uL, $hA, $banner];
				}else{
					push @uN, [0, $uL, $hA, qq(<tr><td colspan="$msg_row_col_cnt">$banner</td></tr>)];
				}
			}
 	push @uN, [0, $uL, $hA, "</table></td></tr></table>\n"] if not ($iS->{align_col_new} && not $iS->{aO});
 	push @uN, [$me, $uL+1, $hA];
 	push @uN, [0, $uL, $hA, $str] if ($iS->{aO} || not $iS->{align_col_new});
 	$hA++;
 }else {
 	unshift @uN, [0, $uL, $hA, $str] if ($iS->{aO} || not $iS->{align_col_new});
 	unshift @uN, [$me, $uL+1, $hA];
 	unshift @uN, [0, $uL, $hA, "</table></td></tr></table>\n"] if not ($iS->{align_col_new} && not $iS->{aO});

			if ($banner) {
				if(not $iS->{align_col_new}) {
					unshift @uN, [0, $uL, $hA, $banner];
				}else {
					unshift @uN, [0, $uL, $hA, qq(<tr><td colspan="$msg_row_col_cnt">$banner</td></tr>)];
				}
			}

 	unshift @uN, [0, $uL, $hA, $iS->{rP}] if $iS->{rP};
 	unshift @uN, [0, $uL, $hA, $catlab] if ($catlab && $iS->{grp_subcat});
 	$hA++;
 }
 next;
	      }
 next if not $lB::sL;  
 if($iS->{revlist_reply}) {
 unshift @lXz, [$me, $uL+1, $hA];
 }else {
 push @uN, [$me, $uL+1, $hA];
 }
 }
 if($uL==0 && $scatname && $shown_cat ne $scatname) {
		if($iS->{aO} || not $iS->{align_col_new} ) {
 	$catlab=qq(\n<a name="cat$cat"></a><table width="$iS->{cYz}" cellspacing="0" $iS->{scat_tb_attr}><tr><td><font $iS->{scat_font}>$scatname</font></td>);
			if($iS->{show_cat_jump} && not $gQ) {
				  $catlab .= qq(<form><td align="right"> Go to $scatjump</td></form>);
			}
 $catlab .=qq(</tr></table>\n) ;
		}else {
			my $csp1 = int( $msg_row_col_cnt /2) || $msg_row_col_cnt;
			my $csp2 = $msg_row_col_cnt - $csp1;
 		$catlab=qq(\n<tr $iS->{scat_tb_attr}><td colspan="$csp1"><a name="cat$cat"></a><font $iS->{scat_font}>$scatname</font></td>);
			if($iS->{show_cat_jump} && not $gQ) {
			  $catlab .= qq(<form><td align="right" colspan="$csp2"> Go to $scatjump</td></form>) if $csp2>0;
			}else {
				  $catlab .= qq(<td align="right" colspan="$csp2"> &nbsp; </td>) if $csp2>0;
			}
 $catlab .=qq(</tr>\n);
		}
 push @uN, [0, $uL, $hA, $catlab] if $iS->{grp_subcat};
 }
 push @uN, @lXz if @lXz;
 }
 $iS->{dyna_forum} = $od;
}
1;

package WWWB2AB;

use strict;

#This program converts WWWBoard to AnyBoard
# see http://netbula.com/anyboard/abformat.html

use vars qw(%mons %days_cnt @mfs @mfs2 %proced $ABDir $wwwboard_dir);

%mons =
 ('Jan',1,'Feb',2,'Mar',3,'Apr',4,'May',5,'Jun',6,
 'Jul',7,'Aug',8,'Sep',9,'Oct',10,'Nov',11,'Dec',12);
%days_cnt =
 (1,0,2,31,3,59,4,90,5,120,6,151,7,181,
 8,212,9,243,10,273,11,304,12,334);

@mfs = qw(aK jE fI wW hC mM size pQ xE email eZz 
	to mood tP rhost mtime scat track kRa attached_objtype attached_objid status rate cnt viscnt fpos readers sort_key key_words);
@mfs2 = qw(rlink_title img aliases body hack modifier);

%proced=();
sub convert_wwwforum{
	my ($w3bmdir, $abdir) = @_;
	$wwwboard_dir = $w3bmdir;
	$ABDir = $abdir;

	print "Content-type: text/html\n\n";
	print "<html><body><pre>";

	print "\nConverting Messages in $wwwboard_dir....\n";

	unlink "$ABDir/.msglist"; #let's delete the old index file

	if(not opendir (MESSAGES,$wwwboard_dir)) {
		 print "Error: Can't open $wwwboard_dir:$!\n";
		 return 0;
		 
	}
	my @messages = readdir (MESSAGES);
	closedir (MESSAGES);
	my @mnos;
	foreach my $message (@messages) {
		$message =~ /(\d+)\.(\w+)$/;
		my $cG = $1;
		my $ext = $2;
		push @mnos, [$cG, $ext];
	}
	for my $mref (sort {$a->[0] <=> $b->[0]} @mnos) {
		my ($cG, $ext) = ($mref->[0], $mref->[1]);
		next if $proced{$cG};
		convert_msg($cG,0,$ext);
	}
	print "\nFinished conversion: now AnyBoard will regenerate the forum, this may take a while \n";
	print "</pre>\n";
	return 1 if scalar(@mnos);
}

#The function below takes a hash which contains the message fields

sub write_ab_msg{
 my %msg = @_;
 return if not $msg{fI}; #error, missing sequence number
 return if not $msg{aK};  #error, missing top sequence number
 local *INDEX;
 local *MSGDAT;
 open INDEX, ">>$ABDir/.msglist"; #append to index
 for(@mfs) {
	$msg{$_} =~ s/(\t|\n)/ /g; #make sure we don't have tabs in original data
 }
 print INDEX join("\t", @msg{@mfs}), "\n";
 close INDEX;

 my $df= "$ABDir/postdata/".$msg{fI}.".dat";
 open MSGDAT, ">$df" or die "Can't open file $df:$!";
 print MSGDAT "AB8DF\n";
 my $Bound="WWWCONV_SAGGSAGSAHAOSOSIQ".time().rand(); #just some random string
 $Bound =~ s/\.//g;
 print MSGDAT 
 "Content-type: multipart/form-data; boundary=$Bound\n",
 "Content-disposition: form-data; name=message_data$msg{fI}\n\n";
 for(@mfs, @mfs2) {
	print MSGDAT "--$Bound\n";
	print MSGDAT "Content-disposition: form-data; name=$_\n",
 "Content-type: text/plain\n\n";
 print MSGDAT $msg{$_}, "\n";
 }
 print MSGDAT "--$Bound--\n";
 close MSGDAT;
 print "wrote message $msg{fI}\n";
}



sub convert_msg{
 my ($msg, $top, $w3b_ext) = @_;
 $proced{$msg} = 1;
	local *FILE;
	if(not open (FILE, "$wwwboard_dir/$msg.$w3b_ext")) {
		print "Can't open file: $wwwboard_dir/$msg.$w3b_ext: $!\n";

 }
	my @file = <FILE>;
	close (FILE);
	my $title = "";
	my $hC = "";
	my $email = "";
	my $date = "";
	my $body = "";
	my $jE = 0;
	my @followups;
	my $textarea = 0;
 my $see_author=0;
	foreach my $line (@file) {
		if ($textarea == 0) {
			if ($line =~ /<title>(.*)<\/title>/i) {
				$title = $1;
			}
			elsif
			  (($line =~
			  /Posted by <a href="mailto:(.*)">(.*)<\/a> \(.*\)/i)
			  || ($line =~
			  /Posted by <a href="mailto:(.*)">(.*)<\/a>/i)) {
				$email = $1;
				$hC = $2;
				$see_author=1;
			}
			elsif
			  (($line =~ /Posted by (.*) \(.*\)/i)
			  || ($line =~ /Posted by (.*)/i)) {
				$hC = $1;
				$date = $2;
				$see_author=1;
			}
			if($see_author==1 && $line =~ /on (.*):<p>/i) {
				$date = $1;
				$textarea = 1;
				$see_author =2;
 }
			next;
		}
		elsif ($textarea == 1) {
			if ($line =~ /In Reply to: <a\s+href="(\d+).$w3b_ext">/i) {
				$jE = $1;
				if($top ==0 && $jE){
					print "trying to do non-top $msg\n";
					return;
				}
			}
			elsif ($line =~ /<a name="followups">/i) {
				$textarea = 2;
			}
			else {
				$body = $body.$line;
			}
			next;
		}
		elsif ($textarea == 2) {
			if ($line =~ /<a\s+href="(\d+).$w3b_ext">/i) {
				push (@followups,$1);
			}
			elsif ($line =~ /<a name="postfp">/i) {
				last;
			}
			next;
		}
	}
 if($top==0 && not $jE){
		$top = $msg;
 }
	return unless ($title);

	if ($date =~ /(\w*) (\d*), (\d*) at (\d*):(\d*):(\d*)/) {
		my $mon = $1;
		my $nQ = int($2);
		my $year = int($3);
		my $hour = int($4);
		my $min = int($5);
		my $sec = int($6);
		if ($year > 19000) { $year -= 17100; }
		$year -= 1900;
		$mon = substr($mon,0,3);
		$mon = int($mons{$mon});
		my $mdays = (($year-69)*365)+(int(($year-69)/4));
		$mdays += $days_cnt{$mon};
		if ((int(($year-68)/4) eq (($year-68)/4)) && ($mon>2)) { $mdays++; }
		$mdays += $nQ;
		$mdays -= 366;
		$date = ($mdays*86400)+18000;
		my $dsthour = (localtime($date))[2];
		if ($dsthour>0) { $date-=3600; }
		$date += ($hour*3600);
		$date += ($min*60);
		$date += $sec;
 }
 write_ab_msg(
		aK=>$top, jE=>$jE,
 		 fI=>$msg, wW=>$title,
 		 hC=>$hC, email=>$email,
			mM=>$date, body=>$body, size=>length($body)
 );
 return if $jE;
 print "Converting followups: ", join(" ", @followups),"\n" if @followups;
 for(@followups) {
	#recurse to followups
	convert_msg($_, $top, $w3b_ext);
 }
}

1;
package Tar;

use strict;
use Carp;
use Cwd;
use File::Basename;

BEGIN {
 # This bit is straight from the manpages
 use Exporter ();
 use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $symlinks $compression $has_getpwuid $has_getgrgid);

 $VERSION = 0.072;
 @ISA = qw(Exporter);
 @EXPORT = qw ();
 %EXPORT_TAGS = ();
 @EXPORT_OK = ();

 # The following bit is not straight from the manpages
 # Check if symbolic links are available
 $symlinks = 1;
 eval { $_ = readlink $0; };	# Pointless assigment to make -w shut up
 if ($@) {
	#warn "Symbolic links not available.\n";
	$symlinks = undef;
 }
 # Check if Compress::Zlib is available
 $compression = 1;
 eval {require Compress::Zlib;};
 if ($@) {
	#warn "Compression not available.\n";
	$compression = undef;
 }
 # Check for get* (they don't exist on WinNT)
 eval {$_=getpwuid(0)}; # Pointless assigment to make -w shut up
 $has_getpwuid = !$@;
 eval {$_=getgrgid(0)}; # Pointless assigment to make -w shut up
 $has_getgrgid = !$@;
}

use vars qw(@EXPORT_OK $tar_unpack_header $tar_header_length $error);

$tar_unpack_header 
 ='A100 A8 A8 A8 A12 A12 A8 A1 A100 A6 A2 A32 A32 A8 A8 A155';
$tar_header_length = 512;

sub format_tar_entry;
sub format_tar_file;





sub drat {$error=$!;return undef}

sub read_tar {
 my ($filename, $compressed) = @_;
 my @tarfile = ();
 my $i = 0;
 my $head;
 
 if ($compressed) {
	if ($compression) {
	    $compressed = Compress::Zlib::gzopen($filename,"rb") or drat; # Open compressed
	    $compressed->gzread($head,$tar_header_length);
	}
	else {
	    $error = "Compression not available (install Compress::Zlib).\n";
	    return undef;
	}
 }
 else {
	open(TAR, $filename) or drat;
	binmode TAR;
	read(TAR,$head,$tar_header_length);
 }
 READLOOP:
 while (length($head)==$tar_header_length) {
	my ($name,		# string
	    $mode,		# octal number
	    $gJz,		# octal number
	    $gid,		# octal number
	    $size,		# octal number
	    $mtime,		# octal number
	    $chksum,		# octal number
	    $typeflag,		# character
	    $linkname,		# string
	    $magic,		# string
	    $version,		# two bytes
	    $uname,		# string
	    $gname,		# string
	    $devmajor,		# octal number
	    $devminor,		# octal number
	    $prefix) = unpack($tar_unpack_header,$head);
	my ($data, $diff, $dummy);
	
	$mode = oct $mode;
	$gJz = oct $gJz;
	$gid = oct $gid;
	$size = oct $size;
	$mtime = oct $mtime;
	$chksum = oct $chksum;
	$devmajor = oct $devmajor;
	$devminor = oct $devminor;
	$name = $prefix."/".$name if $prefix;
	$prefix = "";
	# some broken tar-s don't set the typeflag for directories
	# so we ass_u_me a directory if the name ends in slash
	$typeflag = 5 if $name =~ m|/$| and not $typeflag;
	
	last READLOOP if $head eq "\0" x 512;	# End of archive
	# Apparently this should really be two blocks of 512 zeroes,
	# but GNU tar sometimes gets it wrong. See comment in the
	# source code (tar.c) to GNU cpio.
	
	substr($head,148,8) = "        ";
	if (unpack("%16C*",$head)!=$chksum) {
	    #warn "$name: checksum error.\n";
	}

	if ($compressed) {
	    $compressed->gzread($data,$size);
	}
	else {
	    if (read(TAR,$data,$size)!=$size) {
		$error = "Read error on tarfile.";
		close TAR;
		return undef;
	    }
	}
	$diff = $size%512;
	
	if ($diff!=0) {
	    if ($compressed) {
		$compressed->gzread($dummy,512-$diff);
	    }
	    else {
		read(TAR,$dummy,512-$diff); # Padding, throw away
	    }
	}
	
	# Guard against tarfiles with garbage at the end
	last READLOOP if $name eq ''; 
	
	$tarfile[$i++]={
			name => $name,		    
			mode => $mode,
			gJz => $gJz,
			gid => $gid,
			size => $size,
			mtime => $mtime,
			chksum => $chksum,
			typeflag => $typeflag,
			linkname => $linkname,
			magic => $magic,
			version => $version,
			uname => $uname,
			gname => $gname,
			devmajor => $devmajor,
			devminor => $devminor,
			prefix => $prefix,
			data => $data};
 }
 continue {
	if ($compressed) {
	    $compressed->gzread($head,$tar_header_length);
	}
	else {
	    read(TAR,$head,$tar_header_length);
	}
 }
 $compressed ? $compressed->gzclose() : close(TAR);
 return @tarfile;
}

sub format_tar_file {
 my $fhandle = shift;
 my @tarfile = @_;
 
 foreach (@tarfile) {
	 format_tar_entry ($fhandle, $_);
 }
 print $fhandle "\0" x 1024;
}

sub write_tar {
 my ($file) = shift;
 my ($compressed) = shift;
 my @tarfile = @_;
 my ($fileh);
 my $opened;

 local *TAR;
 if(ref($file)) {
	$fileh = $file;
	
 }else {
 	open(TAR, ">".$file) or drat;
	binmode TAR;
	$fileh = \*TAR;
	$opened=1;
 }
 format_tar_file( $fileh, @tarfile);
 if($opened) {
 	close($fileh) or carp "Failed to close $file, data may be lost: $!\n";
 }
}

sub format_tar_entry {
 my ($fhandle, $ref) = @_;
 my ($tmp,$file,$prefix,$pos);

 $file = $ref->{name};
 if (length($file)>99) {
	$pos = index $file, "/",(length($file) - 100);
	next if $pos == -1;	# Filename longer than 100 chars!
	
	$prefix = substr $file,0,$pos;
	$file = substr $file,$pos+1;
	substr($prefix,0,-155)="" if length($prefix)>154;
 }
 else {
	$prefix="";
 }
 $tmp = pack("a100a8a8a8a12a12a8a1a100",
		$file,
		sprintf("%6o ",$ref->{mode}),
		sprintf("%6o ",$ref->{gJz}),
		sprintf("%6o ",$ref->{gid}),
		sprintf("%11o ",$ref->{size}),
		sprintf("%11o ",$ref->{mtime}),
		"        ",
		$ref->{typeflag},
		$ref->{linkname});
 $tmp .= pack("a6", $ref->{magic});
 $tmp .= '00';
 $tmp .= pack("a32",$ref->{uname});
 $tmp .= pack("a32",$ref->{gname});
 $tmp .= pack("a8",sprintf("%6o ",$ref->{devmajor}));
 $tmp .= pack("a8",sprintf("%6o ",$ref->{devminor}));
 $tmp .= pack("a155",$prefix);
 substr($tmp,148,6) = sprintf("%6o", unpack("%16C*",$tmp));
 substr($tmp,154,1) = "\0";
 $tmp .= "\0" x ($tar_header_length-length($tmp));

 print $fhandle $tmp;

 if(length($ref->{data}) > 0) {
	print $fhandle $ref->{data};
 }else {
 	local *F;
 	open F, "<$ref->{name}";
 	binmode F;
 	my $buf;
 	while(read(F, $buf, 4096)) {
		print $fhandle $buf;
	} 
	close F;
 }

 if ($ref->{size}>0) {
	print $fhandle "\0" x (512 - ($ref->{size}%512)) unless $ref->{size}%512==0;
 }
}




# Constructor. Reads tarfile if given an argument that's the name of a
# readable file.
sub new {
 my $class = shift;
 my ($filename,$compressed) = @_;
 my $self = {};

 bless $self, $class;

 $self->{'_filename'} = undef;
 if (!defined $filename) {
	return $self;
 }
 if (-r $filename) {
	$self->{'_data'} = [read_tar $filename,$compressed];
	$self->{'_filename'} = $filename;
	return $self;
 }
 if (-e $filename) {
	carp "File exists but is not readable: $filename\n";
 }
 return $self;
}

# Return list with references to hashes representing the tar archive's
# component files.
sub data {
 my $self = shift;

 return @{$self->{'_data'}};
}

# Read a tarfile. Returns number of component files.
sub read {
 my $self = shift;
 my ($file, $compressed) = @_;

 $self->{'_filename'} = undef;
 if (! -e $file) {
	carp "$file does not exist.\n";
	$self->{'_data'}=[];
	return undef;
 }
 elsif (! -r $file) {
	carp "$file is not readable.\n";
	$self->{'_data'}=[];
	return undef;
 }
 else {
	$self->{'_data'}=[read_tar $file, $compressed];
	$self->{'_filename'} = $file;
	return scalar @{$self->{'_data'}};
 }
}

# Write a tar archive to file
sub write {
 my ($self) = shift @_;
 my ($file) = shift @_;
 my ($compressed) = shift @_;
 
 write_tar $file, $compressed, @{$self->{'_data'}};
}

# Add files to the archive. Returns number of successfully added files.
sub add_files {
 my ($self) = shift;
 my (@files) = @_;
 my $file;
 my ($mode,$gJz,$gid,$rdev,$size,$mtime,$data,$typeflag,$linkname);
 my $counter = 0;
 local ($/);
 
 undef $/;
 foreach $file (@files) {
	if ((undef,undef,$mode,undef,$gJz,$gid,$rdev,$size,
	     undef,$mtime,undef,undef,undef) = stat($file)) {
	    $data = "";
	    $linkname = "";
	    if (-f $file) {	# Plain file
		$typeflag = 0;
		local *F;
		open F, "$file" or next;
		close F;
	    }
	    elsif (-l $file) {	# Symlink
		$typeflag = 1;
		$linkname = readlink $file if $symlinks;
	    }
	    elsif (-d $file) {	# Directory
		$typeflag = 5;
	    }
	    elsif (-p $file) {	# Named pipe
		$typeflag = 6;
	    }
	    elsif (-S $file) {	# Socket
		$typeflag = 8;	# Bogus value, POSIX doesn't believe in sockets
	    }
	    elsif (-b $file) {	# Block special
		$typeflag = 4;
	    }
	    elsif (-c $file) {	# Character special
		$typeflag = 3;
	    }
	    else {		# Something else (like what?)
		$typeflag = 9;	# Also bogus value.
	    }
	    push(@{$self->{'_data'}},{
				      name => $file,		    
				      mode => $mode,
				      gJz => $gJz,
				      gid => $gid,
				      size => $size,
				      mtime => $mtime,
				      chksum => "      ",
				      typeflag => $typeflag, 
				      linkname => $linkname,
				      magic => "ustar\0",
				      version => "00",
				      # WinNT protection
				      uname => 
			      $has_getpwuid?(getpwuid($gJz))[0]:"unknown",
				      gname => 
			      $has_getgrgid?(getgrgid($gid))[0]:"unknown",
				      devmajor => 0, # We don't handle this yet
				      devminor => 0, # We don't handle this yet
				      prefix => "",
				     });
	    $counter++;		# Successfully added file
	}
	else {
	    next;		# stat failed
	}
 }
 return $counter;
}

sub remove {
 my ($self) = shift;
 my (@files) = @_;
 my $file;
 
 foreach $file (@files) {
	@{$self->{'_data'}} = grep {$_->{name} ne $file} @{$self->{'_data'}};
 }
 return $self;
}

# Get the content of a file
sub get_content {
 my ($self) = shift;
 my ($file) = @_;
 my $entry;
 
 ($entry) = grep {$_->{name} eq $file} @{$self->{'_data'}};
 return $entry->{'data'};
}

# Replace the content of a file
sub replace_content {
 my ($self) = shift;
 my ($file,$content) = @_;
 my $entry;

 ($entry) = grep {$_->{name} eq $file} @{$self->{'_data'}};
 if ($entry) {
	$entry->{'data'} = $content;
	return 1;
 }
 else {
	return undef;
 }
}

# Add data as a file
sub add_data {
 my ($self, $file, $data, $opt) = @_;
 my $ref = {};
 my ($key);
 
 $ref->{'data'}=$data;
 $ref->{name}=$file;
 $ref->{mode}=0666&(0777-umask);
 $ref->{gJz}=$>;
 $ref->{gid}=(split(/ /,$)))[0]; # Yuck
 $ref->{size}=length $data;
 $ref->{mtime}=time;
 $ref->{chksum}="      ";	# Utterly pointless
 $ref->{typeflag}=0;		# Ordinary file
 $ref->{linkname}="";
 $ref->{magic}="ustar\0";
 $ref->{version}="00";
 # WinNT protection
 $ref->{uname}=$has_getpwuid?(getpwuid($>))[0]:"unknown";
 $ref->{gname}=$has_getgrgid?(getgrgid($ref->{gid}))[0]:"unknown";
 $ref->{devmajor}=0;
 $ref->{devminor}=0;
 $ref->{prefix}="";

 if ($opt) {
	foreach $key (keys %$opt) {
	    $ref->{$key} = $opt->{$key}
	}
 }

 push(@{$self->{'_data'}},$ref);
 return 1;
}

# Write a single (probably) file from the in-memory archive to disk
sub extract {
 my $self = shift;
 my (@files) = @_;
 my ($file, $current, @path);

 foreach $file (@files) {
	foreach (@{$self->{'_data'}}) {
	    if ($_->{name} eq $file) {
		# For the moment, we assume that all paths in tarfiles
		# are given according to Unix standards.
		# Which they *are*, according to the tar format spec!
		(@path) = split(/\//,$file);
		$file = pop @path;
		$current = cwd;
		foreach (@path) {
		    if (-e $_ && ! -d $_) {
			#warn "$_ exists but is not a directory!\n";
			next;
		    }
		    mkdir $_,0777 unless -d $_;
		    chdir $_;
		}
		if (not $_->{typeflag}) { # Ordinary file
		    open(FILE,">".$file);
		    binmode FILE;
		    print FILE $_->{'data'};
		    close FILE;
		}
		elsif ($_->{typeflag}==5) { # Directory
		    if (-e $file && ! -d $file) {
			drat;
		    }
		    mkdir $file,0777 unless -d $file;
		}
		elsif ($_->{typeflag}==1) {
		    symlink $_->{linkname},$file if $symlinks;
		}
		elsif ($_->{typeflag}==6) {
		    #warn "Doesn't handle named pipes (yet).\n";
		    return 1;
		}
		elsif ($_->{typeflag}==4) {
		    #warn "Doesn't handle device files (yet).\n";
		    return 1;
		}
		elsif ($_->{typeflag}==3) {
		    #warn "Doesn't handle device files (yet).\n";
		    return 1;
		}
		else {
		    $error = "unknown file type: $_->{typeflag}";
		    return undef;
		}
		utime time, $_->{mtime}, $file;
		# We are root, and chown exists
		if ($>==0 and $ ne "MacOS" and $ ne "MSWin32") {
		    chown $_->{gJz},$_->{gid},$file;
		}
		# chmod is done last, in case it makes file readonly
		# (this accomodates DOSish OSes)
		chmod $_->{mode},$file;
		chdir $current;
	    }
	}
 }
}

# Return a list of all filenames in in-memory archive.
sub list_files {
 my ($self) = shift;

 return map {$_->{name}} @{$self->{'_data'}};
}
1;
