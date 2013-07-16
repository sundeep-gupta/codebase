# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5195 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/tS.al)"
sub tS {
 my ($self, $cmd, $sBz, $fromarch)= @_;
 my $title = $self->{name};
 my $cgi = $self->{cgi};
 my $jO = $abmain::gJ{by};  
 my $action;
 if($cmd eq 'arch') {
 $action = "Archive";
 }elsif($cmd eq "gQ") {
 $action = "Delete";
 }elsif($cmd eq "moder") {
 $action = "Approve";
 $self->{yBz} =0;
 }
 my $depth = $action eq "Archive"? 1: 0;
 $self->{min_rate}=0;

 $self->aFz(undef, $fromarch? "a" : undef);
 $self->eMaA([qw(other_header other_footer)]);

print qq@<html><head><title>$action From $title</title><BASE TARGET=nwin>
$abmain::mC
$self->{sAz}
$self->{other_header}
<a href="${\($self->fC())}"><small>${\($self->{name})}</small></a>
<hr><p>
@
;

 my $eS = $fromarch? $self->nDz('archlist'): $self->nDz('msglist');

print <<DEL_FORM;
<center><h1>$action from $title</h1> </center>
<form action="$cgi" method="POST" target=dwin onsubmit="hB('dwin', this);return true;">
 				@{[$abmain::cYa]}
<input type="hidden" name="hIa" value="">
${\(&yT("Check the boxes on the left of the messages, and submit", ""))}
DEL_FORM

 $self->{hEz}= 1 if $cmd eq 'arch';

 if(($abmain::gJ{pat} || $abmain::gJ{hIz} || $abmain::gJ{hJz}) ) {
 my $pat = $abmain::gJ{pat};
 my $yM;
 my $sti = time() - $abmain::gJ{hIz}* 24 * 3600;
 $sti = -1 if not $abmain::gJ{hIz};
 my $eti = time() - $abmain::gJ{hJz}* 24 * 3600;
 $pat = ".?" if not $pat;
 $yM = sub { my ($e)=@_; 
 return ($fromarch? $e->{aK} == $e->{fI} :1) && ($e->{hC}=~ /$pat/i || $e->{fI} =~ /$pat/i || $e->{wW}=~/$pat/i || $e->{track} =~ /$pat/i || &abmain::pT($e->{pQ}) =~ /$pat/i) && ($e->{mM}>=$sti && $e->{mM} <= $eti);
 };
 
 	$self->aT('A', $eS, 0, $yM,'`', $sBz, $sti, $eti);
 }else {
 	$self->aT('A', $eS, 0, 0,       '`', $sBz);
 }
	       

 if($jO ne 'fI') {
 my %iF;
 for (values %{$self->{dA}}) {
 if($jO eq 'mM') {
	               $iF{abmain::dU('YDAY', $_->{mM}, 'oP')}++;
	          }elsif($jO eq 'pQ') {
	               $iF{abmain::pT($_->{pQ})}++;
	          }else {
	               $iF{$_->{$jO}} ++;
	          }
 }
#      print qq(<table border=1 align="center">);
 for(sort keys %iF) {
	       my $cnt = $iF{$_};
 print qq(<tr><td><input type="checkbox" name="fJ" value="$_">$_</td>);
 print qq(<td> $cnt messages </td></tr>);
	  }
#   print qq(</table>);
 }else {
 print qq(<tr><td colspan=2>);
 $depth= $abmain::gJ{depth} if($depth ==0); 
 $self->{eN}->jN(iS=>$self, nA=>\*STDOUT, jK=>-1, hO=>0, gQ=>1, depth=>$depth, gV=>$fromarch);
 print qq(</td></tr>);
 }
 print qq(<tr bgcolor="#cccccc"><td align="center">);
 print qq(<input type="hidden" name="cmd" value="$cmd">);
 print qq(<input type="hidden" name="by" value="$jO">);
 print qq(<input type="hidden" name="fromarch" value="$fromarch">);
 print qq(<input type="submit" class="buttonstyle" name="submit" value="$action">);
 print qq(\&nbsp;\&nbsp<input type="submit" class="buttonstyle" name="submit" value="Delete">
 confirm deletion <input type="checkbox" name="confdel" value="1">
 ) if $action eq "Approve";

 print qq@\&nbsp;\&nbsp;\&nbsp;\&nbsp;<a href="javascript:window.kEz(document.forms[0], 1);" target=_self> Check all</a>@;
 print qq@\&nbsp;\&nbsp;\&nbsp;\&nbsp;<a href="javascript:window.kEz(document.forms[0], 0);" target=_self> Uncheck all</a>@;
 print qq(</td><td bgcolor="ddddff" align="left"> Including threads);


 unless ($fromarch) {
 	 if($self->{inline_followups} || $action eq "Archive") {
 	 	print qq(<input type="hidden" name="thread" value="1">);
 	 }else {
 	 	print qq(<input type="checkbox" name="thread" value="1" checked>);
 	 }
 	 print qq(\&nbsp;\&nbsp;Backup deleted messages<input type="checkbox" name="backup" value="1">);
 	 if($self->{take_file}) {
 	     print qq(\&nbsp;\&nbsp;Including uploaded files <input type="checkbox" name="gLz" value="1">); 
 	 } 
 }

 print qq(</td></tr></table></form>);
 $self->{other_footer};
}

# end of jW::tS
1;
