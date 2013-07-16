#!/usr/bin/perl -I /usr/local/Virex_LVT/Includes

#########################################################################################################################################
#   'DIFFER.PL'    Diff engine logs  
#########################################################################################################################################
#        Engdiff.pm Module created to diff engine reports   
#        Created by A.Kemp & F.Howard Feb 2001             
#        Update Girish Narkhede 23/11/2003 - 
#										Added sections to the log file, 
#										Corrected the duplicate entry identification,  
#										Added debug logging under /tmp/lvt-log
#										Customized to match LSH LVT needs		
#										Customized to match Virex LVT needs		
#        Place in \perl\lib of in working directory 
#        need to have line "use EngDiff;" at top of script wishing to use module
#        call "proc_rep" from within your script (do not need to define module)
#   	need to pass the following variables:                                     
#        "target"(new rep)       
#        "base"(prev rep)       
#        "strip" - a string, the path prior to this string in the reports will be ignored
#        "delim" - delimiter for formated report output - i.e. $detloss and his friends 
#        following vars will become available in your script                           
#        $detloss                - files which have lost detection                    
#        $decrease               - files which have a decrease in detection         
#        $id                     - files which are reported as the same virus name but have diff i.d. (e.g. gone from "identified as" to "is like")    
#        $vname                  - files which have the same i.d but are reported with a diff virus name                                        
#        $both                   - files in which the reported virus name and id have both changed                                              
#        $appeared               - files that have appeared in the collection between the creation of the two reports                              
#        $disappeared            - files that have disappeared in the collection between the creation of the two reports                               
#        $api1                   - the api number of the scanner used to create the BASE report                                              
#        $api2                   - the api number of the scanner used to create the TARGET report                                           
#        $binary1                - the name of the engine binary (used in 4150-808 engines onwards) BASE                                
#        $binary2                - the name of the engine binary (used in 4150-808 engines onwards) TARGET
#        $compiler1              - compiler version of reference (v8.18+)
#        $compiler2              - compiler version of target (v8.18+)
#        $driver1                - the dat version number used to create the BASE report                 
#        $driver2                - the dat version number used to create the TARGET report              
#        $time_taken1            - the time taken for the scan that produced the BASE report in minutes (decimals are 10ths and 100ths of mins
#        $time_taken2            - the time taken for the scan that produced the TARGET report in minutes (decimals are 10ths and 100ths of mins
#        $scan_time1             - the time taken for the scan that produced the BASE report formated into hours, minutes and seconds           
#        $scan_time2             - the time taken for the scan that produced the TARGET report formated into hours, minutes and seconds        
#                                                                                                                                                
#########################################################################################################################################


use EngDiff;                                # makes the above variables available in this script

$start = time();
$version = "2.60";
     # Added in v2.6
	# enlarge logfile field
	# Added sections in log file
     # Added in v2.5
         # handling of 4180 style enngine logs with hit types
     # Added in v2.4
          # engdiff modified to include repaired, rechecing stuff into $vir for .cln checking
         # Added in v2.2
          # handle error discrepancies
     # Added in v2.1
          # better date/time handling
     # Added in v2.0
          # cope with no dates
          # enlarge fields
          # pull out compiler versions

if (@ARGV) {
        # command line parameters passed: REF_SCAN  TARGET_SCAN  COMMON_STRING  OUTPUT_LOGFILE
        if ($ARGV[5]) {
                $base = $ARGV[0];
                $target = $ARGV[1];
                $common = $ARGV[2];
                $outputfile = $ARGV[3];
		$action = $ARGV[4];
                $moreinfo = $ARGV[5];
                      }       
 else {
                print "\nYou must supply SIX  parameters. Usage:\n\tdiffer.pl REF_SCAN  TARG_SCAN  COMMON_STR  OUT_LOG ACTION\n\n";
                exit;
        }
}

