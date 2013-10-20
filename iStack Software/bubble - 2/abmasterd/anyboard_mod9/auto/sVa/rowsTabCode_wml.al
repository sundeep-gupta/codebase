# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1529 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/rowsTabCode_wml.al)"
sub rowsTabCode_wml{
 my %arghash = @_;
 my ($rows, $capt, $title, $colsel, $usebd, $wd, $tba, $trafunc, $tcafunc, $ths, $thafunc, $thfont, $tc) 
	= @arghash{qw(rows capt title colsel usebd width tba trafunc tcafunc ths thafunc thfont tc)}; 
 my $str;

 my $ncol = scalar(@$ths) if ref($ths) eq 'ARRAY';

 for my $rowh (@$rows) {
	my $row;
	if(ref($rowh) eq 'HASH') {
		$row = $rowh->{row};
	}else {
		$row = $rowh;
	}
	$ncol = scalar(@$row) if scalar(@$row) > $ncol;
 } 

 $colsel = [0..$ncol-1] if not $colsel;
 $ncol = scalar(@$colsel);
 $str .= qq(<table columns="1">\n);
 #$str .= qq(<table columns="$ncol">\n);
 $str .= qq(<b>$title</><br>) if $title ne "";
 if($ths){ 
 my $col=0;
 $str .="<tr>";
 for(@$colsel) {
 #$str .= qq(<td><b>$ths->[$_]</b></td>\n);
 $str .= qq(<b>$ths->[$_]</b> \n);
 $col ++;
 }
 $str .="</tr>";
 }
 my $rcnt =0;    
 my $row;
 for my  $rowh (@$rows) {
 my $j=0;
		  my ($row, $rs, $jK);
		  if(ref($rowh) eq 'HASH') {
			$row= $rowh->{row};
			$rs = $rowh->{begin};
			$jK = $rowh->{end};
		  }else {
			$row = $rowh;
		  }
	  
 $str .= qq($rs<tr>\n);
		  my $colcnt = scalar(@$row);
 for(@$colsel) {
 my $v = $row->[$_] || "&nbsp;";
		       if(ref($v) eq 'ARRAY') {
				$v = $v->[0];
		       }
 $str .=qq($v<br/>\n);
 #$str .=qq(<td>$v</td>\n);
 $j++;
		       last if $j >= $colcnt;
 }
 $str .="</tr>$jK\n";
 $rcnt++;
 }
 $str .= "</table>\n";
 $str .= $capt."<br/>" if $capt;
 return $str;
}

# end of sVa::rowsTabCode_wml
1;
