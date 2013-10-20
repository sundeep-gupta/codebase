# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 136 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/new.al)"
sub new {
 my $type = shift;
 my %fH = @_;
 my $self = {};

 $self->{eD} = $fH{eD}?$fH{eD}:$abmain::eD;
 $self->{eD} =~ s#/?$#/#;
 $self->{eD} =~ s!\\!/!g if $^O =~ /win/i;

 $self->{pL} = $fH{pL};
 $self->{pL} =~ s#/?$#/#;

 $self->{rbaseurl} = $fH{rbaseurl};
 $self->{rbaseurl} =~ s#/?$#/#;

 $self->{cgi} = $fH{cgi};
 $self->{cgi_full}=$fH{cgi_full};
 $self->{cgi} = $self->{cgi_full} if not $self->{cgi};
 $self->{cgi_full} = $self->{cgi} if not $self->{cgi_full};
 $self->{name} = $fH{name};
 $self->{vcook}= $abmain::fvp;
 $self->{vcook} =~ s/\W//g;
 $self->{_fvp_str} = $abmain::cZa;
 $self->{_fvp} = $abmain::fvp;
 $self->{_fvp} =~ s!/?$!/!;
 $self->{_top_dir} = $self->{eD};
 $self->{_top_dir} =~ s/$abmain::fvp$//;
 $self->{_off_web} = $fH{offweb};
 $self->{_no_pi} = $fH{nopi};

 if($abmain::off_webroot) {
 	$self->{pL} = "$self->{cgi_full}?".$abmain::cZa;
 }
 my $fU;
 foreach $fU (values %abmain::eO) {
 	foreach (@{$fU->[1]}) {
 		  $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 	}
 }

 foreach (@abmain::bO) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 foreach (@abmain::vC) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 foreach (@abmain::lQa) {
 $self->{$_->[0]} = $_->[4] if $_->[1] ne 'head'; 
 }
 $self->{eN}= new lB;
 $self->{dA} = {};
 $self->{fYz} = {};

 if($self->{cgi}) {
 @lB::mP = ($self->{qP}, $self->{qQ});
 @lB::eK = ($self->{sM}, $self->{sN});
 @lB::dR=($self->{sP}, $self->{sQ});
 }
 $yDa = time();
 $bYaA = $abmain::bYaA;
 return bless $self, $type;
}

# end of jW::new
1;
