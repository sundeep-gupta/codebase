# Copyright (c) 2010, McAfee Inc.  All rights reserved.
#!/usr/bin/perl -w
BEGIN {
    use Cwd 'abs_path';
    my $abs_path = abs_path($0);
    $abs_path =~ s/(.*)\/.*$/$1/;
    chdir $abs_path;
}

my $ret_val = system("perl ExecBVTScript.command BuildVerification Enterprise AppProtDenyAccess 3 tc_desc  \"Application protection deny application check\" product_pref-aptt \"20000 /Applications/Chess.app 0 1 1\" applications Chess");

exit($ret_val >> 8);
