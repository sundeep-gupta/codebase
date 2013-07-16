package Orbital::Test;

use Net::Telnet;
use LWP::Simple;
use Data::Dumper;
use 5.008004;
use strict;
use warnings;
use vars qw( @ISA $VERSION);

############################################################################################
#                          Module creation related things.                                 #
############################################################################################
$VERSION = "1.0";
our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Orbital::Tests ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(

);


#############################################################################
# ********************  CONSTANTS DECLARATIONS  ****************************#
#############################################################################

use constant COMPRESSION   => 0x001;
use constant DISK_BASED    => 0x002;
use constant PROXY         => 0x004;
use constant MULTISESSION  => 0x008;
use constant TCP           => 0x010;
use constant TCP_ALL       => 0x020;
use constant UDP           => 0x040;
use constant UDP_WAIT      => 0x080;
use constant UDP_VARY      => 0x100;
use constant USE_FILE      => 0x200;
use constant BOTH_DIR      => 0x400;
use constant HARDBOOST     => 0x800;



####################### PRIVATE VARIABLES #######################################
my $test_case_env = undef;
my $xml_in        = undef;
my $xml_out       = undef;

my $config_xml    = undef;
my $log_file_name = undef;
my $output_xml    = undef;

my $dr_ip         = undef;
my $dr_user       = undef;
my $dr_passwd     = undef;


my $orb_local     = undef;
my $orb_remote    = undef;

my $locOrb_rpc    = undef;
my $remOrb_rpc    = undef;

my @config_list   = undef;

my($orb_proxy_info)     = undef;
my($orb_proxy_vip)      = undef;
my($orb_proxy_targetip) = undef;
my($orb_proxy_desc)     = undef;


my $ftp_params = undef;
my $tcp_params = undef;
my $udp_params = undef;


#################################################################################################
# Initial Settings & opening of handles....                                                     #
#################################################################################################
sub _init {

# 1. Open LOG file...                                                                           #
#    $log_file_name  = "Test_log.txt";
    open(LOG_FILE,"> $log_file_name");

# 2. Open XML output file...                                                                    #
    my ($output_file) = new IO::File(">$xml_out");
    $output_xml = XML::Writer->new (OUTPUT      => $output_file,
                              DATA_MODE   => 1,
                              DATA_INDENT => 4);


# 3. Open input XML file...                                                                     #

    if( -e $xml_in) {
       $config_xml = Orbital::XML::Parse->new($xml_in);
    } else {
        print LOG_FILE "$xml_in not found";
        close(LOG_FILE);
        exit(0);
    }

# 3. Read Delay Router Information....                                                          #
#    a. ip                                                                                      #
#    b. usr/pswd                                                                                #

    $dr_ip     = $config_xml->get_dr_ip();
    $dr_user   = $config_xml->get_dr_user();
    $dr_passwd = $config_xml->get_dr_passwd();

# 4. Orbital Information                                                                        #

    $orb_local = $config_xml->get_local_orbital_info();
    $orb_remote = $config_xml->get_remote_orbital_info();

# 5. Connect to XML RPC Server...                                                               #


$remOrb_rpc = Orbital::XMLRPC->new("http://".$orb_remote->{'ip'}.":2050/RPC2");
$locOrb_rpc = Orbital::XMLRPC->new("http://".$orb_local->{'ip'}.":2050/RPC2");

# 6. Check configuration List                                                                   #

    @config_list = $config_xml->get_dr_config_list();
    if(! @config_list){
        print LOG_FILE "No configuration is specified for WanSIM";
        exit(1);
    }
}
sub _set_environment {
    $output_xml->startTag("Environment");                                # Start Environment tag   #
    $output_xml->emptyTag("DelayRouter",'IP'=>$dr_ip);

    $output_xml->startTag("Orbitals");                                   # Start Orbitals tag      #

    $output_xml->startTag("Remote","IP"=>$orb_remote->{"ip"});           # Start Remote tag        #
    if(($test_case_env &  HARDBOOST) == HARDBOOST) {
	# Disable Softboost.
	$remOrb_rpc->set_parameter('UI.Softboost','0');

        # Set Send Rate                                                                            #
        print LOG_FILE "Setting Send rate of ".$orb_remote->{'ip'}." to ". $orb_remote->{'send_rate'};
        $output_xml->dataElement("SendRate",$orb_remote->{'send_rate'});
        $remOrb_rpc->set_parameter('SlowSendRate', $orb_remote->{'send_rate'});

        # Set Recieve rate                                                                         #
        print LOG_FILE "Setting Recieve rate of ". $orb_remote->{'ip'}." to ".$orb_remote->{'send_rate'};
        $output_xml->dataElement("SendRate",$orb_remote->{'recv_rate'});
        $remOrb_rpc->set_parameter('SlowRecvRate', $orb_remote->{'recv_rate'});
    } else {
	# Enable Softboost.
	$remOrb_rpc->set_parameter('UI.Softboost','1');

    }
    $output_xml->endTag();                                               # End Remote Tag          #


    $output_xml->startTag("Local","IP"=>$orb_local->{"ip"});             # Start Local tag         #
    if(($test_case_env & HARDBOOST) == HARDBOOST ){
	# Disable Softboost.
	$locOrb_rpc->set_parameter('UI.Softboost','0');

        # Set Send Rate
        print LOG_FILE "Setting Send rate of ".$orb_local->{'ip'}." to ". $orb_local->{'send_rate'};
        $output_xml->dataElement("SendRate",$orb_local->{'send_rate'});
        $locOrb_rpc->set_parameter('SlowSendRate', $orb_local->{'send_rate'});

        # Set Recieve Rate.
        print LOG_FILE "Setting Recieve rate of ". $orb_local->{'ip'}." to ".$orb_local->{'recv_rate'};
        $output_xml->dataElement("SendRate",$orb_local->{'recv_rate'});
        $locOrb_rpc->set_parameter('SlowRecvRate', $orb_local->{'recv_rate'});
    } else {
	# Enable Softboost.
	$locOrb_rpc->set_parameter('UI.Softboost','1');

    }
    $output_xml->endTag();                                               # End of Local Tag       #

    # Set the proxy and make an entry into XML file...                                            #
    if(($test_case_env & PROXY )==PROXY) {

      $orb_proxy_info     = $orb_local->{"proxy"};
      $orb_proxy_vip      = $orb_proxy_info->{"vip"};
      $orb_proxy_targetip = $orb_proxy_info->{"targetIP"};
      $orb_proxy_desc     = $orb_proxy_info->{"desc"};

      $output_xml->dataElement("Proxy",$orb_proxy_desc,
                                    "VIP"=>$orb_proxy_vip,
                                    "TargetIP"=>$orb_proxy_targetip);


      #TODO: Write code to set Orbital to proxy mode

    }

    $output_xml->endTag();                                               # End Orbitals Tag        #
    $output_xml->endTag();                                               # End Environment tag     #

}

