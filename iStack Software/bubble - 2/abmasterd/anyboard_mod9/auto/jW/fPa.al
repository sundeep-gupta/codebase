# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3009 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fPa.al)"
sub fPa{
 my ($self, $board2, $aK, $keepdate, $cat) = @_; 
 my $thr = $board2->pO($aK, undef, 1, 1);
 abmain::error('inval', "Thread $aK not found in $board2->{eD}") if not $thr;
 my $numgen = sub {$self->iU(); };
 $thr->pOa($numgen,0, 0, $cat);
 $self->fOa($thr, $keepdate);
 $self->nU();
}

# end of jW::fPa
1;
