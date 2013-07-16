#!/usr/bin/perl -w
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision:  $
# Last Modified: $Date:  $
# Modified By:   $Author:  $
# Source:        $Source:  $
#
####################################################################################
##
##

# NOTE:
# The following is a list of the different types of statistics that can be captured
# for performance monitoring. To capture the appropriate stats, you need to verify
# which stat type that you would like collected. These options are defined in the 
# configuration INI file.
#
#   1.  Processor Statistics - Windows / Linux
#   2.  Memory Statistics    - Windows / Linux
#   3.  Page/Swap Statistics - Linux
#   4.  Network Statistics   - Windows / Linux
#   5.  Socket Statistics    - Linux
#   6.  Disk Statistics      - Linux
#   7.  Disk Usage           - Linux
#   8.  Load Average         - Linux
#   9.  File Statistics      - Linux
#   10. Processes            - Linux
#   11. Database Statistics  - Windows / Linux
#   12. System Info          - Linux
#
# Different metrics are captured for Windows versus Linux. The difference between these
# types are explained in more detail within the Metrics.pm module.
#

####################################################################################


BEGIN {
    $_ = ($^O =~ /MSWin32/) ? "C:/AppLabs/AppTool/Library/Perl-Lib" : "/opt/AppLabs/AppTool/Library/Perl-Lib/";
    push @INC, $_;
}



package Config;


use Config::IniFiles;
use Spreadsheet::BasicRead;   # Requirement (install from CPAN)

# -----------------------------------------------------------
# FUNCTIONS:
# -----------------------------------------------------------

