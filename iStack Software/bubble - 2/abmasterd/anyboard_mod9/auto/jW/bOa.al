# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1975 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/bOa.al)"
sub bOa {
 my ($self, $ufile)=@_;
 my @files = split /\s+/, $ufile;
 my @paths = map { abmain::kZz($self->nDz('updir'),$_) } @files;
 return @paths;
}

# end of jW::bOa
1;
