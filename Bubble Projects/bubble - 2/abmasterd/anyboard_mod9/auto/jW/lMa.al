# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2039 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/lMa.al)"
sub lMa{
 my ($self, $file, $r, $chk) = @_;
 my $suf = ""; $suf = rand() if $r;
 if((not $self->{_off_web}) && (not $abmain::off_webroot) && (not $self->{dyna_forum}) && (not ($chk && $self->{mFa}) )) {
 if(not $r) {
 		return abmain::kZz($self->{pL} , sVa::cIaA($file));
 }else {
 		return abmain::kZz($self->{pL} , sVa::cIaA($file)."?$suf");
 }
 }else {
	my $f = dZz::nBz($file);
	$f =~ s/\n$//;
	$f =~ s/\r$//;
	$f = abmain::wS($f);
	$file =~ s!.*/!!;
	my $cgi = $self->{cgi_full};
	if((not $abmain::no_pathinfo) && (not $self->{_no_pi}) ) {
		#$cgi= abmain::kZz($cgi, $abmain::bRaA,$file);
 }
 	return "$cgi?@{[$abmain::cZa]}cmd=retr;vf=$f";
 }
}

# end of jW::lMa
1;
