#!/usr/bin/perl -w

package Virex_LVT;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw ();

# Gets the dat no

sub GetDatNo {
# this sub-routine is not being used in 8.6. DAT no is being taken from the config file
#        my $datnoline = `/usr/local/vscanx/uvscan --version | grep 'Virus data file'`; # harish
#        chomp $datnoline; harish
#        if ($datnoline =~ /Virus data file v(\d\d\d\d) created(.*)/){ #
         #   return  $1;
        my $hardcodedatno = '5111';
         return $hardcodedatno;
        #}
}

# Expects the dat and gives back the logid

sub GetLogID {
		local (*FH) = shift;
        my($datno,$LVT_ROOT) = @_;
        chomp $datno;
		chomp $LVT_ROOT;
        if ($datno =~ /\d\d\d\d/){
        	my $logidline = `grep -ae $datno\~\^\~ $LVT_ROOT/Includes/logid.txt`;
        	#print("$logidline");
            chomp $logidline;
        	if ($logidline =~ /(^.*)\~\^\~(.*$)/){
                #print("coming here $2\n");
        		return  $2;
        	}
        }
	elsif($datno =~ /\d\d/){
			$eit12_logid = 'e5a0dc5018';		
        		return  $eit12_logid;
        }
	else{
			mumble(*FH, "Error", "Error:  Error in getting the DAT no - can't proceed\n");
        }
}

# Sets the mcscan.vlt to enable the engine logging 
# Paramaters:
#			ScanType:	OAS/ODS/uvscan
#			LVT_ROOT:	Directory Path where all the LVT scripts are extracted

sub SetEngineLogging {
	local (*FH) = shift;
	my ($scanMode,$LVT_ROOT,$engineLogPath, $datNo) = @_;
	chomp $scanMode;
	chomp $LVT_ROOT;
	chomp $engineLogPath;
	chomp $datNo;

	# Get the dat Number from the install product
	#my $datNo = GetDatNo();	
	#chomp $datNo;

	# Get the engine LogID for the install dat
	my $logID = GetLogID(*FH,$datNo,$LVT_ROOT);	
	chomp $logID;
	
	system("chmod 777 $engineLogPath") == 0
		or mumble(*FH, "Error", "Error: Failed to change the permissions of $engineLogPath directory\n");
	
	system("chown root:Virex $engineLogPath") == 0
		or mumble(*FH, "Error", "Error: Failed to change the permissions of $engineLogPath directory\n");
	
	system("umask 000 $engineLogPath") == 0
		or mumble(*FH, "Error", "Error: Failed to change the permissions of $engineLogPath directory\n");
	
	system("echo $engineLogPath/scan.rep > /$LVT_ROOT/mcscan.vlt") == 0 # harish
		or mumble(*FH, "Error", "Error: Failed to create the mcscan.vlt file in $LVT_ROOT\n");

	system("echo logid $logID >> $LVT_ROOT/mcscan.vlt") == 0
		or mumble(*FH, "Error", "Error: Failed to create the mcscan.vlt file in $LVT_ROOT\n");

	#system("echo multilog >> /$LVT_ROOT/mcscan.vlt") == 0
	#	or mumble(*FH, "Error", "Error: Failed to append more parameters to mcscan.vlt file in $LVT_ROOT\n");

	# Check the scan type and set the remaining mcascan.vlt accordingly
	if ($scanMode =~ /OAS/i) {
		system("echo multilog >> $LVT_ROOT/mcscan.vlt");
	}
	system("cp -rpf /$LVT_ROOT/mcscan.vlt /usr/local/McAfee/AntiMalware/dats/$datNo/") == 0
		or mumble(*FH, "Error", "Error: Failed to copy the mcscan.vlt file to DAT directory\n");
	system("chmod 777 /usr/local/McAfee/AntiMalware/dats/$datNo/mcscan.vlt") == 0
		or mumble(*FH, "Error", "Error: Failed to change permissions of mcscan.vlt file \n");
	system("chown root:Virex /usr/local/McAfee/AntiMalware/dats/$datNo/mcscan.vlt") == 0
		or mumble(*FH, "Error", "Error: Failed to change the permissions of $engineLogPath directory\n");

	

	return 0;
	
}

