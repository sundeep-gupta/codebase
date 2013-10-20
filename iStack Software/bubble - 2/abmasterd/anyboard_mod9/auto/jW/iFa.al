# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2257 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iFa.al)"
sub iFa {
 my ($self, $path, $chkmov, $rds) = @_;
 my $ok = $self->gCz(!$self->{force_login_4read});
 
 $path =~ s/^\.\.$//g;
 my $root = $self->{eD};
 $root =~ s/\\/\//g;
 $path =~ s/\\/\//g;
 if($path !~ /^$root/) {
	$path = abmain::kZz($root, $path);
 }
 $path =~ s/`|\|&//g;
 $path =~ /\S+\.([^\.]*)$/;
 
 my $type = lc($1) || "octet-stream";
 my %mimemap=(cac=>'text/html', txt=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg', vcf=>'text/v-card'); 
 my $lRa= $mimemap{$type} || "application/$type";
 $lRa='text/html' if $lRa =~ /(htm|asp|php)/i || $path =~ /\.pv$/g;
 my $olv = $/;
 $/ = undef;
 if(not open F, "<$path") {
	if($chkmov && $path =~ /\.pv$/) {
		my $path2 = $path;
		$path2 =~ s/\.pv$//;
		if( -f $path2) {
			rename $path2, $path if -e $path2;
 			open F, "<$path"  or abmain::error('inval', "$path:: $!");
		}else {
			abmain::error("inval","$path: $!");
		}
 }else {	
		abmain::error("inval","$path: $!");
	}
 } 
 binmode F;
 sVa::gYaA "Content-type: $lRa\n";
 if(not ($lRa =~ /text/i || $lRa =~ /image/i || $lRa =~ /script/i)) {
 	print qq(Content-Disposition: attachment; filename="$path"\n);

 }
 if(not $abmain::fPz{vis}){
 	   print abmain::bC('vis', time, "/", abmain::dU('pJ', 60*3600*24));
 }
 print "\n";
 my $line = <F>;
 close F; 
 $/ = $olv;

 if(not $lRa =~ /text/) {
	binmode STDOUT;
	print $line;
	return;
 }
 my %cUa;
 if($lRa =~ /text/ && $self->{fTz}->{name}) {
	$cUa{LOGIN_USER} = abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=ulogout", $self->{logout_word}). " <b>" . $self->{fTz}->{name}."</b>";
	$cUa{PRIVATE_MSG_ALERT} = $self->mYa($self->{fTz}->{name});
 }
 if($rds) {
	$cUa{MSG_READERS} = "$self->{readers_lab} <b>".join(",\&nbsp; ", split (/,/, $rds))."</b>"; 	
 }
 $cUa{LOCAL_USER_LIST} = $self->mMa();
 my $all_fs = "";
 $all_fs = abmain::gIaA() if $self->{compute_forum_list};
 $cUa{ALL_FORUMS_LIST} = $all_fs;
 print  jW::mUa($line, \@jW::dyna_tags, \%cUa); 
}

# end of jW::iFa
1;
