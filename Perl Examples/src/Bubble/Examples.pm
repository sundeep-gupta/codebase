package Bubble::Examples;
use strict;


# Example for writing unicode characters to file.
# Argument is the filename to where some unicode characters will be written.

sub ex_write_unicode {
    use utf8;
    my $file = shift;
    my @chars = (0x41, 0x56, 0x49, 0x20, 0x4C, 0x49, 0x53, 0x54);
    open (my $fh, ">$file");
    print $fh "\U+0041\U+0056\U+0049\U20\U4C\U49\U53\U54";
    print $fh "Sample Text for other characters";
    close $fh;

}

sub ex_mac_process_info {
    use Mac::Processes;

    while ( ($psn, $psi) = each(%Process) ) {
        print "$psn\t",
            $psi->processName,       " ",
            $psi->processNumber,     " ",
            $psi->processType,       " ",
            $psi->processSignature,  " ",
            $psi->processSize,       " ",
            $psi->processMode,       " ",
            $psi->processLocation,   " ",
            $psi->processLauncher,   " ",
            $psi->processLaunchDate, " ",
            $psi->processActiveTime, " ",
            $psi->processAppSpec,    "\n";
    }
    GetProcessInformation(1119);

}

sub ex_storable {
    use Storable;
 
    # Create a hash with some nested data structures
    my %struct = ( text => 'Hello, world!', list => [1, 2, 3] );
 
    # Serialize the hash into a file
    store \%struct, 'serialized';
 
    # Read the data back later
    my $newstruct = retrieve 'serialized';

}


sub ex_procmail {


    use Mail::Procmail;
    # Set up. Log everything up to log level 3.
    print "Initializing with loglevel 3\n";
    my $m_obj = pm_init ( loglevel  => 3 , debug=>1, verbose=>1);
    # Pre-fetch some interesting headers.
    print "Getting header now!\n";
    my $m_from              = pm_gethdr("from");
    print "Header is $m_from\n";
    my $m_to                = pm_gethdr("to");
    my $m_subject           = pm_gethdr("Subject");
    print $m_subject;
}


sub ex_sendmail {
    use Mail::Sendmail;
    %mail = ( To      => 'sundeep.techie@gmail.com',
        From    => 'sgupta6@sun-workstation.local',
        Message => "This is a very short message"
    );
    sendmail(%mail) or die $Mail::Sendmail::error;
}
1;
