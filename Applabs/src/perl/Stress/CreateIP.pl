use WANScaler::Utils::IP;
my $ADAPTER = "Intel(R) PRO/1000 EB Network Connection with I/O Acceleration #2";
my $start_ip = [172,32,2,50];
my $end_ip = [172,32,3,70];
my $mask = [255,255,255,0];

for($i=$$start_ip[0];$i<=$$end_ip[0];$i++) {
	for($j=$$start_ip[1];$j<=$$end_ip[1];$j++) {
		for($k=$$start_ip[2];$k<=$$end_ip[2];$k++) {
			$start = ($$start_ip[0] == $i and $$start_ip[1] == $j and $$start_ip[2] == $k)?$$start_ip[3]:1;
            $end =($$end_ip[0] == $i and $$end_ip[1] == $j and $$end_ip[2] == $k)?$$end_ip[3]:244;
            for($l = $start;$l<=$end;$l++) {
            	WANScaler::Utils::IP->add_ip_address($ADAPTER,   "$i.$j.$k.$l", $mask);
            	print "$i.$j.$k.$l\t";
            }
        }
	}
}
