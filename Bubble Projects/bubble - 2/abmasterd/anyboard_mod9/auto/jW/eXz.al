# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 442 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eXz.al)"
sub eXz {
 my ($self, $filelist, $sep)=@_;
 my $str = qq(<div class="MessageAttachment">\n);
 my @files = split /\s+/, $filelist;
 my $file;
 $sep = ' &nbsp;' if not $sep;
 foreach $file (@files) {
 my $fpath = abmain::kZz($jW::hNa{updir}, $file);
 	my $fsize = sVa::fWaA((stat(abmain::kZz($self->{eD}, $fpath)))[7]);
 my $urlimg = $self->lMa($fpath);
 my $urlicon = "$self->{cgi}?@{[$abmain::cZa]}cmd=lHa;img=$file";
 	if($file =~ /\.(gif|jpg)$/i) {
 if($self->{yRz}) {
 $str.=qq(<a href="$urlimg" target=_picwin><img src="$urlicon" ALT="click to view $file \($fsize\)"></a>);
 }else {
 	   	$str .= qq(<img src="$urlimg" ALT="$file \($fsize\)">);
	   }
 	}else {
 	   $str .= abmain::cUz($urlimg, $file ).$fsize;
 	}
 	$str .= $sep;
 }
 $str .="</div>";
 my $str2 = $self->{message_attachment_layout};
 $str2 =~ s/UPLOADED_FILES/$str/g;
 return $str2;
}

# end of jW::eXz
1;
