# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3993 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/yHz.al)"
sub yHz {
 my ($self, $gV) = @_;
 my $idx= $self->dIz($gV);
 my $str;
 my $arch_x;
 $arch_x= ";gV=1;hEz=1" if $gV;
 my $pgurl= "$self->{cgi}?@{[$abmain::cZa]}cmd=vXz$arch_x;pgno=";
 $str = "\n".$abmain::lRz;
 $str .= $abmain::kSz;
 $str .= <<"EOF_JS2";
 var cook = new Cookie(document, "$self->{vcook}", 2400, "/");
 cook.load();
 function go_cp(tag) {
 if(!cook.vpage) cook.vpage=0;
 if(cook.vpage == 0) cook.vpage = "";
 url= "$pgurl" + cook.vpage + '&t='+tag +'#'+tag;
 location=url;
 }
EOF_JS2
 $str .= "\n".$abmain::js_end;
 return $str;
}

# end of jW::yHz
1;
