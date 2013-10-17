#!/usr/bin/perl
use lib qw(..);
#use strict;
#use warnings;
use Win32::NetResource;
use Socket;
use Sys::Hostname;
use threads;
use threads::shared;
use Net::Ping;
use IPC::Open3;
use POSIX ":sys_wait_h";
use WANScaler::CIFSLibrary;
use WANScaler::CIFSConfig ;
use Cwd;
use Win32::OLE qw(in with);
use Win32::OLE::Const 'Microsoft Word';

BEGIN {
#	print WANScaler::CIFSConfig::SHARE_COUNT;
}

# variables used as constants
my $fourth_octet = $machine_start_address;
my $lock_var   : shared;
my $unmap_lock : shared;
my $think_time : shared;

BEGIN {
	-e INPUT_FILE_NAME or die " input file ".INPUT_FILE_NAME." missing.\n";
}

my $local_ip = get_local_ip();
my @threads = undef;
my $ip_address;


for(my $i = START_INDEX;$i < END_INDEX; $i++ ) {
	for(my $j = 0;$j<SHARE_COUNT;$j++) {
#		my $file_names      = get_file_names(($i - START_INDEX)*SHARE_COUNT+$j);
		$ip_address			= $network_address.$third_octet.".".$fourth_octet;
        $third_octet = $third_octet+1 if $fourth_octet == 240;
        $fourth_octet = ($fourth_octet == 240 ?$machine_start_address:$fourth_octet + 1);
		my $session_options = {'server_address' 		=> $ip_address,
							   'share_index'	    	=> $i,
							   'large_file_dir_name' 	=> \*LARGE_FILES_DIR,
							   'small_file_dir_name'	=> \*SMALL_FILES_DIR,
							   'browse_dir_name'		=> \*BROWSE_DIR,
							   'document_name'  		=> $file_names->{'document_name'},
							   'spreadsheet_name'		=> $file_names->{'spreadsheet_name'},
							   'presentation_name'		=> $file_names->{ 'presentation_name'},
# 							   'drive_letter'   => chr(ord(START_DRIVE_LETTER)+(($i - START_INDEX)*SHARE_COUNT+$j)),
							  };

		$threads[($i - START_INDEX) * SHARE_COUNT + $j] = threads->new(\&cifs_session, $session_options,$i."_".$j.".log",$i * SHARE_COUNT+$j);
        sleep(2);
	}
}

foreach (@threads) {
	$_->join();
    logwrite(\*STDOUT,' One thread joined');
}


