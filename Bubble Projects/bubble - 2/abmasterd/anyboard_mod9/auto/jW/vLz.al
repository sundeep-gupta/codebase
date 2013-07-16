# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3236 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/vLz.al)"
sub vLz  {
 my ($self, $kQz) = @_; 
 $kQz = lc($kQz);
 my $sf = $self->nDz('pstat');
 my $sfcac = $self->nDz('pstat')."ca";
 if( ! -f $sf || time() > (stat($sf))[9] + $self->{vAz}) {
 $self->oF(LOCK_EX,33);
 $self->vUz()
 		if( ! -f $sf || time() > (stat($sf))[9] + $self->{vAz});
 $self->pG(33);
 }
 my $linesref = $bYaA->new($sf, {schema=>"AbPostStat", paths=>$self->dHaA($sf) } )->iQa({noerr=>1} );
 my @ths = ("Name", "Total posts", "Bytes", "Active",  "Archived", "Deleted", "Uploads", "Views", "Rating", "Rates");
 my @rows;
 for (@$linesref) {
 my @vals = @$_;
 next if $kQz && $kQz ne lc($vals[0]);
 my $usre= abmain::wS(lc($vals[0]));
 $vals[3]= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=find;tK=^$usre\$;hIz=365", $vals[3]);
 $vals[4]= abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=finda;tK=^$usre\$;hIz=365", $vals[4]);
	$vals[8] = sprintf("%.2f", $vals[8]/$vals[9]) if $vals[9] >0;
 push @rows, [@vals];
 }
 @ths = jW::mJa($self->{cfg_head_font}, @ths);
 print sVa::fMa(rows=>\@rows, ths=>\@ths, $self->oVa());
}

# end of jW::vLz
1;
