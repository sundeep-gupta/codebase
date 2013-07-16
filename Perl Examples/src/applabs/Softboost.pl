#Softboost using Proxy, With / Without Compression in different bandwidths...
use Getopt::Std;
use Orbital::XML::Parse;
use Orbital::XMLRPC;
use Orbital::Test;
use Data::Dumper;
use XML::Writer;
use IO::File;
#use strict;


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


#############################################################################
# ********************  VARIABLE  DECLARATIONS  *************************** #
#############################################################################
my( $test_case_env ) = 0x00;

my ($my_test) = undef;

my($ftp_params,$tcp_params,$udp_params);

my $result;
my ($dr_ip, $dr_user, $dr_passwd);
my $testCaseName;
my @sessions;
my ($type, $unaccel, $vary, $wait);

#############################################################################
# ******************* XML Object Creation ********************************* #
#############################################################################

#my ($output_file) = new IO::File(">result.xml");
#my ($output_xml) = XML::Writer->new (OUTPUT      => $output_file,
#                          DATA_MODE   => 1,
#                          DATA_INDENT => 4);


#############################################################################
# ********* READ SETTINGS THAT ARE MUST FOR ANY TEST CASE  *****************#
#############################################################################

# 1. Test case name
#$testCaseName = $config_xml->get_testcase_name();
#print LOG_FILE "Started Test : ", $testCaseName."\n";
#$output_xml->startTag("TestResults",'name'=>$testCaseName);          # Start ROOT Tag          #

# 2. Wansim IP
#$dr_ip     = $config_xml->get_dr_ip();
#$dr_user   = $config_xml->get_dr_user();
#$dr_passwd = $config_xml->get_dr_passwd();


#$output_xml->startTag("Environment");                                # Start Environment tag   #
#$output_xml->emptyTag("DelayRouter",'IP'=>$dr_ip);

# 3. Information / configuration of Local & Remote Orbitals
#my( $orb_local) = $config_xml->get_local_orbital_ip();
#my( $orb_remote) = $config_xml->get_remote_orbital_ip();

#my( $orb_local) = $config_xml->get_local_orbital_info();
#my( $orb_remote) = $config_xml->get_remote_orbital_info();


# 5. List of wansim configurations on which test must be run (atleast one)

#my(@config_list) = $config_xml->get_dr_config_list();
#if(!defined(@config_list)){
#    print LOG_FILE "No configuration is specified for WanSIM";
#    exit(1);
#}

# 5. Create Objects for XMLRPC for client & server Orbitals

#my($locOrb_rpc) = Orbital::XMLRPC->new("http://$orb_local:2050/RPC2");
#my($remOrb_rpc) = Orbital::XMLRPC->new("http://$orb_remote:2050/RPC2");


#####################################################################################################
# All command line arguments are OPTIONAL                                                           #
# OPTIONAL:                                                                                         #
# -p: Execute proxy mode. XML file must have proxy IPs.                                             #
# -D: Perform Hardboost                                                                             #
# -c: Perform Memory based compression                                                              #
# -d: perform disk based compression                                                                #
# -s: run multiple sessions. XML file must contain the list of sessions.                            #
# -b: perform operation from client to server & server to client. < restricted to some test cases>  #
# -t: to send Accelerated TCP traffic.                                                              #
# -T: to send Accelerated + Unaccelerated TCP traffic                                               #
# -u: Send UDP traffic in parallel with TCP traffic.                                                #
# -v: Varies UDP traffic                                                                            #
# -U: Send UDP traffic after TCP traffic is started.                                                #
# -f: file to be sent. File Name & location must be available in XML file.                          #
#####################################################################################################

getopts("pcdsbtTuUvfD");
#$output_xml->startTag("Orbitals");                                   # Start Orbitals tag      #
#$output_xml->startTag("Remote","IP"=>$orb_remote->{"ip"});                   # Start Remote tag        #


# 1. Set the Softboost & Hardboost settings...

$test_case_env = $test_case_env | HARDBOOST if ($opt_D == 1);
$test_case_env = $test_case_env | PROXY  if($opt_p == 1);
$test_case_env = $test_case_env | COMPRESSION if($opt_c == 1);
#, $output_xml->dataElement("Compression","Enabled")

# if DBC is specified then compression is automatically ON.
$test_case_env = $test_case_env | COMPRESSION | DISK_BASED if($opt_d == 1);
#, $output_xml->dataElement("DBC","Enabled")
$test_case_env = $test_case_env | MULTISESSION if($opt_s == 1) ;

$test_case_env = $test_case_env | BOTH_DIR if($opt_b == 1) ;

$test_case_env = $test_case_env | TCP if($opt_t == 1) ;

$test_case_env = $test_case_env | TCP_ALL | TCP if($opt_T == 1);

