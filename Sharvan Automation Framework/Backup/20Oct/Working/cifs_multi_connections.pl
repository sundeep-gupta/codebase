#!/usr/bin/perl -w
use strict;
use File::Copy;

my $server_ip = shift || "10.200.1.91";
my $share = shift || "kshare/0";
my $ip_file = shift || "c:/test/ips.txt";

my $ref_files = get_files("//$server_ip/$share");
my $ref_ips = get_ips($ip_file);
my @ips = @{$ref_ips};

my ($ctr, $pid, @cpids, $loop);
my $ppid = $$;
for ($ctr=0; $ctr<=$#ips; $ctr++) {
    if (!defined ($pid = fork())){
        die "Couldn't fork\n";
        exit;
    }elsif ($pid == 0) {
        if (!copy_files("$ips[$ctr]",$ref_files)) {
            print "Couldn't copy @{$ref_files} from $ips[$ctr]\n";
            kill 9,$ppid;
            kill 9, @cpids;
            exit;
        }
        exit;
    }else {
        $cpids[$ctr] = $pid;
    }
}
for ($loop=0; $loop<=$#ips; $loop++) {
    waitpid ($cpids[$loop],0);
}
print "Execution completed\n";

sub copy_files {
    my $ip = shift;
    my $ref_source_files = shift;
    
    my @source_files = @{$ref_source_files};
    my $file;
    foreach $file (@source_files) {
        if(!copy("//$ip/$share/$file","nul:")) {
            print "File //$ip/$share/$file couldn't be copied\n";
            return 0;
        }
        else {
            print "File //$ip/$share/$file copied successfully\n";
        }    
        sleep(10);
    }
    return 1;
}    

sub get_ips {
    my $ip_file = shift;
    
    my (@ips, $ip);
    open(FHIN, "$ip_file") or die "Can't open ip file $ip_file\n";
    foreach $ip (<FHIN>){
        chomp($ip);
        push(@ips,$ip);
    }    
    close(FHIN);
    return \@ips;
    
}

sub get_files {
    my $dir = shift;
    
    my ($file, @files);
    opendir(DIR, $dir) or die "Can't open directory $dir\n";
    foreach $file (readdir(DIR)) {
        if (($file ne ".") && ($file ne "..")) {
            push(@files,$file);
        }
    }
    closedir(DIR);
    return \@files;
}

