# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 916 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/xI.al)"
sub xI {
 my ($self, $wW, $message, $admonly) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 if($admonly) {
 	$mail{To} = $self->{admin_email};
 }else {
 	$mail{To} = join(", ", $self->{admin_email}, split("\t", $self->{moderator_email}));
 }
 $mail{To} =~ s/,$//;
 $mail{Subject} =$self->{name}. ": ". $wW;
 $mail{Body} = $message;
 $mail{Body} .="\n\n----------------\n".$self->fC();
 $mail{Smtp}=$self->{cQz};
 &abmain::vS(%mail);
}

# end of jW::xI
1;
