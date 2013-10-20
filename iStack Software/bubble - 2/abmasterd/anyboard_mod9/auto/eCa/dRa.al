# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 659 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/dRa.al)"
sub dRa {
 my ($db, $words, $jVa, $shared) = @_;
#      hash  content  file-id   options	
 my (%worduniq);
 my $kGa = $shared->{kGa};	    
 my (@words) = split( /[^a-zA-Z0-9\xc0-\xff\+\_]+/, lc $words); 
 my %jJa;

 @words = grep { length  > $kGa } 		
	     grep { s/^[^a-zA-Z0-9\xc0-\xff]+//; $_ }	
 grep { /[a-zA-Z0-9\xc0-\xff]/ } 	
 @words;
 for (@words) {     			
	$jJa{$_} ++;
 }
 for(keys %jJa) {
	my $a = $db->{$_};	
	$a .= pack "n2",$jVa, $jJa{$_};	
 $db->{$_} = $a;
 }
 return int keys %jJa;
}

# end of eCa::dRa
1;
