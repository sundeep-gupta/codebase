# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 371 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/nBz.al)"
sub nBz ($;$)
{
 my $res = "";
 my ($str, $eol) = @_;
 $eol = "\n" unless defined $eol;
 pos($str) = 0;     
 while ($str =~ /(.{1,45})/gs) {
	$res .= substr(pack('u', $1), 1);
	chop($res);
 }
 $res =~ tr|` -_|AA-Za-z0-9+/|;    
 
 my $padding = (3 - length($str) % 3) % 3;
 $res =~ s/.{$padding}$/'=' x $padding/e if $padding;
 
 if (length $eol) {
	$res =~ s/(.{1,76})/$1$eol/g;
 }
 $res;
}

# end of dZz::nBz
1;
