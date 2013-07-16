#!/usr/bin/perl

system("open /Applications/Firefox.app/");
sleep 2;
system ("osascript /Volumes/DATA/stress_soak/soak_stress/Includes/fw_app_launch.scpt");
system ("ping -c 10 PSS-Mactel-one.local");
system ("ping -c 10 performance-macminis-mac-mini.local");

