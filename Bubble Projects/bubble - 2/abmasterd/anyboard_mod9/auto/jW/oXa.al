# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1957 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oXa.al)"
sub oXa {
 my ($self, $uid1) = @_;
 my $gJz = lc($uid1);
 $self->{fTz}->{name}=$uid1;
 $self->{fTz}->{email}=$self->{gFz}->{$gJz}->[1];
 $self->{fTz}->{reg}=0;
 $self->{fTz}->{status} = $self->{gFz}->{$gJz}->[4];
 $self->{fTz}->{type} = $self->{gFz}->{$gJz}->[6];
 $self->{fTz}->{wO} = $self->{gFz}->{$gJz}->[3];
 if(length($self->{fYz}->{$gJz})>0) {
 $self->{fTz}->{reg}=1;
 }
 $self->{fWz} = 1;
}

# end of jW::oXa
1;
