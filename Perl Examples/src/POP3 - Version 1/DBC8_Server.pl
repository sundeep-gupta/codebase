#!/usr/bin/perl
############################################################
# Script  : Script for DBC Test Case 2
# Author  : Jagdish Chittala
# Company :	Applabs Technologies, Hyderabad, India.
# Client  : Orbital Data, California, USA.
############################################################
use MIME::Lite;
use Net::SMTP;
use XML::Simple;
use Data::Dumper;
use strict;


#VALIDATION OF SCRIPT
if (! (-e "config.xml")) {
	print "Config.xml file not found";
	help();
	exit(1);
}
my $c = @ARGV;

if($c>0) {
	my $first = @ARGV[0];
	if($first eq "-h" or $first eq "-H") {
		help();
	} else {
		help_usage();
	}
	exit(1);
};

#Open XML file 
my $xml = new XML::Simple;
my $configdata = $xml->XMLin("config.xml");

my ($mail_host, $from_address, $to_address, $subject,$message_body,$attach_file) = get_test_params($configdata);


### Create the multipart container
my $msg = prepare_message($mail_host, $from_address, $to_address, $subject, $message_body, $attach_file);
my $time = send_message($msg);

my $xsimple = XML::Simple->new();
write_xml($time);




#####################################################################################################
#									User Defined Functions										    #
#####################################################################################################

# DESCRIPTION : Prepares a MIME - Multipart/Mixed message using the arguments specified 
# ARGUMENTS   : 1. IP Address or the Domain name of the SMTP server to which mail is to be sent.
#				2. From address (mail id which must be sent in the from field of the mail)
#				3. To address ( mail id to whom the mail is sent to)
#				4. Subject (Subject of the mail)
#				5. Message_Body (Text that need to be sent as body of the mail).
#				6. Attach_file (SXW file that need to be sent as attachment).
# RETURN	  : Reference to the prepared MIME::Lite object.
sub prepare_message {
	my ($mail_host, $from_address, $to_address, $subject, $message_body, $attach_file) = @_;

	# Create a MIME::Lite object
	my $msg = MIME::Lite->new (
				From => $from_address,
				To => $to_address,
				Subject => $subject,
				Type =>'multipart/mixed'
			) or die "Error creating multipart container: $!\n";

	# Add the text message part
	$msg->attach (
	  Type => 'TEXT',
	  Data => $message_body
	) or die "Error adding the text message part: $!\n";

	# Add the SXW file
	$msg->attach (
	    Type => 'application/zip',
	   Path => $attach_file,
	   Filename => "$attach_file",
	   Disposition => 'attachment'
	) or die "Error adding $attach_file: $!\n";

	# Set the Server to which the mail is to be sent
	MIME::Lite->send('smtp', $mail_host, Timeout=>60);

	# Return the Message object 
	return $msg;
}

# DESCRIPTION : Sends the mail message. This function takes the MIME::Lite object 
#				which contains all the parameters like from address, to address, mail server address, message, attachments, etc.
#				prepare_message() function must be called before this function so that all the attributes are set to the MIME::Lite object.
# ARGUMENTS	  : MIME::Lite object with all required attributes (from, to, ...) set.
# RETURN	  : Time taken to send the message (in seconds)

sub send_message {
	my $msg = shift;
	my $time = time;
	$msg->send || die "Message defined incorrectly";
	$time = time - $time;
	return $time;
}


# DESCRIPTION : get the testcase parameters
# ARGUMENTS : A XML::Simple object.
# RETURN	: Array containing the values of the elements read form XML file.
sub get_test_params {
	my $testcase = shift;
	my $mail_host = $testcase->{'host_address'};
	my $from_address = $testcase->{'from'};
	my $to_address = $testcase->{'to'};
	my $subject = $testcase->{'subject'};
	my $message_body = $testcase->{'message'};
	my $attach_file = $testcase->{'attach'};
	my @vals = ($mail_host, $from_address, $to_address, $subject,$message_body,$attach_file);
	return @vals;
}

# DESCRIPTION : Writes the result to the 'DBC2.XML' file.
# ARGUMENTS   : 1. Time (value to be stored under the element)
#				2. Element (element name, whose value is first parameter (Time))
#				3. This parameter specifies whether or not the <?XML Version > tag must be  specified.
# RETURN	  : NONE
sub write_xml {
	my $time = shift;
	my $tg = shift;
	my $i = shift;
	my %tags = (
		 "$tg" => $time
			);
	if (open(LOGFILE, ">>DBC8Server.xml")) {
		print LOGFILE  $xsimple->XMLout(\%tags,noattr => 1, RootName => undef,xmldecl => ($i==0?'<?xml version="1.0"?>':undef));
		close(LOGFILE);
	}
}

# DESCRIPTION : Displays the descriptiona about the file.
# ARGUMENTS	  : NONE
# RETURN	  : NONE
sub help {
	print "\nPREREQUISITES:\n";
	print "1. XML::Simple module must be installed to read input and write XML files.\n";
	print "3. Config.XML file must be present in the same directory.\n";
	print "\nDESCRIPTION:\n";
	print "-> DBC1 mounts the remote share to the /mntpt/ folder in local machine.\n";
	print "-> Copies all the data in the remote share ( ~80GB) to /root/applabs/DBC1/ directory in local machine.\n";
	print "-> Writes the time taken for each file transfer into DBC1.XML file\n";
}

# DESCRIPTION : Displays the help about the usage of the file.
# ARGUMENTS	  : NONE
# RETURN	  : NONE
sub help_usage {
	print "Invalid argument\n";
	print;
	print "Usage : perl DBC1.pl [-h]\n";
}


