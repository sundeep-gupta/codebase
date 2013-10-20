# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 171 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/hFaA.al)"
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

# end of dDa::hFaA
1;
