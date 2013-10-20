#!/usr/bin/perl -w

use strict;

use FindBin;
use lib "$FindBin::Bin";
use Data::Dumper;
use orbital_constants;
use celestix_lcd;
use celestix_buttons;
use celestix_menu;
use orbital_rpc;

#
# Initialization code
#
my $Buttons = Orbital::CelestixButtons->new(2);
$Buttons->clearkeys();

my $Lcd = Orbital::CelestixLcd->new(2);
#$Lcd->cls();

my $Rpc = Orbital::Rpc->new(RPC_URL);


my	$MaxAllowedThroughput = 0;
my	$IPAddress = "0.0.0.0";
my $IPMask = "0.0.0.0";
my $Dns    = "0.0.0.0";
my $Gateway = "0.0.0.0";
my $Dhcp = 0;
my $Hostname = "noname";

my $RefreshScreen = TRUE;
my $IsPassthrough = 0;
my $GoodPutSlider = 0;
my $LineUsageSlider = 0;
my $CurLineUsageRate = -1;
my $CurGoodPutRate = -1;

my $Running = TRUE;

my $KeyPressed;
my $NumAlerts;
my @Alerts;
my $InAlertState = 0;

my $TimeUntilBacklightGoesOff = BACKLIGHT_OFF_TIME;

$Lcd->display_image(1, 1, FRONT_PAGE_NORMAL_IMAGE);
$Lcd->turn_on_backlight();

$SIG{TERM} = \&ShutdownEvent;

#
# Main listen/worker loop
#
print "Celestix LCD started.\n";
while ($Running)
{	   
   #
   # Get the speed we are sending data at right now
   #
   ($CurLineUsageRate, $CurGoodPutRate) = $Rpc->get_current_transfer_rate();
         
   #
   # Turn off the backlight after a few minutes
   #
   if ($TimeUntilBacklightGoesOff > 0)
   {
      $TimeUntilBacklightGoesOff = $TimeUntilBacklightGoesOff - 1;
      
   	if (DEBUG) {print "TimeUntilBacklightGoesOff $TimeUntilBacklightGoesOff\n";}
      
      if (!$TimeUntilBacklightGoesOff)
      {
         $Lcd->turn_off_backlight();
      }
   }

   #
   # If there was an Alert, display it
   #
   ($NumAlerts, @Alerts) = $Rpc->get_alerts();
   if ( $NumAlerts != 0)
   {
      print("Displaying Alert!\n");
      $Lcd->erase_text(3, 4);
      $Lcd->text_centered(4, $Alerts[0] );
      if ($InAlertState==0) { $InAlertState = 1; $RefreshScreen = 1; }
   }
   elsif ($NumAlerts > 0) # Only non-fatal alerts exist
   {
      if ($InAlertState==0) { $InAlertState = 1; $RefreshScreen = 1; }
   }
   else  # Just display the page to get alert info
   {      
      if ($InAlertState) { $RefreshScreen = 1; $InAlertState = 0; }
   }

	
	#
	# If something has changed, refresh the screen
	#
	if ($RefreshScreen)
	{
		$MaxAllowedThroughput = $Rpc->get_throughput();
      $IsPassthrough = $Rpc->get_parameter("PassThrough");
      print("PassThrough: $IsPassthrough\n"); 
      
		# Display the main screen and wait for the menu button to be pushed
		#
		$Lcd->cls();		
      $Lcd->text(5, 2, "Orbital LC");
      
      if (!$InAlertState) { $Lcd->display_image(1, 1, FRONT_PAGE_NORMAL_IMAGE); }
      else                { $Lcd->display_image(1, 1, FRONT_PAGE_ERROR_IMAGE); }
		
      if (!$IsPassthrough)
      {
		   my $StrRate = sprintf("Max %3.2f Mbs", ($MaxAllowedThroughput / (1000*1000)) ); 
		   $Lcd->text(Orbital::CelestixLcd::Xcenter($StrRate), 4, $StrRate);
      }
      else
      {
         my $StrRate = "<DISABLED>";
		   $Lcd->text(Orbital::CelestixLcd::Xcenter($StrRate), 4, $StrRate);         
      }
	}

   #
   # Update the progress/speed bar, if our rate has changed
   #
   my $NewLineUsageSlider = int( ( ($CurLineUsageRate / $MaxAllowedThroughput) * 100) );
   
   my $NewGoodPutSlider = int( ( ($CurGoodPutRate / $MaxAllowedThroughput) * 100) );
   
   if ( ($RefreshScreen) || ($NewGoodPutSlider != $GoodPutSlider) || ($NewLineUsageSlider != $LineUsageSlider) )
   {
      if (DEBUG) {print "Current Trans Rate: $CurGoodPutRate\n";}
      $Lcd->draw_progress_box( $NewGoodPutSlider, $NewLineUsageSlider );       
      $LineUsageSlider= $NewLineUsageSlider;     
      $GoodPutSlider  = $NewGoodPutSlider;
   }
	
   #
   # If the user pushed the menu button, go into it...
   #
	if ($Buttons->wait_for_key(5000))
	{
      $Lcd->turn_on_backlight();
      
      if ( ($KeyPressed = $Buttons->getkey()) eq UP_LEFT_BUTTON)
      {
         #
         # Show the menu and wait for a selection
         #
         $Lcd->cls();
         my $Menu = Orbital::CelestixMenu->new($Lcd, $Buttons, 
               ("Settings", "Status", "Debugging") );
   
         my $MenuVal = $Menu->wait_for_select();
   
         #
         # Configure settings choosen...
         #
         if ($MenuVal == 1)  
         {
            &ShowSettings();
         }
         
         #
         # Show system status choosen...
         #
         elsif ($MenuVal == 2)
         {
            &ShowStatus();
         }                  
         #
         # Show system status choosen...
         #
         elsif ($MenuVal == 3)
         {
            &ShowDebugging();
         }
         
         #
         # Cleanup....
         #
         $RefreshScreen = 1;		
      }
      elsif ( ($InAlertState) && ($KeyPressed eq UP_RIGHT_BUTTON) ) # Display errors
      {
         &DisplayAlerts();
		   $RefreshScreen = 1;
      }
      else  # Something other then the menu key was pressed
      {
         CheckForSecretKey();
      }     

      $TimeUntilBacklightGoesOff = BACKLIGHT_OFF_TIME;
	}
	else
	{
		$RefreshScreen = 0;
	}
	
}#While(1)


