package Bubble::MSMUtils;
use strict;


sub copy_instru_xml {
    my $target = shift;
    my $lingering_mode = shift;
    my $file = '/usr/local/McAfee/fmp/var/instru.xml';
    $file = '/root/.msm/instru.xml' if $lingering_mode;
    print "Waiting ...\n";
    while ( not -e $file ) {sleep 1;};
    print "Copying ...\n";
    while ( -e $file ) { `cp $file $target`; };
}


sub uninstall_firefox {
    print "Removing Firefox application\n";
    rmdir("/Applications/Firefox.app");
    print "Removing User data\n";
    unlink($ENV{'HOME'}."/Library/Preferences/org.mozilla.firefox.plist");
    # This is where SA is stored.
    print "Removing Extensions\n";
    rmdir ("/Library/Application Support/Mozilla/");
}

1;
