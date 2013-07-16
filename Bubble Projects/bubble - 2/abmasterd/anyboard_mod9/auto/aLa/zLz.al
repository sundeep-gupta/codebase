# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package aLa;

#line 1131 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/aLa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/aLa/zLz.al)"
sub zLz {
 my($self, $form, $fields) = @_;
 my $aJa = $self->{zKz};

 my (@fs, @ts);
 my %aEa;
 if($fields) {
 @fs = @$fields;
 }elsif($form->{_af_xlist_}) {
 @fs = split ('-', $form->{_af_xlist_});
 @ts = split ('-', $form->{_af_tlist_});
 map { $aEa{$fs[$_]} = $ts[$_] } 0 .. $#fs;
 }else {
 @fs = sort keys %$form;
 }
 delete $form->{_af_xlist_};
 delete $form->{_af_tlist_};
 foreach (@fs){
 my $t =  $aEa{$_};
 if (ref($form->{$_}) eq 'ARRAY') {
 $t = 'file';
 }
 if (not $t) {
		if(index("\0", $form->{$_}) < length($form->{$_}) ) {
		   $t = 'checkbox';
 }else {
	           $t = 'textarea' ;
		}
	   }

	   
 $self->zNz([$_, $t, "", $_]) unless $aJa->{aEa}->{$_};
	   $self->aPa($_, $form);
 }
}

# end of aLa::zLz
1;