sub _read_test_params {
    my ($type, $unaccel, $vary, $wait);
    # Read FTP parameters                                                                         #
    if (($test_case_env & TCP) == 0) {
        $ftp_params = $config_xml->get_ftp_params();
    } elsif (($test_case_env & TCP) == TCP) {
    # Read TCP parameters                                                                         #

        $type    = (($test_case_env & USE_FILE ) == USE_FILE) ? 1 : 0;
        $unaccel = (($test_case_env & TCP_ALL ) == TCP_ALL) ? 1 : 0;
    
        $tcp_params = $config_xml->get_tcp_params($type,$unaccel);
    
        if(($test_case_env & UDP)==UDP) {
            $type = (($test_case_env & USE_FILE ) == USE_FILE) ? 1 : 0;
            $vary = (($test_case_env & UDP_VARY ) == UDP_VARY) ? 1 : 0;
            $wait = (($test_case_env & UDP_WAIT ) == UDP_WAIT) ? 1 : 0;
            $udp_params = $config_xml->get_udp_params($type,$vary,$wait);
        }
    } else {
        #This case should never happen, under present scenario.                                   #
        print LOG_FILE "Incorrect information in Config.xml file";
        exit(1);
    }
}

sub _execute {

    my ($sess) = shift;
    my ( $result);
    # Run Twice if Compression Enabled...
    if(($test_case_env & COMPRESSION ) == COMPRESSION) {

       # Run the test for first time                                                       #
       print LOG_FILE "Starting Test for First Compression\n";
       $output_xml->startTag("Result","Compression"=>"1");               # Start result Tag
       _run_test($sess);
       $output_xml->endTag();                                            # End of Result Tag
       print LOG_FILE "Test Completed for First Compression\n";

       # If DBC then clear Primary Memory History                                         #
       if(($test_case_env & DISK_BASED) == DISK_BASED) {
           print LOG_FILE "Removing the Memory History for Disk based compression\n";
           $result = $locOrb_rpc->send_command('CompressionHistory memory');
           print LOG_FILE "Removing Memory History from $orb_local : $result \n";
           $result = $remOrb_rpc->send_command('CompressionHistory memory');
           print LOG_FILE "Removing Memory History from $orb_remote : $result \n"
       }
       # Run the test for Second time                                                     #
       print LOG_FILE "Starting Test for Second Compression\n";
       $output_xml->startTag("Result","Compression"=>"2");
       _run_test($sess);
       print LOG_FILE "Test Completed for Second Compression\n";

       $output_xml->endTag();                                             # End of Result Tag

       #Now reset the History                                                             #

       print LOG_FILE "Removing the Compression History for $orb_local\n";
       $result = $locOrb_rpc->send_command('CompressionHistory reset');
       print LOG_FILE "$result \n";
       print LOG_FILE "Removing the compression History $orb_remote\n";
       $result = $remOrb_rpc->send_command('CompressionHistory reset');
       print LOG_FILE "$result \n"

    } else {
        # Run the Test without compression, i.e., Once only                               #
       print LOG_FILE "Test Started...\n";
       $output_xml->startTag("Result");
       _run_test($sess);
       $output_xml->endTag();                                             # End of results tag.
       print LOG_FILE "Test Completed\n";

    }                                                                     # END OF IF CONDITION FOR COMPRESSION

}

