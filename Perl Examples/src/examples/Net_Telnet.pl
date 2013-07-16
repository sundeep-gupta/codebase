 use Net::Telnet;
 $login = "root";
 $passwd="superorbital123";
 $fileName = "mon.txt";
 $scriptName = "monitor.sh";
 $ip = "10.1.1.3";
 for(;;){
   $telnet = new Net::Telnet ( Host=>$ip,
                              Timeout=>10,
                               Errmode=>'die');
   $telnet->login($login,$passwd);
   print $telnet->cmd("sh $scriptName ");
   open (FILE_HANDLE,"> ".time."$fileName");
   print FILE_HANDLE $telnet->cmd("cat $fileName");
   close(FILE_HANDLE);
   $telnet->cmd("rm -f $fileName");
   $telnet->close();
   sleep 1800;
 }

