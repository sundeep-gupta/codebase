# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 1508 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cW.al)"
sub cW {
 my($self, $cL, @cB) = @_;

 for(@abmain::rC) {
	my $k = $_->[0];
	if($self->{$k} =~ /\|/) {
		abmain::error('inval', "Configuration value cannot contain pipe symbol.");
 }

 }
 local *lW;
 chmod 0600, $cL;
 open lW, ">$cL" or abmain::error('sys', "On writing file $cL: $!") ;

 my $fF;
 foreach $fF (@cB) {
 	foreach  (@{$fF}) {
 next if ($_->[1] eq 'head');
 next if ($_->[1] eq 'const');
 	    print lW $_->[0], "=";
 my $v = $self->{$_->[0]};
 if ($_->[1] eq 'htext'){
		print lW unpack("h*", $v);
 }elsif(1||$_->[1] eq 'textarea' || $_->[1] eq 'htmltext') {
 $v =~ s/\r\n/\n/g;
 print lW abmain::wS($v)  or abmain::error('sys', "On writing file $cL: $!") ;
 }else {
 print lW $v or abmain::error('sys', "On writing file $cL: $!") ;
 }
 print lW  "\n";
	}
 }
 close lW;
}

# end of jW::cW
1;
