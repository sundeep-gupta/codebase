# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1276 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/dHa.al)"
sub dHa{
 my($self) = @_;
 my $aJa = $self->{zKz};
 my @fs =();
 foreach (@{$aJa->{jF}}) {
 next if not $_;
 my $ele= $aJa->{bLa}->{$_->[0]};
	    next if not $ele;
 my $fn = $ele->{name};
 my $ft = $_->[1];
 next if ($ft eq 'head' || $ft eq 'command');
 my $v = $self->{$fn};
 my $sv;
 if($ft eq 'file' and $v ne "") {
 my $path = $v->[0];
		$sv = $path;
 
 }else {
		  $sv = $ele->bCa($v);
	    }
	    push @fs, sVa::wS($sv);
 }
 return @fs;
}

# end of aLa::dHa
1;
