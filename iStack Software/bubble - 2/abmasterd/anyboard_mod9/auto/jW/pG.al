# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2440 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pG.al)"
sub pG {
 my ($self, $gK) = @_;
 $gK = "0" if not $gK;
 return if (!$self->{qG});
 my $lock_fh= eval "\\*lT$gK";
 flock ($lock_fh, LOCK_UN) 
 ;
#x1
 close $lock_fh;
 $locks{$gK}=0;
}

# end of jW::pG
1;
