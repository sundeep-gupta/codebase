#!/usr/bin/perl
use strict;
$abmain::master_cfg_dir="../httpdocs/abmasterd";

$abmain::ab_install_dir =$abmain::master_cfg_dir; # where anyboard libs sit
$abmain::fix_cgi_url="";  # the full URL of this script, e.g., http://mysite.com/cgi-bin/anyboard.cgi

$abmain::fix_top_dir="";  # the directory that will host all anyboard forums, e.g, /home/mysite/www/anyboard/ 

$abmain::fix_top_url="";  # the URL of the directory above, e.g., http://www.mysite.com/anyboard/ 

$abmain::no_pathinfo = 0 ;  ## must set to 1 for IIS
$abmain::allow_board_deletion =0; ## set this to 1 if want master admin to delete forum from web

$abmain::shadow_cfg = 0;  ## set this to 1 to shadow the .forum_cfg file
$abmain::htmla=1;

BEGIN{
	$abmain::img_top="/abicons"; # change this to the URL of the directory where icons are put
}

$abmain::smtp_server ="localhost";  ## set this to smtp server 

 ############################################################################################################
 ############################ Anyboard: The Collaborative Community Groupware for the 21st Century      #####
 ############################   Information capture, sharing, classification, retrieval and utilization #####
 ############################################################################################################
 #############################          All the rest are optional!                            ###############
$abmain::pathinfo_cut;

$abmain::off_webroot = 0; # if $fix_top_dir is off the web tree, set this to 1

$abmain::no_pathinfo 
= 1 if $ENV{SERVER_SOFTWARE} =~ /iis|netscape/i ;  ## set to 1 for IIS and netscape server
$abmain::default_smtp_port = 25;  ## oE number of the SMTP server 

$abmain::use_sendmail_cmd = 0 ;  ## change this to 1 if using sendmail command

$abmain::sendmail_cmd ="/usr/lib/sendmail -t";  ## change this to the path to sendmail command
 ## anyboard uses this if $smtp_server equals $sendmail_cmd 

$abmain::zip_command="/usr/bin/zip -r -";  ## set this to the command that used to archive the forum dirs and files
 ## must output to stdout (such as "tar c") 

#x1

$abmain::min_chat_refresh = 5; ## The minimum refresh interval for the chat page 
$abmain::disable_sinfo = 0; 

$abmain::do_untaint = 1;  ## set this to 1 to do untainting 
$abmain::use_sql=0;
$abmain::bypass_loadfix=0;
$abmain::loaded_fix="no";

@abmain::bgs=('#ffffff', '#dddddd'); # background dR

$abmain::top_virtual_dir="";  
#x1
#x1
#x1
#x1
$abmain::tz_offset = 0; ## time display offset in hours

$abmain::msg_bg ="#ddddff"; ##background color of the message pages (including error page)

$abmain::debug = 0; 
#x1
#x1

$abmain::dump_code = 0;

$abmain::master_cfg_dir= $ENV{ABMASTERD} if $ENV{ABMASTERD};
$abmain::zip_command= $ENV{ABZIPCMD} if $ENV{ABZIPCMD};
#x1

$jW::random_seq = 0;  # randomize message number

$abmain::err_filter=qq(/home/anyboard|/home/bbscity|/home.?/anygroup|/home/jumpstock|/home/anyforum);
$abmain::iconizer="http://www.anygroup.net/cgi-bin/makeicon.pl";

$abmain::bRaA='-=ab=-';
 ##spell checker configure this
 $abmain::enable_speller=0; #set it to 1 to enable
 $abmain::spellcgi ="/cgi-bin/sproxy.cgi"; # URI of the sproxy script, no http://domain part

 ## no need to change what's below, unless you put spch.js out of the www/ root 
 $abmain::spelljs = "/spch.js";    #URI of the spch.js script
 $abmain::spell_js=qq(<script type="text/javascript" language="javascript" src="$abmain::spelljs"></script>); 

 ### end spell checker

$abmain::no_dot_file = 0;
$abmain::use_alarm = ($^O=~/win/i)?0:1;
$abmain::no_crypt = 0;
$abmain::oUa = 1; # log all jW activties

$jW::post_filter=$ENV{ABPOSTFILTER};
$jW::prog_step=qq(<B><font size=4> . </font></B>);

delete @ENV{qw(IF CDPATH PATH ENV BASH_ENV)};
;############# CUT AND SAVE THE HEADER SECTION ABOVE #######################

require 5.003;

$abmain::DONOT_EDIT_START_FROM_HERE =<<'CODE_PROTECTED';

//Copyright(C), Netbula LLC, 1998-2002, All Rights Reserved.
//The AnyBoard(tm) Bulletin Board System is protected
//by US and International copyright laws.
//Unauthorized use or distribution of AnyBoard(tm) is strictly prohibited,
//unauthorized modifications of the code below is also prohibited.
//violators will be prosecuted. To obtain a license for using AnyBoard(tm), 
//please see info at http://netbula.com/anyboard/license.html

CODE_PROTECTED

$abmain::perlapp=0;
if($abmain::perlapp) {
	my $f = PerlApp::exe();
	$f =~ s/anyboard.exe/anyboard_cfg.pl/i;
	eval {
		do $f ;
	};
	err($@) if $@;
}
use vars qw($PROJ $onelib $autolib $onelibex);

$PROJ="AnyBoard";

$onelib = "$abmain::ab_install_dir/${PROJ}One.pm";
$onelibex = "$abmain::ab_install_dir/ex.pm";
$autolib = "$abmain::ab_install_dir/anyboard_mod9";
if((not -d $autolib) || $ENV{QUERY_STRING} eq 'forcesplit') {
 if(not -d $abmain::master_cfg_dir) {
		err("<b>\$abmain::master_cfg_dir </b> is set to \"$abmain::master_cfg_dir\", but it does not exist.<p>You must upload the abmasterd/ folder in the AnyBoard package to your web server and set \$abmain::master_cfg_dir to point to the abmasterd foler. Refresh this page if you are done.");
 }else {
		eval{
			require $onelib;
			sUa::yGz($onelib, $autolib, $onelibex);
		};
		err("<pre>$@</pre>") if $@;
	}
}

unshift @INC, $autolib;

eval {
	require abmain;
	abmain::lTz();
};

if($@) {
	err("Error: $@");
}

sub err{
	my $msg =shift;
	print qq(Content-type: text/html\n\n<html><body>$msg</body></html>);
	exit;
}
