# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 7815 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/dU.al)"
sub dU {
 my ( $format, $li, $gF, $strfmt) = @_;
 my $t;
 if($gF eq "oP") {
 $t = $li;
 } else {
 $t = time() + $li;
 }

 $t += $abmain::tz_offset*3600;

 my($sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst)=localtime($t);
 if($format eq 'POSIX') {
		$strfmt='%c' if not $strfmt;
		return strftime($strfmt, $sec,$min,$hour,$nQ,$monidx,$year,$mD,$bQ,$isdst);
		
 }
 my (@months, @wdays);
 
 if($format ne 'pJ') {
 	@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 	@wdays  = qw(Sun Mon Tue Wed Thu Fri Sat);
 }else {
 	@months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
 	@wdays  = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
 }
		          
 my $mon = $months[$monidx];
 $mD = $wdays[$mD];

 $sec = "0$sec" if $sec<10;
 $hour = "0$hour" if $hour<10;
 $min = "0$min" if $min<10;
 $nQ = "0$nQ" if $nQ<10;
 $year+=1900;
 my $dstr= "$mD, $nQ-$mon-$year $hour:$min:$sec";
#   my $dstr= "Fri, 10-Nov-99 12:23:23";

 if($format eq 'pJ') {
 return "$dstr GMT";
 }
 if($format eq 'LONG') {
 return "$mD, $mon $nQ, $year, $hour:$min:$sec";
 }
 if($format eq 'STD') {
 $monidx++;
 $monidx ="0$monidx" if $monidx <10;
 return "$monidx/$nQ/$year, $hour:$min:$sec";

 }

 if($format eq 'SHORT') {
 return "$mon $nQ, $hour:$min, $year";
 }
 if($format eq 'DAY') {
 return "$mon $nQ";
 }
 
 if($format eq 'YDAY') {
 return "$mon $nQ, $year";
 }
 
 return "$mon $nQ,$year,$hour\:$min";  
 
}

# end of abmain::dU
1;
