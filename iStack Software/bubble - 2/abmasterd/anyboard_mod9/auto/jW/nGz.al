# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8031 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nGz.al)"
sub nGz { 
 my($self, $cG, $aK, $arch, $jK, $priv)=@_;
 my ($xm, $xt) = (unpack("h*", $cG), unpack("H*", $aK)); 
 $jK =0 if not $jK;
 my $lDa;
 $lDa=";domod=1" if $self->{_doing_moder};
 return "$self->{cgi}?@{[$abmain::cZa]}cmd=get;cG=$xm;zu=$xt;v=2;gV=$arch;p=$priv$lDa" if $jK >=0 ;
 return "$self->{cgi_full}?@{[$abmain::cZa]}cmd=get;cG=$xm;zu=$xt;v=2;gV=$arch;p=$priv$lDa";
}

# end of jW::nGz
1;
