# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3575 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/qQa.al)"
sub qQa{
	my ($self) = @_;
	return if not $self->{_show_prog};
	print $jW::prog_step;
	print "<br/>\n\n" if ($self->{_prog_steps}++%20)==0;

}

# end of jW::qQa
1;
