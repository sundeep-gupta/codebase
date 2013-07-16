# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 170 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/jLa.al)"
sub jLa{
 my ($self, $ids, $opts, $clear) =@_;
 my $lck = jPa->new($self->{tb}, jPa::LOCK_EX);

 my $jTa = $self->{tb};

 if($clear) {
	unlink $jTa;
 	unlink $jTa."_upd";
	return;
 }
 my $delf = $jTa."_del";
 jEa::qYa($delf, $ids);
 my $dhash = jEa::hAz($delf);

 if($dhash && scalar(keys %$dhash) > 0) {
	$self->oMz($opts);
 }
 return scalar(@$ids);
 
}

# end of jEa::jLa
1;
