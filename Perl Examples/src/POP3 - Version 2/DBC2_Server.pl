#!/usr/bin/perl

############################################################
# Author :  Jagdish Chittala
# Company :	Applabs Technologies, Hyderabad, India.
############################################################
use MIME::Lite;
use XML::Simple;
use Time::HiRes qw( gettimeofday);


#VALIDATION OF SCRIPT
if (! (-e "config.xml")) {
	print "Config.xml file not found";
	help();
	exit(1);
}
$c = @ARGV;

if($c>0) {
	$first = @ARGV[0];
	if($first eq "-h" or $first eq "-H") {
		help();
	} else {
		help_usage();
	}
	exit(1);
};

#Open XML file 
$xml = new XML::Simple;
$configdata = $xml->XMLin("config.xml");
$xsimple = XML::Simple->new();

($mail_host, $from_address, $to_address, $subject,$message_body, $attach_file) = get_test_params($configdata);
my $msg = prepare_message($mail_host, $from_address, $to_address, $subject, $message_body, $attach_file);

### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
my @timearr = gettimeofday();
$msg->send;
my @timearr2 = gettimeofday();
$time = @timearr2[0]-@timearr[0] + (@timearr2[1]-@timearr[1])/1000000;


write_xml($time,"Send_time");




#####################################################################################################
#				User Defined Functions						    #
#####################################################################################################

#get the testcase parameters
sub get_test_params {
        my $testcase = shift;
        my $mail_host = $testcase->{'host_address'};
        my $from_address = $testcase->{'from'};
        my $to_address = $testcase->{'to'};
		my $subject = $testcase->{'subject'};
		my $message_body = $testcase->{'message'};
		my $attach_file = $testcase->{'attach'};
        @vals = ($mail_host, $from_address, $to_address, $subject,$message_body,$attach_file);
        return @vals;
}



sub write_xml {
        my $time = shift;
	my $i = shift;
       %tags = ( $i =>  $time);

        if (open(LOGFILE, ">>DBC2_Server.xml")) {
	        print LOGFILE  $xsimple->XMLout(\%tags,noattr => 1, RootName => undef,xmldecl => ($i==0?'<?xml version="1.0"?>':undef));
            close(LOGFILE);
            print "In xml";
        }
}

sub help {
        print "\nPREREQUISITES:\n";
        print "1. XML::Simple module must be installed to read input and write XML files.\n";
		print "2. MIME::Lite  module must be installed to send the mail\n";
        print "3. Config.XML file must be present in the same directory.\n";
        print "\nDESCRIPTION:\n";
        print "-> DBC2 prepares a Multipart/mixed mail message containing the attachment (~2 MB)\n";
        print "-> Sends the mail to the mail server.\n";
        print "-> Writes the time taken for sending mail into DBC2_server.XML file\n";
}
sub help_usage {
        print "Invalid argument\n";
        print;
        print "Usage : perl DBC2_Server.pl [-h]\n";
}


sub prepare_message {
	my ($mail_host, $from_address, $to_address, $subject, $message_body, $attach_file) = @_;
	$msg = MIME::Lite->new (
	  From => $from_address,
	  To => $to_address,
	  Subject => $subject,
	  Type =>'multipart/mixed'
	) or die "Error creating multipart container: $!\n";

	### Add the text message part
	$msg->attach (
	  Type => 'TEXT',
	  Data => $message_body
	) or die "Error adding the text message part: $!\n";
	
	### Add the ZIP file

	$msg->attach (
	   Type => 'application/zip',
	   Path => "./$attach_file",
	   Filename => $attach_file,
	   Disposition => 'attachment'
	) or die "Error adding $file_zip: $!\n";

	### Send the Message
	MIME::Lite->send('smtp', $mail_host, Timeout=>60);

	return $msg;
}