sub cifs_session {
	my $session_options = shift;
    my $log_file_name = shift;
    local $index = shift;

	local $log_file_handle;
	open($log_file_handle,">$log_file_name");

    my $server_address 		= $session_options->{'server_address'};
    my $drive_letter   		= $session_options->{'drive_letter'};
#    my $seed_value 	   	= $session_options->{'seed_value'};
    my $large_file_dir_name	= $session_options->{'large_file_dir_name'};
    my $small_file_dir_name	= $session_options->{'small_file_dir_name'};
    my $browse_dir_name		= $session_options->{'browse_dir_name'};
    my $presentation_name 	= $session_options->{'presentation_name'};
    my $sheet_name			= $session_options->{'spreadsheet_name'};
    my $document_name 		= $session_options->{'document_name'};

	my $file_name			= "LargeFile.dat";
    my $local_path 		    = '.\\Payload';
    my $local_file 			= 'LargeFile.dat';

	my $document_path		= "Office".($index % SHARE_COUNT)."\\";
    my $new_document_name 	= "new_".$document_name;
    my $new_spreadsheet_name= "new_".$sheet_name;
    my $new_presentation_name="new_".$presentation_name;
    my $o_index 		    = int ($index/SHARE_COUNT);
    my $share_path 	   		= "CIFS_Share".$o_index;
    my $avg_pause_time = undef;

	local $log_prefix = $server_address."-".$share_path."-";
	my $time = undef;

    #initialize the random number generator
	logwrite($log_file_handle,$log_prefix."Initializing random number generator with seed value - ".($index+1));
    srand($index+1);

	my $server_root = undef;
    my $word 		= undef;
    my $excel 		= undef;
    my $powerpoint 	= undef;

	while(1) {
		# Open the Think Time file
	    open(FH,INPUT_FILE_NAME);
        {
        	lock($think_time);
            $think_time = readline(FH);
        }
		close(FH);
        logwrite($log_file_handle,$log_prefix."Think time changed to".$think_time);

    	if($drive_letter) {
	        logwrite($log_file_handle,$log_prefix."Mapping to drive letter $drive_letter");
            my $r_d;
            do {
            	$r_d = `route delete $server_address  2>&1`;
                chomp $r_d;
            } until ($r_d eq 'The route specified was not found.');

	        unmap_drive($drive_letter);
	        map_drive($drive_letter,$server_address,$share_path) or logwrite($log_file_handle,"Unable to map the drive: $err_msg"), return;
	        $server_root = $drive_letter.":\\";
	    } else {
    	#use UNC path
	        logwrite($log_file_handle,$log_prefix."Using UNC Path.");
	        $server_root  = '\\\\'.$server_address."\\".$share_path."\\";
	    }
      	logwrite($log_file_handle,$log_prefix."Root of server machine is :".$server_root);
	    do {
	        # Copy a large file from remote to local
	        if(!skip()) {
	            random_pause($avg_pause_time);
	            my $source_path = $server_root.$large_file_dir_name."\\" ;
				logwrite($log_file_handle,$log_prefix."Large file copy - ".$source_path.$file_name);
	            $time = copy_file($source_path,$file_name);    #if dest not specified copy to NUL:
				if($time == 0 && $err_msg) {
					logwrite($log_file_handle,$log_prefix."Large file copy operation failed : ".$err_msg);
				} else {
					logwrite($log_file_handle,$log_prefix."Large file copy operation took $time Seconds");
				}
	        } else {
				logwrite($log_file_handle,$log_prefix."Skipped Large file copy operation");
			}

			$time = undef;
	        #Copy a directory from remote to local
	        if(!skip()) {
	            random_pause($avg_pause_time);
   	            my $source_path = $server_root."SmallFiles";
				logwrite($log_file_handle,$log_prefix."Directory copy - ".$source_path);
	            my $ret = copy_directory($source_path);
                $time = $ret->{'time'};
                my $out = $ret->{'out'};
#				delete_directory(".\\".$index);
				if($time and $time == 0 and $err_msg) {
					logwrite($log_file_handle,$log_prefix."Directory copy operation failed : ".$out);
				} else {
					logwrite($log_file_handle,$log_prefix."Directory copy took $time Seconds.");
				}
	        } else {
				logwrite($log_file_handle,$log_prefix."Skipped Directory copy operation");
			}

	        #copy large file from local to remote
			$time = undef;
	        if(!skip()) {
	            random_pause($avg_pause_time);
	            my $remote_file = $local_file;
				logwrite($log_file_handle,$log_prefix."Creating Write Semaphore");
   			    {  #start new block
					lock($lock_var);
                    $lock_var = $index unless defined($lock_var);
                }
                 if($lock_var and $lock_var == $index) {
                    logwrite($log_file_handle,$log_prefix.'Now writing to remote');
					$time = copy_file($local_path."\\",$local_file,$server_root,$remote_file); # v1.3
					if($time and $time == 0 and $err_msg) {
						logwrite($log_file_handle,$log_prefix."Local to remote copy failed :".$err_msg);
					} else {
						logwrite($log_file_handle,$log_prefix."Local to remote large file copy operation took $time seconds.");
					}
					unlink ($server_root,$remote_file); # v1.3
                    {
                    	lock($lock_var);
                        $lock_var = undef if $lock_var == $index;
                    }
                } else {
                	logwrite($log_file_handle,$log_prefix."Skipped local to remote write as lock is not available");
                }
				logwrite($log_file_handle,$log_prefix."Deleted write semaphore");
	        } else {
				logwrite($log_file_handle,$log_prefix."Skipped Local to remote large file copy operation");
			}

			#Directory Browsing
			$time = undef;
			if (!skip()) {
				random_pause($avg_pause_time);
				$time = browse_directory($server_root.$browse_dir_name);
				logwrite($log_file_handle,$log_prefix."Directory browsing took $time Seconds");
			} else {
				logwrite($log_file_handle,$log_prefix."Skipped directory browsing");
			}

   		 	if(office_skip() == 0) {
	            #Open - Update - Save - Delete word Document
	            $time = undef;
				if($index == 0 or $index == 1) {
	                random_pause($avg_pause_time);
	                logwrite($log_file_handle,$log_prefix."Opening Microsoft Word document $server_root$document_path$document_name.");
	                my $w = open_document($server_root.$document_path.$document_name);
                    $word = $w->{'Application'};
                    my $document = $w->{'Document'};
	                if(!skip() and $word and $document) {
	                    random_pause($avg_pause_time);
	                    logwrite($log_file_handle,$log_prefix."Updating word document $document_name");
	                    update_document($word);
                        if (!skip()) {
	                        logwrite($log_file_handle,$log_prefix."Saving $document_name as $new_document_name");
	                        save_document_as($document,$server_root.$document_path.$new_document_name);
		                    logwrite($log_file_handle,$log_prefix."Deleting $new_document_name");
		                    delete_file($document_path.$new_document_name); #use unlink instead
                        }
	                }
                    logwrite($log_file_handle,$log_prefix."Closing word document.");
	               close_document($document,$word);
#                   $word->Quit;
                   $word = undef;
	            }

	            #Open - Update - Save - Delete Excel SpreadSheet
	            $time = undef;

				if($index == 2 or $index == 3) {
	                random_pause($avg_pause_time);
	                logwrite($log_file_handle,$log_prefix."Opening Microsoft Excel spreadsheet $sheet_name.");
	                my $s = open_spreadsheet($server_root.$document_path.$sheet_name);
                    my $spreadsheet = $s->{'Spreadsheet'};
                    $excel = $s->{'Application'};
	                logwrite($log_file_handle,$log_prefix."Undefined handle returned by excel :") unless $spreadsheet;
	                if(!skip() and $spreadsheet) {
	                    random_pause($avg_pause_time);
	                    logwrite($log_file_handle,$log_prefix."Updating spreadhseet $sheet_name");
#                       update_spreadsheet($excel);
                        if(!skip()) {
	                        logwrite($log_file_handle,$log_prefix."Saving $sheet_name as $new_spreadsheet_name");
	                        save_spreadsheet_as($spreadsheet,$server_root.$document_path.$new_spreadsheet_name);
                    	}
	                    logwrite($log_file_handle,$log_prefix."Deleting $new_spreadsheet_name");
	                    delete_file($document_path.$new_spreadsheet_name); #use unlink instead
	                }
                    logwrite($log_file_handle,$log_prefix."Closing spreadsheet.");
	                close_spreadsheet($spreadsheet);
                    $excel->Quit;
	            }

	             #Open - Update - Save - Delete Excel SpreadSheet
	             $time = undef;
  				 if($index == 4 or $index == 5) {
	                random_pause($avg_pause_time);
	                logwrite($log_file_handle,$log_prefix."Opening Microsoft Powerpoint  $presentation_name.");
	                my $presentation = open_presentation($server_root.$document_path.$presentation_name);
	                if(!skip()) {
	                    random_pause($avg_pause_time);
	                    logwrite($log_file_handle,$log_prefix."Updating Powerpoint presentation $presentation_name");
	                    update_presentation($presentation);
	                    logwrite($log_file_handle,$log_prefix."Saving $presentation_name as $new_presentation_name");
	                    save_presentation_as($presentation,$server_root.$document_path.$new_presentation_name);
	                    logwrite($log_file_handle,$log_prefix."Deleting $new_presentation_name");
	                    delete_file($document_path.$new_presentation_name); #use unlink instead
	                }
	#               close_presentation($presentation);
	            }
    		}
	    } while (session_continue() != 0) ;
		logwrite($log_file_handle,$log_prefix."Discontinued the session");
        logwrite($log_file_handle,$log_prefix." Disconnecting TCP connection");
        if($drive_letter) {
            logwrite($log_file_handle,$log_prefix."Unmapping the drive $drive_letter");
            unmap_drive($drive_letter);
        }
        logwrite($log_file_handle,$log_prefix."Killing the active connection");
        kill_tcp_connection($server_address,$share_path,$drive_letter);
	}
	# NEVER COME HERE
	close($log_file_handle);
}
sub kill_tcp_connection {
	my ($server_address,$share_path,$drive_letter) = @_;
	my $d_l =  ($drive_letter) ? $drive_letter: chr(ord(START_DRIVE_LETTER)+($index));
	# add a fake route
	my $res = route_add($server_address);

    if($res->{'error'}) {
    	# Route add fails here
        # must not come here
    } else {
 		logwrite($log_file_handle,$log_prefix."Route added to $server_address".$res->{'out'});
        # map the drive to FAIL mapping
		logwrite($log_file_handle,$log_prefix."Mapping successful.\nAdding Route didn't had desired effect.\n"), return if map_drive($d_l,$server_address,$share_path);
    	# delete the fake route
	    my $r_d;
		do {
			$r_d = route_delete($server_address);
            chomp($r_d->{'error'});
		} while ($r_d->{'error'} eq 'The route specified was not found');

	    logwrite($log_file_handle,$log_prefix."Route Deleted".$res->{'error'});
	    my @rt = `route print 2>&1`;

    	logwrite($log_file_handle,join('',@rt));

	    logwrite($log_file_handle,$log_prefix.'deleting '.$server_address);
		if ( (my $unmap_res = unmap_drive($d_l)) == 0) {
           logwrite($log_file_handle,$log_prefix."Deletion failed : $err_code - $err_msg");
        } else {
        	logwrite($log_file_handle,$log_prefix."Deleted successfully.");
        }
	    do {
	        sleep(2);
	        logwrite($log_file_handle,$log_prefix."Trying to  connect to \\\\$server_address\\$share_path");
            logwrite($log_file_handle,$log_prefix.$err_code." - ".$err_msg) if $err_code and $err_msg;
	    } until(map_drive($d_l,$server_address,$share_path)) ;

	    logwrite($log_file_handle,$log_prefix.'deleting '.$server_address);

        $unmap_res = undef;
		if ( (my $unmap_res = unmap_drive($d_l)) == 0) {
           logwrite($log_file_handle,$log_prefix."Deletion failed : $err_code - $err_msg");
        } else {
        	logwrite($log_file_handle,$log_prefix."Deleted successfully.");
        }
	}
}

