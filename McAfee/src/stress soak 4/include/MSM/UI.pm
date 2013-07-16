package MSM::UI;
use strict;
use Mac::AppleScript;


sub new {
  my $package = $_[0];
  my $self = {
	      'product' => 'Consumer',
	     }; 
  bless $self, $package;
}


sub open {
    &Mac::AppleScript::RunAppleScript('tell application "McAfee Security" to activate');
}

sub quit {

    &Mac::AppleScript::RunAppleScript('tell application "McAfee Security" to quit');

}

sub add_ods_entry {


}


sub remove_ods_entry {


}

sub enable_ods_scan {


}

sub open_preferences {
    my $self = $_[0];

    return unless $self->is_open();
    my $script = 'tell application "System Events" '."\n".' click menu item "Preferences..." of menu 1 of '.
	         'menu bar item "McAfee Security" of menu bar 1 of application process "McAfee Security"'.
		 "\n end tell\n";
print $script;

    &Mac::AppleScript::RunAppleScript($script);   

}

sub open_about {

}

sub get_engine_version {


}
 
sub is_open { return 1; } 

sub close_about {

}

sub close_preferences {

}

sub set_oas_properties {

}

sub get_oas_properties {

}

sub set_ods_preferences {

}

sub get_ods_preferences {

}

sub read_dashboard {
}

sub add_application_rules {

}


1;
