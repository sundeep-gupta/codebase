#use strict;
#XML related Modules
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use XMLRPC::Lite;
require 'Module.pl';

#Modules related to Excel sheet Parsing
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Excel';

#Other Modules
use Cwd;

#store the Template file path and file name in a variable
$excel_name = getDir()."Template2.xls";

#open the XML file
$xml = new XML::Simple;
$configdata = $xml->XMLin("config.xml");

#Configure the Orbitals and WANSIM before test
configure_devices($configdata);

#read the WANSIM tag and store it in variable for writing into Excel sheet
$wansimhash = $configdata->{'wansim'};
@wansim_param = get_wansim_params($wansimhash);
@wansim_param[3] = @wansim_param[3]*100;

# Version to be logged 
#get the build no from XML file
$testcaseRef = $configdata->{'test_case'};
($serverIP,$VERSION,$Testcase) = get_test_params($testcaseRef);

# Date to be Logged
$dateofthetest = timestamp();

$filename = "Log.txt";
my $nlchar = "\n";

#Validation of Command Line Arguments

if (@ARGV==0) {
	print "\nCommandLine argument Missing.\n\n";
	print "Usage: Perl logger.pl 1|2|4|8\n";
	exit;
}else {
	if (@ARGV[0] != 1 and @ARGV[0] != 2 and @ARGV[0] != 4 and @ARGV[0] != 8 and @ARGV[0] != 16 ) {
	print "Invalid argument: ".@ARGV[0];
	print "\nOnly 1 or 2 or 4 or 8 Sessions are allowed\n";
	print "Usage: Perl logger.pl 1|2|4|8\n";
	exit;
	}
}

# Run Test case 3 with given no of sessions and create the log file with name $filename
@average = run_test3(@ARGV[0],$filename);
#store the throughput
@throughput = throughput_test3(@ARGV[0],@average);


#Open the Template file and get the reference to the Sheet required
$book = open_excel($excel_name);

my $Sheet = $book->Worksheets("SM Execution T1 #2.2.0.7");

#write ServerIP here B6 and B20\
$Sheet->Cells(6,2)->{'Value'} = $serverIP;
$Sheet->Cells(20,2)->{'Value'} = $serverIP;

#write latency here C6 and C20
$latency = @wansim_param[1]." Mbps".@wansim_param[2]." RTT ".@wansim_param[3]." plr";
$Sheet->Cells(6,3)->{'Value'} = $latency;
$Sheet->Cells(20,3)->{'Value'} = $latency;

#write No of machines here F3 and F20
$Sheet->Cells(3,6)->{'Value'} = @ARGV[0]." Machines ";
$Sheet->Cells(17,6)->{'Value'} = @ARGV[0]." Machines ";

#write the Throughput values
$rowIndex = 11;
for ($i=0;$i<(@throughput/2);$i++) {
	#Throughput values here First write and then read
	$Sheet->Cells($rowIndex,7)->{'Value'} = @throughput[$i];
	$Sheet->Cells($rowIndex-1,7)->{'Value'} = @throughput[$i+3];
	
	#write the Throughput Formula here
	if(($i%3) == 0) {
		$size = 5*1024*@ARGV[0];
	}elsif(($i%3) == 1){
		$size = 10*100*@ARGV[0];
	}else {
		$size = 50*10*@ARGV[0];
	}

	$val = $size."/".$average[$i];
	$Sheet->Cells($rowIndex+16,7)->{'Value'} = $val;
print $val,"\n";
	$val = $size."/".$average[$i+3];
	$Sheet->Cells($rowIndex+15,7)->{'Value'} = $val;
print $val,"\n";
	$rowIndex-=2;
}
$book->SaveAs("$LOG_PATH@ARGV[0] Sessions.xls");




