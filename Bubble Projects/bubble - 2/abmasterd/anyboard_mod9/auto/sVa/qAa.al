# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1371 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/qAa.al)"
sub qAa{
 my %arghash = @_;
 my ($cols, $list, $capt, $usebd, $wd, $tba, $trafunc, $tcafunc, $th, $tha, $cls, $id) = 
	@arghash{qw(ncol vals capt usebd width tba trafunc tcafunc th tha class id)};
 my $str;
 my $cnt = @$list;

 return if $cnt ==0;

 
 if($cols ==0) {
	    my $ids = qq( id="$id") if $id;
 $str= qq(<div class="list_tab"$ids><span class="title">$th</span>\n<ul>).join("\n", map{qq(<li>$_</li>)} @$list ).
				 qq(</ul>\n<div class="capt">$capt</div>\n</div>\n);
 } else {
	 my $w; $w = "width=$wd" if $wd;
	 $str = qq(<table border="0" cellpadding="0" cellspacing="0" $w bgcolor="#006699" class="ListDataTable"><tr><td>\n)
	 if $usebd;
	 my $wid = $usebd? " width=100%": " width=$wd";
	 my $cls_s;
	 $cls_s =qq( class="$cls") if $cls;
 $cls_s .= qq( id="$id") if $id;
	 $str .= qq(<table $tba $wid$cls_s>\n);
	 if($th){ 
		 $str .= qq(<tr><th $tha colspan="$cols" class="ListTableHeader">$th</th></tr>\n);
 }
 	my $rcnt =0;    
 	my @cola;
 	my $tra; $tra = " ". &$trafunc($rcnt) if $trafunc;
 	$str .="<tr$tra>\n";
 	for(my $i=0; $i<$cnt; ) {
 		for(my $j=0; $j< $cols; $j++, $i++ ) {
 			my $v = $i<$cnt? $list->[$i]: "&nbsp;";
 			push @{$cola[$j]}, $v;
 		}
 	}
 	$str.=qq(<td valign="top" class="ListTableData">);
 	$str.=join(qq(</td><td valign="top" class="ListTableData">), map {join("<br>", @$_) } @cola);
 	$str .= qq(</td></tr>\n);
	if($capt) {
		$str .=qq(<tr class="capt"><td colspan="$cols">$capt</td></tr>);
	}
 	$str .= "</table>\n";
 	$str .= "</td></tr></table>\n" if $usebd;
 }
 return $str;
}

# end of sVa::qAa
1;
