# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1324 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/gridTabCode.al)"
sub gridTabCode{
 my %arghash = @_;
 my ($cols, $list, $capt, $wd, $hdr, $cls, $attr, $tha, $id) = @arghash{qw(ncol vals capt width th class tba tha id )};
 if($cols <0) {
		my $lstr= "<ul>\n".join("\n", map { qq(<li>$_</li>) } @$list)."\n</ul>\n";
		my ($be, $ed);
		$be =qq(<h3><span>$hdr</span></h3>\n) if $hdr;
		$ed =qq(<h4><span>$capt</span></h4>\n) if $capt;
		return qq(<div class="grid">\n$be$lstr$ed\n</div>\n);
 }
 my $cnt = @$list;
 return if  $cnt ==0;

 $cols = $cnt if $cols ==0;
 my $rowcnt = int ($cnt/$cols);
 $rowcnt++ if ($cnt%$cols);
 my @strs;
 my $i=0;
 my (@row, $idx, $j);
 for(;$i<$rowcnt; $i++) {
 		@row = ();
		$j =0;
		for(;$j<$cols; $j++) {
			$idx = $i*$cols+ $j;
			if($idx < $cnt ) {
				push @row, $list->[$idx];
			}else {
				push @row, undef;
			}
		}
		push @strs, qq(<tr>);
		push @strs,  map { qq(<td class="gridTableData">$_</td>) }  @row;
		push @strs,  qq(</tr>\n);
 }
 my ($h, $c, $w, $class);
 $h =qq(<tr class="gridhead"><td align="center" colspan="$cols" $tha>$hdr</td></tr>) if $hdr;
 $c =qq(<tr class="gridcapt"><td align="center" colspan="$cols">$capt</td></tr>) if $capt;
 $w = qq(width="$wd") if $wd;
 $class = qq(class="$cls") if $cls;
 $class .= qq( id="$id") if $id;
	
 $w = $wd? qq(width="$wd") : undef;
 my $str2 = qq(<table $w $class $attr>$h).join("", @strs).$c."</table>";
 return $str2;

}

# end of sVa::gridTabCode
1;
