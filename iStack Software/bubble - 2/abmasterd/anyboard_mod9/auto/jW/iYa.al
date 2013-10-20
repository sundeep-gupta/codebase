# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2661 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/iYa.al)"
sub iYa{
 my %cond = @_;
 my @flds = keys %cond;
 my %idxes;
 for(@flds) {
	$idxes{$_} = abmain::oTa(\@lB::mfs, $_);
 }
 my $filter = sub {
 for(@flds) {
		next if not defined($cond{$_});
 my $v = $cond{$_};
 my $i = $idxes{$_};
 my $fv = $_[0]->[$i];
		$fv = lc($fv) if ($_ eq 'hC' || $_ eq 'to');
		return if $fv ne $v;
 }
 return 1;
 };
 return $filter;

}

# end of jW::iYa
1;