#################################################################################################
# Function : create_iperf_command                                                               #
# Description : To generate TCP traffic (Accelerated & Un Accelerated)                          #
# Arguments : $tcp_info - A reference containing details                                        #
#              using which Iperf command will be constructed                                    #
#################################################################################################
sub _create_iperf_command {
    my ($tcp_info ) = shift;
    my ($type)      = shift;
    my ($file_or_size) = shift;
    my ($bidirect)   = shift;
    
    my $cmd;

    die("Invalid Paramters for create_iperf_command") if ( ! defined($type) || ! defined($tcp_info) );

    my ($dest_ip) = $tcp_info ->{"dest_ip"};
    my ($size) = $tcp_info->{"size"}if (defined($tcp_info->{"size"}));
    my ($file) = $tcp_info->{"file"}if (defined($tcp_info->{"file"}) && $type eq "file");
    my ($sessions) = $tcp_info->{"sessions"} if (defined($tcp_info->{"sessions"}));

    die("Invalid Paramters for create_iperf_command") if ( ! defined($size) && ! defined($file));

    $cmd = "iperf.pl ";
    $cmd = $cmd.(defined($type) && $type eq "UDP" ? " -u" :"");
    $cmd = $cmd." -c $dest_ip -f k";
    $cmd = $cmd.((defined($file)?" -F $file " :(defined($size)?" -n $size" : "")));
    $cmd = $cmd.((defined($bidirect) )?" -d " : "");
    $cmd = $cmd.(defined($sessions) ?" -P $sessions ":"");

    return $cmd;
}

##############################################################################################
# Return : Hash reference. Keys to hash reference are "get" & "put"whose values are arry     #
#               of commands that need to be run.                                             #
##############################################################################################

sub _create_ftp_command {
#    my($self) = shift;
    my ($param) = shift;
    my(@put_arr, @get_arr) ;

    my( $dest_ip) = $param->{"dest_ip"} if defined($param->{"dest_ip"});
    my( $username) = $param->{"username"} if defined($param->{"username"});
    my( $password) = $param->{"password"} if defined($param->{"password"});
    my ($get) = $param->{"get"} if defined($param->{"get"});
    my ($put) = $param->{"put"} if defined($param->{"put"});
    my $ftp_command = {};
    my $i = 0;
    if (defined($get)) {
        foreach (@{$get}) {
            $get_arr[$i] = "FTP_get.pl $dest_ip $username $password $_";
            $i++;
        }
    }
    $i = 0;
    if (defined($put)) {
        foreach (@{$put}) {
            $put_arr[$i] = "FTP_put.pl $dest_ip $username $password $_";
            $i++;
        }
    }

    $ftp_command->{"get"} = \@get_arr if @get_arr;
    $ftp_command->{"put"} = \@put_arr if @put_arr;
    return $ftp_command;
}

sub _create_unaccel_tcp_command {

#    my($self) = shift;
    my ( $tcp_info ) = shift;

    my ($cmd);
    my ($url) = $tcp_info ->{"url"};
    my ($size) = $tcp_info->{"size"}if (defined($tcp_info->{"size"}));
    my ($sessions) = $tcp_info->{"sessions"} if (defined($tcp_info->{"sessions"}));

    $cmd = "tor.pl ";
    $cmd = $cmd.((defined($size)?" -t $size " : ""));
    $cmd = $cmd.(defined($sessions) ?" -c $sessions ":"");
    $cmd = $cmd." $url";
    return $cmd;
}

########################################################
# Configure the Delay router based on given Arguments  #
# Arguments: Delay Router IP, Bandwidth, RTT, and Loss #
# Return :   Whatever is the result of executing       #
#            the command it will be returned.          #
########################################################
sub _config_delay_router {

#    my($self) = shift;
    my ($ip,$login, $passwd, $bw, $rtt, $loss) = @_;

#    my $bw = "$(bw)e6";

    my $scriptName = 'ls';
    my $result_file;
    my $telnet;
    my @res;
  # TODO: Replace this script to do TELNET & execute the NESET.SH command
	my $url = "http://$ip/cgi-bin/wansimconfig.cgi?bw=$bw&dly=$rtt&plr=$loss";
print "Setting Delay Router \n".$url."\n";
    my $content = get($url);
	# Check to see if anything was returned
    if (!defined($content)) {
        print "ORBITAL>> configure_wansim() -> ERROR: No content was returned for LWP::Simple::get() \n";
    }

# ($ip, $login, $passwd, $scriptName, $result_file) =
#  if(!defined($result_file)) {
#     $result_file = "output.txt";
#  }
#  $telnet = new Net::Telnet ( Host=>$ip,
#                              Timeout=>10,
#                              Errmode=>'die');
#   $telnet->login($login,$passwd);
#   print $telnet->cmd("sh $scriptName > $result_file");
#   @res =  $telnet->cmd("cat $result_file");
#   $telnet->cmd("rm -f $result_file");
#   $telnet->close();
sleep(10);
   return @res;



  # my $set_dr = "ssh $ip \"\/tools\/tests\/test_common\/neset.sh \-bw $bw \-rtt $rtt \-loss $loss \" ";
  #  return  `$set_dr`; # return the result of setting delay router by using SSH
}
################################# SOFT BOOST CODE ########################################################

