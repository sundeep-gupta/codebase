#!/usr/bin/perl

use MIME::Lite;
use Net::SMTP;

### Adjust sender, recipient and your SMTP mailhost
my $from_address = 'pavan.podila@applabs.com';
my $to_address = 'sundeep.gupta@applabs.com';
my $mail_host = 'smtp.applabs.com';

### Adjust subject and body message
my $subject = 'A message with 2 parts ...';
my $message_body = "Here's the attachment file(s) you wanted";

### Adjust the filenames
my $my_file_gif = 'Sankranthi.gif';
my $your_file_gif = 'your_file.gif';
my $my_file_zip = 'DBC.zip';
my $your_file_zip = 'DBC.zip';

### Create the multipart container
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
$msg->attach (
   Type => 'image/gif',
   Path => $my_file_gif,
   Filename => $your_file_gif,
   Disposition => 'attachment'
) or die "Error adding $file_gif: $!\n";

### Add the ZIP file
$msg->attach (
   Type => 'application/zip',
   Path => $my_file_zip,
   Filename => $your_file_zip,
   Disposition => 'attachment'
) or die "Error adding $file_zip: $!\n";

### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
$msg->send;

