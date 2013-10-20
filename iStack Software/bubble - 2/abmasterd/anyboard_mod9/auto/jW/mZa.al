# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2215 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mZa.al)"
sub mZa{
 my ($self, $cG, $suf)=@_;
 my $wf = $jW::hNa{'rating'};
 if(($^O=~/win/i && $abmain::new_win32_user) || $abmain::no_dot_file) {
	$wf =~ s/^\.//;
 }
 my $code = ($cG%$jW::hash_cnt) || 0;
 $suf ||="";
 if($abmain::use_sql) {
 	return $self->nDz('msglist') if not $suf; 
 	return $self->nDz('archlist') if $suf eq 'a'; 
 	return $self->nDz('dmsglist') if $suf eq 'd'; 

 }
 return abmain::kZz($self->nDz('iC'), $wf.$code.$suf);
}

# end of jW::mZa
1;
