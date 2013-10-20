# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3823 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/rEa.al)"
sub rEa{
 my @fis;
 my @fps=();
 my ($h, $f);
 my $sf = aLa->new("sf", undef, $abmain::jT);
 $sf->zNz([inf=>"head", "Search forums"]);
 my $fvp_str_save = $abmain::cZa;
 if($fvp && -f $iS->nCa()) {
 $iS->cR();
	push @fps, "$fvp=$iS->{name}";
	push @fps, "="."All channels";
	$iS->eMaA([qw(other_header other_footer)]);
	$h = qq(<html><head> <title>Search</title> $iS->{sAz} $iS->{other_header});
	$f = $iS->{other_footer};
	$sf->cBa($iS->{cfg_head_bg}, $iS->{cbgcolor0}, $iS->{cbgcolor1}, $iS->{cfg_bot_bg});
 }else {
 push @fps, "="."All channels";
 my ($fsref, $fshash) = abmain::pTa();
 for(@$fsref) {
 my $d = $_->[0];
 next if not -d $d;
 my $fv = $_->[4];
 if($abmain::no_pathinfo) {
 	$abmain::cZa = "fvp=$_->[4]\&";
 }else {
 	$abmain::cZa = "";
 }
 my $iS = new jW(eD=>$d, pL=>$_->[1], cgi_full=>$_->[2]); 
 next if not -r $iS->nCa();
 $iS->cR();
 next if $iS->{no_list_me} && not $abmain::gJ{all};
 push @fps, "$fv=$iS->{name}";
 }
 my $mf = new aLa('idx', \@qWa::siteidx_cfgs, $abmain::jT);
 $mf->zOz();
 $mf->load(abmain::wTz('siteidxcfg'));
 $h =  $mf->{siteidx_header};
 $f =  $mf->{siteidx_footer};
 }
 $abmain::cZa = $fvp_str_save; 
 $sf->zNz([tK=>"text", qq(size="20"), "Search word"]);
 $sf->zNz([svp=>"select", join("\n", @fps), "Forum"]);
 $sf->zNz([cmd=>"hidden", "", "command", "searchfs"]);
 sVa::gYaA "Content-type: text/html\n\n";
 print $h;
 print $sf->form();
 print $f;
 
}

# end of abmain::rEa
1;
