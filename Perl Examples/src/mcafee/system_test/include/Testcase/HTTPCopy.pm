package Testcase::HTTPCopy;
use strict;
use MSMConst;
use AppleScript;
our @ISA = ('Testcase');

sub new {
    my ($package, $rh_config, $log, $msm, $result_log) = @_;
    my $self = Testcase->new($rh_config, $log, $msm);
    bless $self, $package;
    $self->{'result_log'} = $result_log if $result_log;
    return $self;
}

sub init {
    my ($self) = @_;
    my $target = $self->{'config'}->{'target'};
    $target = "$DATA_DIR/$target";
    rmdir $target if -e $target;
    mkdir $target;
}

sub clean {
    my ($self) = @_;
    my $target = $self->{'config'}->{'target'};
    rmdir $target if -e $target;
}

sub execute {
    my ($self)   = @_;
    my $server   = $self->{'config'}->{'server'};
    my $source   = $self->{'config'}->{'source'};
    my $target   = $self->{'config'}->{'target'};
    my $ra_files = $self->{'config'}->{'files'};
    my $start_time = time();
    foreach my $file (@$ra_files) {
        unlink "$target/$file" if -e "$target/$file";
        # Make sure to set target-download path of firefox and
        # also make sure .zip files are downloaded by default.
        my $url       = "http:/$server/$source/$file";
        my $dest_file = "$target/$file";
        my $part_file = "${dest_file}.part";
	&AppleScript::close_application("Firefox");
	$start_time = time();
	system("/Applications/Firefox.app/Contents/MacOS/firefox-bin $url &");
        sleep 1;
	while (1) {
		last if ( ! -e $part_file and -e $dest_file );
	}
        # Cleanup work
	&AppleScript::close_application("Firefox");
        unlink "$target/$file" if -e "$target/$file";
    }
    $self->{'result_log'}->append({'HTTPCopy_Firefox'=>  time() - $start_time});
return; # We wont do safari now!!!!
    $start_time = time();
   foreach my $file (@$ra_files) {
        my $url       = "http:/$server/$file";
        my $dest_file = "$target/$file";
        my $part_file = "${dest_file}.download";
	&AppleScript::close_application("Safari");
	system("/Applications/Safari.app/ $url &");	
	while ( -e $part_file or (-e $part_file and -e $dest_file)) {} 
	&AppleScript::close_application("Safari");
        unlink "$target/$file" if -e "$target/$file";
    }

    $self->{'result_log'}->append({'AFPCopy_Safari'=>  time() - $start_time});
    return;    
}

1;
