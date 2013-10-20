# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2958 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/mQa.al)"
sub mQa {
 my ($self) = @_;
 my $eS =  $self->nDz('msglist');
 my $jKa = $bYaA->new($eS, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($eS) })->iQa(); 
 my ($entry);
 my @hS;
 for(@$jKa){
 $entry = lB->new (@$_);
 next if $entry->{fI} <=0;
 $jW::max_mno = $entry->{fI} if $entry->{fI} > $jW::max_mno;
 push @hS, $entry;
 }
 $self->lN(\@hS); 
 1;
}

# end of jW::mQa
1;
