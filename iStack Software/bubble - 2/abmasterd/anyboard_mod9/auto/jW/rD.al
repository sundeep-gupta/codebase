# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2375 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rD.al)"
sub rD {
 my ($self, $user) = @_;
 my @hTa;
 my $passwdir = $self->fQz();
 my $do_loc = $self->eOaA() && $self->{local_control};
 my $locd= $self->dBaA();
 for(my $i=0; $i<$passwd_cnt; $i++){
 	if($do_loc) {
 	   push @hTa, abmain::kZz($locd,$i);
	}else {
 	   push @hTa, abmain::kZz($passwdir,$i);
	}
 }
 return @hTa;
}

# end of jW::rD
1;
