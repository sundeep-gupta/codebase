# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 126 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/be_card.al)"
sub be_card{
 my ($v, $cardarr) = @_;
 #require sNa;
 my $cardt= sNa::zYz($v);
 return if($cardt && not $cardarr); 
 my $ok=0;
 for(@$cardarr) {
	uc($_) eq  $cardt and $ok =1 and last;
 }
 return " $cardt $bAa::invalid_card_label" if not $ok;		 

}

# end of bAa::be_card
1;