#
# new() - Object constructor
# Input: - Nothing
# Output - Object for global configurations to environment
sub new {
    
    my $opersys = $^O;
    
    my $tool_path    = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\" : "/opt/AppLabs/AppTool/";
    my $log_path     = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\Logs\\" : "/opt/AppLabs/AppTool/Logs/";
    my $results_path = ($opersys =~ /MSWin32/) ? "C:\\Inetpub\\wwwroot\\apptool\\results\\" : "/opt/AppLabs/AppTool/Interface/apptool/results/";
    my $sql_path     = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\Library\\Sql-Lib\\" : "/opt/AppLabs/AppTool/Library/Sql-Lib/";
    my $lib_path     = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\Library\\" : "/opt/AppLabs/AppTool/Library/";
    my $config_path  = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\Config\\" : "/opt/AppLabs/AppTool/Config/";
    my $agent_path   = ($opersys =~ /MSWin32/) ? "C:\\AppLabs\\AppTool\\Agent\\" : "/opt/AppLabs/AppTool/Agent/";
    my $test_config_path   = ($opersys =~ /MSWin32/) ? "C:\\Project\\SciLearn\\" : "/opt/Project/SciLearn/";
    my $test_scenario_path = ($opersys =~ /MSWin32/) ? "C:\\Project\\SciLearn\\Scenarios\\" : "/opt/Project/SciLearn/Scenarios/";
    my $test_results_path  = ($opersys =~ /MSWin32/) ? "C:\\Project\\SciLearn\\Results\\" : "/opt/Project/SciLearn/Results/";
    my $config_xls   = $config_path . "config.xls";
    
    # Fetch our configuration INI values
    my $config_ini = $config_path . "config.ini";
    my $cfg = new Config::IniFiles( -file => $config_ini );
    
    # Define our global config values based upon what was found in the INI file.
    my $interval         = parseValue( $cfg->val( 'GLOBAL', 'INTERVAL' ) );
    my $test_time_length = parseValue( $cfg->val( 'GLOBAL', 'TEST_TIME_LENGTH' ) );
    my $db_driver        = parseValue( $cfg->val( 'DATABASE', 'DB_DRIVER' ) );
    my $db_server        = parseValue( $cfg->val( 'DATABASE', 'DB_SERVER' ) );
    my $db_name          = parseValue( $cfg->val( 'DATABASE', 'DB_NAME' ) );
    my $db_user          = parseValue( $cfg->val( 'DATABASE', 'DB_USER' ) );
    my $db_password      = parseValue( $cfg->val( 'DATABASE', 'DB_PASSWORD' ) );
    my $collect_cpu_stats       = parseValue( $cfg->val( 'METRICS', 'CPU_STATS' ) );
    my $collect_memory_stats    = parseValue( $cfg->val( 'METRICS', 'MEMORY_STATS' ) );
    my $collect_page_swap_stats = parseValue( $cfg->val( 'METRICS', 'PAGE_SWAP_STATS' ) );
    my $collect_network_stats   = parseValue( $cfg->val( 'METRICS', 'NETWORK_STATS' ) );
    my $collect_socket_stats    = parseValue( $cfg->val( 'METRICS', 'SOCKET_STATS' ) );
    my $collect_disk_stats      = parseValue( $cfg->val( 'METRICS', 'DISK_STATS' ) );
    my $collect_disk_usage      = parseValue( $cfg->val( 'METRICS', 'DISK_USAGE' ) );
    my $collect_load_avg        = parseValue( $cfg->val( 'METRICS', 'LOAD_AVG' ) );
    my $collect_file_stats      = parseValue( $cfg->val( 'METRICS', 'FILE_STATS' ) );
    my $collect_processes       = parseValue( $cfg->val( 'METRICS', 'PROCESSES' ) );
    my $collect_process_util    = parseValue( $cfg->val( 'METRICS', 'PROCESS_UTIL' ) );
    my $collect_processor_stats = parseValue( $cfg->val( 'METRICS', 'PROCESSOR_STATS' ) );
    my $processes = getWorksheetData($config_xls,"Processes");
    
    
    my $CONFIG = {
        "OS"                    => $opersys,                                  # Current operating system (MSWin32 / linux)
        "TOOL_PATH"             => $tool_path,
        "LOG_PATH"              => $log_path,
        "RESULTS_PATH"          => $results_path,
        "SQL_PATH"              => $sql_path,
        "LIB_PATH"              => $lib_path,
        "CONFIG_PATH"           => $config_path,
        "AGENT_PATH"            => $agent_path,
        "TEST_CONFIG_PATH"      => $test_config_path,
        "TEST_SCENARIO_PATH"    => $test_scenario_path,
        "TEST_RESULTS_PATH"     => $test_results_path,
        "DEBUG"                 => 1,                                         # Debugging mode (1=on / 0=off)
        "LOG"                   => 1,                                         # Logging mode (1=on / 0=off)
        "LOG_FILE"              => "history.log",
        "EVENT_LOG"             => "event.log",                               # Logs events that occur during the testing process
        "INTERVAL"              => $interval,                                 # Interval time of capturing performance metrics (seconds)
        "TEST_TIME_LENGTH"      => $test_time_length,
        "TIMEOUT"               => 3600,
        "DB_DRIVER"             => $db_driver,                                # Database driver (db2, mysql, mysqli, oracle, postgres)
        "DB_SERVER"             => $db_server,
        "DB_USER"               => $db_user,
        "DB_PASSWORD"           => $db_password,
        "DB_NAME"               => $db_name,
        "CONSOLIDATE"           => 0,                                         # Determines whether metrics should be consolidated or not (1=on / 0=off)
        "METRICS_FILE"          => "metrics.xls",                             # Consolidated metrics file. Each metric type is represented as a separate worksheet
        "CPU_STATS"             => {                                          # Processor statistics (1=on / 0=off)
            "COLLECT"           => $collect_cpu_stats,
            "FILE"              => "cpustat.csv"
        },
        "MEMORY_STATS"          => {                                          # Memory statistics (1=on / 0=off)
            "COLLECT"           => $collect_memory_stats,
            "FILE"              => "memory.csv"
        },
        "PAGE_SWAP_STATS"       => {                                          # Page/Swap statistics (1=on / 0=off)
            "COLLECT"           => $collect_page_swap_stats,
            "FILE"              => "pageswap.csv"
        },
        "NETWORK_STATS"         => {                                          # Network statistics (1=on / 0=off)
            "COLLECT"           => $collect_network_stats,
            "FILE"              => "netstat.csv"
        },
        "SOCKET_STATS"          => {                                          # Socket statistics (1=on / 0=off)
            "COLLECT"           => $collect_socket_stats,
            "FILE"              => "socket.csv"
        },
        "DISK_STATS"            => {                                          # Disk statistics (1=on / 0=off)
            "COLLECT"           => $collect_disk_stats,
            "FILE"              => "disk.csv"
        },
        "DISK_USAGE"            => {                                          # Disk usage statistics (1=on / 0=off)
            "COLLECT"           => $collect_disk_usage,
            "FILE"              => "diskusage.csv"
        },
        "LOAD_AVG"              => {                                          # Load average statistics (1=on / 0=off)
            "COLLECT"           => $collect_load_avg,
            "FILE"              => "loadavg.csv"
        },
        "FILE_STATS"            => {                                          # File statistics (1=on / 0=off)
            "COLLECT"           => $collect_file_stats,
            "FILE"              => "filestat.csv"
        },
        "PROCESSES"             => {                                          # Process statistics (1=on / 0=off)
            "COLLECT"           => $collect_processes,
            "FILE"              => "process.csv",
            "LIST"              => $processes
        },
        "PROCESS_UTIL"          => {                                          # Process utilization statistics (1=on / 0=off)
            "COLLECT"           => $collect_process_util,
            "FILE"              => "utilization.csv",
            "LIST"              => $processes
        },
        "PROCESSOR_STATS"       => {                                          # Processor statistics and CPU times (per processor) (1=on / 0=off)
            "COLLECT"           => $collect_processor_stats,
            "FILE"              => "procstat.csv"
        },
        "DATABASE_STATS"        => {                                          # Database statistics (1=on / 0=off)
            "COLLECT"           => 0,
            "FILE"              => "database.csv",
        },
        "SYSTEM_INFO"           => {                                          # System information (1=on / 0=off)
            "COLLECT"           => 0,
            "FILE"              => "sysinfo.csv"
        }
    };
    
    bless $CONFIG, 'Config';   # Tag object with pkg name
    return $CONFIG;
}

