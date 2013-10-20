# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1258 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/oVa.al)"
sub oVa {
 my $hsh= shift;
 my %attr;
#	$attr{trafunc} = sub { my $i = shift; my $idx = $i++%2; my $col = ("#ffffff", "#ffffff")[$idx]; return qq(bgcolor="$col"); };
#        $attr{thafunc}= sub { my ($col, $ncol) = @_; return qq(bgcolor="#eeeeee"); };
 $attr{usebd}=$hsh->{usebd} || 0;
#        $attr{tba}=qq(cellpadding="2"  border="0");
 $attr{width}= $hsh->{width} ||"100%";
	$attr{capt}=undef;
	$attr{title}=undef;
	$attr{border_bg} = qq(#006699);
 for(keys %$hsh) {
		$attr{$_} = $hsh->{$_};
 }
 return %attr;
}

# end of sVa::oVa
1;
