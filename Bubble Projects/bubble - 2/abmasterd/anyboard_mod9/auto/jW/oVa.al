# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4885 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/oVa.al)"
sub oVa {
	my ($self, $hsh)=@_;
 my %attr;
 my @cols = ($self->{cbgcolor0}, $self->{cbgcolor1});
 $attr{tha} = qq(bgcolor="$self->{cfg_head_bg}");
 $attr{trafunc} = sub { my $i = shift; my $col = $cols[$i++%2]; return $col? qq(bgcolor="$col") : ""; };
 $attr{usebd}=$self->{usebd};
 $attr{tba}=qq(cellpadding="3" cellspacing="1" border="0");
 $attr{thafunc}= sub { my ($col, $ncol) = @_; return qq(bgcolor="$self->{cfg_head_bg}"); };
 $attr{tcafunc}= sub { my ($row, $col) = @_; my $colo=$self->{gridtab}? $cols[($row+$col)%2] : $cols[$row%2]; return qq(valign="top" bgcolor="$colo"); };
 $attr{thfont}= $self->{cfg_head_font}; 
 $attr{width}="90%";
 for(keys %$hsh) {
		$attr{$_} = $hsh->{$_};
 }
 return %attr;
}

# end of jW::oVa
1;
