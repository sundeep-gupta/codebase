#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies / Persystent Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
# Description: reboot.pl - reboot Win32 computers
####################################################################################
##
##

use lib "C:\\persystent\\Automation\\Perl-Lib\\";
use Persystent::Config;
use Persystent::Input;
use Persystent::Remote;
use Win32;
use strict;
use Data::Dumper;


# Fetch our global configuration information
my $CONFIG = Config::new();

# Define our spreadsheet object
# NOTE: The input can include 2 values, $InputFileName and $InputFilePath. For example:
#           my $XLS = Input::new($InputFileName, $InputFilePath);
#       $InputFileName - File name of the input file
#       $InputFilePath - Path of where the input file is located (relative or full path)
my $XLS = Input::new();
$XLS->readInput();

# Fetch a list of all computers to reboot
my $computerList = $XLS->getComputers();

# Capture the start time
my $startTime = getTimestamp();
print "Reboot Start Time: \t $startTime \n";

# Reboot each computer
my $count = 0;
foreach my $computer (@$computerList) {
    # Reboot parameters
    my %param = (
        Computer  => $computer->{'IPaddress'},
        Message	  => "Automation framework is shutting system down!",
        Timeout	  => 5,  # Number of seconds to wait before rebooting
        ForeClose => 1,  # 0 = do not force open applications to close, 1 = force
        Shutdown  => 1,  # 0 = power down, do not restart, 1 = restart
    );
    
    # Send reboot command to client machine
    print "Sending System Shutdown Command to [" . $param{Computer} . "]...\n";
    Win32::InitiateSystemShutdown(
        $param{Computer},
        $param{Message},
        $param{Timeout},
        $param{ForeClose},
        $param{Shutdown},
    ) || die "Failed to initiate shutdown.\n $^E\n";
    
    $count++;
}

print "Completed rebooting all client machines.... continuing.... \n";

# Wait N number of seconds after a reboot before continuing
sleep $CONFIG->{'REBOOT_WAIT'};

# Capture the end time
my $endTime = getTimestamp();
print "Reboot End Time: \t $endTime \n";
print "Reboot Elapsed Time = \t " . ($endTime - $startTime) . " secs. \n";
print "Reboot 100\% Complete.\n\n";

# Verify that each machine is up and operational
# TODO: need to add this functionality for a better network check, will use "sleep()" for now


__END__










