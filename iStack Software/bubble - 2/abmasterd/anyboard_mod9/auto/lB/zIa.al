# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package lB;

#line 124 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/lB.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/lB/zIa.al)"
sub zIa{
 my ($self, $iS, $file)=@_;
 $file =$iS->gN($self->{fI}) if not $file;
 local *F;
 open F, ">$file" or abmain::error('sys', "On writing file $file: $!");;
 print F "AB8DF\n";
 my @fs = (@mfs, @mfs2);
 my $lRa = dZz->zVz("message_data");
 $lRa->hEa($self, \@fs);
 print F $lRa->bCa();
 close F;
 
}

# end of lB::zIa
1;
