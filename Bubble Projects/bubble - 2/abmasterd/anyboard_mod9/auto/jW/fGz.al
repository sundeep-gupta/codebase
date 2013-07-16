# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 198 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fGz.al)"
sub fGz {
 my ($self, $str, $tag) = @_;
 my $font = $self->{$tag};
 return $str if not $font;
 return "<font $font>$str</font>";
}

# end of jW::fGz
1;
