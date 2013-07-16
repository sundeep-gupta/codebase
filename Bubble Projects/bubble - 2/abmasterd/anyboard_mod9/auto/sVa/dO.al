# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package sVa;

#line 478 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/sVa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/sVa/dO.al)"
sub dO {
 my($in) ;
 my ($name, $value) ;
 my @eRz;
 undef %gJ;
 undef @lWa;

 &error('sys',"Script was called with unsupported REQUEST_METHOD $ENV{'REQUEST_METHOD'}.") 
 if ( not defined($ENV{'REQUEST_METHOD'})); 

 if ( ($ENV{'REQUEST_METHOD'} eq 'GET') ||
 ($ENV{'REQUEST_METHOD'} eq 'HEAD') ) {
 $in= $ENV{'QUERY_STRING'} ;
	$in =~ s/;/&/g;
 $dC="GET";
 } elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
 length($ENV{'CONTENT_LENGTH'})
 || &error('sys', "No Content-Length sent with the POST request.") ;
 my $len = $ENV{'CONTENT_LENGTH'};
 my $cnt=0;
 $dC="POST";
 my $buf;
 if ($ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 while($len ) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt ==0;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
		open F, ">/tmp/pd";
		print F $in;
		close F;
 }elsif($ENV{'CONTENT_TYPE'}=~ m#^multipart/form-data#i) {
 error('iK', "Data size $len exceeded specified limit ($max_upload_file_size)") 
 if $len > $max_upload_file_size && $max_upload_file_size >0;

 binmode STDIN;
 while($len ) {
 $cnt = read(STDIN, $buf, $len);
 last if $cnt ==0;
 push @eRz, $buf;
 $len -= $cnt;
 }
 $in = join('', @eRz);
 my @plines = split /^/m, $in;
 
 my $lRa = new dZz(\@plines);
 $lRa->{head}->{'content-type'} = $ENV{'CONTENT_TYPE'}; 
 $lRa->bVz();
 $lRa->eBz();
 my $ent;
 for $ent(@{$lRa->{parts}}) {
 my $name= $ent->{eJz};
 my $val = $ent->eHz();
 if (length($ent->{eFz})>0) {
 $ent->{eFz} =~ s/\s+/_/g;
 $mCa{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 $gJ{$name} = [$ent->{eFz}, $val, $ent->{head}->{'content-type'}];
 } else {
 	              if (defined($gJ{$name})){
 	              	$gJ{$name} .= "\0" if defined($gJ{$name}); 
 }else {
 push @lWa, $name;
 }
		      $val =~ s/\x1a//g;
 	              $gJ{$name} .=  $val;
 }
 }
 
 }
 }
 if ($dC eq 'GET'  || $ENV{'CONTENT_TYPE'}=~ m#^application/x-www-form-urlencoded$#i) {
 	foreach (split('&', $in)) {
 	    s/\+/ /g ;
 	    ($name, $value)= split('=', $_, 2) ;
 	    $name=~ s/%([0-9a-fA-F][0-9A-Fa-f])/chr(hex($1))/ge ;
 	    $value=~ s/%([0-9A-Fa-f][0-9a-fA-F])/chr(hex($1))/ge ;
 	    if (defined($gJ{$name})) {
 	    	$gJ{$name}.= "\0";
 }else {
 push @lWa, $name;
 }
 	    $gJ{$name}.= $value ;
 	}
 }
}

# end of sVa::dO
1;
