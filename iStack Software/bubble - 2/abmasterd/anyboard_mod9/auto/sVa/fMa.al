# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 1423 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/fMa.al)"
sub fMa{
 if($aLa::_ml_mode eq 'wml' || $aLa::_ml_mode eq 'xhtmlmp') {
	return rowsTabCode_wml(@_);
 }
 my %arghash = @_;
 my ($rows, $capt, $title, $colsel, $usebd, $wd, $tba, $trafunc, $tcafunc, $ths, $thafunc, $thfont, $tc, $tbg) 
	= @arghash{qw(rows capt title colsel usebd width tba trafunc tcafunc ths thafunc thfont tc border_bg)}; 
 my $str;
 my $bg='';
 if($tbg) {
	$bg = qq(bgcolor="$tbg");
 }

 $str =qq(<table border="0" cellpadding="0" $bg cellspacing="0" width="$wd"><tr><td $bg>\n) if $usebd;
 #$str =qq(<table border="0" align="center" cellpadding="0" $bg cellspacing="0" width="$wd"><tr><td $bg>\n) if $usebd;
 my $wid = $usebd? qq( width="100%"): qq( width="$wd");
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

 $tc = 'RowColTable' if $tc eq '';
 $colsel = [0..$ncol-1] if not $colsel;
 $str .= qq(<table class="$tc" cellspacing="1"  $tba$wid>\n);
 #$str .= qq(<table class="$tc"  cellspacing="1" align="center" $tba$wid>\n);
 my $tha; $tha = &$thafunc(1, $ncol) if $thafunc;
 $str .= qq(<tr><td colspan="$ncol" $tha class="RowColTableTitle">$title</td></tr>) if $title ne "";

 $ncol = scalar(@$colsel);

 if($ths){ 
 my $col=0;
 $str .="<tr>";
 for(@$colsel) {
 $tha = &$thafunc($col, $ncol) if $thafunc;
	      if($thfont) {
 	$str .= qq(<th $tha class="RowColTableHeader"><font $thfont>$ths->[$_]</font></th>\n);
	      }else {
 	$str .= qq(<th $tha class="RowColTableHeader">$ths->[$_]</th>\n);
	      }
 $col ++;
 }
 $str .="</tr>";
 }
 my $rcnt =0;    
 my $row;
 for my $rowh (@$rows) {
	          my ($rs, $jK);
		  if(ref($rowh) eq 'HASH') {
			$row= $rowh->{row};
			$rs = $rowh->{begin};
			$jK = $rowh->{end};
		  }else {
			$row = $rowh;
		  }
		
 my $tra; $tra = &$trafunc($rcnt) if $trafunc;
		  my $rcls = ('RowColTableRow0', 'RowColTableRow1')[$rcnt%2];
 $str .= qq($rs<tr $tra class="$rcls">\n);
 my $j=0;
		  
 if(scalar(@$row) == 1 && ref($row->[0]) eq 'ARRAY' && $row->[0]->[1] eq 'head') {
 		my $tha; $tha = &$thafunc(0, 0) if $thafunc;
			$str .=qq(<td $tha colspan="$ncol" class="RowColTableSubHeader"><font $thfont>).$row->[0]->[0].qq(</font></td></tr>);
			next;
 }
		  my $colcnt = scalar(@$row);
 if($colcnt == 1 && $ncol >1) {
			my $v = $row->[0];
 		my $tha; $tha = &$thafunc(0, 0) if $thafunc;
			if(ref($v) eq 'ARRAY') {
				$tha = $v->[1];
				$v = $v->[0];
			}
			$str .=qq(<td $tha colspan="$ncol" class="RowColTableSubHeader"><font $thfont>).$v.qq(</font></td></tr>);
			next;
 }

 		   
 for(@$colsel) {
 my $v = $row->[$_] || "&nbsp;";
 my $tca; $tca = &$tcafunc($rcnt, $j) if $tcafunc;
		       if(ref($v) eq 'ARRAY') {
				$tca = $v->[1];
				$v = $v->[0];
		       }
 $str .=qq(<td $tca> $v </td>\n);
 $j++;
		       last if $j >= $colcnt;	
 }
 $str .="</tr>$jK\n";
 $rcnt++;
 }
 $tha = &$thafunc(1, $ncol) if $thafunc;
 $str .= qq(<tr><td colspan="$ncol" height="5" class="RowColTableCaption">$capt</td></tr>) if $capt ne "";
 $str .= "</table>\n";
 $str .= "</td></tr></table>\n" if $usebd;
 return $str;
}

# end of sVa::fMa
1;
