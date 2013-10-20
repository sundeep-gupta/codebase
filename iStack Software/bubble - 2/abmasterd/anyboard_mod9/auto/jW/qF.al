# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 599 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qF.al)"
sub qF {
 my($self, $pattern, $after, $before, $partial, $type, $stat, $ifnoti) = @_;
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
 my $ct = time();
 my $sti = $ct - $after * 24 * 3600;
 my $eti = $ct - $before * 24 * 3600;
 my $ucnt=0;
 my $tot =0;
 local $_;
 while ( $_ = pop @xlines) {
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @$_;
	  next if !$n =~ /\S+/;
 $n =~ s/\b(\w)/uc($1)/ge;
	  next if exists $allusers{$n};
	  next if $ifnoti && $noti != $ifnoti;
 $allusers{$n} = [$n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti];
 }
 for(keys %allusers) {
 	  $tot ++;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$allusers{$_}};
	  next if $type && $type ne $fMz;
	  next if $stat && $stat ne $gDz;
 next if ($after && $t < $sti) || ($before && $t > $eti); 
 if($pattern) {
 next if $partial==1 && lc($n) ne lc($pattern);
 next if not ($n =~ /$pattern/i || $e =~ /$pattern/i
 || $fXz =~ /$pattern/i || $fSz =~ /$pattern/i);
 }
 next if $partial && $gDz ne 'A';
 $users{$n} = $allusers{$n};
 $ucnt ++;
 }
 my $ustr;
 my   $dstr;
 $dstr  = "since ". abmain::dU('LONG', $sti, 'oP') if $after >0;
 $ustr = "( $ucnt members $dstr )" if not ($partial && $pattern); 
 $self->eMaA( [qw(other_header other_footer member_list_banner)]);
 sVa::gYaA "Content-type: text/html\n\n";
 print qq(<html><head><title>Member information (Total $tot)</title>\n$self->{sAz}\n$self->{other_header}$self->{member_list_banner}
 );
 print abmain::oWa();
 print qq(<DIV class="ABMEMBERLIST">);
 my @ths= ("Name", "Mod time", "Status", "Home page", "Type", "Location", "Description");
 my @rows;
 my $usrname;
 foreach $usrname (sort keys %users) {
 my @row;
 ($n, $p, $e, $t, $fUz, $gDz, $gIz, $fMz, $fXz, $fSz, $noti) = @{$users{$usrname}};
	  if($e =~ /\S+/ && not ($self->{gNz} && $partial) ) {
	       push @row, abmain::cUz("mailto:$e", $n);
	  }else {
	       push @row,  $n;
	  }
	  my $dlink= sVa::cUz(sVa::sTa($abmain::jT, {docmancmd=>'fVaA', kQz=>$usrname, dir=>'/public'}), "<small>Files</small>");
 my $uenc = abmain::wS($usrname);
	  push @row, "<small>".abmain::dU('SHORT', $t, 'oP')."</small>";
 push @row,
 qq($gDz \&nbsp;\&nbsp;). abmain::cUz($self->{cgi}."?@{[$abmain::cZa]}cmd=admregform;kQz=$uenc", "<small>Modify</small>", "_dw").
 "\&nbsp; ". abmain::cUz($self->{cgi}."?@{[$abmain::cZa]}cmd=delregform;kQz=$uenc", "<small>Delete</small>", "_dw");
 push @row,  abmain::cUz("$fUz", ($fUz=~ m#^http://..#i) ? $fUz:""). ' &nbsp; '.
	  	abmain::hFa($self->{mp_enabled}? "$self->{cgi}?@{[$abmain::cZa]}cmd=viewmp;kQ=$uenc":"", "<small>more</small>").' &nbsp; '.
	  	abmain::hFa($self->{mp_enabled}?"$self->{cgi}?@{[$abmain::cZa]}cmd=viewmp;kQ=$uenc;vcf=1":"", "<small>vcard</small>"). " ".
	  	abmain::hFa($self->{mp_enabled}?"$self->{cgi}?@{[$abmain::cZa]}cmd=mform;kQ=$uenc":"", "<small>edit</small>"). " ".
		$dlink." ".
	  	abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=form;kQz=$uenc", "<small>private</small>");
 push @row, $fMz, $fXz, $fSz;
	  push @rows, [@row];
 }
 my $colsel;
 if($partial) {
	if($self->{short_reg_form}) {
		$colsel = [0, 3];
	}else {
		$colsel = [0, 3, 5, 6];
	}
 }else {
	if($self->{short_reg_form}) {
		$colsel = [0, 1, 2, 4];
	}
 }
 
 print sVa::fMa(rows=>\@rows, ths=>[jW::mJa($self->{cfg_head_font}, @ths)], $self->oVa(), colsel=>$colsel); 
 
 print "\n</DIV>";
 if( $partial && $pattern) {
	print "<center>";
 	$self->vLz($pattern) if $self->{pstat_in_reginfo}; 
	print "</center>";
 	$self->bVa($pattern) if $self->{mp_enabled} && $self->{mp_in_reginfo}; 
 }
 print qq!<center>$ustr</center>!;

 my $mf = new aLa('mem', \@abmain::search_member_form, $self->{cgi});
 print $mf->form();
 print "</center>";

 
 print "$self->{other_footer}";
}

# end of jW::qF
1;