sub _run_test {
    my($sess) = shift;

    #################################################
    # ******* Local Variable Declarations ********* #
    #################################################

    my ($cmd, @arr);
    my (@get_list, @put_list);
    my $i;                                           # This is for Name of the LOCAL FILE after get
    my (@get_arr, $get_file_name);
    my ($put_file_name,@put_arr);
    my ($result_status,$size,$time);
    my ($i_result_status,$i_size,$i_time);
    my ($tcp_accel_command, $tcp_unaccel_command,$udp_command, $udp_command_old);
    my ($done_file);
    my ($vary_size, $max, $incr);
    my ($final_time, $final_size, $final_result_status);

    print LOG_FILE "Starting Test \n";
print "Calling get run command...\n";
    $cmd = _get_run_command($sess);

    @arr = @{$cmd};

   if(($test_case_env & TCP)==0) {
       @get_list = @{$cmd->[0]->{"get"}} if (defined($cmd->[0]->{"get"}));
       @put_list = @{$cmd->[0]->{"put"}} if (defined($cmd->[0]->{"put"}));

       # RUN ALL IN MULTIPLE SESSIONS
       my($i) = 1;
       foreach my $get (@get_list) {
           @get_arr = split(/\s+/,$get);
           $get_file_name = $get_arr[4];           chomp($get_file_name);

           # 1. Start the test.... :)
           if(($test_case_env  & MULTISESSION) == MULTISESSION) {
                for ($i = 1; $i<=$sess;$i++){
                     system("Start $get $i");
                }
           }else {
               system ("Start $get") if ($test_case_env  & MULTISESSION) == 0;
           }

           # 2. Then wait till test completes.... :)
           print "Waiting for script to terminate...\n";
           _wait_till_ftp_complete($sess,'get',$get_file_name);

           # 3. Now read values & save the result.....
           #    & write results to xml file          :)
           print "Calculating valuess....\n";
           ($result_status,$size,$time) = _calc_ftp_values($sess,'get',$get_file_name);

           $output_xml->startTag("Get");
           $output_xml->dataElement("status",$result_status);
           if($result_status eq "PASS") {
                $output_xml->dataElement("Size",$size);
                $output_xml->dataElement("Time",$time);
                $output_xml->dataElement("Throughput",$time>0?$size/($time*1000):0);
           }
           $output_xml->endTag();

           # 4. Now delete files that FTP generates...
           `del FTPG*.log`;
       }    # End of GET;

      #PUT only if BIDIRECTIONAL IS SPECIFIED.
#print $test_case_env & BOTH_DIR."This is put value...\n";
      if(($test_case_env & BOTH_DIR) == BOTH_DIR) {
           $i = 1;
           foreach my $put (@put_list) {
               @put_arr = split(/\s+/,$put);
               $put_file_name = $put_arr[4];  chomp($put_file_name);

               # 1. Start the test.... :)
               if (($test_case_env  & MULTISESSION) == MULTISESSION) {
                    for ($i = 1; $i<=$sess;$i++) {
                          system("Start $put $i") ;
                    }
               } else {
                    system( "Start $put") if ($test_case_env  & MULTISESSION) == 0;
               }
           }
           # 2. Wait till test completes... :)
           _wait_till_ftp_complete($sess,'put');

           # 3. Now calculate the results.... :)
           my($result_status,$size,$time) = _calc_ftp_values($sess,'put',$put_file_name);

           $output_xml->startTag("Put");
           $output_xml->dataElement("status",$result_status);
           if($result_status eq "PASS") {
                $output_xml->dataElement("Size",$size);
                $output_xml->dataElement("Time",$time);
                $output_xml->dataElement("Throughput",$time>0?$size/($time*1000):0);
           }
           $output_xml->endTag();

           # 4.  DELETE the temporary "done" files.

           `del FTPP*.log`;
       }
  } elsif (($test_case_env & TCP)== TCP) {
print Dumper($cmd);
        # 1. Start TCP Accelerated traffic...
       ($tcp_accel_command, $tcp_unaccel_command,$udp_command) = @{$cmd};
       print LOG_FILE "Generating Accelerated TCP Traffic...\n";
       system("start $tcp_accel_command ");

       # 2. Start Unaccelerated trafiic if specified...

       if (($test_case_env & TCP_ALL) == TCP_ALL && (defined($tcp_unaccel_command))){
           print LOG_FILE ("Generating Unaccelerated TCP Traffic...\n");
           system("start $tcp_unaccel_command 2>&1")
       }

       # 3. Start UDP traffic if specified
       if (($test_case_env & UDP) == UDP) {
           print LOG_FILE ("Generating UDP traffic...\n");
           print LOG_FILE ("Waiting...\n"), sleep($udp_params->{"wait"} )if ( ($test_case_env & UDP_WAIT) == UDP_WAIT && defined($udp_params->{"wait"}) && $udp_params->{"wait"} > 0);

           # If specified to Vary the UDP Load then
           if(($test_case_env & UDP_VARY) == UDP_VARY) {
                print LOG_FILE ("Varying the UDP traffic...\n");
                $vary_size = $udp_params->{"vary"}->{"start"};
                $max = $udp_params->{"size"};
                $incr = $udp_params->{"vary"}->{"load"};

                $final_time = 0;
                $final_size = 0;
                for(;$vary_size<=$max;) {

                    # change command to change size to be transfered... :)
                    $udp_command_old = $udp_command;
                    $udp_command = substr( $udp_command, 0, rindex($udp_command, "-n"))."-n $vary_size ";
                    $udp_command = $udp_command.substr($udp_command_old,rindex($udp_command_old,"-P")) if ($sess >1);
                    #Start the UDP command
                    print LOG_FILE ("Generating UDP Traffic of size : $vary_size\n");
                    system("start $udp_command");
                    $done_file = ($sess>1) ?"udp_done_${sess}.txt" :"udp_done.txt";
                    while (!( -e $done_file)) {
                        sleep (1);
                    }
                    unlink($done_file);
                    $vary_size += $incr;
                    ($i_result_status, $i_size, $i_time) = _calc_udp_values($sess);
                    $final_size +=$i_size;
                    $final_time += $i_time;
                    $final_result_status = ($final_result_status eq "FAIL" || $i_result_status eq "FAIL")?"FAIL":"PASS";

                    print LOG_FILE ("Results for UDP Traffic of size : $vary_size\n");
                    print LOG_FILE ("Result : $i_result_status \t Size : $i_size \t Time : \t $i_time\n");

                }

                # Create done file as an indication to completion of UDP traffic generation.
                open (DONEFILE,">$done_file");
                print DONEFILE "done";
                close (DONEFILE);
           } else {
                system("start $udp_command");
           }
       }
       # 2. Wait till the test is completed...
       print LOG_FILE ("Waiting for test to be completed...\n");
       _wait_till_test_complete($sess);

       # 3. Now calculate the results.... :)
       # 3.1 Calculate values of TCP Accelerated Data... :)
       my($result_status,$size,$time) = _calc_tcp_values($sess);
       print LOG_FILE ("Results for TCP Traffic \n");
       print LOG_FILE ("Result : $result_status \t Size : $size \t Time : \t $time\n");

       $output_xml->startTag("AcceleratedTCP");
       $output_xml->dataElement("status",$result_status);
       if($result_status eq "PASS") {
           $output_xml->dataElement("Size",$size);
           $output_xml->dataElement("Time",$time);
           $output_xml->dataElement("Throughput",$time>0?$size/($time*1000):0);
       }
       $output_xml->endTag();
       `del tcp_accel*.txt`;

       # 3.2 Calculate values of TCP Un Accelerated Data, if any... :)
       if(($test_case_env & TCP_ALL ) == TCP_ALL ) {
           my($result_status,$size,$time) = calc_tcp_unaccel_values($test_case_env,$sess);
           print LOG_FILE ("Results for TCP - Unaccelerated Traffic \n");
           print LOG_FILE ("Result : $result_status \t Size : $size \t Time : \t $time\n");

           $output_xml->startTag("UnacceleratedTCP");
           $output_xml->dataElement("status",$result_status);
           if($result_status eq "PASS") {
               $output_xml->dataElement("Size",$size);
               $output_xml->dataElement("Time",$time);
               $output_xml->dataElement("Throughput",$time>0?$size/($time*1000):0);
           }
           $output_xml->endTag();
           `del tcp_unaccel*.txt`;
       }
       # 3.3 Calculate values of UDP Data... :)
       if (($test_case_env & UDP) == UDP) {
           my($result_status,$size,$time) = ($test_case_env & UDP_VARY) == UDP_VARY ? ($final_result_status, $final_size, $final_time): _calc_udp_values($sess);
           print LOG_FILE ("Results for UDP Traffic \n");
           print LOG_FILE ("Result : $result_status \t Size : $size \t Time : \t $time\n");

           (($test_case_env & UDP_WAIT) == UDP_WAIT) ?$output_xml->startTag("UDP","wait"=>$udp_params->{"wait"}) : $output_xml->startTag("UDP") ;
           $output_xml->dataElement("status",$result_status);
           if($result_status eq "PASS") {
               $output_xml->dataElement("Size",$size);
               $output_xml->dataElement("Time",$time);
               $output_xml->dataElement("Throughput",$time>0?$size/($time*1000):0);
           }
           $output_xml->endTag();
           `del udp_log*.txt`;
       }

   }
}

