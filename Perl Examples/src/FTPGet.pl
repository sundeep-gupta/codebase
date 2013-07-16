use Net::FTP;
use GetOpt::Std;

##################################################################################################
# Usage:                                                                                         #
#      FTPGet.pl <dest_ip> <username> <password> <file_name> [<output_file>]                     #
# Description:                                                                                   #
#      1. Connects to FTP server using <dest_ip> and Login using the <username> & <password>     #
#      2. Get the specified file <file_name> from server & save it as <output_file>.             #
#      3. If <output_file> is not specified then file will be saved with same name               #
# Output:                                                                                        #
#      Generates a log file with name FTPGet_<output_file>.log so as to make easy to identify    #
#      the log file even if multiple sessions are run.                                           #
##################################################################################################

($dest_ip,$username,$password,$file_name) = @ARGV;
$output_file = $file_name;
$output_file = @ARGV[4].$file_name if defined(@ARGV[4]);

$log_file_name = "FTPGet_".$output_file.".log";

open(FTP_LOG,">$log_file_name");

print FTP_LOG "Connecting to FTP Server : $dest_ip\n";
$ftp = Net::FTP->new($dest_ip) or print (FTP_LOG  "Cannot connect to server...\n"), exit(1);
print FTP_LOG "Connection Successful...\n";

print FTP_LOG "Logging as $username\n";
$ftp->login($username,$password) or print( FTP_LOG "Invalid Credentials\n"), exit(1);
print FTP_LOG "Login Successful...\n";

print FTP_LOG "Trying to find file, $file_name, and get the size...\n";
$size = $ftp->size($file_name) or  print (FTP_LOG "Unable to find File\n"),exit(1);
print FTP_LOG "File Found.\n";

print FTP_LOG "Getting file from server...\n";
$time = timer;
$result = $ftp->get($file,$dest_file) or print (FTP_LOG "Get failed...\n"),exit(1);
$time = timer - $time;
print FTP_LOG "Operation successfully completed...\n";

print FTP_LOG "Result : ";
if (defined($result)) {
    print FTP_LOG "PASS\n";
}else {
    print FTP_LOG "FAIL\n";
}
print FTP_LOG "Time taken for GET Operation : $time";
$ftp->close();