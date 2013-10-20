# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 258 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/nH.al)"
sub nH {
 my ($self, $iS, $jK, $gV, $cG, $noredir, $forcepriv)=@_;



 my $in = $cG || $self->{fI};
 my $cLaA = $in;
 my $yYz=0;
 my $priv = $self->qRa()||$forcepriv;

 if($iS->{aO}) {
 $in = 0;
 	   $yYz=1;
 } elsif ($iS->{lJ} || $gV){
 $in = $self->{aK};
 	   $yYz=1;
 }
 my ($url, $tag);
 if($in >=0) {
 
 $tag = '#'.$cLaA;

 if ($jK == $in) {
	 return $tag;
 }

 if(($abmain::off_webroot || $iS->{allow_user_view} || $iS->{bMz} || $iS->{qKa} || $iS->{force_login_4read}) ||$iS->{dyna_forum} || $priv && not $noredir){
 $url = $iS->nGz($cLaA, $self->{aK}, $gV, $jK, $priv);
 }elsif($jK<0 || $iS->{mFa}) {
 $url = $iS->jA($in, "AB", $gV, $priv);
 }elsif($jK >0) {
 $url = $iS->jA($in, "jD", $gV, $priv);
 }
 elsif($jK == 0) {
 $url = $iS->jA($in, "kU", $gV, $priv);
 }
 $tag ="" if not $yYz;
 return $url.$tag;

 }else { ## this may never apply
 if(($iS->{bMz} || $iS->{qKa} || $iS->{allow_user_view} || $iS->{force_login_4read} || $iS->{dyna_forum} || $priv) && not $noredir){
 $url = $iS->nGz($cLaA, $self->{aK}, $gV, $jK, $priv);
 }
 if($jK ==0 ){
 $url = $iS->jA($cLaA, "kU", $gV, $priv);
 }
 elsif($jK >0) {
 $url = $iS->jA($cLaA, "jD", $gV, $priv);
 } 
 elsif($jK <0) {
 $url = $iS->jA($cLaA, 'AB', $gV, $priv);
 }
 return $url;
 }
}

# end of lB::nH
1;