# This function is not correct yet & need to be modified.
sub _calc_udp_values {

    my($sess) = shift;
    
    my $result;

    #################################################
    # ******* Local Variable Declarations ********* #
    #################################################
    my $log_file;
    my @arr;
    my ($result_status, $time);
    my @rate = undef;
    my $size;
    my $time;
    my @tmp;
    my $len_tmp;

    $log_file = (($test_case_env & MULTISESSION) == MULTISESSION) && $sess >1 ? "udp_log_${sess}.txt" :"udp_log.txt";

    open(INPUT_FILE,"<$log_file");
    @arr = <INPUT_FILE>;
    close(INPUT_FILE);
    $result_status = "PASS";
    foreach (@arr) {
        $result_status = "FAIL", last if /fail/;
    }
    if($result_status eq "PASS") {
        if( ($test_case_env & MULTISESSION) == 0 || $sess == 1) {
               $result = @arr[@arr - 1];
               @rate = split(/\s+/, $result);
               @tmp = split(/-/,$rate[2]);
               $len_tmp = @tmp;
               if($len_tmp == 1) {
                    $size = $rate[4];
                    $time = $rate[2];
               } else {
                    $size = $rate[3];
                    $time = $tmp[1];
               }
               return ($result_status,$size*1000/8,$time);
        }else {
              $result = undef;
              foreach (@arr) {
                   $result = $_, last if /SUM/;
              }
              if(defined($result)) {
                   $result = @arr[@arr - 1];
                   @rate = split(/\s+/, $result);
                   $len_tmp = @tmp;
                   if($len_tmp == 1) {
                        $size = $rate[4];
                        $time = $rate[2];
                   } else {
                        $size = $rate[3];
                        $time = $tmp[1];
                   }

                   return ($result_status,$size*1000/8,$time);
               }
        }
   }
   return ($result_status, 0,0);
}


