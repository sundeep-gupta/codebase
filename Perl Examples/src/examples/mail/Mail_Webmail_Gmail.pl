use Mail::Webmail::Gmail;

    my $gmail = Mail::Webmail::Gmail->new( 
                username => 'sundeep.techie', password => 'gr33N!e.', proxy_name=>'www-proxy.us.oracle.com:80', 'debug_level' => 1
            );
            use Data::Dumper;
#            print Dumper($gmail);

            print "Authenticated..." if $gmail;

    my @labels = $gmail->get_labels();
    print $gmail->error_msg();
    print @labels;
