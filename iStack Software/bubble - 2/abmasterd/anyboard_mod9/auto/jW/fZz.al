# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 470 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fZz.al)"
sub fZz{
 my($self, $user) = @_;

 $user = lc($user);
 my $fIz = $self->fRz($user);
 my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz)});
 my $linesref = $db->iQa({noerr=>1, where=>"userid='$user'", filter=>sub { return $_[0]->[0] eq lc($user); } });
 
 my $sq = '&#39;';
 local $_;
 while ($_ = pop @$linesref) {
 my ($n, $p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme) = @$_;
 $fSz =~ s/'/$sq/ge;
 $fUz =~ s/'/$sq/ge;
 $fXz =~ s/'/$sq/ge;
	  next if $self->{fYz}->{$n};
	  if($n =~ /\S+/ && $p ne '') { 
	  	$self->{fYz}->{$n} = $p;   
	  	$self->{gFz}->{$n} = [$p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme];
	  }
 }
 if($self->eOaA() && $self->{local_control} ) {
 	my $fIz = $self->eLaA($user);
 	my $db = $bYaA->new($fIz, {schema=>"AbUser", paths=>$self->dHaA($fIz) });
 	my $linesref = $db->iQa({noerr=>1, where=>"userid='$user'", filter=>sub { return $_[0]->[0] eq lc($user); } });
	my $lineref = undef;
	if($linesref && scalar(@$linesref)) {
		my $len =  scalar(@$linesref);
		$lineref = $linesref->[$len-1];
 	my ($n, $p2, $e2, $ct, $hp2, $st2, $vk2, $utype2, $fXz, $fSz, $add2noti2, $showme2) = @$lineref;
		my $oldline = $self->{gFz}->{$n};
 	my ($p, $e, $fUz, $gDz, $gIz, $fMz, $add2noti, $showme) ;
 	( $p, $e, $ct, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $add2noti, $showme) = @$oldline if $oldline;
 	$fSz =~ s/'/$sq/ge;
 	$fUz =~ s/'/$sq/ge;
 	$fXz =~ s/'/$sq/ge;
	  	$self->{gFz}->{$n} = [$p, $e, $ct, $hp2, $st2, $vk2, $utype2, $fXz, $fSz, $add2noti2, $showme2];
	}else {
	  	$self->{gFz}->{lc($user)} = undef;

	}
 
 }
}

# end of jW::fZz
1;
