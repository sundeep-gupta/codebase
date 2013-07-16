#!/usr/bin/perl

my $cmd_1 = "/usr/bin/vm_stat";
my $cmd_2 = "lsof -i -P | grep -i listen";
my $log_file_1 = "./logs/page_faults.log";
my $log_file_2 = "./logs/port_details.log";
while (1) {
    my $op_1 = `$cmd_1`;
    my $op_2 = `$cmd_2`; 
    system(`echo "*********************PAGE-FAULTS-DETAILS*****************************" >> $log_file_1`);
    system(`echo "$op_1" >> $log_file_1`);
    system(`echo "*********************MAC-PORT-DETAILS********************************" >> $log_file_2`);
    system(`echo "$op_2" >> $log_file_2`);
    sleep 300;
}

    
