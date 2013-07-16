#!/usr/bin/perl -I /usr/local/Virex_LVT/Includes

############################################################################################################
#                                                                                                          #
# Driver Script for the Virex - VirusScan for Mac LVT                                                      #	
#                                                                                                          #
# Author 		- Girish Narkhede                                                                          #
#                                                                                                          #
# Description:                                                                                             #
#				This is the main Virex LVT driver script, which sets up the environment as                 #
#				per the configuration before invoking the baseline and product LVT runs.                   #
# Syntax:                                                                                                  #
#				There are 2 ways to start this script                                                      #
#				1. <PATH>/virex_lvt.pl                                                                     #
#				2. <PATH>/virex_lvt.pl -f/F <LVT config file name>                                         #
#			e.g.                                                                                           #
#				/usr/local/Virex_LVT/virex_lvt.pl -f /usr/local/Virex_LVT/virex_lvt.cfg                    #
#                                                                                                          #
############################################################################################################



# DAT path

#####SANJEEV GUPTA
#####CLEANUP

#system("SystemStarter start Virex");

sleep 10;

#system("rm -r `find $COLLECTIONS_PATH -name .DS_Store`");

#####
#####
use Config::Natural;
use Virex_LVT;

$logFile="/var/log/virex_lvt.log";

# Check the currently logged in user is root
if ($< != 0)
{
	die "\n\tError: You must be root to execute this program !!!\n\n";
}

# Take the config file path from the USER

