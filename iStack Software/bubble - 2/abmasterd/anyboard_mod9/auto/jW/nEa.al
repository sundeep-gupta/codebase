# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4126 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nEa.al)"
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

# end of jW::nEa
1;
