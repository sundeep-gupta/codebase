# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 9248 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mXa.al)"
sub mXa{
	my ($self, $txt, $name) = @_;
 my $bad_re_old= q@(f\s*u\s*c\s*k|fxxk|asshole)@;
 my $bad_re= $self->{forbid_words} || $bad_re_old;
	my $gbad = $abmain::gforbid_words;
 $bad_re =~ s/^\|//;
 $bad_re =~ s/\|+$//;
 $gbad =~ s/^\|//;
 $gbad =~ s/\|+$//;
 return if not ($bad_re || $gbad);
 if($txt =~ /($bad_re)/im){
 $jW::fO = $1;
 if("the quick brown fox" =~ /$bad_re/im) {
 &abmain::error('sys', "Exclusion pattern excluded common sentence");
 }
 &abmain::error('forbid_words', "$name, did you say $jW::fO?");
 }
 if($gbad =~ /\S/ && $txt =~ /($gbad)/im){
 $jW::fO = $1;
 if("the quick brown fox" =~ /$gbad/im) {
 &abmain::error('sys', "Exclusion pattern excluded common sentence");
 }
 &abmain::error('forbid_words', "$name, did you say $jW::fO?");
 }
}

# end of jW::mXa
1;
