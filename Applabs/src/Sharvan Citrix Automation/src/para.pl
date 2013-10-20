use Time::HiRes qw(gettimeofday);
use POSIX qw/strftime/;
use XMLRPC::Lite;

if ($ARGV[0] eq "--help") {
	print "Usage: perl $0 parameter-name ip_of_first_orbital ip_of_second_orbital\n";
	print "Warning: This script will create the output file(s) with name output-of-ip-of-orbital.txt.\n";
	print "\tThis script will overwrite the existing file(s) with the mentioned name(s) if any.\n";
	exit;
}
if ($#ARGV<1) {
	print "Usage: perl $0 parameter-name ip_of_first_orbital ip_of_second_orbital\n";
	exit;
}

my $param = shift;
my $orb1 =shift;
my $orb2 =shift or 0;

my $outfile1 = "output-of-".$orb1.".txt";

if (-f $outfile1) {
	unlink($outfile1);
}
if ($orb2) {
	my $outfile2 = "output-of-".$orb2.".txt";
	if (-f $outfile2) {
		unlink($outfile2);
	}
}

while(1)
{
	open(FH1,">>$outfile1");
	my $response = XMLRPC::Lite->proxy("http://$orb1:2050/RPC2")
			->call('Command', $param)
			->result;
	print FH1 today()."-".now().": ".$response;
	print FH1 "\n";
	close(FH1);

	if ($orb2) {
		open(FH2,">>$outfile2");
		my $response2 = XMLRPC::Lite->proxy("http://$orb2:2050/RPC2")
				->call('Command', $param)
				->result;
		print FH2 today()."-".now().": ".$response2;
		print FH2 "\n";
		close(FH2);
	}
	sleep(5);
}

sub today
{
	my $date=strftime("%B %d, %Y", localtime(time()));
	return $date;
}

#Current Time
sub now
{
	my $time=strftime("%H:%M:%S", localtime(time()));
	return $time;
}