# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 385 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eRa.al)"
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

1;
# end of dDa::eRa