#
# Present the user with an IP selector "dialog"
#
sub SelectIp()
{
	my ($Label, $Lcd, $Buttons, $DefaultIp) = @_;

	my $CurDigit = 1;
	my $CurValue = 0;

	$Lcd->cls();
	$Lcd->draw_menu("+", "OK", "<", ">");
	$Lcd->text(3, 2, $Label);

	while (1)
	{
		$Lcd->text_hilight(3, 4, $CurDigit, $DefaultIp);
		$CurValue = substr($DefaultIp, $CurDigit - 1, 1);

		my $Key = $Buttons->block_for_key();
		if ( ($Key eq BOTTOM_RIGHT_BUTTON) && ($CurDigit < 15) )   # right pushed
		{
			$CurDigit++;
			if ( ($CurDigit % 4) eq 0) {$CurDigit++;}
		}
		elsif ( ($Key eq BOTTOM_LEFT_BUTTON) && ($CurDigit > 1) ) # left pushed
		{
			$CurDigit--;
			if ( ($CurDigit % 4) eq 0) {$CurDigit--;}
		}
		elsif ( $Key eq UP_LEFT_BUTTON) # + pushed
		{	
			$CurValue ++;
			if ($CurValue eq 10) {$CurValue = 0;}
			substr($DefaultIp, $CurDigit - 1 , 1, $CurValue);
		}
		elsif ( $Key eq UP_RIGHT_BUTTON)  # Ok pushed
		{
			return $DefaultIp;
		}
		
		$Lcd->erase_text(3, 4);
		
		print "Pos: $CurDigit  CurDig: $CurValue\n";

	}#while(1)

}#SelectIp()


