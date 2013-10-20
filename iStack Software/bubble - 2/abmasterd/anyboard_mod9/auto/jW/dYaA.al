# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8577 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/dYaA.al)"
sub dYaA {
 my ($self, $kQ, $url) = @_; 
 my $f = $self->bJa($kQ, 'mbox');
 $bYaA->new($f, {schema=>"AbMsgBox", paths=>$self->dHaA($f), index=>5})
		->jLa([$url]);
}

# end of jW::dYaA
1;
