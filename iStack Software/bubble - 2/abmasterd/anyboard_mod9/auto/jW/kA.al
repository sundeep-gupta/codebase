# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9859 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/kA.al)"
sub kA {
 my ($self, $oked, $nolast) = @_;
 my $eC = $self->{dA}->{$gP};
 my $parent;

 if($eC->{jE} > 0) {
 $parent = $self->{dA}->{$eC->{jE}};
 }

 $eC->{hack}=
 "\n<!--X=". 
 join("\t", @{$eC}{'aK', 'jE', 'fI', 'wW', 'hC', 'mM', 'size'}, "", $eC->{xE}, "", $eC->{eZz}, $eC->{to}, $eC->{mood},
 $eC->{tP}, "", $eC->{mtime}, $eC->{scat}, $eC->{track}, $abmain::VERSION||8)
 ."-->\n"; 

 my $aliases =  $self->kD();

 $eC->{body} = $self->{bXz}->{body};
 $eC->{img} = $self->{bXz}->{img};
 $eC->{rlink_title} = $self->{bXz}->{url_title};
 $eC->{aliases} =  $aliases;

 #$self->xB($gP, $data);
 
 $eC->store($self);
 if($eC->{to}) {
	$self->hKa($eC);
	$self->cMaA($eC, $eC->{to});
 }elsif ($eC->{aK} == $eC->{fI} && not $nolast){
	$self->oGa($eC);
 }
 if($parent && $parent->{to} ne "") {
	$self->cOaA($parent->{fI}, lc($eC->{hC}), {reply_time=>time()});
 }
 $self->hLz($self->{bXz}->{upfiles}) if $self->{bXz}->{upfiles};

 $self->{cXa} = 1 if not $oked;
 $self->bT($gP);

 my ($dTz, $cc_self, $dSz, $iSz, $reportboss);

 if($self->{xH} && !$self->{bXz}->{to} && !($self->{xS} && !$abmain::gJ{notify})) {
 $dTz=1;
 }
 $iSz = $abmain::gJ{iSz};
 $cc_self = $self->{cc_author};
 $reportboss= $abmain::gJ{reportboss};

 if( $parent && ($parent->{xE} & $pEz || ($self->{dWz} && $abmain::gJ{dWz}))){
 if(!$parent->{email}) {
 $self->fZz($parent->{hC});
 $parent->{email} = $self->{gFz}->{lc($parent->{hC})}->[1];
 }
 $dSz = 1 if($parent->{email});
 }
 my %mail;
 if($dTz || $dSz || $iSz || $reportboss || $cc_self) {
 my $reply_to = $self->{gFz}->{lc($eC->{hC})}->[1] || $eC->{email};
 $mail{From} = $self->{notifier};
 $mail{To} = $self->{wN};
 $mail{'Reply-To'} = $reply_to if ($reply_to && not $self->{gNz});
	if($oked) {
 	$mail{Subject} = "New message on $self->{name}: $eC->{wW}";
	}else {
 	$mail{Subject} = "Pending message on $self->{name}: $eC->{wW}";
	}
 $mail{Body} = qq!$eC->{wW} --- by $eC->{hC} ($eC->{size} bytes)!;
	$mail{'Message-Id'} = join('.', '<abp',$eC->{aK}, $eC->{fI}, time()).'@'.substr($eC->{pQ},0,6).$$.'>';
 if($parent) {
 $mail{Body} .= "\n"."In reply to: @{[$parent->nH($self, -1)]}\n";
 }
 if($self->{xG}) {
 $mail{Body} .= "\n\n$self->{bXz}->{body}\n";
 $mail{Body} =~ s/<p ab>/\n\n/g;
 $mail{Body} =~ s/<br ab>//g;
 abmain::wDz(\$mail{Body}) if $self->{mJz};
 }
 	$mail{Smtp}=$self->{cQz};

 $mail{Body} .= "\n\nThe original message is at  @{[$eC->nH($self, -1)]}";
 $mail{Body} .= "\n-------------------\n          Sent by AnyBoard (http://netbula.com/anyboard/)\n";
 $mail{Body} .= "\n".$self->{jBa};
 $wN ="";
 if($dTz) {
 if($self->{notify_usr} && ! $iSz) {
 $mail{Mlist} = $self->hWz(0, 0, 1, 0, 0, 1);
 }
#x1
 	abmain::error('sys', "Error when sending notification to admin:<br/>". $abmain::wH)
 	if ($abmain::wH && $self->{wQ});
 $wN = "forum administrator";
 }	
 if($dSz) {
 $mail{To} =  $parent->{email};
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= ", " if $wN;
 $wN .= " original author";
 }
 if($reportboss) {
	   $mail{To} =  $self->{iZa};
	   $mail{Subject} =  $eC->{wW};
 $mail{Body} = qq!$eC->{wW} ---  $eC->{hC}!;
 $mail{Body} .= "\n\n$self->{bXz}->{body}\n";
 abmain::wDz(\$mail{Body}) if $self->{mJz};
 $mail{Body} .= "\n\nThe original message is at  @{[$eC->nH($self, -1)]}";
 $mail{Body} .= "\n".$self->{jBa};
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= ", " if $wN;
 $wN .= "bosses";
 
 }
 if($iSz) {
#x1
 $wN .= ", " if $wN;
 $wN .= "all users";
 }
 if($cc_self && $reply_to) {
	   $mail{To} =  $reply_to;
 $mail{Subject} = "Your message on $self->{name}: $eC->{wW}";
	   delete $mail{Mlist};
 abmain::vS(%mail); 
 abmain::error('sys', "Error when sending notification:<br/>". $abmain::wH)
 if ($abmain::wH && $self->{wQ});
 $wN .= " and " if $wN;
 $wN .= " yourself ";
 
 }
 $bNz=1;
 }
 if($self->{oXz} && $parent && ($parent->{xE} & $oRz) && $parent->{eZz}) {
 undef %mail;
 $mail{To} = $eC->{email};
 $mail{From} = $self->{notifier};
 $mail{Subject} = "Re: $eC->{wW}";
 $mail{Body} = "Dear $eC->{hC}:\n\n";
 $mail{Body} .= $self->{pHz};
 $mail{Body} .= "\n\n"."Your message was:\n$self->{bXz}->{body}" if $self->{nAz};
 if ($self->{mZz} && $self->{nEz} =~ /\@/ ) {
 my %mailmap;
 map { $mailmap{lc($_)}=1 } split /\s+/, $self->{nEz}; 
 abmain::error('deny', "Not in mail list. No back mail sent.") 
 if not $mailmap{lc($eC->{email})}
 }
 my $e = abmain::mXz(\%mail, $self->bOa($parent->{eZz}));
 abmain::error('sys', "When mail back: $e") if $e; 
 $jW::mailed_back =1;
 }

}

# end of jW::kA
1;
