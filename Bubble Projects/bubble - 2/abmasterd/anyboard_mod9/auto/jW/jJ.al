# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9296 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jJ.al)"
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

# end of jW::jJ
1;
