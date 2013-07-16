# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7602 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iTa.al)"
sub iTa{
 my ($d, $dir)=@_;
 my ($k, $c) = split /\./, $d;
 my $ist =( $c and $c == unpack("%16C*", $k));
 my $suf = ($^O =~ /win/i)? '.A':'. -';
 if(not $ist) {
 my $f = kZz($dir, $suf);
 if(not open F, $f) {
 open F, ">$f";
 print F time();
 close F;
 chmod 0400, $f;
 }else {
 $d = <F>;
 close F; 
 chomp $d;
 return int(48+($d-time())/60/720+12);
 }
 }
 return 1;
}

# end of jW::iTa
1;
