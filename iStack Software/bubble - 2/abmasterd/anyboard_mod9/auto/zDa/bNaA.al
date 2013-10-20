# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package zDa;

#line 206 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/zDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/zDa/bNaA.al)"
sub bNaA{
 my ($self, $id, $maxsize) = @_;
 my $fields = undef;
 if(defined($maxsize)) {
 $fields = [ $self->bLaA($maxsize)];
 }
 my $t = ref $self;
 my $cD;
	if($t eq 'zDa') {
 	$cD  = $t->new($self->{tb}, $self->{aHaA});
	}else {
 	$cD  = $t->new($self->{aHaA});
 }
 return $cD->aPaA("where id=?", [$id], $fields)?$cD:undef;
}

# end of zDa::bNaA
1;
