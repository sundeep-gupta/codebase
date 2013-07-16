# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 736 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/pG.al)"
sub pG {
 my ($gK) = @_;
 $gK = "0" if not $gK;
 my $lock_fh= eval "\\*lT$gK";
 flock ($lock_fh, LOCK_UN) 
 ;
#x1
 close $lock_fh;
 $locks{$gK}=0;
}

# end of sVa::pG
1;
