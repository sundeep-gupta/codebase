# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7302 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/xNa.al)"
sub xNa{
 sVa::gYaA "Content-type: application/x-javascript\n\n";
 my $cVaA = ($abmain::agent =~ /MSIE\s*(5|6)/i);
 print sVa::xPa($abmain::gJ{xZa}) if ($cVaA && $ENV{HTTP_REFERER}=~/anyboard/);
}

# end of abmain::xNa
1;