sub route_add {
	my $ip = shift;
    my $res = undef;
    my ($out,$err );
 	my $pid = open3(\*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR,'route','add',$ip, 'MASK', '255.255.255.255',$n_e_gateway);

	while((sysread(CHLD_OUT,$out,80)) != 0) {
		$res->{'out'} = $res->{'out'}.$out;
	}

	while(sysread(CHLD_ERR,$err,80)!=0) {
		$res->{'error'} = $res->{'error'}.$err;
	}
	my	$kid = waitpid($pid, WNOHANG);
  	return $res;
}

sub route_delete {
	my $ip = shift;
    my $res = undef;
    my $out;
    my $err;
 	my $pid = open3(\*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR,'route','delete',$ip);

	while((sysread(CHLD_OUT,$out,80)) != 0) {
		$res->{'out'} = $res->{'out'}.$out;
	}

	while(sysread(CHLD_ERR,$err,80)!=0) {
		$res->{'error'} = $res->{'error'}.$err;
	}

	my	$kid = waitpid($pid, WNOHANG);
  	return $res;
}

sub skip {
    return int rand(2);
}
sub office_skip {

	return 1; # comment this when you want office operations
	my $o_s = $index <= 5 ? 0 : 1;
    logwrite($log_file_handle,$log_prefix."Skipping office operations") if $o_s == 0;
    return $o_s;
#	return 1; # v1.4
}
sub random_pause {
	my ($avg_pause_time) = @_;
	my $sleep_time = int rand(2*$think_time);
	logwrite($log_file_handle,$log_prefix."Sleeping for $sleep_time Seconds");
    sleep($sleep_time);
}

