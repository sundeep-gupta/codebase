# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4902 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fQa.al)"
sub fQa{
 my $self= shift;
 my @tags = split ("\n", $self->{forum_tag_trans});
 my @tags2 = split ("\n", $self->{kNa});
 my @trans;
 my @res;
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
 	$k=~ s/</&lt;/g; 
	push @trans, [$k, $v];
 }   
 push @trans, ["Tags in message only"];
 for(@tags2) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
 	$k=~ s/</&lt;/g; 
	push @trans, [$k, $v];
 }   
 my @ths = jW::mJa($self->{cfg_head_font}, "Tag", "Displayed As");
 return sVa::fMa(rows=>\@trans, ths=>\@ths, $self->oVa()); 
}

# end of jW::fQa
1;
