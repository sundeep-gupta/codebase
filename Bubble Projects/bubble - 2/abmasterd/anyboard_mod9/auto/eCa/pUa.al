# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 682 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/pUa.al)"
sub pUa {
 my ($db, $words, $jVa, $shared) = @_;
 my (%worduniq);
 my $kGa = $shared->{kGa};	    
 my (@words) = split( /(\s|`|'|"|,|\||;|:|#|\(|\)|\[|\])+/, lc $words); 
 my %jJa;
 my @words2;
 my @words3;
 if($shared->{wsplit}) {
	for(@words) {
		my @words3 = split /$shared->{wsplit}/o, $_;
		for my $k (@words3){
			if(length($k)<=4) {
				push @words2, $k;
			}else {
				my @x= split /$eCa::ws2/o, $k;
				push @words2, @x;
			}
		}
 }
 }else {
	@words2 = @words;
 }  
 for (@words2) {     			
	$jJa{$_} ++;
 }
 for(keys %jJa) {
	my $a = $db->{$_};	
	$a .= pack "n2",$jVa, $jJa{$_};	
 $db->{$_} = $a;
 }
 return int keys %jJa;
}

# end of eCa::pUa
1;
