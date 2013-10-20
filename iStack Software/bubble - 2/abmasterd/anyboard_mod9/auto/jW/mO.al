# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2237 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mO.al)"
sub mO {
 my $self = shift;
 if($_[1] < 0) {
 return;
 }
 my $eS = $self->nDz('msglist'); 
 $self->oF();
 $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iSa(
 [@_],
 {kG=> "On writing file"}
 );
 chmod 0600, $eS;
 $self->pG();
 my $entry= lB->new(@_);
 $self->{dA}->{$entry->{fI}} = $entry;
 $self->{eN}->nB($self, $entry);
 push @{$self->{pC}}, $entry;
 $self->{dI}++;
 $self->{uC} = $entry;
}

# end of jW::mO
1;
