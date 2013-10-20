# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 542 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hWz.al)"
sub hWz{
 my($self, $pattern, $full, $valid, $after, $before, $innoti) = @_;
 my @jXz = $self->rD();
 my @xlines;
 for(@jXz) {
	  next if ((not -f $_ ) && (not $abmain::use_sql));
	  my $linesref = $bYaA->new($_, {schema=>"AbUser", paths=>$self->dHaA($_) })->iQa({noerr=>1});
	  push @xlines, @$linesref if $linesref;
 }

 my $ct = time();
 my $sti = $ct - $after * 24 * 3600;
 my $eti = $ct - $before * 24 * 3600;

 my ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti);
 my %user_emails=();
 my @vcards;
 my %seen_user=();
 local $_;
 while ($_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_; 
 next if ($after && $t < $sti) || ($before && $t > $eti); 
	  next if !$n =~ /\S+/;
 next if $seen_user{$n};
 $seen_user{$n}=1;
 next if $innoti && !$noti;
	  next if $user_emails{$n};
 if($pattern) {
 next if not ($n =~ /$pattern/i || $e =~ /$pattern/i
 || $fXz =~ /$pattern/i || $fSz =~ /$pattern/i
 );
 }
 next if $valid && $gDz ne 'A';
 next if not $e =~ /\@/;
 if($full) {
 	$user_emails{$n} = "$n\&lt;$e\&gt;" ;
 }else {
 $user_emails{$n} = $e;
 }
 if($self->{gRa}) {
		push @vcards, $self->fYa($n);
 }
 
 }
 if($self->{gRa}) {
 my %mail;
 	$mail{To} = $self->{gRa};
 $mail{From} = $self->{notifier};
 $mail{Subject} = "$self->{name} vcards";
 $mail{Body} = "See attached card files for details.";
	abmain::mXz(\%mail, "anyboard.vcf", @vcards);
 if ($abmain::wH){
 abmain::error('sys', "Error sending e-mail: ". $abmain::wH)
 }
 }
 return join(', ', values %user_emails);
}

# end of jW::hWz
1;
