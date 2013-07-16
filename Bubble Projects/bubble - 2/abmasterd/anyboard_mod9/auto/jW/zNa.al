# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7531 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/zNa.al)"
sub zNa {
 my ($self, $cG, $suf, $one) = @_;
 
 my @nums;
 if(defined $cG) {
 push @nums, ($cG%$jW::hash_cnt) || 0;
 }else {
	   @nums = (0..$jW::hash_cnt);
 }
 my $rf = $self->nDz('rating');
 my @linesx;
 if ( -f $rf) {
		my $linesref = $bYaA->new($rf, {schema=>"AbRatings"})->iQa({noerr=>1} );
 	return if not $linesref;
		push @linesx, @$linesref;
 }else {
		for(@nums) {
			my $f = $self->mZa($_, $suf);
			my $linesref = $bYaA->new($f, {schema=>"AbRatings"})->iQa({noerr=>1} );
 		next if not $linesref;
			push @linesx, @$linesref;
		}
 }
 for(@linesx) {
 my ($mno2, $rate, $cnt, $viscnt, $fpos, $loc, $readers) = @$_;
 next if not $mno2;
 $self->{ratings2}->{$mno2}= join("\t", $rate, $cnt, $viscnt, $fpos, $loc, $readers);
 }
 if ( -f $rf) {
		$self->aKz();
		unlink $rf;
 }
 1;
}

# end of jW::zNa
1;
