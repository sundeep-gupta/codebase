# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1736 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/gOaA.al)"
sub gOaA {
 my ($self, $noerr) = @_;
 my $ipok = 1;
 my $ippass = 0;
 my $dmok = 1;
 my $dmpass = 0;
 my $isadm =0;
 if($self->{xD} && $ENV{'REMOTE_ADDR'} =~ /$self->{xD}/){
	$ipok = 0;
 }
 $ippass = 1 if ($self->{allowed_ips} && $ENV{REMOTE_ADDR} =~ /$self->{allowed_ips}/); 
 
 if ($self->{lDz} || $self->{allowed_dms}) { 
 	$self->{_cur_user_domain} = abmain::lWz(undef, 1) ;
 }
 if ($self->{lDz} && $self->{_cur_user_domain} =~ /$self->{lDz}/i) {
		$dmok =0;
 }
 $dmpass = 1 if ($self->{allowed_dms} && $self->{_cur_user_domain} =~ /$self->{allowed_dms}/i); 

 if( not ( ($ipok && $dmok) || ($ippass|| $dmpass) ) ){
 		my $isadm = $self->yXa();
		return 1 if $isadm;
		abmain::error('deny') if not $noerr;
		return 0;
 }
 return 1;
 
}

# end of jW::gOaA
1;