sub get_file_names {
	my ($index) = @_;
	my $file_names = {};
	$file_names->{'file_name'} = 'Test.dat';
	$file_names->{'document_name'} = $index.'.doc';
	$file_names->{'spreadsheet_name'} = $index.'.xls';
	$file_names->{ 'presentation_name'} = $index.'.ppt';
	return $file_names;
}
sub logwrite {
	my($file_handle,$msg) = @_;
	my $time = get_date_time();
	syswrite($file_handle,$local_ip."-".$time."-".$msg."\n");
}
sub get_local_ip {
	my $addr = gethostbyname(hostname());
	my ($name,$aliases,$addrtype,$length,@addrs)= gethostbyname(hostname());
	return join('.',unpack('C4',$addrs[0]));
}
sub get_date_time {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	return  sprintf "%2d/%02d/%4d %2d:%2d:%2d",$mday,$mon,$year+1900,$hour,$min,$sec;
}
sub session_continue {
	return int rand 100;
#	return 1;
}

sub open_document {
	my ($document) = @_;
	my $word = Win32::OLE->new('Word.Application', 'Quit') or
              die $!;
  	$word->{'Visible'} = 1;
	$word->{DisplayAlerts}=0;
	my $wd = $word->Documents->Open($document);
    sleep(1);
    my $w = {'Application' => $word, 'Document' => $wd};
	return $w;
}
sub update_document {
	my ($word) = @_;
    $word->Selection->TypeText(' Testing with the testing text if the test, which tests whether writing test into remote word document succeeds ');
}

