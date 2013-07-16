# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4767 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gNaA.al)"
sub gNaA {
 my ($self, $msg, $jK, $depth, $here, $linkit, $nocat) = @_;
 require gPaA;

 local *PRINTBUF;

 my $msg_a = tie *PRINTBUF, 'gPaA';
 my $fh_b = \*PRINTBUF;

 $self->{nolink_here} = 1 if not $linkit;
 my $oldgrp = $self->{grp_subcat};
 $self->{grp_subcat} =0 if $nocat;
 $msg->jN(iS=>$self, nA=>$fh_b, jK=>-1, 
 depth=>$depth, gV=>0, kQz=>$self->{kUz},
				     iZz=>$here,
				     pub=>$self->{kUz}?0:'p');
 my $str = <PRINTBUF>;
 untie *PRINTBUF;
 $self->{nolink_here} = 0;
 $self->{grp_subcat} = $oldgrp; 
 return $str;
}

# end of jW::gNaA
1;