#
# Present the user with a netmask selector "dialog"
#
sub SelectMask()
{
	my ($Lcd, $Buttons, $Label, $Mask) = @_;

	my $Bits = &Mask2Bits($Mask);

	$Lcd->cls();
	$Lcd->draw_menu("+", "OK", "-", ">");
	$Lcd->text(3, 2, $Label);

 	$Lcd->text(3, 4, Bits2Mask($Bits) );
	while (1)
	{
		$KeyPressed = $Buttons->block_for_key();
		if ( $KeyPressed eq UP_LEFT_BUTTON ) # + pushed
		{
			$Bits ++;
			if ( $Bits > 32) {$Bits=1;}
		}
		elsif ( $KeyPressed eq BOTTOM_LEFT_BUTTON) # - pushed
		{	
			$Bits--;
			if ( $Bits < 1) {$Bits=32;}
		}
		elsif ( $KeyPressed eq UP_RIGHT_BUTTON)  # Ok pushed
		{
			return &Bits2Mask($Bits);
		}
		
		$Lcd->erase_text(3, 4);
   	$Lcd->text(3, 4, Bits2Mask($Bits) );
		
		print "Bits: $Bits Mask: " . Bits2Mask($Bits) . "\n";

	}#while(1)

}#SelectMask()


#
# Display the settings page
#
sub ShowSettings()
{
   #
   # Show the menu and wait for a selection
   #
   $Lcd->cls();
   my $Menu = Orbital::CelestixMenu->new($Lcd, $Buttons, 
         ("IP/Mask/Gateway", "Firewall", "Bandwidth", "Date/Time") );

   my $MenuVal = $Menu->wait_for_select();

   if       ($MenuVal == 1) { &SetNetwork(); }
   elsif  ($MenuVal == 2)   { &SetWindowSize(); }
   elsif  ($MenuVal == 3)   { &SelectBW(); }
   elsif  ($MenuVal == 4)   { &SetDateTime(); }
   
}#ShowSettings()

#
# Allow the user to select the max bandwidth
#
sub SelectBW()
{
	my $CurDigit = 1;
	my $CurValue = 0;
	my $Units = "Mbits/s";
   my $DefaultBW = $MaxAllowedThroughput;
	
   # Round Current BW to less than 10Mbs
   $DefaultBW = $DefaultBW % (10 * 1000 * 1000);
   
	my $DefaultBWStr = sprintf("%04.2f", ($DefaultBW / (1000*1000) ) );
	
	print "DefaultBWStr: " . $DefaultBWStr . "\n";
	$Lcd->cls();
	$Lcd->draw_menu("+", "OK", "<", ">");
	$Lcd->text(3, 2, "Set BW:");
	
   my $Done = 0;
	while (!$Done)
	{
		$Lcd->text_hilight(3, 4, $CurDigit, $DefaultBWStr);
		$Lcd->text(9, 4, $Units);

		$CurValue = substr($DefaultBWStr, $CurDigit - 1, 1);

		my $Key = $Buttons->block_for_key();
		if ( ($Key eq BOTTOM_RIGHT_BUTTON) && ($CurDigit < 4) )   # right pushed
		{
			$CurDigit++;
			if ($CurDigit == 2) {$CurDigit++;}
		}
		elsif ( ($Key eq BOTTOM_LEFT_BUTTON) && ($CurDigit > 1) ) # left pushed
		{
			$CurDigit--;
			if ($CurDigit == 2) {$CurDigit--;}
		}
		elsif ( $Key eq UP_LEFT_BUTTON) # + pushed
		{	
			$CurValue ++;
			if ($CurValue eq 10) {$CurValue = 0;}
			substr($DefaultBWStr, $CurDigit - 1 , 1, $CurValue);
		}
		elsif ( $Key eq UP_RIGHT_BUTTON)  # Ok pushed
		{
			$Done = 1;
		}

		$Lcd->erase_text(3, 4);
		
		print "Pos: $CurDigit  CurDig: $CurValue\n";

	}#while(!$Done)

   $Lcd->show_waiting_dialog("Setting BW...");         
   $Rpc->set_parameter("SlowSendRate", $DefaultBWStr * 1000 * 1000);
   print "BW Set: " . $DefaultBWStr . "\n";
   sleep(2);   
   
}#SelectBW()

