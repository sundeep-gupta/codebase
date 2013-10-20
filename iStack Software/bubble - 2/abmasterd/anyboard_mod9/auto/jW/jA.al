# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2324 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/jA.al)"
sub jA {

 my ($self, $fI, $type, $gV, $priv) = @_;
 my $mdir = $gV? $jW::hNa{mK}: $jW::hNa{hM};
 my $eS;
 my $suf ="";
 $suf = ".pv" if $priv;

 if($fI>0) {
 $eS= "$fI.". $self->{ext}.$suf;
 }else {
 $eS = $gV? $self->dMz() : $self->dIz();
 $mdir = "";
 }

 if($type eq 'jD') {
 return "$eS";
 }
 elsif($type eq 'kU') {
 return abmain::kZz($mdir, $eS);
 }else {
 return $self->lMa(abmain::kZz($mdir, $eS));
 }
}

# end of jW::jA
1;
