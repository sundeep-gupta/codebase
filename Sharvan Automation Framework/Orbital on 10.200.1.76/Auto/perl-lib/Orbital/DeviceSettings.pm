#!/usr/local/bin/perl
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.19 $
# Last Modified: $Date: 2005/08/18 23:56:23 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbital/control/perl-lib/Orbital/DeviceSettings.pm,v $
#
####################################################################################
##
##

package DeviceSettings;

use lib qw(/usr/local/lib/perl5/5.8.6 /usr/local/orbital/console/perl-lib);
use vars qw($ORBITAL_PATH $ORBITAL_PORT);
use Orbital::Config;
use XMLRPC::Lite;
use LWP::Simple;
use strict;
use Data::Dumper;

# -----------------------------------------------------------
# SETTINGS:
# -----------------------------------------------------------

my $CONFIG = Config::new();

# Define the following
my $ORBITAL_PATH = $CONFIG->{'ORBITAL_PATH'};    # Directory of the Orbital Test Tool software package
my $ORBITAL_PORT = $CONFIG->{'ORBITAL_PORT'};    # Port number of the Orbital device

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - $hashref - Hash reference containing all of our test case instance information
# Output - Object reference
sub new {
    my $hashref = shift;
    
    # Capture our devices
    my $orbitals = $hashref->{'orbitals'};
    my $wansim = $hashref->{'wansim'};
    
    my $DEVICES = {
        "Orbitals"   => $orbitals,
        "Wansim"     => $wansim,
        "ActiveConn" => 0
    };
    bless $DEVICES, 'DeviceSettings';   # Tag object with pkg name
    return $DEVICES;
}

# configure_devices() - Configure all of our devices (Orbitals & WAN-simulator)
# Input:  $DEVICES - Object reference containing our device configuration data
# Output: None
sub configure_devices {
    my $DEVICES = shift;
    
    # Get our device information
    my $orbitals = $DEVICES->{'Orbitals'};
    my $wansim   = $DEVICES->{'Wansim'};
    
    # Configure our WAN-simulator
    configure_wansim($wansim) if ($CONFIG->{'USE_DELAYROUTER'} > 0);

    # Configure our Orbital devices
    if ($CONFIG->{'USE_ORBITALS'} > 0) {
        foreach my $device (keys %$orbitals) {
            my $ip = $orbitals->{$device}->{'ip_address'};
            
            # Display our configuration information
            if (exists($ENV{'HTTP_USER_AGENT'})) {
                my $html = <<END_OF_HTML;
            <table class="testrun">
            <tr>
                <td colspan="2" class="orbHeader">Orbital Configuration:</td>
            </tr>
            <tr>
                <td class="orbLabel">IP Address:</td>
                <td class="orbField">$ip</td>
            </tr>
END_OF_HTML

                print $html if ($CONFIG->{'VERBOSE'} > 0);
            }
            else {
                print "ORBITAL>> Orbital Device IP Address: $ip \n";
            }
            
            # Configure our orbital devices
            my $settings = $orbitals->{$device}->{'settings'};
            foreach my $param (keys %$settings) {
                configure_orbital($ip,$param,$settings->{$param});
            }
            
            # Display our html footer
            if (exists($ENV{'HTTP_USER_AGENT'})) {
                my $html = <<END_OF_HTML;
            </table>
END_OF_HTML
                print $html if ($CONFIG->{'VERBOSE'} > 0);
            }
        }
    }
}

