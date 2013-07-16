# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 566 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/kP.al)"
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

# end of sVa::kP
1;
