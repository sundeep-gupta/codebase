# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 168 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/mIa.al)"
sub mIa{
 my ($lref, $start, $end) = @_;
 my @res;
 my $i;
 my $str;
 for($i=$start; $i<$end; $i++) {
 $str = $lref->[$i];
 	$str =~ tr|A-Za-z0-9+=/||cd;            
 	if (length($str) % 4) {
 
 	}
 	$str =~ s/=+$//;                       
 	$str =~ tr|A-Za-z0-9+/| -_|;          
 	while ($str =~ /(.{1,60})/gs) {
		my $len = chr(32 + length($1)*3/4); 
		push @res, unpack("u", $len . $1);   
	}
 
 }
 return join('', @res);
}

# end of dZz::mIa
1;
