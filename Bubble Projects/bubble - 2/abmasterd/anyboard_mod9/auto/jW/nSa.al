# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 2402 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/nSa.al)"
sub nSa{
 my ($self, $gQ) = @_;
 my $f = abmain::wTz('forums');
 my ($fsref, $fshash) = abmain::pTa();
 push @$fsref, [$self->{eD}, $self->{pL}, $self->{cgi_full}, $self->{category}, $abmain::fvp];
 my @rows;
 my %rE;
 for(@$fsref) {
	next if $gQ && $self->{eD} eq $_->[0];
	next if $rE{$_->[0]};
	$rE{$_->[0]} = 1;
	push @rows, $_;
 }
 $bYaA->new($f, {schema=>"AbForumList"})->iRa(\@rows, {kG=>"Fail to open forum list"}); 
}

# end of jW::nSa
1;