sub _calc_tcp_values {

    my($sess) = shift;

    my $log_file;
    my $result;
    my @arr;
    my @rate = undef;
    my ($result_status, $size) ;
    my $time;
    my @tmp;
    my $len_tmp;

    $log_file = (($test_case_env & MULTISESSION) == MULTISESSION) && $sess >1 ? "tcp_accel_log_${sess}.txt" :"tcp_accel_log.txt";

    open(INPUT_FILE,"<$log_file");
    @arr = <INPUT_FILE>;
    close(INPUT_FILE);
print "@arr";
    $result_status = "PASS";
    foreach (@arr) {
        $result_status = "FAIL", last if /fail/;
    }
    if($result_status eq "PASS") {
        if( ($test_case_env & MULTISESSION) == 0 || $sess == 1) {
               $result = @arr[@arr - 1];
               @rate = split(/\s+/, $result);
               $len_tmp = @tmp;
               if($len_tmp == 1) {
                    $size = $rate[4];
                    $time = $rate[2];
               } else {
                    $size = $rate[3];
                    $time = $tmp[1];
               }

print "@rate"."and size is " .$size;

               return ($result_status,$size*1000,$time);
        }else {
              $result = undef;
               foreach (@arr) {
                   $result = $_, last if /SUM/;
               }
               if(defined($result)) {
                   $result = @arr[@arr - 1];
                   @rate = split(/\s+/, $result);
                   $len_tmp = @tmp;
                   if($len_tmp == 1) {
                        $size = $rate[4];
                        $time = $rate[2];
                   } else {
                        $size = $rate[3];
                        $time = $tmp[1];
                   }

#print "@arr";
                   return ($result_status,$size*1000,$time);
               }
        }
   }
   return ($result_status, 0,0);
}


sub _calc_tcp_unaccel_values {

    my($sess) = shift;

    my $log_file;
    my @file_content;
    my @arr;
    my ($time);
    my ($result_status, $size);

#    $log_file = ($test_case_env & MULTISESSION) == MULTISESSION ? "tcp_unaccel_${sess}.txt" :"tcp_unaccel.txt";

    if(-e $log_file) {
        $result_status =  "PASS";
        open(INPUT_FILE, "<$log_file");
        @file_content = <INPUT_FILE>;
        close(INPUT_FILE);
        chomp($file_content[0]); chomp($file_content[1]);

        $size = $file_content[0];
        $time = $file_content[1];
    } else {
        $result_status = "FAIL";
    }
    return ($result_status, $size,$time);
}

sub _calc_ftp_values{
#    my($test_case_env) = shift;
    my($sess) = shift;
    my($type) = shift;
    my($get_file_name) = shift;


    my($i,$log_file_name,@result_arr,@file_content,@size_arr,@time_arr,$size,$time);
    my($result_status) = "PASS";

    for($i = 1; $i<=$sess; $i++) {
        $log_file_name =  ($test_case_env & MULTISESSION) == MULTISESSION ? "FTP${type}_${i}${get_file_name}.log" :"FTP${type}_${get_file_name}.log" ;
        @result_arr = undef;

print $log_file_name." Reading \n";

        open(FILE_HANDLE,$log_file_name);
        @file_content = <FILE_HANDLE>;
        close(FILE_HANDLE);

print @file_content;

        @result_arr = split(/\s+/,$file_content[8]);
        chomp($result_arr[2]);

        if($result_arr[2] eq "FAIL") {
            $result_status = "FAIL";
            last;
        }elsif($result_arr[2] eq "PASS") {
            @size_arr = split(/\s+/,$file_content[9]);
            @time_arr = split(/\s+/,$file_content[10]);
            chomp(@size_arr[@size_arr-1]);
            chomp(@time_arr[@time_arr-1]);
            $size += @size_arr[@size_arr-1];
            $time += @time_arr[@time_arr-1];
        }else {
            print "Wrong result...asdf Problem in script";
        }
    } # End Of FOR LOOP 2
    return ($result_status, $size, $time);
}

sub _wait_till_test_complete {

#    my($test_case_env) = shift;
    my($sess) = shift;

    my ($search, $len_search);
    my $flag;
    my @arr;
    my $len;
    my @myList;

    $search =  (($test_case_env & MULTISESSION) == MULTISESSION )&& $sess >1? "tcp_accel_done_".$sess.".txt ":"tcp_accel_done.txt ";

    $search = (($test_case_env & TCP_ALL) == TCP_ALL) ?((($test_case_env & MULTISESSION) == MULTISESSION)&& $sess >1 ? "$search tcp_unaccel_done_${sess}.txt ":"$search tcp_unaccel_done.txt ") :"$search";

    $search = (($test_case_env & UDP) == UDP)?((($test_case_env & MULTISESSION) == MULTISESSION )&& $sess >1? "$search udp_done_${sess}.txt":"$search udp_done.txt") :"$search";

    my @a = split(/\s+/,$search);
    $len_search = @a;
    $flag = 0;
    while($flag == 0) {
        @arr = `dir $search 2>&1`;
        $len = @arr;
        chomp($arr[$len-1]);
        if($arr[$len-1] ne "File Not Found") {
             chomp($arr[$len-2]);
              @myList = split(/\s+/,$arr[$len-2]);
              if($myList[1]==$len_search) {
                  `del $search`;
                  $flag = 1;
                  last;
              }
         }
         # "Sleeping for some time...\n";
         sleep 1;
    }  # END of WHILE LOOP
}

