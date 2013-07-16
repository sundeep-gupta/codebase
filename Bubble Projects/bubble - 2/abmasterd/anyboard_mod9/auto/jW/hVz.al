# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1440 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/hVz.al)"
sub hVz{
 my $self = shift;
 return if (time()-$self->{_fonts_compiled}) < 30;
 my $uf = $self->{user_fonts};
 my @gHz = split "\n", $uf;
 for(@gHz) {
	my ($u, $v) = split '=', $_, 2;
	next if not $u;
 	abmain::jJz(\$u);
	$self->{_usr_fonts}->{lc($u)} = $v;
 }
 $uf = $self->{user_subj_fonts};
 $self->fetch_usr_attrib();
 @gHz = split "\n", $uf;
 for(@gHz) {
	my ($u, $v) = split '=', $_, 2;
	next if not $u;
 	abmain::jJz(\$u);
	$self->{_usr_subj_fonts}->{lc($u)} = $v;
 }
 $self->{_fonts_compiled} = time();
}

# end of jW::hVz
1;