#
# getWorksheetData() - Get a list of all data based upon the given worksheet
# Input:  $config_xls - String containing the file name of our configuration spreadsheet
#         $worksheetName - String containing the name of the worksheet we want to capture data for
# Output: Array containing a list of all data for the given worksheet
sub getWorksheetData {
    my $config_xls = shift;
    my $worksheetName = shift;
    
    # Make sure we have a valid worksheet name
    if (!defined($worksheetName) || $worksheetName eq "") {
        return;
    }
    
    # Create new spreadsheet object
    my $xls = new Spreadsheet::BasicRead($config_xls) || die "Could not open '" . $config_xls . "': $! \n";
    
    # Set the heading row to 0
    $xls->setHeadingRow(0);
    
    # Reset back to the first worksheet
    $xls->setCurrentSheetNum(0);
    
    my $numSheets = $xls->numSheets();
    
    # Array containing a list all worksheet data to return
    my @worksheet;
    
    WORKSHEET:
    for (my $i=0; $i < $numSheets; $i++) {
        # Make sure we actually have a valid worksheet
        unless (defined($xls->currentSheetName())) {
            next WORKSHEET;
        }
        
        # Reset back to the first row of the sheet
        $xls->setRow(0);
        
        if ($xls->currentSheetName eq $worksheetName) {
            # Capture the headers and put into an associative array
            my $heading = $xls->getFirstRow();
            my %headers;
            my $cellCount = 0;
            foreach my $cell (@$heading) {
                $headers{$cell} = $cellCount++;
            }
            
            # Capture all records of the current sheet
            my $row = 0;
            while (my $data = $xls->getNextRow()) {
                # Define our details associative array
                my %details;
                
                my @dataArray = @$data;
                my $datasize  = $#dataArray + 1;
                
                # Capture our computer details
                my $itemCount  = 0;
                my $emptyCount = 0;
                foreach my $item (@$data) {
                    # Check if our values are empty
                    if ($item eq "") {
                        $emptyCount++;
                    }
                    
                    foreach my $header (keys %headers) {
                        if ($headers{$header} eq $itemCount) {
                            $details{$header} = $item;
                        }
                    }
                    $itemCount++;
                }
                if ($datasize == $emptyCount) {
                    last WORKSHEET;
                }
                
                $worksheet[$row] = \%details;
                $row++;
            }
            
            last WORKSHEET;
        }
        
        $xls->getNextSheet();
    }
    
    return (\@worksheet);
}

#
# parseValue() - 
# Input:  
# Output: 
sub parseValue {
    $var = shift;
    
    $var =~ s/"//g;
    
    return $var;
}


1;

__END__
