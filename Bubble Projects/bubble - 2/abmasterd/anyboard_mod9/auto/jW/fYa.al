# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3218 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fYa.al)"
sub fYa{
	my ($self, $gJz) = @_;
 $self->fZz($gJz);
 my $profile = $self->{gFz}->{lc($gJz)};
 return if not $profile;
 my %vcard;
 $vcard{nick}=   $gJz;
	my $mf = $self->gXa(lc($gJz));
	$mf->zQz($self->{cgi});
 $vcard{email} =   $profile->[1];
 $vcard{wO} =   $profile->[3];
 $vcard{phone}= $mf->{day_phone};
 $vcard{fax}   =$mf->{fax};
 $vcard{name}=$mf->{realname};
 $vcard{org}=$mf->{company};
 $vcard{photourl}=$mf->{photourl};
 return abmain::lTa(%vcard); 
}

# end of jW::fYa
1;
