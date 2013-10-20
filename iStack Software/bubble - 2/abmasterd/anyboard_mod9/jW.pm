package jW;

use strict;

use AutoLoader 'AUTOLOAD';

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
1;
use aLa;