$test_case_env = $test_case_env | UDP | TCP if($opt_u == 1) ;

$test_case_env = $test_case_env | UDP_WAIT | TCP | UDP if($opt_U == 1) ;

$test_case_env = $test_case_env | UDP_VARY | TCP | UDP  if($opt_v == 1) ;

$test_case_env = $test_case_env | USE_FILE if($opt_f == 1) ;

$my_test = Orbital::Test->new($test_case_env,"Config.xml", "result.xml","test_log.txt");
$my_test->execute();
#for Server
#if(($test_case_env &  HARDBOOST) == HARDBOOST) {
#
#    print LOG_FILE "Setting Send rate of ".$orb_remote->{'ip'}." to ". $orb_remote->{'send_rate'};
#    $output_xml->dataElement("SendRate",$orb_remote->{'send_rate'});
#    # TODO: Write code to set Sendrate and recieve rates... :)
#     $remOrb_rpc->set_parameter('SlowSendRate', $orb_remote->{'send_rate'});

#    print LOG_FILE "Setting Recieve rate of ". $orb_remote->{'ip'}." to ".$orb_remote->{'send_rate'};
#    $output_xml->dataElement("SendRate",$orb_remote->{'recv_rate'});
#    # TODO: Write code to set Sendrate and recieve rates... :)
#    $remOrb_rpc->set_parameter('SlowRecvRate', $orb_remote->{'recv_rate'});
#}

#$output_xml->endTag();                                                      # End of Remote Tag       #

# for client...
#$output_xml->startTag("Local","IP"=>$orb_local->{"ip"});                    # Start Local tag        #
#if(($test_case_env & HARDBOOST) == HARDBOOST ){


#    print LOG_FILE "Setting Send rate of ".$orb_local->{'ip'}." to ". $orb_local->{'send_rate'};
#    $output_xml->dataElement("SendRate",$orb_local->{'send_rate'});
#    # TODO: Write code to set Sendrate and recieve rates... :)
#     $locOrb_rpc->set_parameter('SlowSendRate', $orb_local->{'send_rate'});

#    print LOG_FILE "Setting Recieve rate of ". $orb_local->{'ip'}." to ".$orb_local->{'recv_rate'};
#    $output_xml->dataElement("SendRate",$orb_local->{'recv_rate'});
#    # TODO: Write code to set Sendrate and recieve rates... :)
#     $locOrb_rpc->set_parameter('SlowRecvRate', $orb_local->{'recv_rate'});

#}
#$output_xml->endTag();                                               # End of Local Tag       #

# 2. Proxy Settings
#$test_case_env = $test_case_env | PROXY  if($opt_p == 1);
#if(($test_case_env & PROXY )==PROXY) {

#  my($orb_proxy_info) = $config_xml->get_proxy_info();
#  my($orb_proxy_info) = $orb_local->{"proxy"};

#  my($orb_proxy_vip) =$orb_proxy_info=>{"vip"};
#  my($orb_proxy_targetip) =$orb_proxy_info=>{"targetIP"};
#  my($orb_proxy_desc) =$orb_proxy_info=>{"desc"};
#  $output_xml->dataElement("Proxy",$orb_proxy_desc,
#                                "VIP"=>$orb_proxy_vip,
#                                "TargetIP"=>$orb_proxy_targetip);


  #TODO: Write code to set Orbital to proxy mode

  #Set Orbital to Proxy
#}


#$output_xml->endTag();                                               # End of Orbitals Tag      #


# if compression is specified then specify that compression needs to be done


#$output_xml->endTag();                                               # End of Environment Tag   #

#die("Cannot run -t or -T or -u or -U or -v switch with -b") if (($test_case_env & TCP) == TCP && ($test_case_env & BOTH_DIR) == BOTH_DIR);



####################################################################################
# ****************** Do orbital settings ******************************************#
####################################################################################



#####################################################################################
# ************** Read data from XML File based on Optional paramters ************** #
#####################################################################################

# 1. Sessions List

#@sessions = (1); #default is 1 session.
#if(($test_case_env & MULTISESSION) == MULTISESSION) {
#   @sessions = $config_xml->get_session_list();
#}

# 2. Enable the compression in both orbitals
#if(($test_case_env & COMPRESSION ) == COMPRESSION) {
# # $result = $locOrb_rpc->set_parameter('Compression.EnableCompression', '1');00
#   print LOG_FILE "Set Compression on for ",$orb_local," : ", $result,"\n";
 #
#   $result = $remOrb_rpc->set_parameter('Compression.EnableCompression', '1');
#   print LOG_FILE "Set Compression on for ",$orb_remote," : ", $result,"\n";
#}

# 3. Read All paramters from XML.

