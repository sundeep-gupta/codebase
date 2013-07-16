# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1695 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cNaA.al)"
sub cNaA {
 my ($self, $kQ) = @_; 
 my $url = $self->fC();
 my $str = qq(<table border="0" cellpadding="5" width=60% align=center class="UserControlPanel">);
 my $i=0;
 $str .= jW::nKz($bgs[$i++%2], qq(<a href="$url"> Go to $self->{name} </a>) ); 
 my $palert;
 if($self->{kWz}) {
 my ($mycnt, $myt) = $self->wUz($kQ);
 my $str2;
 my $d = int $myt /24/60;
 my $h = int (($myt - $d * 24*60) /60);
 my $m = $myt % 60;
 my $t;
 $t = "$d days " if $d >0;
 $t = "$h hours " if ($h >0 && not $t);
 $t = "$m minutes" if ($m >0 && not $t);
 $t = "0 minutes" if not $t;
 $str2 = ", updated $t ago" if $mycnt >0;
 $palert = $self->mYa($kQ);
 $str .= jW::nKz($bgs[$i++%2],  
 abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=myforum", "Go to $self->{kRz}"). " ($mycnt messages $str2)<br/>$palert");
 my $pmb = $self->eKaA(lc($kQ));
 $str .= jW::nKz($bgs[$i++%2], $pmb) if $pmb; 
 }
 
 if($self->{gFz}->{lc($kQ)}->[4]) {
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=xV", "Modify your registration"));
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}cmd=mform", "Edit your profile, such as signature"))
 if $self->{mp_enabled}; 
 }
 if(!$self->{no_user_doc}) {
 $str .= jW::nKz($bgs[$i++%2],  abmain::cUz("$self->{cgi}?@{[$abmain::cZa]}docmancmd=fVaA", "Manage your documents"));
 }
 if($self->{login_msg}) {
 $str .= qq(<tr bgcolor="$self->{cfg_head_bg}"><td align="center"><h2><font $self->{cfg_head_font}>Message from forum administrator</font></h2></td></tr>
 <tr><td>$self->{login_msg}</td></tr>);
 }
 $str .="</table>";
 return $str;
}

# end of jW::cNaA
1;
