#!/usr/local/bin/perl

use strict;
my $user_entry = '11.1.2.0.2M'; 
my $regex_fixed_version = '[a-zA-Z0-9_\-\.]+';
my $regex_fixed_version_end = '[a-zA-Z0-9_\-]$';
if ($user_entry !~ /^NONE/i && 
               ($user_entry !~ /$regex_fixed_version/ ||
               $user_entry !~ /$regex_fixed_version_end$/ )) {
    print "SKGUPTA: BUG REOPEN\n";               
      }

$user_entry = '11.1.2.0.3M';
if ($user_entry !~ /^NONE/i && 
               ($user_entry !~ /$regex_fixed_version/ ||
               $user_entry !~ /$regex_fixed_version_end$/ )) {
    print "SKGUPTA: BUG REOPEN\n";               
      }



    $view_label = 
      $version_fixed = $user_entry;
      while (!$version_fixed ) { # Note, "0.0" is a TRUE value in Perlish
        # --- THESE HARDCODES NEEDS TO BE REMOVED LATER --- #
        #BUG 5533711 - Only for EM*_MAIN series default version fixed to 11GC
        if ($view_label =~ m/^EM.+_MAIN_.+/) {
           #BUG 5654553 - EMDBSA_MAIN series default version fixed to 11.1
           if ($view_label =~ m/^EMDBSA_MAIN_.+/) {
             $version_fixed = &error::interactive("Enter the Fixed Version for the"
                  . " bug (format a.b[.c.d.e]) [default - 11.1] : ",1,0) || '11.1';
           } else {
             $version_fixed = &error::interactive("Enter the Fixed Version for the"
                  . " bug (format a.b[.c.d.e]) [default - 11GC] : ",1,0) || '11GC';
           }
        } else {
          $version_fixed = &error::interactive("Enter the Fixed Version for the"
                       . " bug (format a.b[.c.d.e]) : ",1,0) ;
        }

