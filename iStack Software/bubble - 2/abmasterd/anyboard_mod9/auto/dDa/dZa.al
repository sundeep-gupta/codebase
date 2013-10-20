# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 330 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/dZa.al)"
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

# end of dDa::dZa
1;
