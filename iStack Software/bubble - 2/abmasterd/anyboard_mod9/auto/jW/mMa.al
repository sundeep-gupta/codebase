# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8054 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mMa.al)"
sub mMa{
 my ($self, $where, $maxintv) = @_;
 my ($ul, $ths)= $self->fTa($where, undef, 300);
 return if not @$ul;
 return abmain::qAa(ncol=>4, tba=>qq(cellpadding="3" cellspacing="1" bgcolor="$self->{cbgcolor0}"), 
	tha=>qq(bgcolor="$self->{bgmsgbar}"), th=>$self->{online_users_lab}, usebd=>1, 
 vals=>[map {abmain::cUz(
 "$self->{cgi}?@{[$abmain::cZa]}cmd=form;kQz=".abmain::wS($_->[0]), "<b>$_->[0]</b>").": <small>".$_->[1]."</small>"} @$ul ] );
}

# end of jW::mMa
1;
