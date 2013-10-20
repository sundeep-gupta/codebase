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

use lB;
use jW;
use jFa;
use jEa;
use dZz;
use jPa;
use hDa;

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

use AutoLoader 'AUTOLOAD';

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
hOa();
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

1;
