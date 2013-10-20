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

use AutoLoader 'AUTOLOAD';
1;
