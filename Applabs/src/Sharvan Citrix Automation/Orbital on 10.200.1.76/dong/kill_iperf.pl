my $find_pid ="ps -e | grep iperf ";
   @iperf_pid = `$find_pid`;
   print $OUTPUT "Local Iperf PID:   $find_pid \n";
   print $OUTPUT "@iperf_pid \n";
   my $i=0;
   while ($iperf_pid[$i])
   {
   print $OUTPUT "Iperf Process: $iperf_pid[$i] \n";
#   kill_iperf($iperf_pid[$i]);
   if ($iperf_pid[$i] =~ /iperf/){
     my @field = split(/\s+/, $iperf_pid[$i]);
     my $counter = 0;
     if ($field[0] eq "") {$counter++}
     if (`kill $field[$counter]`) {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was not killed \n\n";
                 } else {
           print $OUTPUT "The Iperf deamon ID:$field[$counter] was killed \n\n";
                 }
        }else {
        print $OUTPUT "Iperf service was not running\n";
        }
  
  $i++;
   sleep 2;
 }