#
# Configure network settings
#
sub SetNetwork()
{
   $Lcd->show_waiting_dialog("Loading...");     
   
   ($IPAddress, $IPMask, $Dns, $Gateway, $Dhcp, $Hostname) = $Rpc->get_system_net_info();
   
   
   $IPAddress = ExpandAddress($IPAddress);
   $IPMask    = ExpandAddress($IPMask);
   $Gateway = ExpandAddress($Gateway);
   $Dns    = ExpandAddress($Dns);
   
   print "IP: $IPAddress\n";
   print "Netmask: $IPMask\n";
   print "Gateway: $Gateway\n";
   print "DNS: $Dns\n";
   
   my $NewIp = &SelectIp("Select IP:", $Lcd, $Buttons, $IPAddress);            
   my $NewMask = &SelectMask($Lcd, $Buttons, "Select Mask:", $IPMask);   
   my $NewGateway = &SelectIp("Select Gateway:", $Lcd, $Buttons, $Gateway);            
   my $NewDns = &SelectIp("Select Dns:", $Lcd, $Buttons, $Dns);
               
   $Lcd->cls();
   $Lcd->draw_menu("Set...", " ", "YES", "NO");     
   $Lcd->text(1, 2, "IP: " . CompactAddress($NewIp) );         
   $Lcd->text(1, 3, "Mask: " . CompactAddress($NewMask) );
   $Lcd->text(1, 4, "Gateway: " . CompactAddress($NewGateway) );         
   $Lcd->text(1, 5, "Dns: " . CompactAddress($NewDns) );            
   
   if ( ($Buttons->wait_for_key(50000)) && ($Buttons->getkey() eq BOTTOM_LEFT_BUTTON) )
   {	            
      print "Setting the network params...\n";
      $Rpc->set_system_net_info($NewIp, $NewMask, $NewDns, $NewGateway, $Dhcp, $Hostname);
      
      
      $Lcd->show_waiting_dialog("Restarting...");    
      `$FindBin::Bin/../scripts/reboot`;        
      exit;            
   }            
}#SetNetwork

#
# Set Date/Time on the box
#
sub SetDateTime()
{
   `$FindBin::Bin/setdate.pl`;  
}

#
# Allow the user to see all the current system values
#
sub ShowStatus()
{
   #
   # Show the menu and wait for a selection
   #
   $Lcd->cls();
   my $Menu = Orbital::CelestixMenu->new($Lcd, $Buttons, 
         ("Enable/Disable", "Enable WebUI", "Show Version", "Duplex") );

   my $MenuVal = $Menu->wait_for_select();

   if     ($MenuVal == 1)   { &EnableDisableOrbital(); }
   elsif  ($MenuVal == 2)   { &EnableWebUI(); }
   elsif  ($MenuVal == 3)   { &ShowVersionInfo(); }
   elsif  ($MenuVal == 4)   { &ConfigureDuplex(); }
   
}#ShowStatus()

#
# Display the menu of debugging options
#
sub ShowDebugging()
{
   #
   # Show the menu and wait for a selection
   #
   $Lcd->cls();
   my $Menu = Orbital::CelestixMenu->new($Lcd, $Buttons, 
         ("Start/Stop Tracing", "Enable Remote Dbg", "Reset To Factory") );

   my $MenuVal = $Menu->wait_for_select();

   if     ($MenuVal == 1)   { &EnableDisableTracing(); }
   elsif  ($MenuVal == 2)   { &EnableRemoteAdmin(TRUE); }
   elsif  ($MenuVal == 3)   { &RestoreToFactoryDefaults(); }
}#ShowDebugging()


#
# Show the IP and Mask for the first active adapter found
#
sub ShowIPSettings()
{
   ($IPAddress, $IPMask, $Dns, $Gateway, $Dhcp, $Hostname) = $Rpc->get_system_net_info();
   
   $Lcd->cls();
   $Lcd->draw_menu("Set...", " ", " ", " ");     
   $Lcd->text(1, 2, "IP: " . $IPAddress);         
   $Lcd->text(1, 3, "Mask: " . $IPMask);
   $Lcd->text(1, 4, "Dns: " . $Dns);         
   $Lcd->text(1, 5, "Gate: " . $Gateway);
   
   # Wait for OK button push...
   while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne UP_LEFT_BUTTON) ) {};               
}



