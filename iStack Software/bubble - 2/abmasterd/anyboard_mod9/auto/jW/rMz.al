# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 5130 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rMz.al)"
sub rMz{
 my ($self, $qQz)= @_;
 my $pp = $self->qZz($qQz);
 my $ps = $self->qYz($qQz);
 return "$qQz does not exist" if not -f $pp;
 $self->cJ($pp, \@abmain::qSz);
 my @polls = split ("\n", $self->{qRz});
 my %qs=();
 for(@polls) {
 my ($k, $v) = abmain::oPa($_);
 abmain::jJz(\$k);
 $k =~ /(\w+)/;
 $k = $1;
 next if not $k;
 $qs{$k} = $v; 
 }
 $self->rAz($qQz) if not -f $ps;
 open F, "<$ps";
 my @gHz = <F>;
 close F;
 my %ans;
 for(@gHz) {
 chop;
 my ($k, $v) = split ('=', $_);
 $ans{$k} = $v if $k ne '';
 $ans{$k} = 0 if not $ans{$k};
 }
 
 my $vstr ;
 if ($ans{total}==0 ) {
 $vstr =  "No votes yet";
 }else {
 	$vstr .=qq(<table $self->{pollrtabattr}>);
 $vstr .=qq(<tr><td bgcolor="$self->{pollhbg}">$self->{rFz}</td></tr>);
 	my $cnt = scalar(keys %qs);
 	my $resi=100;
 	for(keys %qs) {
 $cnt--;
 my $pct = sprintf("%.2f",  $ans{$_}/$ans{total} * 100);
 my $block = rOz(int $pct, 10, $self->{rNz});
 $resi -= $pct;
 $pct += $resi if $cnt == 0;
 my $pct2 = sprintf("%.2f", $pct);
 $vstr .=qq(<tr><td><b>$qs{$_}</b><br/>$block $pct2\%\&nbsp;\&nbsp;($ans{$_} votes)</td></tr>\n);
 	}
 $vstr .=qq(<tr><td align="right">Total votes: $ans{total}</td></tr>\n);
 	$vstr .="</table>\n";
 }
 open F, ">".$self->rKz($qQz);
 print F abmain::rLz($vstr);
 close F;
 open F, ">".$self->xFz($qQz);
 $self->eMaA( [qw(other_header other_footer)]);
 print F "<html><head>\n$self->{sAz}\n$self->{other_header}\n$vstr\n$self->{other_footer}";
 close F;
 return $vstr;
}

# end of jW::rMz
1;
