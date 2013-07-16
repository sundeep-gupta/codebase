# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1107 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/aG.al)"
sub aG{
 my($self, $n, $p, $e, $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme) = @_;
 $self->fZz($n);
 my $fIz = $self->fRz($n);
 my $pfile2 = $self->eLaA($n);
 my $cE = $self->{fYz}->{lc($n)};
 my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 my $db2 = $bYaA->new($pfile2, {schema=>"AbUser", paths=>$self->dHaA($pfile2) });
 if($cE eq "") {
if($db->pXa()>11*5) { return; } 
 	$db->iSa(
 	    [$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]
 	);
	if($self->eOaA() && $self->{local_control}) {
 	  $db2->iSa(
 	    [$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]
	  );
	}
 }else {
	if($self->eOaA() && $self->{local_control}) {
 	  $db2->jXa(
 	    [[$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]]
 	  );
	  my $oldline = $self->{gFz}->{$n};
 my ($p2, $e2, $ct2, $hp2, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2) ;
 if ($oldline) {
 	( $p2, $e2, $ct2, $hp2, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2) = @$oldline;
		if($vkey ==0 && $vk2>0 && $st2 eq 'C' && $gDz eq 'A') {
			$vk2 =0;
			$st2 = 'A';
		}
 	  	$db->jXa(
 	  	  [[$n, $p, $e, time(), $fUz, $st2, $vk2, $utype2, $uloc2, $udesc2, $add2noti2, $showme2]]
 	  	);
 }
 }else {
 	  $db->jXa(
 	    [[$n, $p, $e, time(), $fUz, $gDz, $vkey, $ut, $fXz, $fSz, $add2noti, $showme]]
 	  );
 }
 }
}

# end of jW::aG
1;
