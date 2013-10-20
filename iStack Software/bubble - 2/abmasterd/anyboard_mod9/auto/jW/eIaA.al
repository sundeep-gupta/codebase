# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1824 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/eIaA.al)"
sub eIaA {
	my ($self, $input) = @_;
 $self->cR();
	$self->{yLz} = 'POST';
	$self->{tHa} = 1;
	$self->gCz();
 $self->eMaA( [qw(other_header other_footer)]);
 	sVa::gYaA "Content-type: text/html\n\n";
 	print qq(<html><head>$self->{sAz}\n$self->{other_header}
 <center>
 <table border="0" cellpadding="5" width=60%><tr rowspan=2 bgcolor="$self->{cfg_head_bg}"><th><font $self->{cfg_head_font}>User control panel</font></th></tr></table>
		</center>
 );
 	print $self->cNaA($self->{fTz}->{name});
 	print "$self->{other_footer}";
}

# end of jW::eIaA
1;
