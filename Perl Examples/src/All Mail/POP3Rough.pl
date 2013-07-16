use Net::POP3;
use MIME::Parser;

$pop = Net::POP3->new('172.16.2.2');
#$pop = Net::POP3->new('smtp.applabs.com', Timeout => 60);
$username = "sundeep.gupta";
$password = "hash\@dollar";

if ($pop->login($username,$password) == undef){
		print "Authentication Failed";
};

#	print "Before Login: $res After Login";
#    if ($pop->login($username, $password) > 0) {
#	print "Login Succesful";

 my $msgnums = $pop->list; # hashref of msgnum => size
# foreach my $msgnum (keys %$msgnums) {
     my $msg = $pop->get(3);
print $msg;
#create a new Parser Object
	  my $parser = new MIME::Parser;
#parse an In-core MIME Message
      $entity = $parser->parse_data($msg);
	  print $entity->mime_type;

### Output each message body to a one-per-message directory:
	  $parser->output_under("/tmp");




#        print @$msg;
       # $pop->delete($msgnum);
      #}
 #   }

    $pop->quit;