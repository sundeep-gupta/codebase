#Open the excel sheet specified in the first parameter
#!/usr/bin/perl

#-----------------------------------------SUBROUTINES SPECIFIC TO TESTCASE

#runs the test case 3 with given no of sessions and 
# writes the time into a log file
# Writes also the averages into the log file
# returns the average values
sub run_test3 {
	my ($no_of_sessions,$filename) = @_;
	#print `spawn @ARGV[0]`;

	#Write the Header INFO into Log file
	log_events($LOG_PATH,$filename,$dateofthetest."\n");
	log_events($LOG_PATH,$filename,$VERSION."\n");
	log_events($LOG_PATH,$filename,$Testcase."\n");

	#Saving the Individual times into log file 
	#also calculating sum for further calculations

	my @sum = (0,0,0,0,0,0);

	for($i=1;$i<=$no_of_sessions;$i++){
		my $logfilestr = "c".$i."time.txt";
		open(INFILE, $logfilestr);

		my $start = 1;
		my $j = 0;
		while($line = <INFILE>) {
			chomp($line);
			if(substr($line,length($line)-1,1) =~ /\d/) {
				$time = substr($line,length($line) - 11, 12);
				if ($start == 0){ 
					$start = 1;
					$time_in_sec = calcTime($time) - $time_in_sec;
					if($time_in_sec < 0) {
						$time_in_sec = 86400+$time_in_sec;
					}
					$time_in_sec = sprintf("%.3f",$time_in_sec);
					@sum[$j] = @sum[$j] + $time_in_sec;
					$j = $j + 1;
					log_events($LOG_PATH,$filename,$time_in_sec."\t");
				} else {
					$start = 0;
					$time_in_sec = calcTime($time);
				}
			}
		} # End of While 
		log_events($LOG_PATH,$filename,"\n");
	} # End of For
	log_events($LOG_PATH,$filename,"\nAverage Time is: \n");
	#calculate the averages and save it in file
	my @average = (0,0,0,0,0,0);
	for ($i=0;$i<@sum;$i++) {
		@average[$i] = @sum[$i]/$no_of_sessions;
		@average[$i] = sprintf("%.3f",@average[$i]);
		log_events($LOG_PATH,$filename,@average[$i]."\t");
	}
	return @average;
}

#Takes the average values and the No_of sessions
#and Returns the throughput values for test case 3
sub throughput_test3 {
	my ($no_of_sessions,@average) = @_;
	log_events($LOG_PATH,$filename,"\nThroughput values are: \n");
	#calculate the throughput and save the results to log file
	my @throughput = (0,0,0,0,0,0);
	for ($i=0;$i<@average;$i++) {
		if(@average[$i] == 0) {
			@throughput[$i] = 0;
		}elsif(($i%3) == 0) {
			@throughput[$i] = 5*1024*$no_of_sessions/@average[$i];
		}elsif(($i%3) == 1){
			@throughput[$i] = 10*100*$no_of_sessions/@average[$i];
		}else {
			@throughput[$i] = 50*10*$no_of_sessions/@average[$i];
		}
		@throughput[$i] = sprintf("%.3f",@throughput[$i]);
		log_events($LOG_PATH,$filename,@throughput[$i]."\t");
	}
	return @throughput;
}


#####################################################################################
#					GENERAL FUNCTIONS												#
#####################################################################################

#returns the present working directory in the windows format
sub getDir {
	$LOG_PATH = getcwd;
	$LOG_PATH=~s/\//\\/g;
	$LOG_PATH = $LOG_PATH."\\";
return $LOG_PATH;
}



# Subroutine to get date  
sub timestamp {
    # Time Information
    my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year = $year + 1900;
    $mon  = $mon + 1;
    my $localtime = "$mon/$mday/$year";
    return $localtime;
}

#subroutine to get no of seconds from given time string
sub calcTime {
	$valHr = substr(@_[0],0,2);
	if( substr($valHr,0,1) =~ /\D/) {
		$valHr = substr($valHr,1,1);
	}
	$posMin = index(@_[0], ":") + 1;
	$valMin = substr(@_[0],$posMin,2);
	$posSec = index(@_[0],":",$posMin) + 1;
	$valSec = substr(@_[0],$posSec,2);
	$valMilli = substr(@_[0], index(@_[0],".")+1,2);
	return eval($valHr*3600+$valMin*60+$valSec)+($valMilli/100);
}