if ( $#ARGV <= 1 )
{
	if($ARGV[0] =~ /-f/i)
	{
    	$configFile = $ARGV[1];
	    chomp $configFile;
	    #print "Config File : $configFile\n";
	}
   else
   {
	   print "\n\tInvalid option provided\n";
       print "\tSyntax:\n";
       print "\t\t<PATH>/virex_lvt.pl -f <config file name with absolute path>\n";
       print "\t\te.g. /usr/local/Virex_LVT/virex_lvt.pl -f /usr/local/Virex_LVT/virex_lvt.cfg\n\n";
       exit 1;
   }

}
else
{
    print "\nEnter the path for the LVT config file: ";
    $configFile = <STDIN>;
    chomp $configFile;
    #print "Config File name = $configFile\n";
}


# Backup if old log file exists
if (-e $logFile)
{
	system("mv $logFile $logFile.1");
}

# Open the LVT run log file
open(LOG,">$logFile") or die "\n\tError: Could not open the log file $logFile\n\n";

# Check the existance of the config file and is not a zero byte file
unless (-e $configFile) {
	Virex_LVT::mumble(*LOG, "Error", "\nError:\tCould not open the config file $configFile\n\n");
}

#Read the config file
my $configFileReader = new Config::Natural $configFile;
my $LVT_ROOT = $configFileReader->value_of("LVT_ROOT");
my $logPath = $configFileReader->value_of("LOG_PATH");
my $collectionPath = $configFileReader->value_of("COLLECTIONS_PATH");
my $allRuns = $configFileReader->value_of("/LVT_RUNS[*]");
my $datno = $configFileReader->value_of("DAT_NO");
chomp ($configFileReader,$LVT_ROOT, $logPath, $collectionPath, $datno);



system("rm -r /usr/local/McAfee/AntiMalware/$datno/mcscan.vlt");

# Backup old logs if any
if(-d $logPath) { 
print $logPath, "\n";

	rename($logPath, $logPath."-".$$) 
		or Virex_LVT::mumble(*LOG, "Error", "Error: Could not rename the existing log directory to backup -$!\n");
}
mkdir("$logPath") or Virex_LVT::mumble(*LOG, "Error", "\nError: Could not create the directory $logPath - $!\n");



# Start processing LVT runs of each type of mentioned in the LVT runs section

foreach $runType (@$allRuns)
{
	chomp $runType;
	#print STDOUT "runType is - $runType\n";

	(my $scanMode,my $scanType, my $isMail) = split(/-/,$runType);
	chomp ($scanMode, $scanType, $isMail);
	#print STDOUT "scanMode is - $scanMode\n $scanType\n";
	
	# Now read all the COllections list to run for this runType
	#print("\/"."$runType"."[*]\n");
	my $collections = $configFileReader->value_of("\/"."$runType"."[*]");
	chomp $collections;
	
	# Start the LVT run for each @collections with $scanMode and $scanType 
	my $collName;
	foreach $collName (@$collections)
	{
		chomp $collName;
		Virex_LVT::mumble(*LOG, "INFO", "INFO: -------------------------------------START--------------------------------\n\n");		
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Starting $scanMode $isMail $scanType run with $collName collection\n");

		# Set the log path for current run e.g. troj-OAS-detect
		my $currentLogPath = $logPath."/".$collName."-".$runType;

		# Create the current log directory or die
		mkdir($currentLogPath) or Virex_LVT::mumble(*LOG,"Error", "\nError: Could not create the log directory $currentLogPath - $!\n");

		system("chown -R root:Virex $currentLogPath") == 0
			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to change the ownership of $currentLogPath directory\n");

		system("chmod -R 777 $currentLogPath") == 0
			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to change the permission of $currentLogPath directory\n");

		system("chmod g+w $currentLogPath") == 0
			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to add g+w ownership to $currentLogPath directory\n");

		system("chmod o+w $currentLogPath") == 0
			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to add o+w ownership to $currentLogPath directory\n");

		system("chmod g+s $currentLogPath") == 0
			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to add g+s ownership to $currentLogPath directory\n");

		my $debugLog = $currentLogPath."\/run_debug.log";
		
		# Get ready to copy the collection to scan by product and baseline
		mkdir("$currentLogPath\/lvt-virex") 
			or Virex_LVT::mumble(*LOG, "Error", "Error: Could not create the directory $currentLogPath/lvt-virex - $!\n");
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Created the directory $currentLogPath/lvt-virex to sync the collection\n");

		mkdir("$currentLogPath\/lvt-uvscan") 
			or Virex_LVT::mumble(*LOG, "Error", "Error: Could not create the directory $currentLogPath/lvt-uvscan - $!\n");
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Created the directory $currentLogPath/lvt-uvscan to sync the collection\n");

#		system("launchctl unload /Library/LaunchDaemons/com.mcafee.virusscan.ScanManager.plist") == 0 
#Aravind			 system("$LVT_ROOT/Includes/PrefChanger -k 1 -v 0") == 0
#Aravind 			or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to stop Virex before copying the collection - $!\n");
#		system("/usr/bin/killall VirusScan > /dev/null 2>&1") == 0 
#			or Virex_LVT::mumble(*LOG, "INFO", "Error: Failed to kill all VirusScan App $!\n"); # harish
 		sleep 60;
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Stopped the Virex services to sync the collections\n");
	
		# Check the collection directory
		unless (-d "$collectionPath\/$collName") { 
				Virex_LVT::mumble(*LOG, "Error", "Error: Collection directory $collectionPath/$collName does not exist - $!\n");
		}

		# Sync the original collection for product and baseline to scan 
		my @args = ("cp", "-Rf", "$collectionPath\/$collName", "$currentLogPath\/lvt-virex");
		system(@args) == 0
				or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to copy the collection to $currentLogPath\/lvt-virex properly - $!\n");
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Copied the collection to $currentLogPath/lvt-virex to scanned by product\n");

		undef @args;
		@args = ("cp", "-Rf", "$collectionPath\/$collName", "$currentLogPath\/lvt-uvscan");
		system(@args) == 0
				or Virex_LVT::mumble(*LOG, "Error", "nError: Failed to copy the collection to $currentLogPath\/lvt-uvscan properly - $!\n");
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Copied the collection to $currentLogPath/lvt-virex to scanned by baseline\n");

		# Create directories for the engine logging for baseline and product 
		mkdir("$currentLogPath\/virex-enginelog")
				or Virex_LVT::mumble(*LOG, "Error", "Error: Could not create the directory $currentLogPath/virex-enginelog - $!\n");
		mkdir("$currentLogPath\/uvscan-enginelog")
				or Virex_LVT::mumble(*LOG, "Error", "Error: Could not create the directory $currentLogPath/uvscan-enginelog - $!\n");

		# Get the product ID to use for baseline run
		my ($prodID, $FileList);
		if($scanMode =~ /OAS/i)
		{
				# Create the file listing of the collection for virex OAS
				$FileList = $currentLogPath."\/".$runType."\.list\.virex";
				system("find $currentLogPath/lvt-virex -type f | LC_ALL=C sort  > $FileList") == 0
						or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to generate the file listing of the collection: Product - $!\n");

				# Create the file listing of zero byte files in the collection which are being excluded from virex OAS run
				system("find $currentLogPath/lvt-virex -type f -empty | LC_ALL=C sort | tr '[\200-\377]' '[?*]'  > $FileList.zeroByte") == 0
						or Virex_LVT::mumble(*LOG, "INFO", "Error:  Failed to generate the zero byte file listing of the collection $!\n");
				
				# Create the file listing of the collection for uvscan
				system("sed -e 's:lvt-virex:lvt-uvscan:g' <$FileList > $FileList.uvscan") == 0
						or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to generate the file listing of the collection: baseline - $!\n");

				Virex_LVT::mumble(*LOG, "INFO", "INFO: Created the file list of collection for scanning by baseline and product\n");

				# Get the OAS product ID to use for baseline run
				if(defined($isMail) && $isMail =~ /MAIL/i)
				{
					$prodID = $configFileReader->value_of("MAIL_PRODID");
					unless (defined($prodID)) {
						Virex_LVT::mumble(*LOG, "Error", "Error: Could not read MAIL_PRODID from config file - $!\n");
					}
				}
				else
				{
					$prodID = $configFileReader->value_of("OAS_PRODID");
					unless (defined($prodID)) {
						Virex_LVT::mumble(*LOG, "Error", "Error: Could not read OAS_PRODID from config file - $!\n");
					}
				}
				chomp $prodID;

		}
		elsif ($scanMode =~ /ODS/i)
		{
			# Get the ODS product ID to use for baseline run
			if(defined($isMail) && $isMail =~ /MAIL/i)
			{
				$prodID = $configFileReader->value_of("MAIL_PRODID");
				unless (defined($prodID)) {
				Virex_LVT::mumble(*LOG, "Error", "Error: Could not read MAIL_PRODID from config file - $!\n");
				}
			}
			else
			{
				$prodID = $configFileReader->value_of("ODS_PRODID");
				unless (defined($prodID)) {
					Virex_LVT::mumble(*LOG, "Error", "Error: Could not read ODS_PRODID from config file - $!\n");
				}
			}
			chomp $prodID;

			# Create the file listing of the collection for virex OAS
			$FileList = $currentLogPath."\/".$runType."\.list\.virex";
			system("find $currentLogPath/lvt-virex -type f | LC_ALL=C sort > $FileList") == 0
					or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to generate the file listing of the collection: Product - $!\n");
		
			# Create the file listing of the collection for uvscan
			system("sed -e 's:lvt-virex:lvt-uvscan:g' <$FileList > $FileList.uvscan") == 0
					or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to generate the file listing of the collection: baseline - $!\n");

			Virex_LVT::mumble(*LOG, "INFO", "INFO: Created the file list of collection for scanning by baseline and product\n");
		}
				
		# Set the engine logging for baseline run
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Setting the engine logging for baseline run\n");
		Virex_LVT::SetEngineLogging(*LOG,$scanMode,$LVT_ROOT,$currentLogPath."\/uvscan-enginelog", $datno);
	
		
	    # Start the LVT runs depending on the scanMode and scanType
		# Start the baseline run 
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Starting the baseline run\n");
		Virex_LVT::StartBaselineRun(*LOG,$scanType,$prodID,$currentLogPath."\/lvt-uvscan",$FileList."\.uvscan",$isMail, $datno);

	
		# Scan completed time is not added to the engine logging so doing the workaround
        my $scanCompletedat_uvscan=`/bin/date "+%a %b %e %H:%M:%S %Y"`;
		my $scanCompletedTxt_uvscan="Scan completed at: $scanCompletedat_uvscan";

		
		# process the engine log for comparison
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Processing the engine logging for baseline run\n");
		Virex_LVT::processEngineLog(*LOG,$LVT_ROOT,$scanCompletedTxt_uvscan,$currentLogPath,"$currentLogPath\/uvscan-enginelog","$currentLogPath\/lvt-uvscan")== 0
				or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to process the engine log: baseline $!\n");
			
		
			
		# Rename the processed engine log to appropriate scanner
		rename($currentLogPath."\/sorted-engine.log", $currentLogPath."\/lvt_uvscan-engine.log") 
				or Virex_LVT::mumble(*LOG, "Error", "Error: Could not rename the sorted engine log $!\n");
				
		# Set the engine logging for product run
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Setting the engine logging for product run\n");
		Virex_LVT::SetEngineLogging(*LOG,$scanMode,$LVT_ROOT,$currentLogPath."\/virex-enginelog", $datno);
		
		if ( $scanMode =~ /ODS/i)
		{
			system("/bin/cat /dev/null > $currentLogPath\/virex-enginelog\/scan.rep") == 0
					or Virex_LVT::mumble(*LOG, "Error", "Error: Could not touch the engine log file $!\n");

			system("chmod 777 $currentLogPath\/virex-enginelog\/scan.rep") == 0
					or Virex_LVT::mumble(*LOG, "Error", "Error: Could not change the permissions of engine log file $!\n");
		}

		# Start the product run 
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Starting the product run\n");
		Virex_LVT::StartProductRun(*LOG,$scanMode,$scanType,$LVT_ROOT,$currentLogPath."\/lvt-virex",$FileList,$currentLogPath,$isMail, $datno);
		

		# Scan completed time is not added to the engine logging so doing the workaround
        my $scanCompletedat_virex=`/bin/date "+%a %b %e %H:%M:%S %Y"`;
		$scanCompletedTxt_virex="Scan completed at: $scanCompletedat_virex";

		# process the engine log for comparison
		Virex_LVT::mumble(*LOG, "INFO", "INFO:  Processing the engine logging for product run\n");
		Virex_LVT::processEngineLog(*LOG,$LVT_ROOT,$scanCompletedTxt_virex,$currentLogPath, "$currentLogPath\/virex-enginelog", "$currentLogPath\/lvt-virex") == 0
				or Virex_LVT::mumble(*LOG, "Error", "Error:  Failed to process the engine log: Product $!\n");

		# Remove the "contains macros" string from virex engine log to match the baseline log 
		system("sed -e 's:,contains macros::g' < $currentLogPath/sorted-engine.log > $currentLogPath/lvt_virex-engine.log") == 0
				or Virex_LVT::mumble(*LOG, "Error", "Error: Could not rename the sorted engine log $!\n");


		# Create a directory to generate final results
		mkdir($currentLogPath."\/report") == 1
				or Virex_LVT::mumble(*LOG, "Error", "Error: Could not create the directory $currentLogPath/report $!\n");




               # TODO: call tree compare
               Virex_LVT::mumble(*LOG, "INFO", "INFO: Starting the tree comparison for $collName $scanMode $scanType run\n");
               system("$LVT_ROOT/compare-trees $currentLogPath/report/log $currentLogPath/lvt-uvscan $currentLogPath/lvt-virex $LVT_ROOT > $currentLogPath/report/tree-compare.log") == 0
                              or Virex_LVT::mumble(*LOG, "INFO", "Error: Tree comparison of $currentLogPath/lvt-uvscan and $currentLogPath/lvt-virex Failed !!! \nCheck $currentLogPath/report/tree-compare.log for more details !!!\n");












          	# Call differ.pl to compare the engine log generated by UVScan and Product 
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Starting the engine comparison for $collName $scanMode $scanType run\n");		
		my $commonStr="\/lvt";
		system("$LVT_ROOT/differ.pl $currentLogPath/lvt_uvscan-engine.log $currentLogPath/lvt_virex-engine.log $commonStr $currentLogPath/report/engine-log-compare.RESULT $scanType $currentLogPath/report/tree-compare.log") == 0
				or Virex_LVT::mumble(*LOG, "Error", "Error: Failed to execute the engine log comparison");		
		if( -d "/tmp/lvt-log" )
		{
			Virex_LVT::mumble(*LOG, "INFO", "INFO: Starting the backup of debug engine log\n");		
			# backup the debug log 
			system("/bin/mv /tmp/lvt-log $currentLogPath/lvt-debug-log") == 0
					or Virex_LVT::mumble(*LOG, "INFO", "Error: Could not backup the debug engine log $!\n");
		}

#		# TODO: call tree compare 
#		Virex_LVT::mumble(*LOG, "INFO", "INFO: Starting the tree comparison for $collName $scanMode $scanType run\n");		
#		system("$LVT_ROOT/compare-trees $currentLogPath/report/log $currentLogPath/lvt-uvscan $currentLogPath/lvt-virex $LVT_ROOT > $currentLogPath/report/tree-compare.log") == 0
#				or Virex_LVT::mumble(*LOG, "INFO", "Error: Tree comparison of $currentLogPath/lvt-uvscan and $currentLogPath/lvt-virex Failed !!! \nCheck $currentLogPath/report/tree-compare.log for more details !!!\n");		
#
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Completed $scanMode $scanType run with $collName collection\n");		
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Check the $currentLogPath/report directory for the results of this run\n");		
		Virex_LVT::mumble(*LOG, "INFO", "INFO: Check the /var/log/virex_lvt.log to see all  messages printed on the STDOUT\n");		
		Virex_LVT::mumble(*LOG, "INFO", "INFO: -------------------------------------END--------------------------------\n\n");		

	}
}

close(LOG);