#############################################################################
# $ftp_params will have FTP related information                             #
# $tcp_params will have all TCP related information (Accel & UnAccel)       #
# $tcp_params = {"Accel"=>{"dest_ip"=>"IP","size"=>"size"...},              #
#                "UnAccel"=>{"dest_ip"=>"IP","size"=>"size"...}}            #
# $udp_params will have UDP related information                             #
#############################################################################

#if (($test_case_env & TCP) == 0) {
#     $ftp_params = $config_xml->get_ftp_params();
#} elsif (($test_case_env & TCP) == TCP) {
#    $type = (($test_case_env & USE_FILE ) == USE_FILE) ? 1 : 0;
#    $unaccel =( ($test_case_env & TCP_ALL ) == TCP_ALL) ? 1 : 0;
#
#    $tcp_params = $config_xml->get_tcp_params($type,$unaccel);
##   $udp_params = undef;
#    if(($test_case_env & UDP)==UDP) {
#        $type = (($test_case_env & USE_FILE ) == USE_FILE) ? 1 : 0;
#        $vary = (($test_case_env & UDP_VARY ) == UDP_VARY) ? 1 : 0;
#        $wait = (($test_case_env & UDP_WAIT ) == UDP_WAIT) ? 1 : 0;
#
#        $udp_params = $config_xml->get_udp_params($type,$vary,$wait);
#    }
#} else {
#    #This case should never happen, under present scenario.
#    print LOG_FILE "Incorrect information in Config.xml file";
#    exit(1);
#}


#######################################################################################
# ****************** RUN DESIRED TEST CASE HERE ************************************* #
#######################################################################################

#$output_xml->startTag("Tests");

#foreach my $config (@config_list) {
    #configure the delay router and wait for 10 seconds...

#    print LOG_FILE "Configure Delay Router : $dr_ip\n";
   # $result = Orbital::Test->config_delay_router($dr_ip,$dr_user,$dr_passwd, $config=>{"bw"},$config=>{"rtt"},$config=>{"plr"});
#    print LOG_FILE "Result :",$result,"\n";

#    $output_xml->startTag("Configuration","bandwidth" => $config->{"bw"},
#                                          "rtt"       => $config->{"rtt"},
#                                          "plr"       => $config->{"plr"}); # Start Config tag

#    foreach my $sess (@sessions) {

 #     print LOG_FILE "Running test for $sess Session(s)\n";
#      $output_xml->startTag("Sessions","count"=>$sess);                     # Start Sessions Tag

      # if compression needs to be done, then set the parameter as required
#      if(($test_case_env & COMPRESSION ) == COMPRESSION) {
#           print LOG_FILE "Starting Test for First Compression\n";
 #          $output_xml->startTag("Result","Compression"=>"1");               # Start result Tag
#
           # Run the test for first time
#           run_test($test_case_env, $sess);

 #          $output_xml->endTag();                                            # End of Result Tag
  #         print LOG_FILE "Test Completed for First Compression\n";


#           if(($test_case_env & DISK_BASED) == DISK_BASED) {
 #              print LOG_FILE "Removing the Memory History for Disk based compression\n";
#               #If disk based compression then Clear the Memory History using XMLRPC
#               $result = $locOrb_rpc->send_command('CompressionHistory memory');
#               print LOG_FILE "Removing Memory History from $orb_local : $result \n";

#               $result = $remOrb_rpc->send_command('CompressionHistory memory');
#               print LOG_FILE "Removing Memory History from $orb_remote : $result \n"
#           }
#           print LOG_FILE "Starting Test for Second Compression\n";
#           $output_xml->startTag("Result","Compression"=>"2");

           # Run the test once again
#           run_test($test_case_env,$sess);
#           print LOG_FILE "Test Completed for Second Compression\n";

#           $output_xml->endTag();                                  # End of Result Tag
           #Now reset the History
#           print LOG_FILE "Removing the Compression History for $orb_local\n";

#           $result = $locOrb_rpc->send_command('CompressionHistory reset');
#@           print LOG_FILE "$result \n";

#           print LOG_FILE "Removing the compression History $orb_remote\n";
#           $result = $remOrb_rpc->send_command('CompressionHistory reset');
#           print LOG_FILE "$result \n"
#      } else {
#          print LOG_FILE "Test Started...\n";
#          $output_xml->startTag("Result");
#
 #         run_test($test_case_env,$sess);
##
#          $output_xml->endTag();                                             # End of results tag.
#          print LOG_FILE "Test Completed\n";

#      } # END OF IF CONDITION FOR COMPRESSION
#      $output_xml->endTag()    ;                                             # End of Sessions Tag

#    }# END OF SESSIONS LOOP
#    $output_xml->endTag();                                        # End of Configuration Tag

# }# END OF CONFIG LOOP

#close(LOG_FILE);       # Close the file                            #
#$output_xml->endTag(); # End of Tests Tag                          #
#$output_xml->endTag(); # ROOT Tag close                            #

