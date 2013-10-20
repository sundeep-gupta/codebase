# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2627 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lN.al)"
sub lN {
 my ($self, $aE, $mcut, $tn) = @_;
#x1
 $self->{eN} = lB->new();
 $self->{dA}={};
 keys(%{$self->{dA}}) = scalar(@$aE);

 my ($fI, $aK, $top);
 my $cnt =0;
 for(@{$aE}){
 $cnt ++;
 next if ($mcut && $cnt > $mcut && not $self->{dA}->{$_->{aK}});
 $fI = $_->{fI};
 $self->{dA}->{$fI} = $_;
 $_->{bE}=[]; 
 }

#x1
 for(@{$aE}) {
 $fI = $_->{fI};
 $aK = $_->{aK};
 next if $tn && $tn != $aK;
 next if not $self->{dA}->{$fI};
 next if $self->{hEz} && not $self->{dA}->{$_->{aK}};
 $self->{eN}->nB($self, $_);
 }
 $self->{pC} = $aE;
#x1
}

# end of jW::lN
1;
