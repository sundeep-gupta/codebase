# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 766 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bKa.al)"
sub bKa {
 my($self, $nt) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for my $f(@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $f;
 }
 my $linesref = $bYaA->new($f, {schema=>"AbUser", paths=>$self->dHaA($f) })->iQa({noerr=>1} );
	  if(not $abmain::use_sql) {
 	unlink $f if $bYaA->new("$f.bak", {schema=>"AbUser"})->iRa($linesref)>0;
	  }
	  push @xlines, @$linesref;
 }
 my %users=();
 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
	  next if $users{$n};
 $users{$n} = [$n, $p, $e, $fUz, $gDz, $gIz, $nt, $fXz, $fSz, $noti];
 }  
 my $cnt=0;
 my $usrname;
 foreach $usrname (sort keys %users) {
 	  $self->aG(@{$users{$usrname}});
 $cnt ++;
 }
 return $cnt;
}

# end of jW::bKa
1;
