#!/usr/bin/perl


############################################################
# Author : Jagdish Chittala, Sundeep Gupta
# Company :	Applabs Technologies, Hyderabad, India.
############################################################
use MIME::Lite;
use Net::SMTP;
use Data::Dumper;

### Adjust sender, recipient and your SMTP mailhost
my $from_address = 'orbital.user1@mybug.applabs.net';
my $to_address = 'orbital.user1@mybug.applabs.net';
my $mail_host = '172.16.11.216';

### Adjust subject and body message
my $subject = 'A message with 2 parts ...';
my $message_body = "Here's the attachment file(s) you wanted";

### Adjust the filenames
my $my_file_gif = 'Sankranthi.gif';
my $your_file_gif = 'your_file.gif';
my $my_file_zip = 'DBC7.zip';
my $your_file_zip = 'DBC.zip';

### Create the multipart container
$msg = prepare_message($mail_host, $from_address, $to_address, $subject, $message_body, $my_file_zip);
$msg->send;

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

	### Add the GIF file
	#$msg->attach (
	 #  Type => 'image/gif',
	  # Path => $my_file_gif,
	  # Filename => $your_file_gif,
	  # Disposition => 'attachment'
	#) or die "Error adding $file_gif: $!\n";

	### Add the ZIP file
	$msg->attach (
	   Type => 'application/zip',
	   Path => $attach_file,
	   Filename => $attach_file,
	   Disposition => 'attachment'
	) or die "Error adding $file_zip: $!\n";

	### Send the Message
	MIME::Lite->send('smtp', $mail_host, Timeout=>60);
	#print Dumper($msg);
	return $msg;
}