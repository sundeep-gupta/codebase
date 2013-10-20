# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 682 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/iUz.al)"
sub iUz {
 my $code = shift;
 if($ENV{GATEWAY_INTERFACE} =~ /^CGI-Perl/ || exists $ENV{MOD_PERL}) {
 undef %gJ;
 undef %mCa;
 undef %fPz;
 Apache::exit($code); 
 }elsif($main::is_ithread) {
	die;
	#threads->self()->join();
 }else {
 exit;
 }
}

# end of sVa::iUz
1;
