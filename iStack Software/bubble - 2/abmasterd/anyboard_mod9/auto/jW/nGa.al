# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 8140 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nGa.al)"
sub nGa {
 my $self = shift;
 my ($hIz, $hJz, $pat) = @_;
 my $chatdf = abmain::kZz($self->nDz('chat'), "chat.dat");
 my $linesref = $bYaA->new("$chatdf.txt", {schema=>"AbChatMsg", paths=>$self->zOa('chat') })->iQa({noerr=>1} );
sVa::gYaA "Content-type: text/html\n\n";
 print  qq! 
<html><head>
$self->{sAz}
</head>
<body bgcolor="$self->{tEz}">\n
$self->{yOz}
<DIV class="CHATAREA">
$self->{yPz}
!;

 my $sti = time() - $hIz* 24 * 3600;
 $sti = -1 if not $hIz;
 my $eti = time() - $hJz* 24 * 3600;
 my ($nf, $mf) = ($self->{sVz}, $self->{sOz});
 my ($d, $h, $m, $s);
 my $td;
 my @gAa;
 my @lsref = sort {$a->[2] <=> $b->[2]} @$linesref;
 for(@lsref) {
 my ($n, $msg, $t, $sys, $mood) = @$_;
 next if $t > $eti && not $sys;
 next if $t < $sti;
	    next if $pat && not $msg." ".$n =~ /$pat/i;
 my $tstr="";
 if($sys == 1) {
 $tstr = abmain::dU('LONG', $t, 'oP'),
 }
 &jEz(\$msg, "target=iIa");
	    $self->fZa(\$msg, 1);
 push @gAa,  qq(<span class="ChatUserName"><font $nf><b>$n</b></font></span>$self->{sHz}<span class="ChatMessageLine">title="$tstr"><font $mf>$msg</font></span><br/>\n); 
 }
 print join($self->{yMz}, @gAa);
 print  $self->{yQz};
 print  "\n</DIV>\n";
 print  $self->{yNz};
 print  qq(</body></html>\n);
} 

# end of jW::nGa
1;
