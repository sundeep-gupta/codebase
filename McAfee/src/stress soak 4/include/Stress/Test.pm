package Stress::Test;

use strict;

sub soak_mixed {
}

sub soak_clean {

    mkdir $LOG_DIR unless -d $LOG_DIR;
    
    &MSM::Configure::add_application_rules();
    &MSM::Configure::add_firewall_rules();
    
    # TODO : This must be using threads.
    &Util::capture_cpu_memory();
    &Util::capture_page_faults();
    &Util::capture_disk_information();

    &Stress::Test::_do_appusage();

    sleep 900;
    
    &Stress::Test::_do_scan_update();
}

sub _do_appusage {
    ### Kick off Application Usage
    my $au = "/Volumes/DATA/stress_soak/soak_stress/appusage.pl &";
    system($au);
    print "Application Usage will be logged to -- logs Application_Usage.log ... \n\n";
}

sub _do_scan_update {
    my $log_file = "./logs/mem_cpu_usage.log";
    system(`echo "STARTING SCAN NOW" >> $log_file`);


    $clean_ods=&ConfigReaderValue ("ODS_CleanDatasetPath");
$VirexTaskdatabase=&ConfigReaderValue ("VirexTaskDb");
system (`rm /private/tmp/ScanFolder`) if (-e '/private/tmp/ScanFolder');
system (`cp $VirexTaskdatabase /usr/local/McAfee/AntiMalware/var/`);
system (`ln -s $clean_ods /private/tmp/ScanFolder`); 
}

sub _oas_scan {
$clean=&ConfigReaderValue ("OAS_CleanDatasetPath");


print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("Opening files for OAS test\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

$get_time = `date`;
print $get_time, "\n";
$count = 0;
$iteration = 0;

while ($count < 1) {
    system("echo > /var/log/VirusScan.log");
    $iteration++;
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
    print("Opening files for OAS test\n");
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
    system(`echo "Run:$iteration" >> ./logs/time`);
    system(`echo "Start-Time" >> ./logs/time`);
    system(`date >> ./logs/time`);
    &OpenFiles($clean);
    #sleep 12000;
    sleep 10;
    $get_time = `date`;
    system (`echo "$get_time" >> ./logs/runs.log`);
    print $get_time, "\n";
    system(`echo "End-time" >> ./logs/time`); 
    system(`date >> ./logs/time`);
    system(`echo '' >> ./logs/time`);

    $SIG{'INT'} = 'CLEANUP';
    
}

}
sub CLEANUP {

    my $logfile = "./logs/mem_cpu_usage.log";
    system(`echo "STOPPING SCAN NOW" >> $logfile`);

}

sub stress_mixed {
}

sub stress_clean {
}



1;


