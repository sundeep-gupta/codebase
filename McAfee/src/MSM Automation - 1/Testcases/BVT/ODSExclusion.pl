# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#!/usr/bin/perl -w
BEGIN {
    use Cwd 'abs_path';
    my $abs_path = abs_path($0);
    $abs_path =~ s/(.*)\/.*$/$1/;
    chdir $abs_path;
}

my $ret_val = system("perl ExecBVTScript.command BuildVerification Enterprise ODSExclusion");

exit($ret_val >> 8);