sub _wait_till_ftp_complete {
#    my($test_case_env) = shift;
    my($sess) = shift;
    my($type) = shift; # FTP 'get' or 'put'

    my($search,$flag,@arr,$len,@myList);
    $search = (($test_case_env & MULTISESSION) == MULTISESSION) ?"*_${type}_done.txt":"${type}_done.txt";
    $flag = 0;
    print "File being searched $search\n";
    while($flag == 0) {
        @arr = `dir $search 2>&1`;
        $len = @arr;
        chomp($arr[$len-1]);
        if($arr[$len-1] ne "File Not Found") {
             chomp($arr[$len-2]);
              @myList = split(/\s+/,$arr[$len-2]);
              if($myList[1]==$sess) {
                  `del $search`;
                  $flag = 1;
                   last;
              }
         }
         sleep 1;
    }  # END of WHILE LOOP
}


 sub _get_run_command {

     my($sessions) = shift;
     my $test_case_info;

     my($tcp_accel_command,$tcp_unaccel_command,$udp_command,$param,$params,$cmd,@tmp_arr);

     if( ( $test_case_env & TCP) == TCP) {
         $tcp_accel_command = undef;
         $tcp_unaccel_command = undef;
         $udp_command = undef;
         $param = $tcp_params->{"accelerated"};
print "printing tcp params...\n";
print Dumper($param);

         if(($test_case_env & MULTISESSION) == MULTISESSION && defined($sessions) && $sessions > 1) {
             $param->{"sessions"} = $sessions;
         }else {
             $param->{"sessions"}=undef;
         }
         # create command for TCP Acceleration ( Both for -t and -T
         # add sessions if provided
         if (($test_case_env & USE_FILE) == USE_FILE) {
              $tcp_accel_command = _create_iperf_command($param,"TCP","file",((($test_case_info & BOTH_DIR) == BOTH_DIR )?1:undef));
         }else {
              $tcp_accel_command = _create_iperf_command($param,"TCP","size",((($test_case_info & BOTH_DIR) == BOTH_DIR )?1:undef));
         }

         # if Unaccelerated also is specified then
         # then create command for unaccelerated traffic generation.
         if( ($test_case_env & TCP_ALL) == TCP_ALL) {
             $param = $tcp_params->{"unaccelerated"};
             if(($test_case_env & MULTISESSION) == MULTISESSION && defined($sessions) && $sessions > 1) {
                  $param->{"sessions"} = $sessions;
             }else {
                  $param->{"sessions"}=undef;
             }
             $tcp_unaccel_command = _create_unaccel_tcp_command($param);
         }

         # if UDP is specified then                       #
         # then create command for UDP traffic generation #

         if( ($test_case_env & UDP) == UDP) {
             $params = $udp_params;
             if(($test_case_env & MULTISESSION) == MULTISESSION && defined($sessions) && $sessions > 1) {
                 $params->{"sessions"} = $sessions;
             }else {
                 $params->{"sessions"} = undef;
             }

             $udp_command = _create_iperf_command($params,"UDP","size",((($test_case_info & BOTH_DIR) == BOTH_DIR )?1:undef));
         }
         @tmp_arr = ($tcp_accel_command, $tcp_unaccel_command,$udp_command);

         $cmd=\@tmp_arr;

         return $cmd;
     }else {
         # FTP Work Here... :)
         $cmd = _create_ftp_command($ftp_params);
         @tmp_arr = ($cmd);
         return \@tmp_arr;
     }
 }
 
 sub _get_version {
     my $version = $locOrb_rpc->get_system_variable("Version");
     my @version = split(/\s+/, $version);
     my $i =0;
     my $release="";                         #The short form
     while ($version[$i]) {
      if ($version[$i++] eq "Release" ){     #$i now at the version number
         $release = "$version[$i++]"."-";        #$i now pointing at "Build"
         my $subver =  int ($version[++$i]) ;
    #     print "Version sub:  $subver \n";
         $release = "$release"."$subver"; 
      }
    }
         printf "THE TESTED VERSION: %8s \n", $release;

 }

######################### Public functions ######################################################



