# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 143 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/zLa.al)"
sub zLa{
 my ($self, $iS, $conver, $file)=@_;
 $conver = 0 if $file;
 $file = $iS->gN($self->{fI}) if not $file;
 local *F;
 open F, "<$file" or return;
 my $line1 = <F>;
 chomp $line1;
 if($line1 !~ /^AB8DF/){
 close F;
	if($conver) {
		$self->nBa($iS);
		return $self->load($iS);
	}
 return;
 }
 my @gHz = <F>;
 close F;
 my $lRa = dZz->new(\@gHz);
 $lRa->parse();
 for my $f (@mfs, @mfs2) {
	$self->{$f} = $lRa->gVa($f);
 }
 return 8;

}

# end of lB::zLa
1;
