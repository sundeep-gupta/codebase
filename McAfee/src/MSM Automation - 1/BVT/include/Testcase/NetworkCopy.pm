# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::NetworkCopy;
use strict;
use Const;
use Testcase;
use System;
use Time::HiRes qw/gettimeofday/;
our @ISA = ('Testcase');
use File::Find;
sub new {
	my ($package, $rh_param) = @_;
	my $self = Testcase->new($rh_param);
	bless $self, $package;
	return $self;
}

sub init { 
    my ( $self ) = @_;
    my $protocol = $self->{'config'}->{'protocol'};
    my $log      = $self->{'log'};
    $self->clean(); 
    if( $protocol eq 'afp') {
        $log->info("Mounting ". $self->{'config'}->{'mount'});
        &System::get_object_reference()->mount_afp($self->{'config'});
    }
}

sub clean {
    my ($self) = @_;
    my $log    = $self->{'log'};
    my $protocol = $self->{'config'}->{'protocol'};
    if ( $protocol eq 'afp' ) {
        $log->info("Unmounting ".$self->{'config'}->{'mount'});
        &System::get_object_reference()->unmount($self->{'config'}->{'mount'});
    }
    my $target = "$DATA_DIR/". $self->{'config'}->{'target'};
    $log->info("Cleaning files");
    &File::Find::find ( { no_chdir => 1,
                         wanted   => sub { unlink $File::Find::name if ( $File::Find::name !~ /\.svn/ and 
                                            -e $File::Find::name ); }}, $target );

}


sub execute {
    my ($self)   = @_;
    my $log      = $self->{'log'};
    my $protocol = $self->{'config'}->{'protocol'};
    my $m = "_".$protocol."_copy";
    no strict;
    &$m($self);
    use strict;

    $self->{'result'}   = { 'NetworkCopy' => $PASS };
}

sub _ftp_copy {
    my ($self)   = @_;
    my $log      = $self->{'log'};
    my $server   = $self->{'config'}->{'server'};
    my $user     = $self->{'config'}->{'user'};
    my $password = $self->{'config'}->{'password'};
    my $target   = $DATA_DIR."/".$self->{'config'}->{'target'};
    my $ra_files = $self->{'config'}->{'files'};
    my $source   = $self->{'config'}->{'source'};
    my $pwd      = &Cwd::getcwd();
    chdir($target);

    my $ftp = Net::FTP->new($server, Debug => 0);
    $ftp->login($user, $password);
    $ftp->binary();
    $ftp->cwd($source);    

    $self->{'start_time'} = [ gettimeofday() ];
    foreach my $file (@$ra_files) {
        $ftp->get($file);
    }
    $ftp->quit;
    chdir($pwd);
    $self->{'end_time'} = [gettimeofday() ];
}


sub _http_copy {
    my ($self)   = @_;
    my $server   = $self->{'config'}->{'server'};
    my $source   = $self->{'config'}->{'source'};
    my $target   = $DATA_DIR."/".$self->{'config'}->{'target'};
    my $ra_files = $self->{'config'}->{'files'};
    my $log      = $self->{'log'};
    $self->{'start_time'} = [ gettimeofday() ];
    foreach my $file (@$ra_files) {
        # Make sure to set target-download path of firefox and
        # also make sure .zip files are downloaded by default.
        my $url       = "http:/$server/$source/$file";
        my $dest_file = "$target/$file";
        my $part_file = "${dest_file}.part";
	&AppleScript::quit_application("Firefox");
        &AppleScript::launch_application("Firefox");
        &System::get_object_reference()->execute_cmd("open $url");
        
	# Wait till download begins 
        $log->info("Wait till download begins...");
       print "Checking $part_file\n";
        while(1) {
            last if grep { $_ =~ $part_file; } &System::get_object_reference()->open_files_on_process('firefox');
        }
        $log->info("Download started ...");
        while (1) {
            last unless grep { $_ =~ $part_file; } &System::get_object_reference()->open_files_on_process('firefox');
        }
        $log->info("Download finished...");

        # Cleanup work
	&AppleScript::quit_application("Firefox");
        &AppleScript::wait_till_quit("Firefox");
    }
    $self->{'end_time'} = [ gettimeofday() ];
}


sub _scp_copy {
    my ($self)   = @_;
    my $server   = $self->{'config'}->{'server'};
    my $user     = $self->{'config'}->{'user'};
    my $password = $self->{'config'}->{'password'};
    my $target   = "$DATA_DIR/".$self->{'config'}->{'target'};
    my $ra_files = $self->{'config'}->{'files'};
    my $source   = $self->{'config'}->{'source'};
    $self->{'start_time'} = [ gettimeofday() ];
    foreach my $file (@$ra_files) {
        &System::get_object_reference()->scp( {'source' => " ${user}\@${server}:${source}/${file} ",
						'target'=> "$target/$file"
					       } );
    }
    $self->{'end_time'} = [gettimeofday() ];
}

# Copy each file to the local directory.
sub _afp_copy {
    my ($self) = @_;
    
    my $target = $DATA_DIR.'/'.$self->{'config'}->{'target'};
    my $ra_files  = $self->{'config'}->{'files'};
    my $source = $self->{'config'}->{'mount'};
    my $log    = $self->{'log'};
    my $resource_log = $self->{'resource_log'};

    $log->info("Starting AFPCopy") if $log;
    $self->{'start_time'} = [gettimeofday()]; 

    foreach my $file (@$ra_files) {
	$log->info("Copying $file from $source to $target");
	my $system = &System::get_object_reference();
	$system->copy({'source'=>"$source/$file", 'target'=>$target});
    }
    $self->{'end_time'} = [gettimeofday()];
}


1;