#
# configure_wansim() - Configure the WAN-simulator using the given settings
# Input:  $wansim - Hash reference containing our delay router settings
# Output: None
sub configure_wansim {
    my $wansim = shift;
    
    my $ip = $wansim->{'ip_address'};
    my $bw = $wansim->{'settings'}->{'bandwidth'};
    my $dly = $wansim->{'settings'}->{'delay'};
    my $plr = $wansim->{'settings'}->{'plr'};
    my $url = "http://$ip/cgi-bin/wansimconfig.cgi?bw=$bw&dly=$dly&plr=$plr";

    # Display our configuration information
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        my $html = <<END_OF_HTML;
            <table class="testrun">
            <tr>
                <td colspan="2" class="wanHeader">WAN-Simulator Configuration:</td>
            </tr>
            <tr>
                <td class="wanLabel">IP Address:</td>
                <td class="wanField">$ip</td>
            </tr>
            <tr>
                <td class="wanLabel">Bandwidth:</td>
                <td class="wanField">$bw</td>
            </tr>
            <tr>
                <td class="wanLabel">Delay:</td>
                <td class="wanField">$dly</td>
            </tr>
            <tr>
                <td class="wanLabel">PLR:</td>
                <td class="wanField">$plr</td>
            </tr>
            </table>
END_OF_HTML

        print $html if ($CONFIG->{'VERBOSE'} > 0);
    }
    else {
        print "ORBITAL>> configure_wansim() -> ip address: $ip\n";
        print "ORBITAL>> configure_wansim() -> bandwidth: $bw\n";
        print "ORBITAL>> configure_wansim() -> delay: $dly\n";
        print "ORBITAL>> configure_wansim() -> plr: $plr\n";
        print "ORBITAL>> configure_wansim() -> url: $url\n";
    }

    my $content = get($url);

    # Check to see if anything was returned
    if (!defined($content)) {
        print "ORBITAL>> configure_wansim() -> ERROR: No content was returned for LWP::Simple::get() \n";
    }
}

# configure_orbital() - Configure Orbital device using the given parameters, values and ip address
# Input:  $orbitalip - IP address of the Orbital device to be configured
#         $param     - Parameter to be changed
#         $value     - Value of the parameter to be changed
# Output: None
# TODO: Add a success/failure value for output
sub configure_orbital {
    chomp(my $orbitalip = shift);
    chomp(my $param = shift);
    chomp(my $value = shift);

    my $url = "http://$orbitalip:$ORBITAL_PORT/RPC2";

    # Define our parameter names and values
    my $parameterName = ($param) ? $param : "Parameter name not defined";
    my $parameterValue = (($value) || ($value == 0)) ? $value : "Parameter value not defined";

    # As an extra option, we can decide whether to output anything or not
    my $display = shift;
    if (!defined($display)) {
        $display = "true";
    }
    
    # Display our configuration information
    if (exists($ENV{'HTTP_USER_AGENT'})) {
        my $stdout = <<END_OF_HTML;
            <tr>
                <td class="orbLabel">$parameterName</td>
                <td class="orbField">$parameterValue</td>
            </tr>
END_OF_HTML

        print $stdout if (($CONFIG->{'VERBOSE'} > 0) && $display eq "true");
    }
    else {
        my $stdout = "ORBITAL>> configure_orbital() -> parameter name: $parameterName \n";
        $stdout .= "ORBITAL>> configure_orbital() -> parameter value: $parameterValue \n";
        $stdout .= "ORBITAL>> configure_orbital() -> URL: $url\n";
        
        print $stdout if (($CONFIG->{'VERBOSE'} > 0) && $display eq "true");
    }

    # Change our call to XMLRPC based upon whether a parameter value was included or not
    if (!defined($value)) {
        my $response =  XMLRPC::Lite
            ->proxy($url)
            ->call('Get', {Class => "PARAMETER", Attribute => "$param" })
            ->result;

        if (!defined(${$response}{$param}{'Fault'})) {
            while (( my $okey, my $oval) = each %$response) {
                if ($oval->{'XML'} =~ (m/^ARRAY/)) {
                    print  $okey . " = " . $oval->{'Text'} . "\n";
                }
                else {
                    print  $okey . " = " . $oval->{'XML'} . "\n";
                }
            }
        }
        else {
            print "${$response}{$param}{'Fault'} $param\n";
        }
    }
    else {
        my $response =  XMLRPC::Lite
            ->proxy($url)
            ->call('Set', {Class => "PARAMETER", Attribute => $param, Value => eval($value) })
            ->result;

        if (defined(${$response}{'Fault'})) {
            print "${$response}{'Fault'}\n";
        }
    }

}




1;

__END__
