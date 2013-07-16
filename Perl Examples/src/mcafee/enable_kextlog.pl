#!/usr/bin/perl -w
use strict;

print "Enabling logging for virusscan\n";
print `sudo sysctl -w kern.com_mcafee_virex_log=3`;
print "Enabling logging for application protection\n";
print `sudo sysctl -w kern.com_mcafee_app_protection_log=3`;