sub close_document {
	my $document = shift;
    my $word = shift;
   	my $wd = Win32::OLE::Const->Load($word);
	$document->Close( { SaveChanges => $wd->{wdDoNotSaveChanges} } );
}

sub open_spreadsheet {
	my ($sheet) = @_;
    my $spreadsheet = Win32::OLE->new('Excel.Application', 'Quit') or die $!;
  	$spreadsheet->{'Visible'} = 1;
	$spreadsheet->{DisplayAlerts}=0;
	my $ss = $spreadsheet->Workbooks->Open($sheet);
    sleep(1);
    my $s = {'Application'=>$spreadsheet,'Spreadsheet' => $ss}  ;
	return $s;
}

sub update_spreadsheet {
	my ($spreadsheet) = @_;

	# TODO
	$spreadsheet->Cells(1,2)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);
	$spreadsheet->Cells(2,2)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);
    $spreadsheet->Cells(1,3)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);
	$spreadsheet->Cells(2,3)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);
    $spreadsheet->Cells(1,6)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);
	$spreadsheet->Cells(2,6)->{'Value'} = int rand 100 if $spreadsheet;    sleep(2);

}
sub update_presentation {
	my ($presentation) = @_;
	#TODO
}
sub close_spreadsheet {
	my ($spreadsheet) = @_;
	$spreadsheet->Quit if $spreadsheet;
}
sub close_presentation {
	my $presentation = shift;
	$presentation->Quit if $presentation;
}
sub save_document_as {
	my ($document,$new_name) = @_;
    $document->SaveAs($new_name);
}
sub save_presentation_as {
	my ($presentation,$new_name) = @_;
    $presentation->SaveAs($new_name) if $presentation;
}
sub save_spreadsheet_as {
	my ($spreadsheet,$new_name) = @_;
    $spreadsheet->SaveAs($new_name);
}

sub open_presentation {
	my ($presentation) = @_;
	my $ppt_app =# Win32::OLE->GetActiveObject('PowerPoint.Application')
	              Win32::OLE->new('PowerPoint.Application', 'Quit')
                 or die $!;
	$ppt_app->{Visible} = 1;
	$ppt_app->{DisplayAlerts}=0;
	my $ppt = $ppt_app->Presentations->Open({FileName=>$presentation});
	sleep(4);
    return $ppt;
}
sub delete_directory {
	my $directory = shift;
	print `del $directory /Q`;
	rmdir $directory;
}