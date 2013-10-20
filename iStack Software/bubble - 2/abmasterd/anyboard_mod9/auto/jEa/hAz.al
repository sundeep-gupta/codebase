# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 154 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/hAz.al)"
sub hAz{
 my ($delf, $ids, $opts) =@_;
 local *TBF;
 open TBF, "<$delf" or return;
 local $/=undef;
 my $l = <TBF>;
 $l =~ s/\s+$//g;
 my @ids = split /\r?\n/, $l;
 my $idhsh = {};
 for(@ids) {
	$idhsh->{$_} =1 if $_ ne "";
 }
 close TBF;
 return $idhsh; 
}

# end of jEa::hAz
1;
