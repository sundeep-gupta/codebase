# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1009 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mTz.al)"
sub mTz {
 my ($self, $n, $e) = @_;
 my $np = (int rand() * time())%99999 + 100;
 $self->iMz($n, $np, $e, 0, 1);
 my %mail;
 $mail{From} = $self->{admin_email};
 $mail{To} = $e;
 $mail{Smtp}=$self->{cQz};
 $mail{Subject} = "Password for $self->{name}";
 $mail{Body}  = "Your new password is:\n$np\n\nThanks";
 abmain::vS(%mail);
 if($abmain::wH) {
 abmain::error('sys', $abmain::wH. " -- Send mail failed. Please contact admin at $self->{admin_email} to reset your password.");
 }else {
 abmain::cTz("Password has been sent to you by email");
 }
}

# end of jW::mTz
1;
