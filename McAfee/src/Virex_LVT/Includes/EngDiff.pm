#!/usr/bin/perl
#########################################################################################################################################
#        Module created to diff engine reports          
#        Created by A.Kemp & F.Howard Feb 2001
#        Updated to merge changes by A.K. and F.P.H Oct 2001     
#
#        Updated A.K. May 2002 to cope with changes introduced in 4180 engine
#        main change - introduction of hit type into engine log
#
#        Update A.K. 30/07/02 to add Not Scanned not executable type miss
#
#        Update A.K. 04/11/02 to ignore Normal hit if there is a virus hit on the same line
#
#        Update A.K. 14/05/03 small to fix bug where would not match on V10.00 API
#	 
#	 Update Girish Narkhede 23/11/2003 fix for the proper tag removing/appending (function Log_read line: 244)
#
#	 Update Girish Narkhede 20/04/2005 fix for the normal hit samples counting problem (function Log_read line: 255)
#
#        Place in \perl\lib of in working directory             
#        need to have line "use EngDiff;" at top of script wishing to use module
#        call "proc_rep" from within your script (do not need to define module)
#   need to pass the following variables: 
#        "target"(new rep)
#        "base"(prev rep)
#        "strip" - a string, the path prior to this string in the reports will be ignored 
#        "delim" - delimiter for formated report output - i.e. $detloss and his friends 
#        following vars will become available in your script  
#        $detloss       - files which have lost detection
#        $decrease      - files which have a decrease in detection
#        $id            - files which are reported as the same virus name but have diff i.d. (e.g. gone from "identified as" to "is like")
#        $vname         - files which have the same i.d but are reported with a diff virus name 
#        $both          - files in which the reported virus name and id have both changed
#        $appeared      - files that have appeared in the collection between the creation of the two reports
#        $disappeared   - files that have disappeared in the collection between the creation of the two reports 
#        $api1          - the api number of the scanner used to create the BASE report
#        $api2          - the api number of the scanner used to create the TARGET report
#        $binary1       - the name of the engine binary (used in 4150-808 engines onwards) BASE
#        $binary2       - the name of the engine binary (used in 4150-808 engines onwards) TARGET
#        $driver1       - the dat version number used to create the BASE report
#        $driver2       - the dat version number used to create the TARGET report
#        $time_taken1   - the time taken for the scan that produced the BASE report in minutes (decimals are 10ths and 100ths of mins
#        $time_taken2   - the time taken for the scan that produced the TARGET report in minutes (decimals are 10ths and 100ths of mins
#        $scan_time1    - the time taken for the scan that produced the BASE report formated into hours, minutes and seconds
#        $scan_time2    - the time taken for the scan that produced the TARGET report formated into hours, minutes and seconds
#        $falses        - files which are not is ok (yes I know it doesn't mean its a false but I'm only using it for the false rig)
#           
#########################################################################################################################################

package EngDiff;

require Exporter;
@ISA        =qw (Exporter);
@EXPORT        =qw (proc_rep Falses $detloss $decrease $id $appeared $vname $both $disappeared $api1 $api2 $binary1 $binary2 $driver1 $driver2 $compiler1 $compiler2 $time_taken1 $time_taken2 $scan_time1 $scan_time2 $falses $lvt_uvclean $lvt_naclean $lvt_naInfected $lvt_uvInfected $lvt_uvNotRepaired $lvt_naNotRepaired $lvt_uvRepaired $lvt_naRepaired $lvt_uvDeleted $lvt_naDeleted $lvt_uvScanned $lvt_naScanned $lvt_uvRenamed $lvt_naRenamed $lvt_uvQuarantined $lvt_naQuarantined $lvt_uvZerod $lvt_naZerod);

