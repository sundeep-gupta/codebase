# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3295 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/lIz.al)"
sub lIz{
 my $catd = shift;
 my $catf = abmain::kZz($catd, $abmain::catidx);
 return ("", "", 1, 1) if(not -r $catf);
 my $iS = jW->new();
 $iS->cJ($catf, \@abmain::lQa);
 return ($iS->{cat_name}, $iS->{cat_desc}, $iS->{cat_list}, $iS->{cat_makeboard}, 
 $iS->{cat_news}, $iS->{cat_guide}, $iS->{cat_inherit}, $iS->{cat_inhe_guide}, $iS->{cat_sortkey});
}

# end of abmain::lIz
1;