else {
        print "\nEnter base to diff against:\n";
        $base = <STDIN>;
        $base =~ chomp($base);
        print "Enter new scan report to check:\n";
        $target = <STDIN>;
        $target =~ chomp($target);
        print "Enter first common string:\n";
        $common = <STDIN>;
        $common =~ chomp($common);
        print "\nEnter path and filename for output log:\n";
        $outputfile = <STDIN>;
        $outputfile =~ chomp($outputfile);


}

#####Adding information from tree-compare.log to this report

#####Done by Sanjeev Gupta

$no_tree_compare_log = `wc -l $moreinfo`;


$data_tree_compare_log = `cat $moreinfo`;

#####

#####



# Print version
     print "------------------------------\nEngine log differ: v$version\n------------------------------\n";
# Compare logs
proc_rep($target, $base, $common, "\n");

        my $results;
		my $flag=1;
		my $missed=0;
		my $diff_id=0;
		my $mis_repaired=0;
		my $diff_both=0;
		my $Rappeared=0;
		my $Rdisappeared=0;

        my @detloss = split /\n/, $detloss;
        my @sorted_results1 = sort { substr($a, 0) cmp substr($b, 80) } @detloss;
		my $start_line1 = "-----Files which have detection loss by Virex---------------";
		$results .= "\n$start_line1\n" if ($detloss);
         foreach (@sorted_results1) {
         	$results .= "$_\n";
			$missed++;
        }
#                my @decrease = split /\n/, $decrease;
#                my @sorted_results7 = sort { substr($a, 0) cmp substr($b, 80) } @decrease;
#                         $results .="\nDECREASE\n";
#                        foreach (@sorted_results7) {
#                                $results .= "$_\n";
#                        }
        my @id = split /\n/, $id;
        my @sorted_results2 = sort { substr($a, 0) cmp substr($b, 80) } @id;
		my $start_line2 = "-----Files which are reported with diff i.d.------\n (e.g. gone from 'identified as' to 'is like')";
		$results .= "\n$start_line2\n" if ($id);
        foreach (@sorted_results2) {
			(my $uvstring, my $naRStr) = split /NOW/;
			(my $f, my $uvRStr) = split(/WAS/, $uvstring);
           	$results .= "\n$f\n UVSCAN Result - $uvRStr\n Virex Result - $naRStr\n";
            # $results .= "$_\n";
			$diff_id++;
        }
        my @vname = split /\n/, $vname;
        my @sorted_results3 = sort { substr($a, 0) cmp substr($b, 80) } @vname;
		my $start_line3 = "-----Files which have the same virus name but are reported with a diff i.d. ----";
		my $start_line31 = "------Uvscan not repaired Virex repaired----";
    	my $start_line32 = "------Uvscan not repaired Virex repaired----";

		$results .= "\n$start_line3\n" if ($vname);
        foreach (@sorted_results3) {
			$entry = $_;
			(my $uvstring, my $naRStr) = split (/NOW/, $entry);
			(my $f, my $uvRStr) = split(/WAS/, $uvstring);
			#print "\n3 FILE - $f \n3 UV - $uvRStr\n"; 
			if (($uvRStr =~ /not repaired/) and ($naRStr =~ /is ok/ or $naRStr =~ /repaired.$/)) {
				$results1 .= "\n$f\n UVSCAN Result - $uvRStr\n Virex Result - $naRStr\n";	
			}
			elsif (($naRStr =~ /not repaired/) and ($uvRStr =~ /repaired.$/ or $uvRStr =~ /is ok/)) {
				$results2 .= "\n$f\n UVSCAN Result - $uvRStr\n Virex Result - $naRStr\n";	
			}
			else {
    			$results .= "\n$f\n UVSCAN Result - $uvRStr\n Virex Result - $naRStr\n";
			}
			$mis_repaired++;
    	}
		$results .= "\n$start_line31\n" if ($results1);
		$results .= $results1 if ($results1);
		$results .= "\n$start_line32\n" if ($results2);
		$results .= $results2 if ($results2);
       	my @both = split /\n/, $both;
       	my @sorted_results4 = sort { substr($a, 0) cmp substr($b, 80) } @both;
		my $start_line4 = "-------Files in which the reported virus name and id have both changed------";
		$results .= "\n$start_line4\n" if ($both);
        foreach (@sorted_results4) {
			(my $uvstring, my $naRStr) = split /NOW/;
			(my $f, my $uvRStr) = split(/WAS/, $uvstring);
		    $results .= "\n$f\n UVSCAN Result - $uvRStr\n Virex Result - $naRStr\n";
            # $results .= "$_\n";
			$diff_both++;
        }

        my @appeared = split /\n/, $appeared;
        my @sorted_results5 = sort { substr($a, 0) cmp substr($b, 1) } @appeared;
		my $start_line5 = "-------Files which appear in Virex log only-----------------";
		$results .= "\n$start_line5\n" if ($appeared);
        foreach (@sorted_results5) {
        	$results .= "$_\n";
			$Rappeared++;
        }
        my @disappeared = split /\n/, $disappeared;
        my @sorted_results6 = sort { substr($a, 0) cmp substr($b, 1) } @disappeared;
		my $start_line6 = "-------Files which do not appear in Virex log-----------------";
		$results .= "\n$start_line6\n" if ($disappeared);
        foreach (@sorted_results6) {
        	$results .= "$_\n";
			$Rdisappeared++;
        }

		# If all queries return nowt, files are identical
        if (($decrease eq '') && ($detloss eq '') && ($id eq '') && ($vname eq '') && ($both eq '') && ($appeared eq '') && ($disappeared eq '') && ($outputfile ne '')) {
        		$conclusion = "LVT Run PASSED	: No differences found! NJoy Virex Team, No Analysis is Required";
				$flag=0;
         }
         else {
         		$conclusion = "LVT Run FAILED	: Found Discrepancies - see the .RESULT log file";
         }




