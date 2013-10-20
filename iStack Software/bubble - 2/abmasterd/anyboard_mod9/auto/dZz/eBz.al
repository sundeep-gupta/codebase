# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dZz;

#line 228 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dZz.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dZz/eBz.al)"
sub eBz {
 my ($self) = @_;
 my $eNz = "--$self->{eOz}";
 my $dYz = $eNz."--";
 my $eIz=0;
 my $isme=0;
 return $self->{got_parts} if $self->{got_parts};
 return if not $self->{eOz};

 my $start = $self->{eKz};
 my $lref = $self->{gHz};
 my $ent;
 for(;$start< $self->{eLz}; $start++) {
	    my $line = $lref->[$start];
	    $line =~ s/\r\n$//;
	    $line =~ s/\n$//;
	    if($line eq $eNz || $line eq $dYz) {
 	       if ($ent) {
 $ent->{eLz} = $start;
 $ent->parse();
 	    my $ent_try = dZz->new();
 	    $ent_try->{gHz} = $self->{gHz};
 	    $ent_try->{ePz} = $ent->{eKz};
 	    $ent_try->{eLz} = $start;
		    if($ent_try->parse()) {
 	            	push @{$ent->{parts}}, $ent_try;
 }
 	            $self->zRz($ent);
 last if $line eq $dYz;
 }
	       if($line eq $eNz) {
 	   $ent = new  dZz;
 	   $ent->{gHz} = $self->{gHz};
 $ent->{ePz} = $start + 1;
 }
 }
 }
 $self->{got_parts}= scalar(@{$self->{parts}});
}

# end of dZz::eBz
1;
