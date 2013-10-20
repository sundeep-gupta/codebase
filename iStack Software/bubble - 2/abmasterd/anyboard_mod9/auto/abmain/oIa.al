# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package abmain;

#line 3205 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/abmain.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/abmain/oIa.al)"
sub oIa{
 eval 'use Win32::FileSecurity qw(MakeMask Get Set)';
 $abmain::gcnt++;
 my $filea = MakeMask( qw( FULL ) );
 my $dira = MakeMask( qw( FULL GENERIC_ALL) );
 return if $abmain::gcnt >4;
 my ($dir, $kQz) = @_;
 opendir DIR, $dir or print "Fail open dir $dir\n";
 my @dirs = readdir DIR;
 closedir DIR;
 my %hash;
 foreach( @dirs) {
 s/\\$//;
	next if $_ eq  '.' || $_ eq '..';
 my $f = "$dir\\$_";
 Get( $f, \%hash ) ;
 if(-d $f) {
		$hash{$kQz} = $dira;
 	Set( $f, \%hash ) ;
		print "Set dir $f\n";
		oIa($f, $kQz);
 }else {
		$hash{$kQz} = $filea;
 	Set( $f, \%hash ) ;
		print "Set file $f\n";
 }
		
 }
}

# end of abmain::oIa
1;