sub proc_rep {# process the report
        $target=$_[0]; # new report file
        $base=$_[1];   # old report file
        $strip=$_[2]; #stripy stripy
        $delim=$_[3]; #delimiter

	undef ($lvt_naclean);
	undef ($lvt_naInfected);
	undef ($lvt_naNotRepaired);
	undef ($lvt_naRepaired);
	undef ($lvt_naDeleted);
	undef ($lvt_naScanned);
	undef ($lvt_uvclean);
	undef ($lvt_uvInfected);
	undef ($lvt_uvNotRepaired);
	undef ($lvt_uvRepaired);
	undef ($lvt_uvDeleted);
	undef ($lvt_uvScanned);

		system("rm -rf /tmp/lvt-log") == 0
			or warn "Failed to delete the old debug log directory /tmp/lvt-log\n";
        # Get engine logs (from command-line), and process to hashes with anon arrays
        ($base_ref,$start_time1,$end_time1,$api1,$driver1,$binary1,$compiler1) = Log_read($base,$strip,0); # references not hashes => $
        return ($detloss) and $detloss = $base_ref if $base_ref =~ /sorry/;
        $detloss = $base_ref if $base_ref =~ /present in path/;
        return ($detloss) if $base_ref =~ /present in path/;
        %baseline = %$base_ref ;
        ($new_ref,$start_time2,$end_time2,$api2,$driver2,$binary2,$compiler2) = Log_read($target,$strip,1);
        return ($detloss) and $detloss = $new_ref if $new_ref =~ /sorry/;
        $detloss = $base_ref if $base_ref =~ /present in path/;
        return ($detloss) if $base_ref =~ /present in path/;
#        return ($detloss) and $detloss = $base_ref if $base_ref =~ /present in path/;
        %newone = %$new_ref;
        # Diff hashes - outputs 3 hashes
        ($detloss,$decrease) = hash_diff(\%baseline, \%newone,$delim);

        # Times for BASE log
        $start1 = scantime ($start_time1);
        $end1 = scantime ($end_time1);
        $time_taken1 = ($end1 - $start1) / 60;#time taken in minutes
        # split into h:m:s
        if ($time_taken1 =~ /\./) {
             ($minutes1,$secs1) = $time_taken1 =~ /(\d*)(\.\d*)/i;
        }
        else {
             ($minutes1) = $time_taken1 =~ /(\d*)/i;
             $secs1 = 0;
        }
        $secs1 = ($secs1*60);
        $secs1 =~ s/\..*// if ($secs1 =~ /\./);
        $hours1 = $minutes1/60;
        ($hours1,$minutes1) = $hours1 =~ /(\d*)(\.\d*)/i;
        $minutes1 = $minutes1*60;
        $minutes1 =~ s/^(\d+)\.\d*/$1/g;
        $scan_time1 = sprintf "%2.4sh%2.2sm%2.2ss\n",$hours1,$minutes1,$secs1;

        # Times for TARGET log
        $start2 = scantime ($start_time2);
        $end2 = scantime ($end_time2);
        $time_taken2 = ($end2 - $start2) / 60;#time taken in minutes
        # split into h:m:s
        if ($time_taken2 =~ /\./) {
             ($minutes2,$secs2) = $time_taken2 =~ /(\d*)(\.\d*)/i;# there must be a nicer way of spliting into hrs,min,secs
        }
        else {
             ($minutes2) = $time_taken2 =~ /(\d*)/i;
             $secs2 = 0;
        }

        $secs2 = ($secs2*60);
        $secs2 =~ s/\..*// if ($secs2 =~ /\./);
        $hours2 = $minutes2/60;
        ($hours2,$minutes2) = $hours2 =~ /(\d*)(\.\d*)/i;
        $minutes2 = $minutes2*60;
        $minutes2 =~ s/^(\d+)\.\d*/$1/g;
        $scan_time2 = sprintf "%2.4sh%2.2sm%2.2ss\n",$hours2,$minutes2,$secs2;
#        return ($detloss,$decrease,$id,$appeared,$vname,$both,$disappeared,$api1,$api2,$driver1,$driver2,$compiler1,$compiler2,$time_taken1,$time_taken2,$scan_time1,$scan_time2);
	return ($detloss,$decrease,$id,$appeared,$vname,$both,$disappeared,$api1,$api2,$driver1,$driver2,$compiler1,$compiler2,$time_taken1,$time_taken2,$scan_time1,$scan_time2,$lvt_uvclean,$lvt_naclean,$lvt_naInfected,$lvt_uvInfected,$lvt_uvNotRepaired,$lvt_naNotRepaired,$lvt_uvRepaired,$lvt_naRepaired,$lvt_uvDeleted,$lvt_naDeleted,$lvt_uvScanned,$lvt_naScanned);
}

