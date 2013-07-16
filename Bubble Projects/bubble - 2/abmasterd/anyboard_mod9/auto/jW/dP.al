# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 845 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dP.al)"
sub dP {
 my($self, $user, $qD) = @_;
 my $fIz = $self->fRz($user);
 my $db= $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 my %cC;
 my $cnt= $db->jLa([lc($user)]);
 unlink $self->bJa($user);
 return $cnt unless $qD; 
 $self->gOa($user,0);
 return $cnt;
}

# end of jW::dP
1;
