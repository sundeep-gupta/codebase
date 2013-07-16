#!/usr/bin/perl

use MIME::Lite;


### Adjust sender, recipient and your SMTP mailhost
my $from_address = 'sundeep.gupta@applabs.com';
my $to_address = 'sundeep.gupta@applabs.com';
my $mail_host = 'smtp.applabs.com';

### Adjust subject and body message
my $subject = 'Mail with Perl...';
my $message_body  = "Hi Sundeep\nScript for sending mail using perl.... \n\nSee.. I can send attachments also...\n\nCost = 1 Ice Cream :-))\n\n~!~ Sun ~!~\n";

### Adjust the filenames
my $my_file_gif = 'never-give-up.jpg';
my $your_file_gif = 'never-give-up.jpg';

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
#$msg->attach (
#   Type => 'image/gif',
#   Path => $my_file_gif,
#   Filename => $your_file_gif,
#   Disposition => 'attachment'
#) or die "Error adding $file_gif: $!\n";

### Send the Message
MIME::Lite->send('smtp', $mail_host, Timeout=>60);
$msg->send;