sub Falses {
        $target = $_[0];
        $strip = $_[1];
        $delim = $_[2];
        ($false_ref,$start_time,$end_time,$api,$driver) = Not_ok ($target,$strip);
        foreach  $key (keys %$false_ref ) {
                $falses  .= sprintf "%-70.70s  %-15.15s  %-30.30s$delim",$key,$$false_ref{$key}->[0],$$false_ref{$key}->[1] ;
        }
        # Times for TARGET log
        $start2 = scantime ($start_time);
        $end2 = scantime ($end_time);
        $time_taken2 = ($end2 - $start2) / 60;#time taken in minutes
        # split into h:m:s
        if ($time_taken2 =~ /\./) {
             ($minutes2,$secs2) = $time_taken2 =~ /(\d*)(\.\d*)/i;# there must be a nicer way of spliting into hrs,min,secs
        }
        else {
             ($minutes2) = $time_taken2 =~ /(\d*)/i;
             $secs2 = 0;
        }

        $secs2 = ($secs2*60);
        $secs2 =~ s/\..*// if ($secs2 =~ /\./);
        $hours2 = $minutes2/60;
        ($hours2,$minutes2) = $hours2 =~ /(\d*)(\.\d*)/i;
        $minutes2 = $minutes2*60;
        $minutes2 =~ s/^(\d+)\.\d*/$1/g;
        $scan_time2 = sprintf "%2.4sh%2.2sm%2.2ss\n",$hours2,$minutes2,$secs2;

        return         ($falses,$start_time,$end_time,$api,$driver,$time_taken2,$scan_time2)
}
sub Not_ok(\$) {# reads engine log into report and puts results which are not "is ok" into hash containing anonymous arrays
        $log_to_read = $_[0];
        $strip = $_[1];
        print "reading file\t$log_to_read\n";
        %hashlog=();
        $/="\n";
        open (LOG, "$log_to_read") or $detloss = "I am very sorry but it seems that I am unable to open $log_to_read due to $!" and return ();
                while (<LOG>) {
                        $file='';
                        $id='';
                        $vir='';
                        # Change following two lines such that all of line up to colon is ignored (ie: handle lines with no drive letter:\
                         ($file, $id, $vir) = /^.*?($strip.+?),(.+)(\".*\")$/igms if /\".*\"/;
                        # ($file, $id, $vir) = /^.*?($strip.+?),(.+)$/igms unless /\".*\"/;#this is to match lines without vir names i.g. is o.k.
                        # Handle forward slashes
                         $file =~ s/\//\\/igms;
                        # Lowercase
                         $file = lc($file);

                        $tag = 0;
                         until (! exists $hashlog{$file}) {#check for duplicate file names with paths in zip, will append number.
                                $file =~ s/(.*)\d$/$1/igs if $tag;
                                $tag++;
                                $file .= $tag;
                        }
                        $hashlog{$file}=[$id, $vir] if $file;        # path\file is key, value is anon array of 'id' and 'v name'
                        #($start_time) = /Scan started at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4}).?\n/igms if /Scan Started/i;
                        ($start_time) = /Scan started at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4}).*/igms if /Scan Started/i;
                        ($api) =                /API version API:\s(.{5})\n/igms if /API version/i;
                        ($driver) =                /Driver version\s(\d{4})\n/igms if /Driver version/i;
                        ($end_time) =  /Scan completed at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4}).?\n/igms if /Scan completed/i;
                }
        close (LOG);