#
# Let the user scroll through the system alerts
#
sub DisplayAlerts()
{   
   $Lcd->cls();
      
   if (scalar(@Alerts) == 0) # If no alerts exist, display a message saying so
   {
      $Lcd->cls();
      $Lcd->draw_menu(" ", " ", " ", "OK");
      $Lcd->text(5, 3, "No Alerts!");      
      
      while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) ) {};                     
   }
   else # If we have alerts, display 'em
   {
      my $i;   
      for ($i=0; $i < scalar(@Alerts); $i++ )
      {
         $Lcd->cls();
         $Lcd->draw_menu(" ", " ", " ", "Next");

         $Lcd->text(1, 2, "Alert " . ($i + 1) . ":");            
         $Lcd->text_centered(4, $Alerts[$i]);
   
         while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) ) {};               
         
      }
      $Lcd->cls();
   }   
}

#
# Display current system proxies
#
sub ShowProxies()
{   
   $Lcd->cls();
   $Lcd->text(1, 3, "Loading Proxies...");
   
   my $Proxies = $Rpc->get_system_var_struct("TCP.UpstreamProxyTuples");
   
   if (scalar(@$Proxies) == 0) # If no proxies configured display a message saying so
   {
      $Lcd->cls();
      $Lcd->draw_menu(" ", " ", " ", "OK");

      $Lcd->text(5, 3, "No Proxies!");      
      
      while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) ) {};                     
   }
   else # If we have proxies, display 'em
   {
      my $i;   
      for ($i=0; $i < scalar(@$Proxies); $i++ )
      {
         $Lcd->cls();
         $Lcd->draw_menu("Done", " ", " ", "Next");
         
         my $VIP = ${$Proxies}[$i]{"Client"}{"Begin"}{"Dotted"};
         my $Downstream = ${$Proxies}[$i]{"Downstream"}{"Dotted"};
         my $Server = ${$Proxies}[$i]{"Server"}{"Begin"}{"Dotted"};
         print "$VIP  $Downstream  $Server \n";
         
         $Lcd->text(1, 3, "V: " . $VIP);
         $Lcd->text(1, 4, "D: " . $Downstream);
         $Lcd->text(1, 5, "S: " . $Server);
   
         while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) ) {};               
         
      }
   }   
}

sub ShowVersionInfo()
{
   $Lcd->cls();
   $Lcd->text(1, 3, "Querying Vesion...");

   my $Version = $Rpc->get_system_variable("VersionCompact");
   print "Orbital Version: $Version\n";

   $Lcd->draw_menu(" ", " ", " ", "OK");
   $Lcd->text(1, 3, "Version:");         
   $Lcd->text(1, 4, $Version);   

   while ( (! $Buttons->haskey()) && ( $Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) ) {};               
}

#
# Configure duplex on the network adapters
#
sub ConfigureDuplex()
{
   my @AdapterInfo = $Rpc->get_adapter_info();
      
   $Lcd->cls();
   $Lcd->draw_menu("Change", " ", " ", "OK");
   
   print "Dumping: " . Dumper( @AdapterInfo );   
   print "Value: " . $AdapterInfo[0][1]{'LinkSpeedDuplex'} . "\n";
#   exit;
   
   my $i;
   my $DisplayedLine;
   for ($i=0; $i < 2; $i++ ) # Only display eth0 and eth1
   {      
      $DisplayedLine  = $AdapterInfo[0][$i]{'DisplayName'} . " - ";
      $DisplayedLine .= ($AdapterInfo[0][$i]{'WireSpeed'}) / (1000*1000) . "M "; 
      $DisplayedLine .= ($AdapterInfo[0][$i]{'Duplex'});
      
      $Lcd->text(1, 3+$i, $DisplayedLine);         
   }
      
   my @DUPLEX_SETTINGS = ("Auto", "Full 1000mbs", "Full 100mbs", "Half 100mbs", "Full 10mbs", "Half 10mbs");
   my $Key = $Buttons->getkey();
   if ($Key eq UP_LEFT_BUTTON) # Configure the duplex 
   {
      my @NewDuplex;
      
      for ($i=0; $i < 2; $i++ ) # Only display eth0 and eth1
      {
         $Lcd->draw_menu("Set", "Cancel", "<", ">");            
         
         my $CurVal = $AdapterInfo[0][$i]{'LinkSpeedDuplex'};
         my $Done = FALSE;
         
         while (!$Done)
         {
      		$Lcd->erase_text(1, 3);		                  
            $Lcd->text(3, 3, $AdapterInfo[0][$i]{'DisplayName'} . ":" );         
            $Lcd->text(9, 3, $DUPLEX_SETTINGS[$CurVal]);         
            
            my $Key = $Buttons->getkey();      
            if ( ($Key eq BOTTOM_LEFT_BUTTON) && ($CurVal > 0) )
            {
               $CurVal --;
               if ($CurVal == 1) {$CurVal--;} # Skip over 1000M/Full
            }
            elsif ( ($Key eq BOTTOM_RIGHT_BUTTON) && ($CurVal < 5) )
            {
               $CurVal ++;
               if ($CurVal == 1) {$CurVal++;} # Skip over 1000M/Full
            }
            elsif ($Key eq UP_RIGHT_BUTTON)
            {
               return;
            }
            elsif ($Key eq UP_LEFT_BUTTON)
            {
               $Done = TRUE;
            }            
         }
         
         $NewDuplex[$i] = $CurVal;
         
         if ($CurVal != $AdapterInfo[0][$i]{'LinkSpeedDuplex'}) # The value has changed, save it
         {
            $Lcd->show_waiting_dialog("Configuring Adapter");     
            $Rpc->set_adapter_info($i, $CurVal);
         }

      }
      &ConfigureDuplex();
   }
   
}#ConfigureDuplex()


