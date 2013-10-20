# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1226 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/oEa.al)"
sub oEa{
 my ($dir, $foundarr, $match, $hO, $maxlev, $fN)=@_;
 return if $maxlev && $hO > $maxlev;
 $hO ++;
 local *DIR;
 opendir DIR, "$dir";
 my @entries = readdir DIR;
 closedir DIR;
 local *F;
 my @dirs = grep { -d "$dir/$_" && ! /^\.\.?$/  && /$match/i} @entries;

 for my $e (@dirs) {
 my $thisd = kZz($dir, $e);
 oEa($thisd, $foundarr, $match, $hO, $maxlev);
 next if not -w $thisd;
 push @$foundarr, $thisd if nZa($thisd);;
 return if scalar(@$foundarr) > ($fN||10);
 }
}

# end of sVa::oEa
1;
