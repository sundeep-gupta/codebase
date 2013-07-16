package MSM::Configure;
use script;


sub add_application_rules {
    system ( "osascript addAppProRules.scpt");
}

sub add_firewall_rules {
    system ("osascript Firewall.scpt");
}


1;
