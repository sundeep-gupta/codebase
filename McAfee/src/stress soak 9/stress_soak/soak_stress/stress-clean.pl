#!/usr/bin/perl
use Includes::Virex;

if (! -d "logs") {
    system(`mkdir logs`);
}

### Add Application Protection Rules
system ("osascript addAppProRules.scpt");

### Add Firewall rules
system ("osascript Firewall.scpt");

### Get Memory and CPU Usage Details 
my $mem = "/Volumes/DATA/stress_soak/soak_stress/get_mem_usage.pl &";
system ($mem);
print "Memory & CPU usage details will be logged to -- logs/mem_cpu_usage.log ... \n\n";

### Get Page Faults Details
my $pd = "/Volumes/DATA/stress_soak/soak_stress/get_info.pl &";
system($pd);
print "Page Fault and Port information will be logged to -- logs/info.log ... \n\n";

### Get Disk Space Details
my $ds = "/Volumes/DATA/stress_soak/soak_stress/diskinfo.sh &";
system($ds);
print "The Disk Space info will be logged to -- logs/freedisk.log ... \n\n";

### Kick off Application Usage
my $au = "/Volumes/DATA/stress_soak/soak_stress/appusage.pl &";
system($au);
print "Application Usage will be logged to -- logs/Application_Usage.log ... \n\n";

### Sleep for 10 minutes before beginning the scan/update
sleep 600;

my $log_file = "./logs/mem_cpu_usage.log";
system(`echo "STARTING SCAN NOW" > $log_file`);


$clean_ods=&ConfigReaderValue ("ODS_CleanDatasetPath");
$VirexTaskdatabase=&ConfigReaderValue ("VirexTaskDb");
system (`rm /private/tmp/ScanFolder`) if (-e '/private/tmp/ScanFolder');
system (`cp $VirexTaskdatabase /usr/local/McAfee/AntiMalware/var/`);
system (`ln -s $clean_ods /private/tmp/ScanFolder`); 

$clean=&ConfigReaderValue ("OAS_CleanDatasetPath");


print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("Opening files for OAS test\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

$get_time = `date`;
print $get_time, "\n";
$count = 0;
$iteration = 0;
while ($count < 1) {
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("Opening files for OAS test\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
    system(`echo "Run:$iteration" >> ./logs/time`);
    system(`echo "Start-Time" >> ./logs/time`);
    system(`date >> ./logs/time`);

        &OpenFiles($clean);
        #sleep 5400;
            sleep 10;
    $get_time = `date`;
    system (`echo "$get_time" >> ./logs/runs.log`);
    print $get_time, "\n";
    system(`echo "End-time" >> ./logs/time`);
    system(`date >> ./logs/time`);
    system(`echo '' >> ./logs/time`);

    $SIG{'INT'} = 'CLEANUP';

}

sub CLEANUP {

    my $logfile = "./logs/mem_cpu_usage.log";
    system(`echo "STOPPING SCAN NOW" >> $logfile`);

#    ### Get Memory Leakage Details
#    print "Executing  /Volumes/DATA/stress_soak/soak_stress/MemoryLeakLogger.sh \n";
#    print "Checking for Memory Leakages ... \n";
#    print "The logs would be saved under logs/ \n";
#    system(`/Volumes/DATA/stress_soak/soak_stress/MemoryLeakLogger.sh`);
#
#    ### Sleep for 10 minutes
#    sleep 600;

#    ### Close all the terminals so no
#    ### background processes are running
#    my $ps = `ps | grep 'login -pf root'`;
#    my @processes = split('\n',$ps);
#    my $kill_cmd = "kill -9 ";
#    foreach my $a (@processes) {
#        my ($c,@temp) = split(/tty/,$a);
#        $kill_cmd .= $c;
#    }
#    print "cmd = $kill_cmd \n";
#    system(`$kill_cmd`);
}


