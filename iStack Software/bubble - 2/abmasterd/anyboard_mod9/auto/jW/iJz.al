# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 391 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iJz.al)"
sub iJz {
 my ($self, $msg) = @_;
 $self->xI("test msg", $msg); 
 if ($abmain::wH){
 abmain::error('sys', "Error sending e-mail: ". $abmain::wH)
 }else {
 abmain::cTz("Email sent");
 }
}

# end of jW::iJz
1;
