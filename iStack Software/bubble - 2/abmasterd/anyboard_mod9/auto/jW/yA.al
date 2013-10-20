# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9006 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yA.al)"
sub yA {
 my ($self, $vf, $formod) = @_;

 $abmain::js = $vf->{'abc'};

 my ($name, $to);
 if ($vf->{'name'}) {
 $name = "$vf->{'name'}";
 my $err;
 if($err=abmain::jVz($name)) {
 abmain::error('inval', $err);
 }
 abmain::jJz(\$name);
 
 $self->{bXz}->{name}=$name;
 $self->{bXz}->{name} = $ENV{REMOTE_USER} if $self->{http_auth_only};

 my $n_re = $self->{forbid_names};
 if($n_re) {
 &abmain::error('inval', "The name you used is not allowed") if $name =~ /$n_re/i;
 }

 if(length($name) > $self->{sO}){
 &abmain::error('iK', "Name field must be less than ${\($self->{sO})} characters");
 }

 $abmain::jH = $abmain::fPz{$abmain::dS};
 
 if($abmain::jH > $self->{sF} || $abmain::hI{$abmain::ab_id1} || $abmain::hI{$abmain::ab_track}|| $abmain::hI{$name}) {
 &abmain::error('nG', "$name has $abmain::jH violations") if($abmain::js ne 'hV');
 &abmain::error('deny');
 }
 }
 else {
 &abmain::error('miss', "Name is missing") if !$self->{fWz};
 }
 $to = $vf->{to} || $vf->{priv_reply};
 abmain::jJz(\$to);
 $self->{bXz}->{to}= $to;
 $self->{bXz}->{take_priv_only} = $vf->{take_priv_only};

 if ($vf->{'email'} =~ /.*\@.*\..*/) {
 my $email = $vf->{'email'};
 $self->{bXz}->{email}=$email;
 }

 if ($vf->{'subject'}) {
 my $subject = "$vf->{'subject'}";
 if(length($subject) > $self->{qJ}){
 &abmain::error('iK', "Subject must be less than ${\($self->{qJ})}");
 }
 $subject =~ s/\&/\&amp\;/g;
 $subject =~ s/"/\&quot\;/g;
 $subject =~ s/>/&gt;/g;
 $subject =~ s/</&lt;/g;
 $subject =~ s/\t/ /g;
 $subject =~ s/\n/ /g;
 $self->{bXz}->{wW}=$subject;
 }
 else {
 &abmain::error('miss', "Subject is missing");
 }

 $jUz = 0;

 $vf->{'url'} =~ s/^\s+//;
 $vf->{'url'} =~ s/\s+$//;
 if ($vf->{'url'}) {
 my $url = $vf->{'url'};
 if(length($url) > 4*$self->{qJ}){
 &abmain::error('iK', "URL must be less than ${\(4*$self->{qJ})}");
 }
 $url = "" unless $url =~ /.*tp:\/\/.*\..*/;
 $self->{bXz}->{url}=$url;
 $self->{bXz}->{url_title}=  $vf->{url_title} if $url;
 $jUz |= $FHASLNK if $url; 
 }

 $self->{bXz}->{sort_key} = $abmain::gJ{sort_key};
 $self->{bXz}->{key_words} = $abmain::gJ{key_words};
 $self->{bXz}->{upfiles}= \%abmain::mCa;
 if ($self->{auto_rename_file}) {
	for(values %abmain::mCa) {
	     my $fn = $_->[0];
 my $i=1;
 while(-f $self->cPz($_->[0])) {
		$_->[0] =   $i."_".$fn;
		$i++;
	     };
	}
 }

 my @upfile_names;
 for(values %abmain::mCa) {
 	 if ($_->[0]) {
 	    &abmain::error('inval', "Attempt to upload disallowed file type, must be of type $self->{upfile_ext}")
 	    if($self->{upfile_ext} &&  not $_->[0] =~ /\.$self->{upfile_ext}$/i); 
	     $_->[0] = "pv-".$_->[0] if $to;
 
 	    &abmain::error('inval', "Uploaded file must be smaller than $self->{upfile_max} KB")
 	    if ($self->{upfile_max} >0 && length($_->[1]) > $self->{upfile_max}*1024); 
	    push @upfile_names, $_->[0];
 
 	 }
 }

 &abmain::error('inval', "Attempt to upload too many files") if scalar(@upfile_names) > 1 + $self->{max_extra_uploads};

 $self->{bXz}->{eZz} = join(" ", @upfile_names);

 if ($vf->{'img'} =~ /.*tp:\/\/.*\..*/i ) {
 my $img = "$vf->{'img'}";
 $self->{bXz}->{img}= $img;
 }
 if ($self->{bXz}->{img} || $self->{bXz}->{eZz} =~ /\.(gif|jpg)( |$)/i) {
 $jUz |= $pTz;
 }
 if ($self->{bXz}->{take_priv_only} ) {
 $jUz |= $FTAKPRIVO;
 }
 if($vf->{used_fancy_html}) {
 $jUz |= $FFANCY;
 }
 
 
 if($vf->{dUz}) {
 $jUz |= $pEz;
 }
 if($vf->{allow_no_reply}) {
 $jUz |= $pYz;
 }
 
 if($vf->{fM}=~/[a-z]/i){
 $self->{nT} = $vf->{fM};
 }
 $self->{bXz}->{repredir} = $vf->{repredir};
 $self->{bXz}->{repmailattach} = $vf->{repmailattach};
 $self->{bXz}->{scat} = $vf->{scat};

 $self->jJ($vf);
 if (not $self->{qDz}) {
	for(values %abmain::mCa) {
 	abmain::error('inval', "Attempt to upload a file that exists") 
 		if -f $self->cPz($_->[0]);
	}
 }

 abmain::error('miss', "Please choose a category") if($self->{allow_subcat} && $self->{no_null_subcat}
 && $vf->{scat} eq "" && not $formod );

 $lV = abmain::dU();
 if($self->{filter_words}) {
 $self->{bXz}->{body} =~ s/$self->{filter_words}/\?\?\?/ig; 
 $self->{bXz}->{wW} =~ s/$self->{filter_words}/\?\?\?/ig; 
 }
 $self->mXa(join(" ", $self->{bXz}->{body}, $self->{bXz}->{name},  $self->{bXz}->{wW}), $self->{bXz}->{name});
 $self->{bXz}->{mood} = $vf->{mood};
}

# end of jW::yA
1;