$end = time();
$time = $end - $start;
# print "\nScanned: $lvt_uvScanned  Infected: $lvt_uvInfected Repaired: $lvt_uvRepaired Not Repaired: $lvt_uvNotRepaired Clean:  $lvt_nclean Deleted: $lvt_uvDeleted\n";

my $fResult = "\n  -----------------------R E S U L T---------------------------\n  Result of the LVT Run after comparing Engine log file:\n  -------------------------------------------------------------\n\tFiles Missed Detection\t\t\t\t : $missed\n\tFiles Detected with Diff ID\t\t\t : $diff_id\n\tFiles Detected with Diff. Virus Name\t\t : $mis_repaired\n\tFiles Detected with Diff. ID & VName\t         : $diff_both\n\tFiles Appeared     (in Virex, not in UVScan LOG) : $Rappeared\n\tFiles Dis-Appeared (in UVScan, not in Virex LOG) : $Rdisappeared\n  -------------------------------------------------------------\n~~~~~Adding information from tree-compare.log~~~~~\n**Number of entries and file path of tree-compare.log\t: $no_tree_compare_log\n**All entries from tree-compare.log\t\t: SEE BELOW\n\n$data_tree_compare_log\n---------------------------------------------------------------\n\n";
my $logtime = "Log processing took: $time secs";
               # Print output to screen and file
               $~ = "TESTINFO";
               write;
               $~ = "SUMMARY1" if $action =~ /Clean/i or $action =~ /Delete/i or $action =~ /Block/i or $action =~ /Detect/i;
               $~ = "SUMMARY2" if $action =~ /Quarantine/i;
               $~ = "SUMMARY3" if $action =~ /Rename/i;
               write;
				print "$fResult" if $flag;
				open (OUTPUT, ">$outputfile");
                    my $oldhandle = select OUTPUT;
					$~ = "TESTINFO";
               		write;
		    		$~ = "SUMMARY1" if $action =~ /Clean/i or $action =~ /Delete/i or $action =~ /Block/i or $action =~ /Detect/i;
                    $~ = "SUMMARY2" if $action =~ /Quarantine/i;
                    $~ = "SUMMARY3" if $action =~ /Rename/i;
                    select($oldhandle);
                    write(OUTPUT);
                    print OUTPUT "$fResult" if $flag;
                    print OUTPUT "$results" if $flag;
               close (OUTPUT);

