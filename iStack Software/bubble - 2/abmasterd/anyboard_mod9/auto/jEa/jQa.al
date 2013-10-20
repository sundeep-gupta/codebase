# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jEa;

#line 54 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jEa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jEa/jQa.al)"
sub jQa{
 my ($jTa, $rowrefs, $opts, $clear) =@_;
 local *TBF;
 my $res;
 if($clear) {
	$res = open TBF, ">$jTa";
 	unlink $jTa."_upd";       
 	unlink $jTa."_del";       
 }else {
	$res = open TBF, ">>$jTa";
 }
 if(not $res) {
		unless($opts && $opts->{noerr}) {
			sVa::error("sys", $opts->{kG}. "($!: $jTa)");
	        }
		return;
 }
 for(@$rowrefs) {
	next if not ref($_) eq 'ARRAY';
	for my $str (@$_) {
		next if not $str;
		$str =~ tr/\t/ /;
		$str =~ tr/\n/ /;
	}
 	print TBF join("\t", @$_), "\n";
 }
 close TBF;
 1;
}

# end of jEa::jQa
1;