#        print "about to print hash\n";
#        foreach (keys %hashlog) {
#                print ;
#                print "\n";
#                last;
#        }
#        print "after printing hash\n";

return (\%hashlog,$start_time,$end_time,$api,$driver);
} # end of sub not_ok

sub Log_read(\$) {# reads engine log into report and puts results into hash containing anonymous arrays
        $log_to_read = $_[0];
        $strip = $_[1];
	$lvt_flag = $_[2];
        print "reading file\t$log_to_read\n";
        %hashlog=();
        $/="\n";
        $api='';
        $napi='';
	$lvt_nclean=0;
	$lvt_nInfected=0;
	$lvt_nNotRepaired=0;
	$lvt_nRepaired=0;
	$lvt_nDeleted=0;
	$lvt_nScanned=0;
	$lvt_nrenamed=0;
	$lvt_nquarantined=0;
	$lvt_nZerod=0;
	`mkdir -p /tmp/lvt-log/debug`;
        open (LOG, "$log_to_read") or $detloss = "Sorry I am unable to open $log_to_read due to $!" and return ($detloss);
        open (TLOG, ">/tmp/lvt-log/debug/test.log") or die "I am very sorry I am unable to open test.log due to $!";
        open (REP, ">/tmp/lvt-log/debug/Repaired.log") or die "I am very sorry I am unable to open Repaired.log due to $!";
        open (NREP, ">/tmp/lvt-log/debug/notRepaired.log") or die "I am very sorry I am unable to open notRepaired.log due to $!";
        open (DEL, ">/tmp/lvt-log/debug/Deleted.log") or die "I am very sorry I am unable to open Deleted.log due to $!";
        open (CLE, ">/tmp/lvt-log/debug/Clean.log") or die "I am very sorry I am unable to open Clean.log due to $!";
        open (nHIT, ">/tmp/lvt-log/debug/NormalHit.log") or die "I am very sorry I am unable to open Clean.log due to $!";
                while (<LOG>) {
                        $file='';
                        $id='';
                        $vir='';
                        $hit='';

                        # remove new line characters
                        chomp $_;

                        # remove <CR> characters (DOS)
                        if( ord(substr($_,-1)) eq "13" ) { chop $_ }


                         if (/\".*\"/) {
                                 #return ("$strip is not present in path in line $_") unless /$strip/i;
                                 ($file, $id, $vir) = /^.*?($strip.+?),(.+?)(\".*\".*)$/igms;# now picks up repair info
                                  #want to split id to get the hit type for 4180 logs
                                 if ($napi >= 909){#this is the api when log changed to include hit types
                                   ($id,$hit) = $id =~ /(found)(.+)/ig if $id =~ /found/i;
                                   ($id,$hit) = $id =~ /(is like)(.+)/i if $id =~ /is like/i;
                                   ($id,$hit) = $id =~ /(could be a new)(.+)/i if $id =~ /could be a new/i;
                                   if ($id =~ /normal hit/i and $vir =~ /".*?",.+\".*\"/i){ # bodge to fix stupid reporting of normal and hit on same line
					if($vir !~ /found/i){
                                            ($hit,$id,$vir = '') = $vir =~ /".*?",(.*?"),(.*?.)$/ig ;
			                        print nHIT "\nfile = $file\tid = $id\tHIT = $hit  \tvir = $vir" if $file;
					}
					else{
                                            ($hit,$id,$vir) = $vir =~ /".*?",(.*?"),(.+ .+)(\".*\".*)$/ig ;
                        			print nHIT "\nfile = $file\tid = $id\tHIT = $hit  \tvir = $vir" if $file;
					}	
                                   }
                                   #($hit="normal", $id = "is ok.",$vir ='') if $id =~ /normal hit/i and $vir !~ /found/i;
                                   ($hit="negative", $id = "is ok.",$vir = '' ) if $id =~ /negative hit/i;
                                                 #note to self - $hit will contain a trailing space
                                 }
                        }
                        else {
                                ($file, $id) = /^.*?($strip.+?), ?(.+)$/igms; # dir\dir\file.exe, is ok.
                                $vir = '';
                                chomp($id); # added for inc of detection
                        }
                        # Handle forward slashes
#                         $file =~ s/\//\\/igms;
                        # Lowercase
                         $file = lc($file);
                         $giri_file = $file;
                         chomp $vir ;

                        $tag = 0;
                         until (! exists $hashlog{$file}) {#check for duplicate file names with paths in zip, will append number.
#				print "File b4 tag - $file\n";
				if ( $tag ) { # Chekck if the file has previous tag
				    while ($giri_file ne $file) { # Remove the old tag before adding new
                                	$file =~ s/(.*)\d$/$1/igs;
#					print "----inside while-----";
#   					print "File in while - $file\n";
				    }
				}	
#				print "TAG b4 ++ - $tag\n";
                                $tag++;
#				print "TAG after ++ - $tag\n";
                                $file .= $tag;
#				print "File after tag - $file\n";
#				print "-----------------------\n";
                        }
			# Count the files depending on the detection and action taken
			if ($id =~ /found/ or $id =~ /is like/) { 
			    $lvt_nInfected++; 
			    $lvt_nScanned++;
#			    if ($vir =~ /negative hit/)	{
#				$lvt_negative++;
#			    }
			    if (($vir =~ /repaired./) and ($vir =~ /is ok/ or $vir =~ /repaired.$/)) {
			        $lvt_nRepaired++; 
                                print REP "\nFILE = $file ID = $id\tHIT = $hit   VIR = $vir" if $file;
  			    }
			    elsif (($vir =~ /renamed./) and ($vir =~ /is ok/ or $vir =~ /renamed.$/)) {
				$lvt_nrenamed++;
			    }	
			    elsif (($vir =~ /quarantined./) and ($vir =~ /is ok/ or $vir =~ /quarantined.$/)) {
				$lvt_nquarantined++;
			    }	
			    elsif ($vir =~ /moved.$/) {
				$lvt_nquarantined++;
			    }	
			    elsif ($vir =~ /deleted/) {
				$lvt_nDeleted++;
                            	print DEL "\nFILE = $file   ID = $id\tHIT = $hit     VIR = $vir" if $file;
			    }
			    else{
				$lvt_nNotRepaired++;
                            	print NREP "\nFILE = $file   ID = $id\tHIT = $hit     VIR = $vir" if $file;
			    }

			}
			elsif ($id =~ /is ok./) {
			    $lvt_nclean++;
			    $lvt_nScanned++;
                            print CLE "\nFILE = $file   ID = $id $hit     VIR = $vir" if $file;
			}
                        print TLOG "\nfile = $file\tid = $id\tHIT = $hit  \tvir = $vir" if $file;
                        $hashlog{$file}=[$id, $vir, $hit] if $file;        # path\file is key, value is anon array of 'id' and 'v name'
                        #($start_time) = /Scan started at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4})$/igms if /Scan Started/i;
                        ($start_time) = /Scan started at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4})/igms if /Scan Started/i;
                        # 4150-808 onwards introduced engine binary name into log:
                        # Scan started at: Mon Jun 04 15:09:35 2001
                        #
                        # API version (MCSCAN32.DLL - RELEASE) API: V8.08
                        # Driver version 4138
                        # Ensure compatability with previous log formats though.
                        # Add trapping of debug build API labels.
                        if (/API version \(/) {
                                ($binary, $api) = /API version \((.+?) .*?\)\s(.*)/igms;
                                $api =~ s/API\:\s//g;
                                $api =~ /V(\d+)\.(\d+)/;
                                $napi = $1.$2;

                        }
                        elsif (/API version/i) {
                                ($api) =                /API version API:\s(.{5})\n/igms;
                                $api =~ /V(\d+)\.(\d+)/;
                                $napi = $1.$2;
                                $binary = "n\/a   \t";
                        }
                        #($driver) =                /Driver version\s(\d{4})\n/igms if /Driver version/i;
                        #($end_time) =  /Scan completed at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4}).?\n/igms if /Scan completed/i;
                        if (/Driver version\s\d+\s\(/i) {    # with COMPILER VERSION: eg. Driver version 4145 (1.59)
                                ($driver, $comp) = /Driver version\s(\d+)\s\((\d\.\d\d)\)/igms;
                        }
                        elsif (/Driver version\s\d+/i) {                         # no COMPILER VERSION: eg. Driver version 4145
                                ($driver) = /Driver version\s(\d+)/igms;
                                $comp = "n\/a   \t";
                        }
                        if (/Scan completed/i) {
                                #($end_time) =  /Scan completed at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4}).?\n/igms;
                                ($end_time) =   /Scan completed at:\s(\w{3}\s\w{3}\s{1,2}\d{1,2}\s\d\d:\d\d:\d\d\s\d{4})/igms;
   #                             print "$end_time" . "\n";
                        }
                        elsif (/./) {     # Cope with no scan completed line
                              $end_time = "Mon Jan 01 01\:01\:01 2001";
                        }

                }

	print TLOG "\n\n NScanned= $lvt_nScanned\t Nclean= $lvt_nclean\t Ninfection= $lvt_nInfected\t Nrepaired= $lvt_nRepaired\t NnotRepaired= $lvt_nNotRepaired\t NDeleted = $lvt_nDeleted";
        close (nHIT);
        close (REP);
        close (NREP);
        close (DEL);
        close (CLE);
        close (LOG);
	close (TLOG);
	if ($lvt_flag) { # get the virex clean files number
	    $lvt_naclean = $lvt_nclean;
	    $lvt_naInfected = $lvt_nInfected;
	    $lvt_naNotRepaired = $lvt_nNotRepaired;
	    $lvt_naRepaired = $lvt_nRepaired;
	    $lvt_naDeleted = $lvt_nDeleted;
	    $lvt_naScanned = $lvt_nScanned;
	    $lvt_naRenamed = $lvt_nrenamed;
	    $lvt_naQuarantined = $lvt_nquarantined; 
	    `/bin/mv /tmp/lvt-log/debug /tmp/lvt-log/virex_log`;
#	    print "Total number virex of files clean = $lvt_nclean\n";
        }
	else{ 
	    $lvt_uvclean = $lvt_nclean;
	    $lvt_uvInfected = $lvt_nInfected;
	    $lvt_uvNotRepaired = $lvt_nNotRepaired;
	    $lvt_uvRepaired = $lvt_nRepaired;
	    $lvt_uvDeleted = $lvt_nDeleted;
	    $lvt_uvScanned = $lvt_nScanned;
	    $lvt_uvRenamed = $lvt_nrenamed;
	    $lvt_uvQuarantined = $lvt_nquarantined; 
	    `/bin/mv /tmp/lvt-log/debug /tmp/lvt-log/uvscan_log`;
#	   print "\nScanned: $lvt_uvScanned  Infected: $lvt_uvInfected Repaired: $lvt_uvRepaired Not Repaired: $lvt_uvNotRepaired Clean:  $lvt_nclean Deleted: $lvt_uvDeleted\n";
	 }
#        print "first hash entry:\t\n";
#        foreach (keys %hashlog) {
#                print ;
#                print "\n";
#                last;
#        }

return (\%hashlog,$start_time,$end_time,$api,$driver,$binary,$comp);
} # end of sub log_read

sub hash_diff() {
                $vercomp = 0;
                $reference = $_[0];
                $new = $_[1];
                $delim = $_[2];
                $appeared = '';
                $detloss = '';
                $decrease = '';
                $id = '';
                $vname = '';
                $both = '';
                $disappeared = '';
                $api1 =~ /V(\d\d)\.(\d\d)/;
                $napi1 = $1.$2;
                $api2 =~ /V(\d\d)\.(\d\d)/;
                $napi2 = $1.$2;
                $vercomp = 1 if ($napi1 < 909)and($napi2 < 909); # two pre 4180
                $vercomp = 2 if ($napi1 < 909) and ($napi2 >= 909); # old vs new
#		print "\nNAPI1 = $napi1\nNAPI2 = $napi2\n";
         if ($vercomp){
                  foreach $key (keys %$new) {
                           $$new{$key}->[0] =~ s/found/identified as/ig if ($vercomp == 2);
                           $$new{$key}->[0] =~ s/could be a new/heuristic find./ig if ($vercomp == 2);
                                 if (! exists $$reference{$key}) { # CASE 1 NEW FILE - 'APPEARED'
                                                 $appeared .= $key." $$new{$key}->[0] $$new{$key}->[1] appeared$delim";
                                 }
                                 else {# changed \n for = to go through socket
                                         # CASE 2 WAS INFECTED, NOW CLEAN - 'DETLOSS'
                                                 $detloss .= sprintf "%-s WAS %-15.15s %-15.30s NOW missed %-s$delim",$key,$$reference{$key}->[0],$$reference{$key}->[1],$$new{$key}->[0] if (($$reference{$key}->[1] =~ /\".+\"/) && (($$new{$key}->[0] =~ /is ok/) || ($$new{$key}->[0] =~ /zero/) || ($$new{$key}->[0] =~ /not scanned/)));
                                         # CASE 3 DECREASE IN DETECTION
                                                 $decrease .= sprintf "%-s WAS %-15.15s %-15.30s NOW %-15.15s %-15.30s$delim",$key,$$reference{$key}->[0],$$reference{$key}->[1],$$new{$key}->[0],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".*\"/) && ($$new{$key}->[0] !~ /identified/) && ($$reference{$key}->[0] =~ /identified/));
                                         # CASE 4 SAME V NAME, CHANGE IN ID - 'ID'
                                                 $id .= sprintf "%-s WAS %-s %-s NOW %-s %-s$delim",$key,$$reference{$key}->[0],$$reference{$key}->[1],$$new{$key}->[0],$$new{$key}->[1] if (($$new{$key}->[0] ne $$reference{$key}->[0]) && ($$new{$key}->[1] eq $$reference{$key}->[1]));
                                         # CASE 5 SAME ID, DIFF V NAME - 'VNAME'
                                                 $vname .= sprintf "%-s WAS %-s NOW %-s$delim" ,$key,$$reference{$key}->[1],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".+\"/) and ($$new{$key}->[0] eq $$reference{$key}->[0]) and ($$new{$key}->[1] ne $$reference{$key}->[1]));
                                         # CASE 6 BOTH ID and VNAME CHANGED - 'BOTH'
                                                 $both .= sprintf "%-s WAS %-s %-s NOW %-s %-s$delim" ,$key,$$reference{$key}->[0],$$reference{$key}->[1],$$new{$key}->[0],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".*\"/) and ($$new{$key}->[0] ne $$reference{$key}->[0]) and ($$new{$key}->[1] ne $$reference{$key}->[1]));                        }
                  }
                  foreach $key (keys %$reference) {
                                 if (! exists $$new{$key}) {                                                                # CASE 7 FILE FONE - 'DISAPPEARED'
                                                 $disappeared .= $key." $$reference{$key}->[0] $$reference{$key}->[1] disappeared$delim";
                                 }
                 }
         }
         else{
                 foreach $key (keys %$new) {
                                 if (! exists $$reference{$key}) {                                                # CASE 1 NEW FILE - 'APPEARED'
                                                 $appeared .= $key." $$new{$key}->[0] $$new{$key}->[1] appeared$delim";
                                 }
                                 else {# changed \n for = to go through socket
                                         # CASE 2 WAS INFECTED, NOW CLEAN - 'DETLOSS'
                                                 $detloss .= sprintf "%-s WAS %-15.15s %-15.30s NOW missed$delim",$key,$$reference{$key}->[0],$$reference{$key}->[1] if (($$reference{$key}->[1] =~ /\".+\"/) && (($$new{$key}->[0] =~ /is ok/) || ($$new{$key}->[0] =~ /zero/) || ($$new{$key}->[0] =~ /not scanned/)));
                                         # CASE 3 DECREASE IN DETECTION
                                                 $decrease .= sprintf "%-s WAS %-15.15s %-15.30s NOW %-15.15s %-15.30s$delim",$key,$$reference{$key}->[0],$$reference{$key}->[1],$$new{$key}->[0],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".*\"/) && ($$new{$key}->[0] !~ /found/) && ($$reference{$key}->[0] =~ /found/));
                                         # CASE 4 SAME V NAME, CHANGE IN ID - 'ID'
                                                 $id .= sprintf "%-s WAS %-s %-s NOW %-s %-s$delim",$key,$$reference{$key}->[0].$$reference{$key}->[2],$$reference{$key}->[1],$$new{$key}->[0].$$new{$key}->[2],$$new{$key}->[1] if (($$new{$key}->[0].$$new{$key}->[2] ne $$reference{$key}->[0].$$reference{$key}->[2]) && ($$new{$key}->[1] eq $$reference{$key}->[1]));
                                         # CASE 5 SAME ID, DIFF V NAME - 'VNAME'
                                                 $vname .= sprintf "%-s WAS %-s NOW %-s$delim" ,$key,$$reference{$key}->[1],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".+\"/) and ($$new{$key}->[0].$$new{$key}->[2] eq $$reference{$key}->[0].$$reference{$key}->[2]) and ($$new{$key}->[1] ne $$reference{$key}->[1]));
                                         # CASE 6 BOTH ID and VNAME CHANGED - 'BOTH'
                                                 $both .= sprintf "%-s WAS %-s %-s NOW %-s %-s$delim" ,$key,$$reference{$key}->[0].$$reference{$key}->[2],$$reference{$key}->[1],$$new{$key}->[0].$$new{$key}->[2],$$new{$key}->[1] if (($$new{$key}->[1] =~ /\".*\"/) and ($$new{$key}->[0].$$new{$key}->[2] ne $$reference{$key}->[0].$$reference{$key}->[2]) and ($$new{$key}->[1] ne $$reference{$key}->[1]));                        }
                 }
                 foreach $key (keys %$reference) {
                                 if (! exists $$new{$key}) {                                                                # CASE 7 FILE FONE - 'DISAPPEARED'
                                                 $disappeared .= $key." $$reference{$key}->[0] $$reference{$key}->[1] disappeared$delim";
                                 }
                 }

         }
        return ($detloss,$decrease);
} # end of hash_diff sub

sub scantime {#nicked from joel

  use Time::Local;

  %dayhash = ( "Sun" => "0",
               "Mon" => "1",
               "Tue" => "2",
               "Wed" => "3",
               "Thu" => "4",
               "Fri" => "5",
               "Sat" => "6");

  %monhash = ( "Jan" => "0",
               "Feb" => "1",
               "Mar" => "2",
               "Apr" => "3",
               "May" => "4",
               "Jun" => "5",
               "Jul" => "6",
               "Aug" => "7",
               "Sep" => "8",
               "Oct" => "9",
               "Nov" => "10",
               "Dec" => "11" );

  ($wday,$mon,$mday,$hour,$min,$sec,$year) = split /:|\s{1,}/, $_[0], 7;

  $wday = $dayhash{$wday};
  $mon  = $monhash{$mon};
  $year -= 1900;
  $time = timegm($sec,$min,$hour,$mday,$mon,$year);
  return $time;

}#scantime

1; # "True"
