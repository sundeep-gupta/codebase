# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8110 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sEz.al)"
sub sEz {
 my ($self, $name, $msg, $sysm, $mood) = @_;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 $msg =~ s/>/&gt;/g;
 $msg =~ s/</&lt;/g;
 $msg =~ s/\t/ /g;
 $msg =~ s/\n/ /g;  
 $self->mXa($msg, $name);
 $sysm = 0 if not $sysm;
 $self->oF(LOCK_EX, 10);
 if($name) {
 $bYaA->new($chatdf, {schema=>"AbChatMsg", paths=>$self->zOa('chat') })->iSa([$name, $msg, time(), $sysm, $mood]);
	if($bYaA ne 'jEa') {
 	jEa->new($chatdf, {schema=>"AbChatMsg"})->iSa([$name, $msg, time(), $sysm, $mood]);
	}
 }
 $self->sSz();
 $self->pG(10);
} 

# end of jW::sEz
1;
