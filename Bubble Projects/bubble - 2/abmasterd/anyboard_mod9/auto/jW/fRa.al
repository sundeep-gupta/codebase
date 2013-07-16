# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 4924 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/fRa.al)"
sub fRa {
 my ($self, $all)= @_;
 my $tagt = "iKa$all$self->{eD}"; 
 return $self->{$tagt} if $self->{$tagt};
 my @tags = split ("\n", $self->{forum_tag_trans});
 push @tags, split ("\n", $self->{kNa}) if $all;
 my $trans={};
 my @res;
 for(@tags) {
 my ($k, $v) = abmain::oPa($_);
 next if not $k;
	$trans->{$k} = $v;
 push @res, "\Q$k\E";
 }   
 my $jK = join ("|", @res);
 $self->{$tagt} = sub {
	my $lineref = shift;
 $$lineref =~ s/($jK)/$trans->{$1}/ge; 
 };
 return $self->{$tagt};
}

# end of jW::fRa
1;