# Define summary format
format TESTINFO=
----------------------------------------T E S T I N F O----------------------------------------
BASE:   Binary: @<<<<<<<<<<< API: @<<<<<<<<<<  DAT: @<<<  C40: @<<<  Scan Time: @<<<<<<<<<<<<<<
$binary1, $api1, $driver1, $compiler1, $scan_time1
TARGET: Binary: @<<<<<<<<<<< API: @<<<<<<<<<<  DAT: @<<<  C40: @<<<  Scan Time: @<<<<<<<<<<<<<<
$binary2, $api2, $driver2, $compiler2, $scan_time2
-----------------------------------------------------------------------------------------------

.
format SUMMARY1=
STATS: After parsing Virex and UVScan engine log files.
--------------------------------------------S U M M A R Y------------------------------------------------------------
  +    | Total Obj Scanned | Objects Infected | Objects Clean | Obj's Repaired | Obj's Not Repaired | Obj's Deleted |
---------------------------------------------------------------------------------------------------------------------
UVSCAN:|    @<<<<<<<<<<<<< |   @<<<<<<<<<<<<< |   @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<<<<<<<<< |   @<<<<<<<<<< |
$lvt_uvScanned, $lvt_uvInfected, $lvt_uvclean, $lvt_uvRepaired, $lvt_uvNotRepaired, $lvt_uvDeleted
VIREX :|    @<<<<<<<<<<<<< |   @<<<<<<<<<<<<< |   @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<<<<<<<<< |   @<<<<<<<<<< |
$lvt_naScanned, $lvt_naInfected, $lvt_naclean, $lvt_naRepaired, $lvt_naNotRepaired, $lvt_naDeleted
--------------------------------------------------------------------------------------------------------------------
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  |
$conclusion												    
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                               |
$logtime									    		
---------------------------------------------------------------------------------------------------------------------
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
.

format SUMMARY2=
STATS: After parsing Virex and UVScan engine log files.
--------------------------------------------S U M M A R Y----------------------------------------------------------
  +    | Total fScanned | Files Infected | Files Clean | Files Quarantined | Files Not Quarantined | Files Deleted |
-------------------------------------------------------------------------------------------------------------------
UVSCAN:|    @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<< |   @<<<<<<<<<<<    |    @<<<<<<<<<<<<<<<   |   @<<<<<<<<<< |
$lvt_uvScanned, $lvt_uvInfected, $lvt_uvclean, $lvt_uvQuarantined, $lvt_uvNotRepaired, $lvt_uvDeleted
Virex:|    @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<< |   @<<<<<<<<<<<    |    @<<<<<<<<<<<<<<<   |   @<<<<<<<<<< |
$lvt_naScanned, $lvt_naInfected, $lvt_naclean, $lvt_naQuarantined, $lvt_naNotRepaired, $lvt_naDeleted
-------------------------------------------------------------------------------------------------------------------
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<    |
$conclusion												    
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                                     |
$logtime									    		
-------------------------------------------------------------------------------------------------------------------
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
.

format SUMMARY3=
STATS: After parsing Virex and UVScan engine log files.
--------------------------------------------S U M M A R Y----------------------------------------------------
  +    | Total fScanned | Files Infected | Files Clean | Files Renamed | Files Not Renamed | Files Deleted   |
-------------------------------------------------------------------------------------------------------------
UVSCAN:|    @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<<<<<<<<< |   @<<<<<<<<<< |
$lvt_uvScanned, $lvt_uvInfected, $lvt_uvclean, $lvt_uvRenamed, $lvt_uvNotRepaired, $lvt_uvDeleted
Virex:|    @<<<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<< |   @<<<<<<<<<<< |   @<<<<<<<<<<<<<<< |   @<<<<<<<<<< |
$lvt_naScanned, $lvt_naInfected, $lvt_naclean, $lvt_naRenamed, $lvt_naNotRepaired, $lvt_naDeleted
-------------------------------------------------------------------------------------------------------------
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< |
$conclusion												    
    @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                               |
$logtime									    		
-------------------------------------------------------------------------------------------------------------
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
.

