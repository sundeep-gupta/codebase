# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1603 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fIaA.al)"
sub fIaA {
 my ($path) = @_;
 $path =~ /\S+\.([^\.]*)$/;
 
 my $type = lc($1) || "octet-stream";
 my %mimemap=(cac=>'text/html', txt=>'text/plain', gif=>'image/gif', jpg=>'image/jpeg', jpeg=>'image/jpeg', vcf=>'text/v-card'); 
 my $lRa= $mimemap{$type} || "application/$type";
 $lRa='text/html' if $lRa =~ /(htm|asp|php)/i || $path =~ /\.pv$/g;
 return $lRa;
}

# end of sVa::fIaA
1;
