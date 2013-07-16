# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#!/usr/bin/perl -w
BEGIN {
    use Cwd 'abs_path';
    my $abs_path = abs_path($0);
    $abs_path =~ s/(.*)\/.*$/$1/;
    chdir $abs_path;
}

my $cmd_string = "perl ExecBVTScript.command BuildVerification Enterprise Install 1 build_url ";
$cmd_string = $cmd_string."\"".$ARGV[0]."\"";

my $ret_val = system($cmd_string);

exit($ret_val >> 8);
