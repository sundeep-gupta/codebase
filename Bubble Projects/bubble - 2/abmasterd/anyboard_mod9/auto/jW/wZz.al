# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 797 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/wZz.al)"
sub wZz {
 my($self) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for my $f (@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $f;
	  }
 my $linesref = $bYaA->new($f, {schema=>"AbUser", paths=>$self->dHaA($f) })->iQa({noerr=>1} );
	  push @xlines, @$linesref;
 }
 my %users=();

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
	  next if $users{$n};
 $users{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 sVa::gYaA "Content-type: application/octet-stream\n";
 print "Content-Disposition: attachment; filename=abuserdb.txt\n\n";
 print $UDMAGIC, "\n";
 foreach my $usrname (sort keys %users) {
 print join ("\t", @{$users{$usrname}}), "\n";
 }
}

# end of jW::wZz
1;