# Name			:- mumble
# Description	:- Logs the information provided with the log level.
#
#
#
#
#

sub mumble {
	local (*FH) = shift;
	my($logLevel,$logLine) = @_;
	chomp ($logLevel,$logLine);
	$vel = `/bin/date`;
	chomp $vel;

	if($logLine =~ /INFO/i)
	{
		print STDOUT "INFO: $logLine\n";
		print FH "[$vel]: INFO: $logLine\n";
	}
	elsif($logLevel =~ /Error/i)
	{
		print FH "[$vel]: ERROR: $logLine\n";
		die "$logLine\n";
	}

}


# Name 			:- StartProductRun
# Description	:- Function to perform the product run
# Arguments		:- 
#				1. $scanType		-	CLEAN/DETECT	
#				2. $LVT_ROOT		-	Path to the LVT scripts directory
#				3. $collectionPath	-	Complete Path to collection 
#				4. $fileList		-	File listing of the collection to scan
#
 
sub StartProductRun {

	local (*FH) = shift;
	my ($scanMode,$scanType,$LVT_ROOT,$collectionPath,$fileList,$currentLogPath,$isMail, $datNo) = @_;
	chomp($scanMode,$scanType,$LVT_ROOT,$collectionPath,$fileList,$currentLogPath,$isMail, $datNo);

	# Stop the services before replacing the config file
	#system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0
	#	or die "Error: Failed to stop the services\n";
	
#Aravind	system("$LVT_ROOT/Includes/PrefChanger -k 1 -v 0") == 0
#		or die "Error: Failed to stop the services\n";	
		
	sleep 60;
		
	# set the scan settings to run with depending on the $scanMode
	if ($scanMode =~ /OAS/i)
	{
		if($scanType =~ /CLEAN/i)
		{
			if (defined($isMail) && $isMail =~ /MAIL/i)
			{
				# Copy the predefined config file	
				#system("cp -f $LVT_ROOT/plist/OAS-MAIL-CLEAN.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
		#				or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
			else
			{
				# Copy the predefined config file	
			#	system("cp -f $LVT_ROOT/plist/OAS-CLEAN.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
			#			or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
		}
		elsif ($scanType =~ /DETECT/i)
		{
			if (defined($isMail) && $isMail =~ /MAIL/i)
			{
				# Copy the predefined config file	
			#	system("cp -f $LVT_ROOT/plist/OAS-MAIL-DETECT.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
		#				or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
			else
			{
				# Copy the predefined config file	
# 				system("cp -f $LVT_ROOT/plist/OAS-DETECT.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
	#					or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
			
		}

		# Start the services to reflect the config settings
#		system("launchctl load /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0 
#Aravind			system("$LVT_ROOT/Includes/PrefChanger -k 1 -v 1") == 0
#				or mumble(*FH, "Error", "Error: Failed to start the services\n"); 
		
		 sleep 180;
		
		# Touch each file from the collection to invoke the OAS
		system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0
		or die "Error: Failed to stop the services\n";
		system("sh $LVT_ROOT/Includes/reloadScanManager.sh") == 0  #Anand
		or die "Error: Failed to unload and reload the VShield Processes\n"; #Anand		
		sleep 180;		
		#system("launchctl load /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0
		#or die "Error: Failed to stop the services\n";
		#sleep 60;
		touchFiles($fileList);
		
		
		#system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0 
		#		or mumble(*FH, "Error", "Error: Failed to start the services\n"); 
		#sleep 50; 
		
	}
	elsif ($scanMode =~ /ODS/i)
	{
	# stop OAS first
#	system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0 
#Aravind			system("$LVT_ROOT/Includes/PrefChanger -k 1 -v 0") == 0
#				or mumble(*FH, "Error", "Error: Failed to stop the services\n"); 
		sleep 180;
		if($scanType =~ /CLEAN/i)
		{
			if (defined($isMail) && $isMail =~ /MAIL/i)
			{
				# Copy the predefined config file	
#				system("cp -f $LVT_ROOT/plist/ODS-MAIL-CLEAN.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
#						or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
			else
			{
				# Copy the predefined config file	
#				system("cp -f $LVT_ROOT/plist/ODS-CLEAN.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
#						or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
		}
		elsif ($scanType =~ /DETECT/i)
		{
			if (defined($isMail) && $isMail =~ /MAIL/i)
			{
				# Copy the predefined config file	
#				system("cp -f $LVT_ROOT/plist/ODS-MAIL-DETECT.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
#						or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
			else
			{
				# Copy the predefined config file	
#				system("cp -f $LVT_ROOT/plist/ODS-DETECT.plist /Library/Preferences/com.mcafee.virex.prefs.plist") == 0 # harish
#						or mumble(*FH, "Error", "Error: Failed to copy the plist file appropriate directory\n"); # harish
			}
		}

		# Start the services to reflect the config settings
#		system("/sbin/SystemStarter start Virex") == 0 # harish
# 				or mumble(*FH, "Error", "Error: Failed to start the services\n"); # harish
#		sleep 30; # harish
		
		#print STDOUT "Starting the ODS LVT $scanType run with $collectionPath\n";
		
#		system ("/usr/local/vscanx/VShieldScheduleLauncher -s $collectionPath") == 0 # harish 8.5
        
        system (`cp $LVT_ROOT/Includes/VSMacDatabase.db /usr/local/McAfee/AntiMalware/var/.`); 
        print "copied db\n";
        system (`rm /private/tmp/scanfolder`); 
        system (`ln -s $collectionPath /private/tmp/ScanFolder`);     
        print "Going to start the ods scan...";
		system ("/usr/local/McAfee/AntiMalware/VShieldTaskManager 4") == 0
		
				or mumble(*FH, "Error", "Error: Failed to complete the ODS LVT run properly\n");
        
		sleep 20;	
		#waiting for the ODS task to complete
		my ($oldsize,$newsize);
        do
        {
			undef $oldsize; 
			undef $newsize;
            $oldsize = -s $currentLogPath."\/virex-enginelog\/scan.rep";
            #print("$oldsize\n");
            print "waiting to ods task to finish...";
            sleep 30;
            $newsize = -s $currentLogPath."\/virex-enginelog\/scan.rep";
        }
        while($oldsize != $newsize);

	}


	# Remove the mcscan.vlt at the end of the run
	system("rm -f /usr/local/McAfee/AntiMalware/dats/$datNo/mcscan.vlt ") == 0
			or mumble(*FH, "Error", "Error: Failed to remove the mcscan.vlt file from DAT directory\n");
	system("rm -f $LVT_ROOT/mcscan.vlt") == 0
			or mumble(*FH, "INFO", "Error: Failed to remove the mcscan.vlt file from DAT directory\n");

	# Stop the services
#	system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0 
#Aravind			system("$LVT_ROOT/Includes/PrefChanger -k 1 -v 0") == 0
#			or mumble(*FH, "Error", "Error: Failed to stop the services\n"); 
#	system("/usr/bin/killall VirusScan >/dev/null 2>&1") == 0 # harish
#			or mumble(*FH, "INFO", "Error: Failed to kill all VirusScan app\n"); # harish
	sleep 60; # harish

}



# Name 			:- StartBaselineRun
# Description	:- Function to perform the baseline run
# Arguments		:- 
#				1. $scanType		-	CLEAN/DETECT	
#				2. $prodID			-	productID of scan mode for uvscan to behave like
#				3. $collectionPath	-	Complete Path to collection 
#				4. $fileList		-	File listing of the collection to scan
#
 
sub StartBaselineRun {

	local (*FH) = shift;
	my ($scanType,$prodID,$collectionPath,$fileList,$isMail, $datNo) = @_;
	chomp ($scanType,$prodID,$collectionPath,$fileList,$isMail, $datNo);

    my $uvscanpath = "/usr/local/Virex_LVT/scan_mub/uvscanv --engine /Library/Frameworks -d /usr/local/McAfee/AntiMalware/dats/$datNo";
    print "uvscanscanpath,\n";
    print "$uvscanpath,\n";
	if ($scanType =~ /CLEAN/i)
	{
		if (defined($isMail) && $isMail =~ /MAIL/i)
		{
			system ("$uvscanpath --unzip --panalyse --manalyse --verbose --program --summary --recursive --vid --mime --clean --\!forgeprodid= $prodID --file $fileList > /dev/null 2>&1");
		}
		else
		{
			system ("$uvscanpath --unzip --panalyse --manalyse --verbose --program --summary --recursive --vid --clean --\!forgeprodid= $prodID --file $fileList > /dev/null 2>&1");
        print "finished uvscan scan\n";

		}
	}
	elsif ($scanType =~ /DETECT/i)
	{
		if (defined($isMail) && $isMail =~ /MAIL/i)
		{
			system ("$uvscanpath --unzip --panalyse --manalyse --verbose --program --summary --recursive --vid --mime --\!forgeprodid= $prodID  --file $fileList > /dev/null 2>&1");
		}
		else
		{
			system ("$uvscanpath --unzip --panalyse --manalyse --verbose --program --summary --recursive --vid --\!forgeprodid= $prodID  --file $fileList > /dev/null 2>&1");
		}
	}

	# Remove the mcscan.vlt at the end of the run
	system("rm -f /usr/local/McAfee/AntiMalware/dats/$datNo/mcscan.vlt ") == 0
		or die "Error: Failed to remove the mcscan.vlt file from DAT directory\n";
}


# Open Files one by one for on access scanner to catch. expects the sample path
# Referred from old LVT scripts - Girish


sub touchFiles{
	my ($fileList) = @_;
	chomp ($fileList);

    my ($count, $maxfile) = (0,50);

    open (LIST, $fileList) or  die "Error: Coudln't open the filelist of collection to scan\n";
    while (<LIST>)
    {
		my $fName = $_;
        chomp $fName;

        if ($count == $maxfile)
        {
            #print "$count files touched, sleeping for a sec...\n";
            sleep 1;
            $count = 0;
        }

        if (-e $fName)
        {
        	print "File name:$fName\n";
			open (FH1,"$fName")	|| warn "Couldn't open: $fName\n";
			close(FH1);
			#system("/usr/bin/file $fName > /dev/null 2>&1");
        }
        $count++;
    }
    close(LIST);
}


# Name : processEngineLog
#
#
#
#
#\
#

sub processEngineLog {
	local (*FH) = shift;
	my ($LVT_ROOT,$scanCompleteTxt,$currentLogPath,$engineLogDir,$engineLogStr) = @_;
	chomp ($LVT_ROOT,$scanCompleteTxt,$currentLogPath);
	
	# for sort not working on leopard	
	system("export LC_ALL=C");

	# Merge or sort out the uvscan engine log for comparison with virex engine log
	system("$LVT_ROOT/merge-engine-log $engineLogDir $engineLogStr |sort |uniq > $currentLogPath/sorted-engine.log") == 0
			or mumble(*FH, "Error", "Error:  Failed to merge/sort the engine log: $engineLogDir $!\n");

	system ("sed -e 's:^/:/lvt/:g' < $currentLogPath/sorted-engine.log > $currentLogPath/sorted-engine.frm 2>/dev/null") == 0
			or mumble(*FH, "Error", "Error:  Failed to add common string to the engine log: $engineLogDir $!\n");

	my $firstLogFile =`/usr/bin/grep -l 'Scan started' $engineLogDir/* | head -1`; 
	chomp $firstLogFile;
	Virex_LVT::mumble (*FH, "INFO", "First Log file: $firstLogFile");

	
	#`/usr/bin/head -5 $firstLogFile > $currentLogPath/sorted-engine.log`;
	system ("/usr/bin/head -5 <$firstLogFile > $currentLogPath\/sorted-engine.log") == 0
			or Virex_LVT::mumble(*FH, "Error", "Error:  Failed to insert the scan started entry to the engine log: $engineLogDir $!\n");

	system ("/bin/cat $currentLogPath/sorted-engine.frm >> $currentLogPath/sorted-engine.log") == 0
			or Virex_LVT::mumble(*FH, "Error", "Error:  Failed to insert final engine log entries: $engineLogDir $!\n");

	system ("/bin/echo $scanCompleteTxt >> $currentLogPath/sorted-engine.log") == 0
			or Virex_LVT::mumble(*FH, "Error", "Error:  Failed to insert the scan completed entry to the engine log: $engineLogDir $!\n");
	return 0;
}





1; #TRUE
