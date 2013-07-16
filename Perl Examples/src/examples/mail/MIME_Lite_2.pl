use MIME::Lite;

$msg = MIME::Lite->new (
  From => 'sundeep.gupta@oracle.com',
  To => 'sundeep.gupta@oracle.com',
  Subject => 'subject',
  Type =>'multipart/mixed'
) or die "Error creating multipart container: $!\n";

### Add the text message part
$msg->attach (
  Type => 'TEXT',
  Data => 'message_body'
) or die "Error adding the text message part: $!\n";

### Add the GIF file
#$msg->attach (
#   Type => 'image/gif',
#   Path => $my_file_gif,
#   Filename => $your_file_gif,
#   Disposition => 'attachment'
#) or die "Error adding $file_gif: $!\n";

### Add the ZIP file
#$msg->attach (
#   Type => 'application/zip',
#   Path => $my_file_zip,
#   Filename => $your_file_zip,
#   Disposition => 'attachment'
#) or die "Error adding $file_zip: $!\n";

### Send the Message
MIME::Lite->send('smtp', 'rgmamersmtp.oraclecorp.com', Timeout=>60);
$msg->send;
