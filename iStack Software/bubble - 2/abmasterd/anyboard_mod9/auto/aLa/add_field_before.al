# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 320 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/add_field_before.al)"
sub add_field_before{
 my ($self, $fn, $f, $prefix) = @_;
 my $aJa = $self->{zKz};
 my @fs =  @{$aJa->{jF}};
 my @nfs ;
 $f->[0] .= "${prefix}_" if $prefix;
 for(my $i=0; $i< @fs; $i++) {
 my $p =$fs[$i];
 next if not $p;
 if($p->[0] eq $fn) {
			push @nfs, $f;
		}
		push @nfs, $p;
 }
 @{$aJa->{jF}} = @nfs;
 $self->{zKz}->{bLa}->{$f->[0]} = bYa($f);
 $self->{zKz}->{bLa}->{$f->[0]}->{form} = $self;
 $self->{$f->[0]} = $f->[4];

}  

# end of aLa::add_field_before
1;