#
# Allow the user to enable or disable Orbital
#
sub EnableDisableOrbital()
{
   my $PassThrough = $Rpc->get_parameter("PassThrough");
   
   $Lcd->cls();
   
   $Lcd->draw_menu("YES", " ", " ", "CANCEL");
   
   if ($PassThrough)
   {
      $Lcd->text(1, 3, "Enable Orbital?");         
      $PassThrough = 0;
   }
   else
   {
      $Lcd->text(1, 3, "Disable Orbital?");         
      $PassThrough = 1;
   }
   
   # Wait for OK button push...
   while (! $Buttons->wait_for_key(250)) {};
      
   my $Key = $Buttons->getkey();

   if ($Key eq UP_LEFT_BUTTON) 
   {
      $Lcd->show_waiting_dialog("Enabling/Disabling..");         
      print "Setting passthrough to: " . $PassThrough;
      $Rpc->set_parameter("PassThrough", $PassThrough); 
   }
}

#
# Allow the user to enable or disable Orbital Tracing
#
sub EnableDisableTracing()
{
   my $Trace = $Rpc->get_parameter("Trace");
   
   $Lcd->cls();
   
   $Lcd->draw_menu("YES", " ", " ", "CANCEL");
   
   if ($Trace)
   {
      $Lcd->text(1, 3, "Disable Tracing?");         
      $Trace = FALSE;
   }
   else
   {
      $Lcd->text(1, 3, "Enable Tracing?");         
      $Trace = TRUE;
   }
   
   # Wait for OK button push...
   while (! $Buttons->wait_for_key(250)) {};
      
   my $Key = $Buttons->getkey();

   if ($Key eq UP_LEFT_BUTTON) 
   {
      $Lcd->show_waiting_dialog("Enabling/Disabling..");         
      print "Setting passthrough to: " . $Trace;
      $Rpc->set_parameter("Trace", $Trace); 
   }
}


#
# Restore machine back to factory defaults
#
sub RestoreToFactoryDefaults()
{   
   $Lcd->cls();  
   $Lcd->draw_menu("YES", " ", " ", "CANCEL");
   
   $Lcd->text_centered(3, "Reset To");         
   $Lcd->text_centered(4, "Factory Defaults?");         
   
   # Wait for OK button push...
   while (! $Buttons->wait_for_key(250)) {};
      
   my $Key = $Buttons->getkey();

   if ($Key eq UP_LEFT_BUTTON) 
   {
      $Rpc->send_command("ResetToFactoryDefault"); 
   }
}


