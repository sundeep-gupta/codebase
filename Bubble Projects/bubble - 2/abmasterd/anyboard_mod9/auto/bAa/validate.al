# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package bAa;

#line 187 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/bAa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/bAa/validate.al)"
sub validate{
 my ($self, $v)= @_;
 $v = $self->{val} if not defined ($v);
 if($v eq ''){
 	if($self->{required}){
 	 $self->{_error} = " $bAa::missing_val_label";
		 return;
	}else {
		return 1;
	}
 }
 return 1 if not $self->{verifier};
 $self->{_error} = undef;

 for(@{$self->{verifier}}) {
	 my ($hR, $arga);
	 if (ref($_) eq 'ARRAY') {
	 	$hR = $_->[0] ;
 	$arga = $_->[1];
 }else {
		$hR = $_;
 }
 $self->{_error} .= &$hR($v, $arga);
	 return if $self->{_error} ne "";
 }
 return 1;
}

# end of bAa::validate
1;
