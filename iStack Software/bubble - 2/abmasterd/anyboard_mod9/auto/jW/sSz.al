# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8183 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/sSz.al)"
sub sSz {
 my $self = shift;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 my $chathf = abmain::kZz($self->nDz('chat'), "index.html");
 $self->{tDz} = $abmain::min_chat_refresh if($self->{tDz} < $abmain::min_chat_refresh);
 my $t2 = $self->{tDz} +5;
 my $sPz = $self->sPz();
 my ($initloc, $scroll) = ("#eof", 99999);
 if($self->{hLa}) {
		$initloc="#bof";
 $scroll=0;
 }
 open F, "<$chatdf";
 my @gHz = <F>;
 close F;
 open F, ">$chathf";
 print F qq! 
<html><head>
<META HTTP-EQUIV="Expires" CONTENT="0"> <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="refresh" CONTENT="$t2; URL=$sPz">
<script>
function xbeep(){ /*java.awt.Toolkit.getDeafultToolkit.beep();*/}
function dx() {
min_refresh_intv = $self->{tDz};
refresh_intv = min_refresh_intv;
if(parent.sYz.refresh_time >= min_refresh_intv)
refresh_intv = parent.sYz.refresh_time;
location = "$initloc";
window.scroll(0, $scroll);
setTimeout("location.reload()", refresh_intv*1000);
xbeep();
}

</script>
$self->{sAz}
</head>
<body bgcolor="$self->{tEz}" onload="dx()">\n
<a name="bof"></a>
$self->{yOz}
<DIV class="CHATAREA">
$self->{yPz}
!;

 my $dcnt = $self->{tCz};
 $dcnt = 30 if $dcnt <=0;
 my $nM = @gHz;
 my $sidx = $nM-$dcnt;
 $sidx = 0 if $sidx <0;
 my ($nf, $mf) = ($self->{sVz}, $self->{sOz});
 my ($daysec, $hrsec, $msec) = (60*60 *24, 60*60, 60);
 my ($d, $h, $m, $s);
 my $ct = time();
 my $td;
 my @gAa;
 my $i;
 for($i=$sidx; $i< $nM; $i++) {
	    my $line = $gHz[$i];
 chomp($line);
 my ($n, $msg, $t, $sys, $mood) = split /\t/, $line;
 $td = $ct - $t;
 next if $td > $self->{chat_max_age} && not $sys;
 next if $td > 4 * $self->{chat_max_age};
 my $tstr="";
 if($sys == 1) {
 $m = sprintf("%.2f", $td/60);
 $tstr = " [<small><i>$m minutes ago</i></small>]";
 }
 &jEz(\$msg, "target=iIa");
	    $self->fZa(\$msg, 1);
 my $md="";
 $md = $self->{$mood}." " if $mood;
 push @gAa, qq(<span class="ChatUserName"><font $nf><b>$n</b></font></span>$self->{sHz}$md<span class="ChatMessageLine" title="$tstr"><font $mf>$msg</font></span><br/>\n); 
 }
 if($self->{hLa}) {
		print F join($self->{yMz}, reverse @gAa);
 }else {
		print F join($self->{yMz}, @gAa);
 }
 print F $self->{yQz};
 print F "\n</DIV>\n";
 print F $self->{yNz};
 print F qq(\n<a name="eof"></a></body></html>\n);
 close F;
 if($nM > 2 * $dcnt) {
 open F, ">$chatdf";
 print F @gHz[$sidx..$nM];
 close F;
 open F, ">>$chatdf.txt";
 $sidx--;
 print F @gHz[0..$sidx];
 close F;
 }
} 

# end of jW::sSz
1;
