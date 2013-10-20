# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 856 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/pHa.al)"
sub pHa {
 my ($self, $kQz) = @_;
 my @subjs = split /\n+/, $self->{welcome_subjs};
 my $cnt = @subjs;
 my $wW = $subjs[int (rand()*$cnt)];
 my $msg = $self->{welcome_msg};
 $wW =~ s/{USERNAME}/$kQz/g;
 my $kNz=qq($self->{cgi}?@{[$abmain::cZa]}cmd=kPz;pat=).abmain::wS($kQz);
 my $kOz = qq(<a href="$kNz">$kQz</a>);
 $msg  =~ s/{USERNAME}/$kOz/g;
 $self->{_noreload_cfg} =1;
 $self->cCz($wW, $self->{admin}, $msg, time(), $self->{welcome_cat});
 if($self->{aWz}) {
 	$self->{aGz}=1;
 	$self->{aIz}=0;
 $self->aQz();
 }
 $self->aT();
 $self->eG();
}

# end of jW::pHa
1;