#################################################################################################
# execute : The main controller of the test, upon calling the test will be run                  #
#            and result generated.                                                              #
#                                                                                               #
#################################################################################################
sub execute {
    my @sessions;
    my $result;
    # 1. Test case name
    my $testCaseName = $config_xml->get_testcase_name();
    print LOG_FILE "Started Test : ", $testCaseName."\n";
    $output_xml->startTag("TestResults",'name'=>$testCaseName);          # Start ROOT Tag          #

    # 2. Set the Environment
    _set_environment();

    # Read Sessions if MULTISESSION test needs to be run                                        #

    @sessions = (1);                                                     # default is 1 session.   #
    if(($test_case_env & MULTISESSION) == MULTISESSION) {
        @sessions = $config_xml->get_session_list();
    }

    # 4. Enable the compression in both orbitals                                                #
    if(($test_case_env & COMPRESSION ) == COMPRESSION) {
       $result = $locOrb_rpc->set_parameter('Compression.EnableCompression', '1');
       print LOG_FILE "Set Compression on for ",$orb_local," : ", $result,"\n";

       $result = $remOrb_rpc->set_parameter('Compression.EnableCompression', '1');
       print LOG_FILE "Set Compression on for ",$orb_remote," : ", $result,"\n";
    } else {
    # Disable Compression if not specified                                                      #
       $result = $locOrb_rpc->set_parameter('Compression.EnableCompression', '0');
       print LOG_FILE "Set Compression on for ",$orb_local," : ", $result,"\n";

       $result = $remOrb_rpc->set_parameter('Compression.EnableCompression', '0');
       print LOG_FILE "Set Compression on for ",$orb_remote," : ", $result,"\n";
    }

    # 5. Read All paramters from XML.
    _read_test_params();
    $output_xml->startTag("Tests");                                      # Start Tests Tag         #

    # Execute for Multiple Wansim Configuration                                                 #
    foreach my $config (@config_list) {
        # Configure Delay Router                                                                #
        print LOG_FILE "Configure Delay Router : $dr_ip\n";
print Dumper($config);
        $result = _config_delay_router($dr_ip,$dr_user,$dr_passwd, $config->{"bw"},$config->{"rtt"},$config->{"plr"});
        print LOG_FILE "Result :",$result,"\n";
        $output_xml->startTag("Configuration","bandwidth" => $config->{"bw"},
                                              "rtt"       => $config->{"rtt"},
                                              "plr"       => $config->{"plr"}); # Start Config tag

        # Execute for Multiple Sessions                                                        #
        foreach my $sess (@sessions) {
          print LOG_FILE "Running test for $sess Session(s)\n";
          $output_xml->startTag("Sessions","count"=>$sess);                      # Start Sessions Tag
          _execute($sess);
          print "Completed ...\n";
          $output_xml->endTag()    ;                                             # End of Sessions Tag
        }                                                                        # END OF SESSIONS LOOP
        $output_xml->endTag();                                                   # End of Configuration Tag
     }                                                                           # END OF CONFIG LOOP

    $output_xml->endTag();                                               # End Tests Tag           #

    $output_xml->endTag();                                               # End the ROOT Tag        #
    
    close(LOG_FILE);                                                     # Close the file          #


}
#################################################################################################
#                                       CONSTRUCTOR                                             #
#################################################################################################

sub new {
    my $self = {};
    shift();
    $test_case_env = shift();                                                  # Test Case Environment...
    $xml_in = shift();                                                         # Input XML file Name.....
    $xml_out = shift();                                                        # Output XML File Name....
    $log_file_name = shift();                                                            # Log file Name...........
     _init();
    bless($self);
    return $self;
}


1;

# Below is stub documentation for your module. You'd better edit it!
__END__

=head1 NAME

Orbital::Test - Class that performs a test on Orbital Device.

=head1 SYNOPSIS

  use Orbital::Tests;


=head1 DESCRIPTION

C<Orbital::Tests> is a class implementing Regression test cases for Orbital
WAN Accelerater device in Perl, as described in "Regression Test Plan.doc".

=head1 OVERVIEW

Orbital|Data is a manufacturer of WAN Accelerator Devices. These devices
accelerate the data transfer over TCP. This module provides methods for
testing the performance of the device by sending TCP and UDP traffic.


=head1 CONSTANTS

COMPRESSION   => To indicate the Compression needs to be enabled.

DISK_BASED    => Indicates if Disk Based Compression needs to be made.

PROXY         => Turns Orbital into Proxy mode before starting test.

MULTISESSION  => Runs test in multiple instances.

TCP           => Sends TCP Accelerated Traffic (Using IPERF).

TCP_ALL       => Sends TCP Unaccelerated traffic (Using HTTP).

UDP           => Sends UDP Traffic (Using IPERF).

UDP_WAIT      => Starts TCP traffic and wait before staring UDP.

UDP_VARY      => Ramp up the UDP traffic slowly.

USE_FILE      => Send a file instead of raw data in TCP | UDP.

BOTH_DIR      => Perform data transfer in both direction.

HARDBOOST     => Sets the orbital to Hardboost.


=head1 CONSTRUCTOR

Orbital::Test->new($test_case_env,$xml_in,$xml_out,$log_file_name);
Creates a new Orbital::Test object.


        $test_case_env is a numeric value which identifies the test
        that need to be made. Values passed to it is a combination of
        Orbital::Test constants.

        $$xml_in Name of the input XML file, which contains all the 
        required parameters.

        $xml_out Name of the output file to be generated.

        $log_file_name is the name of the file where log information is
        stored.

=cut

=head1 METHODS

execute()

      Run the test based on the the value of $test_case_name (provided when
      creating the object).
      Based on value of $test_case_env, it reads parameters form the $xml_in
      file and initiates the test. Once the test is finished, it writes the
      performance metrics into $xml_out file. The brief detail about events
      occuring in the test process can be found in $log_file. This can be
      used to traceout where exactly the test is failing.

      Based on the value of $test_case_env, the script may require one or
      more of the following files:

      1. FTP_get.pl
      2. FTP_get.pl
      3. Tor.pl
      4. Iperf.pl
      5. Iperf.exe

   NOTE:
      To pass appropriate value to $test_case_env use constants defined
      in Orbital::Test package
      Put appropriate values in XML file used for input.


=head1 SEE ALSO

L<Orbital::XMLRPC>
L<Orbital::Parse>
L<Net::Telnet>

http://www.orbitaldata.com/

=head1 AUTHOR

Sundeep Gupta, E<lt>sundeep.gupta@india.comaE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Applabs Technologies Private Limited.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
