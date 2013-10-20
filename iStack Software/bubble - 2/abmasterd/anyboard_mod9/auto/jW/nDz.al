# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2206 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nDz.al)"
sub nDz {
 my ($self, $which, $dir)=@_;
 my $wf = $jW::hNa{$which};
 abmain::error('sys', "File for $which is not set!") if $wf eq "";
 if(($^O=~/win/i && $abmain::new_win32_user) || $abmain::no_dot_file) {
	$wf =~ s/^\.//;
 }
 return abmain::kZz($dir||$self->{eD}, $wf);
}

# end of jW::nDz
1;
