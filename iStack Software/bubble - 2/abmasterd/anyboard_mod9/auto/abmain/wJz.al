# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 5045 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/wJz.al)"
sub wJz {
 if( not -e $abmain::oG){
 $iS->jI(\@abmain::dN, "bDz", "Create master admin first");
 abmain::iUz();
 }
 abmain::error('inval', "Parent directory does not exist") if not -d $iS->{eD};
 $iS->{hide_flink}=1;
 abmain::lIz($iS->{eD});
 $iS->{cat_name}="";
 $iS->{cat_desc}="";
 $iS->{cat_dir}="";
 $iS->jI(\@abmain::lQa, "lOz", "Create new category");
} 

# end of abmain::wJz
1;
