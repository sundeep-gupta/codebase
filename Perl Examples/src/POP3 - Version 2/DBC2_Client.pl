############################################################
# Script  : Script for DBC Test Case 2
# Author  : Jagdish Chittala
# Company :	Applabs Technologies, Hyderabad, India.
# Client  : Orbital Data, California, USA.
############################################################
use strict;
use XML::Simple;
use MIME::Parser;
use MIME::Lite;
use Mail::POP3Client;
use Time::HiRes qw( gettimeofday);

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

# Open XML file and read from it.
my $xml = new XML::Simple;
my $configdata = $xml->XMLin("config.xml");
my ($mail_host, $username, $password, $from_address, $to_address, $subject) = get_test_params($configdata);

# Connect to Mail Server using the login and password.
my $pop1 = new Mail::POP3Client(USER => "$username", PASSWORD => $password, HOST => $mail_host);

#find the required message and fetch it.
my @timearr = gettimeofday();
my $msg =  $pop1->Retrieve(1);
my @timearr2 = gettimeofday();
$time = @timearr2[0]-@timearr[0] + (@timearr2[1]-@timearr[1])/1000000;


#parse the message and save the attachments in local directory.
my $parser = new MIME::Parser;
my $entity = $parser->parse_data($msg);
$parser->output_under("/tmp");


#Log the time taken for fetching into the xml file
my $xsimple = XML::Simple->new();
write_xml($time, "Recieve_Time",1);

#Open the document and edit it 
my $attach_file = find_file();
#modify_file($attach_file);
print "File modified and saved successfully";


#Send it back to the same address
my $msgReply = prepare_message($mail_host, $to_address, $from_address,"Re: ".$subject, "This is message", $attach_file);

$time = send_message($msgReply);

write_xml($time, "Send_Time",2);

#####################################################################################################
#									User Defined Functions											#
#####################################################################################################

# DESCRIPTION : Open the SXW (OpenOffice document) file and add a paragraph to it and save it.
# ARGUMENTS   : Name of the SXW file that must be modified.
# RETURN      : NONE
sub modify_file {
	my $attach_file = shift;

	#Exit if file does not exist
	if (!(-e "./$attach_file")) {
		print "$attach_file does not exist.";
		exit(1);
	}

	#Open the document, add a paragraph and Save it.
	my $document = ooDocument(file => "./$attach_file");
	my $newparagraph = $document->appendParagraph (
                        text            => 'A new paragraph to be inserted',
                        style           => 'Text body'
                 );
	$document->save;
}

# DESCRIPTION : Find any SXW (OpenOffice document) file in the current directory.
#				If more than one file is found then the program quits displaying the appropriate message.
# ARGUMENTS   : NONE
# RETURN	  : Name of the SXW file in the current directory.
sub find_file {
	opendir(DIR, ".");
	my @files = sort(grep(/zip$/, readdir(DIR)));
	closedir(DIR);
	# Close program if more than one file with sxw extension.
	if( @files > 0) {
		return @files[0];
	} else {
		print "Too many files. Unable to decide which file to send as attachment.";
		exit(1);
	} 

}


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
	   Filename => $attach_file,
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
	my @timearr = gettimeofday();
	print $msg->send || die "Message defined incorrectly";
	my @timearr2 = gettimeofday();
	$time = @timearr2[0]-@timearr[0] + (@timearr2[1]-@timearr[1])/1000000;
	return $time;
}


# DESCRIPTION : get the testcase parameters
# ARGUMENTS : A XML::Simple object.
# RETURN	: Array containing the values of the elements read form XML file.
sub get_test_params {
	my $testcase = shift;
	my $mail_host = $testcase->{'host_address'};
	my $username = $testcase->{'username'};
	my $password = $testcase->{'password'};
	my $from_address = $testcase->{'from'};
	my $to_address = $testcase->{'to'};
	my $subject = $testcase->{'subject'};
	my @vals = ($mail_host, $username, $password, $from_address, $to_address, $subject);
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
	if (open(LOGFILE, ">>DBC2_Client.xml")) {
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
	print "2. MIME::Parser must be installed to parse the message. \n";
	print "3. MIME::Lite must be installed to Send the mail to mail server.\n"
	print "4. Mail::POP3Client must be installed to connect to POP3 Server and fetch mails.\n"
	print "5. Config.XML file must be present in the same directory.\n";
	print "\nDESCRIPTION:\n";
	print "-> DBC2 Connects to the POP3 server and fetches the mail (based on the from, to and subject values in the config.xml file).\n";
	print "-> Parses the read message and then saves the attachment to the local directory. \n";
	print "-> Edits the saved attachment (OpenOffice Document).\n";
	print "-> Sends the same file as attachment back to the Server (from whom the mail came).\n";
	print "-> Writes the time taken for mail reading and mail sending into DBC2_Client.XML file\n";
}

# DESCRIPTION : Displays the help about the usage of the file.
# ARGUMENTS	  : NONE
# RETURN	  : NONE
sub help_usage {
	print "Invalid argument\n";
	print;
	print "Usage : perl DBC2_Client.pl [-h]\n";
}

# DESCRIPTION : Finds the mail with the given from, to and subject in the list of mails
# ARGUMENTS	  : 1. Net::POP3 object which is conencted to the mail server.
#				2. From ( mail address which must be searched in the From field of mail)
#				3. To ( mail address which must be searched in the To field of mail)
#				4. subject ( subject (or part of subject) that must be searched in the subject field of mail)
# RETURN	  : Message ID of the mail if found otherwise, -1
sub find_message {
	my ($pop, $from_address, $to_address, $subject) = @_;
	my $from = 0;
	my $to = 0;
	my $sub = 0;

	for( my $i = 1; $i <= 2; $i++ ) {

		 my  @val = @{$pop->top($i)};
	     foreach  (@val) {
	 		#check if this element contains any of the search criteria
			if( m/From/i && m/$from_address/i ){
				$from = 1;
			}elsif( m/To/i && m/$to_address/i ){
				$to = 1;
			}elsif( m/subject/i && m/$subject/i ){
				$sub = 1;
			}
	
		#if search satisfied then return the index;
			if($from == 1 && $to == 1 && $sub == 1) {
				return $i;
			}
		}
   }
return -1;
}
