# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use XMLRPC::Lite;

######################################################################################
#About usage of the Automated script :   XMLPARSE.PL
#
#
# 1) Assign the values for the Params for the Orbital and Wansim in the 
#    Config.xml file.
#
# 2) Ensure to keep the config.xml in the same path of the automated script.
#
# 3) Run the script 
#    perl xmlparse.pl
#
# Then it will change the Parameters of the Wansim and Orbital as per the 
# Given Values.
#####################################################################################

# create object
$xml = new XML::Simple;
# read XML file
$configdata = $xml->XMLin("config.xml");

# Orbital and wansim configuration paramers
configure_devices($configdata);
sub configure_devices {
    my $DEVICES = shift;
  
    # Get our device information
    my $orbitals = $DEVICES->{'orbitals'}->{'machine'};
    my $wansim   = $DEVICES->{'wansim'};
   # print Dumper($orbitals);
    # Configure our WAN-simulator
    configure_wansim($wansim);

    # Configure our Orbital devices
    foreach my $device (keys %$orbitals) {
        my $ip = $orbitals->{$device}->{'ip_address'};
 	# Configure our orbital devices
	    my $settings = $orbitals->{$device}->{'settings'};
        foreach my $param (keys %$settings) {
           configure_orbital($ip,$param,$settings->{$param});
        }
	}
}

sub configure_wansim {
    my $wansim = shift;
    
    my $ip = $wansim->{'ip_address'};
    my $bw = $wansim->{'settings'}->{'bandwidth'};
    my $dly = $wansim->{'settings'}->{'delay'};
    my $plr = $wansim->{'settings'}->{'plr'};
    
	my $url = "http://$ip/cgi-bin/wansimconfig.cgi?bw=$bw&dly=$dly&plr=$plr";
    my $content = get($url);
	# Check to see if anything was returned
    if (!defined($content)) {
        print "ORBITAL>> configure_wansim() -> ERROR: No content was returned for LWP::Simple::get() \n";
    }
}

sub configure_orbital {
    chomp(my $orbitalip = shift);
    chomp(my $param = shift);
    chomp(my $value = shift);

    my $url = "http://$orbitalip:2050/RPC2";

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