# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 944 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sJa.al)"
sub sJa {
 my ($self, $to, $wW, $message) = @_;
 my %mail;
 $mail{From} = $self->{notifier};
 $mail{To} =  $to;
 $mail{To} =~ s/,?$//;
 $mail{Subject} =$self->{name}. ": ". $wW;
 $mail{Body} = $message;
 $mail{Smtp}=$self->{cQz};
 &abmain::vS(%mail);
}

# end of jW::sJa
1;
