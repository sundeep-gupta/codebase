# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 191 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bLaA.al)"
sub bLaA{
 my ($self, $maxsize, $skips, $includes) = @_;
 my $tb = $self->{tb} ;
 my $len = @{$tab_desc{$tb}};
 my @fs=();
 for( my $i=0; $i<$len; $i++) {
	my ($field, $prec, $null) = ($tab_desc{$tb}->[$i], $precision_desc{$tb}->[$i], $nullable_desc{$tb}->[$i]); 
	next if ($skips && $skips->{$field});
	next if $maxsize>0 && $prec > $maxsize;
	push @fs, $field ;
 }
 return @fs;

}

# end of zDa::bLaA
1;
