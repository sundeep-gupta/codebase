# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1390 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fetch_usr_attrib.al)"
sub fetch_usr_attrib{
 my $self = shift;
 return if (time()-$self->{_attrib_compiled}) < 30;
 my $attrf = $self->nDz('usrfonts');
 my $oldct;
 my $lck = jPa->new($attrf, jPa::LOCK_EX());
 local *FF;
 my $nc=0;
 if(open FF, $attrf) {
		binmode FF;
		my @gHz = <FF>;
		$oldct = join("", @gHz);
		close FF;
 }
 
 my @gHz;
 if(length($self->{user_fonts_url}) > 10) {
	my $uf = abmain::mGa($self->{user_fonts_url});
	if($uf eq $oldct) {
		$nc =1;
	}else {
		open FF, ">$attrf";
		binmode FF;
		print FF $uf;
		close FF;
		

	}
	push @gHz, split /\n\r?/, $uf;
	
 }
 for my $l (@gHz) {
	my ($t, $f) = split /\s+/, $l, 2;
	my ($u, $v) = split '=', $f, 2;
	next if not $u;
 	abmain::jJz(\$u);
	my $lu = lc($u);
	$self->{_usr_fonts}->{$lu} = $v;
 	if(not $nc) {
		$self->fZz($lu);
		$self->{_adm_mod_reg} =1;
		$self->{gFz}->{$lu} ->[6] = $t;
		my @uinfo = @{$self->{gFz}->{$lu}}[0,1, 3..10]; 
		$self->aG($lu, @uinfo);

 	}
 }
 $self->{_attrib_compiled} = time();
 
}

# end of jW::fetch_usr_attrib
1;