#
# Presents the user with a digit selection dialog
#
sub GetNumber()
{
	my ( $Label1, $Label2, $CurrentValue, $Min, $Max) = @_;
   
	$Lcd->cls();
	$Lcd->draw_menu("+", "OK", "-", " ");
	$Lcd->text(3, 2, $Label1);
		
   my $Done = 0;
	while (!$Done)
	{
		$Lcd->text_hilight(10, 4, 1, $CurrentValue);
		$Lcd->text(3, 4, $Label2);

		my $Key = $Buttons->block_for_key();
		if ($Key eq UP_LEFT_BUTTON)   # + pushed
		{
			$CurrentValue++;
			if ($CurrentValue == ($Max+1) ) {$CurrentValue = $Min;}
		}
		elsif ($Key eq BOTTOM_LEFT_BUTTON)   # + pushed
		{
			$CurrentValue--;
			if ($CurrentValue == ($Min-1) ) {$CurrentValue = $Max;}
		}
		elsif ( $Key eq UP_RIGHT_BUTTON)  # Ok pushed
		{
         return $CurrentValue;
		}
		
		$Lcd->erase_text(10, 4);		
	}   
} #GetNumber()

#
# Set the window size on the box
#
sub SetWindowSize()
{
   my $CurrentWindow = $Rpc->get_parameter("Tcp.SlowWindowSize");

	$CurrentWindow = int($CurrentWindow / 1048576);
   $CurrentWindow = (&GetNumber("Firewall Scaling", "Limit:",  $CurrentWindow , 1, 9))*1048576;
   
   print "Setting Tcp.SlowWindowSize to $CurrentWindow...\n";
   $Rpc->set_parameter("Tcp.SlowWindowSize", $CurrentWindow);   
}

#
# This is used for tracking keysequences, to enable secret options
#
# If any_button - up-right-button - low-left-button - up-right-button: enable httpd server
#
sub CheckForSecretKey
{   
	if (!$Buttons->wait_for_key(1000)) { return; }      
   if ($Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) { return; }

	if (!$Buttons->wait_for_key(1000)) { return; }      
   if ($Buttons->getkey() ne BOTTOM_LEFT_BUTTON) { return; }

	if (!$Buttons->wait_for_key(1000)) { return; }      
   if ($Buttons->getkey() ne BOTTOM_RIGHT_BUTTON) { return; }
 
   print "Enabling httpd\n";
   EnableWebUI();
}

#
# Kick on the Remote Orbital Administration daemon (also called the Debug Extender)
#
sub EnableRemoteAdmin
{
   my ( $PromptForIP ) = @_;
   
   my $refRemoteManIP =   $Rpc->get_parameter("UI.DebugDaemonIP");
   my $RemoteManPort = 1;
   
   my $RemoteManIP = $refRemoteManIP->{"Dotted"};
   
   # Make sure the debug extender isn't running (if it is, kill it)
   system ("$FindBin::Bin/../scripts/extender.run --stop");

   my $AutoStart = 0;
   if ($PromptForIP)
   {
      $RemoteManIP = ExpandAddress($RemoteManIP);
      $RemoteManIP = &SelectIp("Orbital HQ IP:", $Lcd, $Buttons, $RemoteManIP);

      $Rpc->set_parameter("UI.DebugDaemonIP", {Dotted=>$RemoteManIP} );
      print( "Selected IP: " . $RemoteManIP . "\n" );

      #
      # Now set the daemon to autostart on reboot, if needed
      #
      $Lcd->cls();
      $Lcd->draw_menu(" ", "CANCEL", "YES", "NO");     
      $Lcd->text_centered(2, "Would you like the" );
      $Lcd->text_centered(3, "Debug Daemon to" );
      $Lcd->text_centered(4, "start automatically");
      $Lcd->text_centered(5, "after reboots?" );
      
      if ( !$Buttons->wait_for_key(50000) ) { return; }
      
      $KeyPressed = $Buttons->getkey();
      if ($KeyPressed eq BOTTOM_LEFT_BUTTON)
      {   
         $Rpc->set_parameter("UI.DebugDaemonAutostart", TRUE);     
         $AutoStart = 1;
      }   
      elsif ($KeyPressed eq BOTTOM_RIGHT_BUTTON)
      {   
         $Rpc->set_parameter("UI.DebugDaemonAutostart", FALSE);     
      }   
      else  # Cancel debug daemon startup.. 
      { 
         $Rpc->set_parameter("UI.DebugDaemonAutostart", FALSE);           
         return; 
      }
   }


   if ($AutoStart) {
     system("$FindBin::Bin/../scripts/extender.run --start --ip=$RemoteManIP --autostart");
   } else {
     system("$FindBin::Bin/../scripts/extender.run --start --ip=$RemoteManIP");
   }
}


