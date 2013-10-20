# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8923 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gDaA.al)"
sub gDaA {
	my ($self) = @_;
	return if not $self->{bXz};
	my @rows;
	push @rows, ["Subject", $self->{bXz}->{wW}];
	push @rows, ["Message", $self->{bXz}->{body}];
 return sVa::fMa(rows=>\@rows, ths=>[jW::mJa($self->{cfg_head_font}, ("Post information"))], $self->oVa()); 
}

# end of jW::gDaA
1;
