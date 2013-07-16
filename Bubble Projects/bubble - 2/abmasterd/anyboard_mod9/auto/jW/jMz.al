# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1683 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jMz.al)"
sub jMz{
 my($self) = @_;
 $self->bI();
 $self->iA(\@abmain::vC);
 $self->{vI}=abmain::lKz($self->{eF}->{vI});
 if(not $self->{moders}->{$self->{moderator}}) {
 abmain::error('inval', "Moderator does not exist");
 }
 $self->{moderator_email} =~ s/\s//g;
 $self->{moders}->{$self->{moderator}}= 
 [ $self->{moderator_email}, $self->{vI}, $self->{vM}, $self->{vN}, $self->{mod_can_dopoll}];
}

# end of jW::jMz
1;