# Sub routine to log the data,release,heading and key perf data in to the log file
# log_events() - This function logs any data passed to it
# Input:  $LOG_PATH - Path of the log file (NOTE: Path needs to be writeable)
#         $content  - Content to be logged
# Output: Returns nothing
sub log_events {
    my($LOG_PATH,$LOG_FILE_NAME,$content) = @_;
    my $log_file =	$LOG_PATH.$LOG_FILE_NAME;

    # Append
    if (-e $log_file) {
        open(OUTFILE, ">>$log_file") || die "Cannot append to $log_file: $!\n";
        print OUTFILE "$content";
		
        close(OUTFILE);
    }
    # Create
    else {
        open(OUTFILE, ">$log_file") || die "Cannot create $log_file: $!\n";
        print OUTFILE "$content";
        close(OUTFILE);
    }
}




##################################################################################################
#								FUNCTIONS RELATED TO EXCEL SHEET								 #
##################################################################################################

#open the excel sheet specified
sub open_excel {
		eval{
				$ex = Win32::OLE->GetActiveObject('Excel.Application')
			};
        die "Excel not installed" if $@;
        unless (defined $ex) {
        $ex = Win32::OLE->new('Excel.Application', sub {$_[0]->Quit;}) or die "Oops, cannot start Excel";
        }

	$ex->{'Visible'} = 1;
	$ex->{DisplayAlerts}=0;

	return $ex->Workbooks->Open(@_[0]);
}


# Write the given values to the range specified of the given sheet
sub write_excel {
	#Takes the arguments to the subroutine in to local variables
	my($Sheet,$startRow,$startCol,$Value) = @_;

	$Sheet->Cells($startRow,$startCol)->{'Value'} = $Value;
}


#usage: format_excel($sheet1,1,1,1,6,"FontStyle","Bold");
sub format_excel {
		my ($Sheet,$startrow,$startcol,$noRows,$noCols,$fontstyle,$fontval) = @_;
		for($i=1;$i<=$noRows;$i++) {
		for($j=1;$j<=$noCols;$j++) {
			$Sheet->Cells($i,$j)->Font->{$fontstyle} = $fontval;
		}
	}
}
######################################################################################################
#						FUNCTIONS USED IN CONFIGURING THE ORBITAL AND WANSIM						 #
######################################################################################################


#Read the attributes from the XML file of WANSIM tag
sub get_wansim_params {
    my $wansim = shift;
    my $ip = $wansim->{'ip_address'};
    my $bw = $wansim->{'settings'}->{'bandwidth'};
    my $dly = $wansim->{'settings'}->{'delay'};
    my $plr = $wansim->{'settings'}->{'plr'};
   
  @vals =($ip,$bw,$dly,$plr);
 return @vals;
}

#get the testcase parameters
sub get_test_params($testcaseRef) {
	my $testcase = shift;
	my $ip = $testcase->{'ip_address'};
	my $rel = $testcase->{'release'};
	my $hdr = $testcase->{'header'};
	@vals = ($ip,$rel,$hdr);
	return @vals;
}

sub configure_devices {
    my $DEVICES = shift;
  
    # Get our device information
    my $orbitals = $DEVICES->{'orbitals'}->{'machine'};
    my $wansim   = $DEVICES->{'wansim'};
   # print Dumper($orbitals);
    # Configure our WAN-simulator
    #configure_wansim($wansim);

    # Configure our Orbital devices
    foreach my $device (keys %$orbitals) {
        my $ip = $orbitals->{$device}->{'ip_address'};
 	# Configure our orbital devices
	    my $settings = $orbitals->{$device}->{'settings'};
        foreach my $param (keys %$settings) {
         #  configure_orbital($ip,$param,$settings->{$param});
        }
	}
}

sub configure_wansim {
    my $wansim = shift;
    
  #  my $ip = $wansim->{'ip_address'};
   # my $bw = $wansim->{'settings'}->{'bandwidth'};
#   my $dly = $wansim->{'settings'}->{'delay'};
 #  my $plr = $wansim->{'settings'}->{'plr'};
    my ($ip,$bw,$dly,$plr) = get_wansim_params($wansim);

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


###############################################################
# RETURN TRUE AT END;
1;