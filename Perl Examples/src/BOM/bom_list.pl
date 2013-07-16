#!/usr/bin/perl -w

# Copyright (C) 2010 McAfee, Inc. All rights reserved.

use strict;
use File::Find;
use Stat::lsMode;

die "Please provide the mpkg path as argument\n" unless $ARGV[0];
die "Invalid path : $ARGV[0] \n" unless -e $ARGV[0];
my $mpkg = $ARGV[0];

my $ra_pkgs  = [ 'AntiMalware.pkg','AppProtection.pkg', 'Firewall.pkg', 'FMP.pkg', 'MSCUI.pkg', 'sainst.pkg', 'SiteAdvisorFM.pkg'];
open( FH, "> preinstall.txt");
foreach my $pkg (@$ra_pkgs) {
    my $path = "$mpkg/Contents/Packages/$pkg/Contents/Archive.bom";
    die "$path does not exist\n" unless -e $path;
    my $output = `lsbom -pFMUGs '$path'`;
    $output =~ s/\t/:/sg; $output =~ s/^"(.*?)":/$1:/gm;
    print FH $output;
}

close FH;
my $ra_path = ['/usr/local/McAfee',                          # Primary location
        '/Library/Application Support/McAfee',        # Application Supporta
        '/Library/Frameworks/SACore.framework',
        '/Library/Frameworks/Scanbooster.framework',
        '/Library/Frameworks/AVEngine.framework',
        '/Library/Frameworks/VirusScanPreferences.framework',
        '/Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist',
        '/Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist',
        '/Applications/McAfee Internet Security.app',         # Applications Directory
        '/Applications/McAfee Internet Security Uninstaller.app',
        '/Library/Application Support/Mozilla/Extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{1650a312-02bc-40ee-977e-83f158701739}',
        '/Library/Preferences/com.mcafee.ssm.antimalware.plist',
        '/Library/Preferences/com.mcafee.ssm.appprotection.plist',
        '/Library/Preferences/com.mcafee.ssm.firewall.plist',
        '/etc/periodic/daily/555.siteadvisor',
        '/Users/Shared/.McAfee',
        ];
open(my $fh, "> postinstall.txt");
foreach my $path (@$ra_path) {
    find(sub {
        my ($mode, $uid, $gid, $size) = (stat $File::Find::name)[2,4,5,7];
        print "\n$uid:$gid:\t";
        $mode = &Stat::lsMode::file_mode($File::Find::name);
        my $uname = (getpwuid($uid))[0];
        my $gname = (getgrgid($gid))[0];
        print $fh "${File::Find::name}:$mode:$uname:$gname:$size\n";
    },$path) if -e $path;
    print "$path not found \n" unless -e $path;
}
close($fh);
