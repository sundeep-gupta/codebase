# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 7920 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/rQz.al)"
sub rQz { 
 my ($self) = @_;
 my $pd = $self->nDz('qUz'); 
 opendir DIRF, $pd; 
 my @files = grep /\.pol$/, readdir DIRF; 
 closedir DIRF;
 my $pollstr= qq(<table align="center" border="0" width="90%" bgcolor="$abmain::msg_bg" class="PollsTable"><tr bgcolor="$self->{cfg_head_bg}"><td align="center"><h2><font $self->{cfg_head_font}>Poll</font></h2></td><td align="center"><h2><font $self->{cfg_head_font}>Result</font></h2></td></tr>\n);
 my $pollcnt=0;
 for (@files ) {
 my $f = abmain::kZz($pd, $_);
 	 my $iS = new jW(eD=>$self->{eD}, cgi=>$self->{cgi}, cgi_full=>$self->{cgi_full}, pL=>$self->{pL}); 
 	 $iS->cJ($f, \@abmain::qSz) if -r $f;
 	 next if not $iS->{polllisted};
 	 my $votestr = $iS->qXz($iS->{qQz});  
 	 my $resstr = $iS->rMz($iS->{qQz});  
 	 $pollstr .= qq(<tr><td width="50%" valign=top>$votestr</td><td width="50%" valign=top>$resstr</td></tr>\n);
 $pollcnt++;
 }
 $pollstr .= qq(<tr><td align="center" colspan=2>No listed polls</td></tr>\n) if $pollcnt == 0;
 $pollstr .= qq(</table>\n);
 return $pollstr;
}

# end of jW::rQz
1;
