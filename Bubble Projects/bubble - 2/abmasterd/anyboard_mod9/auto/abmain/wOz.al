# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3579 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wOz.al)"
sub wOz{            
 my $idx = abmain::kZz($abmain::eD, "_cindex.html");
 if( (-f $idx ) && (stat($idx))[9] > time() - 3600 ) {
 goto E_O_I if not $abmain::gJ{lF};
 } 

 my $pstr = abmain::lPz($abmain::eD);
 my $all = $abmain::gJ{all};

 my $cats = vQz($abmain::eD, $dLz);
 my @gHz;
 push @gHz, "<html><title> Category list under $cats->[0] </title><body bgcolor=#ffffff>",
 $pstr, "<hr>",
 "<h1>Category list ($cats->[0]) </h1>";
 my @cstack=($cats);
 my $cat;
 while( $cat = pop @cstack) {
 if(not $cat->[1]) {
 push @gHz, $cat->[0];
 next;
 }
 if($cat->[3]) {
 	push @cstack, ["\n</ul>\n"];
 	push @cstack, @{$cat->[3]};
 	push @gHz, "<ul>";
 }
 push @gHz, "\n<li>",
 abmain::cUz(abmain::kZz($cat->[1], "/?@{[$abmain::cZa]}cmd=lGz"), $cat->[0]);
 push @gHz, " <small>(", (int scalar(@{$cat->[4]}))." forums</small>) "; 
 }
 push @gHz, "<hr>$pstr          ";
 push @gHz, qq@<a href="javascript:history.go(-2)">$iS->{back_word}</a>@;
 push @gHz, "</body></html>";

 open F, ">$idx" or abmain::error('sys', "$!");
 print F @gHz;
 close F;

 open F, ">".abmain::kZz($abmain::eD, "cindex.html") or abmain::error('sys', "$!");
 print F qq(<html><head><META HTTP-EQUIV=refresh CONTENT="0; URL=),
 abmain::kZz($dLz, "/?@{[$abmain::cZa]}cmd=list_cats"), 
 qq("></head><body></body></html>);
 close F;

E_O_I:
 sVa::hCaA "Location: ", abmain::kZz($abmain::pL, "_cindex.html"),"\n\n";

}

# end of abmain::wOz
1;
