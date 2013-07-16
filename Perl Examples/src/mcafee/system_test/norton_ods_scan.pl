#!/usr/bin/perl
use strict;

require "include/AppleScript.pm";
my $time = &_do_scan_on_norton("/Volumes/DATA/test.pl");
print "Scan time is $time\n";
exit;
sub _do_scan_on_norton {

    my $path = $_[0];

    my $app_name = "Norton AntiVirus";
    my $apple_script = AppleScript->new();
    $apple_script->start_system_event();
    $apple_script->append("tell application \"Norton AntiVirus\" to activate");
    $apple_script->append("activate application process \"Norton AntiVirus\"");
    $apple_script->append("click radio button \"Specific files\" of radio group 1 of window 1 of application process \"Norton AntiVirus\"");
    $apple_script->append("click button \"Choose Files...\"  of window 1 of application process \"Norton AntiVirus\"");
    $apple_script->append("delay 2");
    $apple_script->append("activate application process \"$app_name\"");
    $apple_script->append("delay 2");
    $apple_script->append("key down shift");
    $apple_script->append("key down command");
    $apple_script->keystroke("\"g\"");
    $apple_script->append("key up shift");
    $apple_script->append("key up command");
    $apple_script->keystroke("\"$path\"");
    $apple_script->append("click button \"Go\" of sheet 1 of sheet 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("delay 2");
    $apple_script->append("click button \"Choose\" of sheet 1 of window 1 of application process \"$app_name\"");
    $apple_script->append("delay 2");
    $apple_script->end_system_event();
    $apple_script->run();
    
    my $time = time();
    $apple_script = AppleScript->new();

    $apple_script->start_system_event();
    $apple_script->append("activate application process \"$app_name\"");
    $apple_script->append("click button 6 of window 1 of application process \"$app_name\"");

    $apple_script->append("repeat while button 3 of sheet 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append("end repeat");
    $apple_script->append("repeat while button 3 of sheet 1 of window 1 of application process \"$app_name\" is not enabled");
    $apple_script->append("end repeat");
    $apple_script->end_system_event();
    $apple_script->run();

    return time() - $time;
}
sleep 5;
my $apple_script = AppleScript->new();
$apple_script->append("tell application \"Norton AntiVirus\" to activate");
$apple_script->start_system_event();
$apple_script->end_system_event();
$apple_script->run();
