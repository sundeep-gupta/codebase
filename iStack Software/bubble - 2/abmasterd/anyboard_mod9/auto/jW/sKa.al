# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 721 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sKa.al)"
sub sKa {
 my($self) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  if(not $abmain::use_sql) {
	  	next if not -f $_;
	  }
 my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1} );
	  push @xlines, @$linesref;
 }
 my %allusers=();
 my %users=();

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my $ucnt=0;
 my $tot =0;
 local $_;
 while ( $_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
 $n =~ s/\b(\w)/uc($1)/ge;
	  next if exists $allusers{$n};
 $allusers{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 for(keys %allusers) {
 	  $tot ++;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$allusers{$_}};
 next if  $gDz ne 'A';
 $users{$n} = $allusers{$n};
 $ucnt ++;
 }
 return sort keys %users;
}

# end of jW::sKa
1;
