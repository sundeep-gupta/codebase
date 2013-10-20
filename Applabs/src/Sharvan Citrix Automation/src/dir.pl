#!/usr/bin/perl -w
use strict;

opendir(DIR, "//10.200.1.91/kshare");
foreach (readdir(DIR)) {
    print $_;
}
closedir(DIR);