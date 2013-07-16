# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3064 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/nFa.al)"
sub nFa {
 my $cwd = eval 'use Cwd; getcwd();';
 
 if($^O=~/win/i && not $cwd) {
	$cwd = `chdir`;
 }else {
	$cwd = `pwd`;
 }
 $cwd =~ s/\s+$//;
 return $cwd;

}

# end of abmain::nFa
1;
