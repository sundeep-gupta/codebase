 use Net::POP3;
 use MIME::Parser;
 use Data::Dumper;

    # Constructors
    $pop = Net::POP3->new('smtp.applabs.com');


	$username = "sundeep.gupta";
	$password = 'hash@dollar';
	if ($pop->login($username,$password) == undef){
		print "Authentication Failed";
		exit(1);
	}
	 my $msgnums = $pop->list; # hashref of msgnum => size
	 $from_address = 'sundeep.gupta@applabs.com';
	 $to_address = $from_address;
	 $subject =  'A message with 2 parts';
	$result = find_message($from_address, $to_address, $subject);
	if( $result > 0) {
		print "Message found ".$result;
	}
	 
 #    my $msg = $pop->get(3);
#	 print Dumper($msg);
  #   my $parser = new MIME::Parser;

   #  $entity = $parser->parse_data($msg);
    # $parser->output_under("/tmp");
     $pop->quit;

sub find_message {
	my ($from_address, $to_address, $suubject) = @_;
	my $from = 0;
	my $to = 0;
	my $sub = 0;

	for( $i = 1; $i <= 3; $i++ ) {
		 @val = @{$pop->top($i)};
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