sub EnableWebUI
{
   $Lcd->show_waiting_dialog("Enabling Web UI");     
   `/etc/init.d/httpd start`;
   `/sbin/chkconfig httpd on`;
   $RefreshScreen = 1;
}

sub ShutdownEvent
{
   print "SHUTTING DOWN!\n";
   $Lcd->show_waiting_dialog("Restarting...");     
   $Running = 0;
}

##########################################################################
#                       HELPER FUNCTIONS
##########################################################################

#
# Takes and address like: 255.101.1.20 and returns 255.101.001.020 
#
sub ExpandAddress
{
   my( $addr ) = @_;
      
   if( $addr =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)$/ ) {
      $addr = sprintf "%03d.%03d.%03d.%03d", $1 ,$2, $3, $4;
   } else {
      $addr = "000.000.000.000";
   }
   return $addr;
}


#
# Takes and address like: 255.101.001.020 and returns 255.101.1.20
# (The reverse of ExpandAddress()
#
sub CompactAddress
{
  my ( $addr ) = @_;

  if( $addr =~ /^([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)$/ ) {
    my $addr1 = sprintf "%d", $1;
    my $addr2 = sprintf "%d", $2;
    my $addr3 = sprintf "%d", $3;
    my $addr4 = sprintf "%d", $4;
    $addr = "$addr1.$addr2.$addr3.$addr4";
  }
  return $addr;
}

#
# bits2mask: Example: converts 24 => 255.255.255.0
#
sub Bits2Mask
{
	my ($Bits )= @_;
	my $Root = 4294967296 - ( 2 ** (32-$Bits) );
	return &int2quad($Root);
}

#
# mask2bits: Example: converts 255.255.255.0 => 24
#
sub Mask2Bits
{
	my ($Mask) = @_;
	my $Quad = &quad2int($Mask);
	my $Bits = 0;

	while ($Quad > 0)
	{
	   $Quad = $Quad << 1;
      $Bits ++;
	}		
	
	return $Bits;
}

#
# Function take from Net::NetMask
# This code is © 2003, Luis E. Muñoz. It is provided with no warranty and
# can be distributed under the same terms as Perl itself.
#
sub quad2int
{
	my @bytes = split(/\./,$_[0]);
	return undef unless @bytes == 4 && ! grep {!(/\d+$/
&& $_<256)} @bytes;
	return unpack("N",pack("C4",@bytes));
}

#
# Function take from Net::NetMask
# This code is © 2003, Luis E. Muñoz. It is provided with no warranty and
# can be distributed under the same terms as Perl itself.
#
sub int2quad
{
	return join('.',unpack('C4', pack("N", $_[0])));
}

#
#
#
sub ShowUsageGraph
{
    #~ $panel->send("focusGFXsurface", 2);
    #~ $panel->box( 68, 35, 87, 50 );
    #~ $panel->clear( 69, 36, 87, 50 );
    #~ for( $i=0; $i<=20; $i++ ) {
      #~ my $x = 86 - $i;
      #~ my $y = 50 - rand(50);
      #~ $panel->line( $x, 50, $x, $y);
    #~ }
    #~ $Lcd->snd1("blitGFXsurface", 68, 35, 68, 35, 19, 15);
    #~ $Lcd->snd1("focusGFXsurface", 0);
                                                                                                   
    #~ if( $dio ) {
      #~ open FD, "df /var |";
      #~ while( <FD> ) {
        #~ if( /([0-9]+)\%/ ) {
          #~ $bar = $1 / 20;
          #~ last;
        #~ }
      #~ }
      #~ close FD;
                                                                                                   
      #~ $panel->box( 98, 35, 117, 51 );
      #~ if ( ref($panel) =~ /Drawd$/ ) {
        #~ $panel->clear( 99, 36, 116, 50 );
      #~ }
      #~ for( $i=0; $i<$bar; $i++ ) {
        #~ my $y1 = 50 - $i * 3;
        #~ my $y2 = $y1 - 2;
        #~ $panel->box( 98, $y1, 117, $y2 );
      #~ }
                                                                                                   
    #~ }
    
    #~ if( $dio ) {
     #~ $self->got_it;
    #~ }
   
}
