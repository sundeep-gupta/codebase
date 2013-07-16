package Resource::CPUMemory;
use strict;

#my
sub new {
    my ($package, $logfile, $ra_process) = @_;
	my $self = {};
	$self->{'resource_file'}  = $logfile;
	$self->{'result_file'} = Result->new($logfile) if $logfile;
	$self->{'command'} = &_get_top_command();
	$self->{'process'}     = $ra_process;
    bless $self, $package;
	return $self;
}

sub _get_top_command {
   my $version = `defaults read loginwindow SystemVersionStampAsString`;
   
   if ($version =~ /^10.6/) {
        return 'top -l 1 -stats cpu,rsize,vsize,rshrd,command ';
   }
   return  'top -l 1 -p \'$cccc:$jjjjjjjjjjjj:$llllllllllll:$iiiiiiiiiiii:^bbbbbbbbbbbbbbbbbbbb\'';

}

sub get {
    my ($self) = @_;
    my $fh_results = $self->{'result_file'};
    my $ra_process = $self->{'process'};
	my $command    = $self->{'command'};
	return unless $^O eq 'darwin';

    my @top_command_output = `$command`;
    chomp @top_command_output;
    my $rh_resource_stats = {};
    my ($total_real, $total_virtual, $total_shrd) = (0,0,0);
    foreach my $line (@top_command_output) {
		if($line =~ /Processes:\s*(\d+)\s*total/) {
    		$rh_resource_stats->{'Processes'} = $1;
		   next;
		} elsif ($line =~ /CPU usage:\s*(.*)%\s*user,\s*(.*)%\s*sys/) {
	  		$rh_resource_stats->{'CPU_USER'} = $1;
	 	    $rh_resource_stats->{'CPU_SYS'} = $2;
	   		next;
		} 
    	foreach my $process (@$ra_process) {
			next unless $line =~ /$process/;

			$line =~ s/\s+/ /g;
	        my ($cpu,$rsize, $vsize, $rshrd) = &_get_stats($line);
			$rh_resource_stats->{$process.'_rsize'} =  ($rh_resource_stats->{$process.'_rsize'} ) ? 
								  $rh_resource_stats->{$process.'_rsize'} .":". $rsize : $rsize;
			$rh_resource_stats->{$process.'_vsize'} = ($rh_resource_stats->{$process.'_vsize'} ) ? 
								  $rh_resource_stats->{$process.'_vsize'} .":". $vsize : $vsize;
			$rh_resource_stats->{$process.'_cpu'} = ($rh_resource_stats->{$process.'_cpu'})?
								 $rh_resource_stats->{$process.'_cpu'} .":". $cpu : $cpu;
			$rh_resource_stats->{$process.'_rshrd'} = ($rh_resource_stats->{$process.'_rshrd'})?
								 $rh_resource_stats->{$process.'_rshrd'} .":". $rshrd : $rshrd;
	        $total_virtual += $vsize;
    	    $total_real    += $rsize;
			$total_shrd    += $rshrd;
	        last;
		}       # foreach
    }               # outer foreach
	$rh_resource_stats->{'Total_rsize'} = $total_real;
	$rh_resource_stats->{'Total_vsize'} = $total_virtual;
	$rh_resource_stats->{'total_shared'} = $total_shrd;

	if ($self->{'result_file'}) {
		# Save results here
		$self->add_results($rh_resource_stats);
#		$fh_results->append($rh_resource_stats); 
    } else {
        return $rh_resource_stats;
    }
}

sub add_results {
    my ($self, $rh_resource_stats) = @_; 

    my $filename = $self->{'resource_file'};
	if (-e $filename) {
		open(my $fh, $filename);
		my @lines = <$fh>; chomp @lines;
		close $fh; 
		my $rh_key_data = {};
	    foreach my $line (@lines) {
	    	my ($app_name, @entries) = split(',',$line);
    	    $rh_key_data->{$app_name} = join(',',@entries);
    	}
		foreach my $key ( keys %$rh_key_data) {
			if ($rh_resource_stats->{$key}) {
				$rh_resource_stats->{$key} = $rh_key_data->{$key}.",".$rh_resource_stats->{$key};
			} else {
				if($key eq 'timestamp') {
					$rh_resource_stats->{$key} = $rh_key_data->{$key}.','. time();
				} else {
					$rh_resource_stats->{$key} = $rh_key_data->{$key}.',N/A' if $key ne 'timestamp';
				}
			}
		}
		
	} else {
		$rh_resource_stats->{'timestamp'} = time();
	}
	open(my $fh, ">$filename");
	foreach my $key (keys %$rh_resource_stats) {
		print $fh "$key,".$rh_resource_stats->{$key}."\n";
	}
	close $fh;

}

sub _get_stats {
	my ($line) = @_;
    my $sep = ' ';
    my $version = `defaults read loginwindow SystemVersionStampAsString`; chomp $version;
    $sep = ':' if $version =~ /^10.6/;
    my ($cpu, $rsize, $vsize, $rshrd) = (split(':', $line) )[ 0,1,2,3];
    $cpu =~ s/^\s*//; $rsize =~ s/^\s*//; $vsize =~ s/^\s*//; $rsize =~ s/^\s*//;
    if( $rsize =~ /(\d+)(\w)\+$/) {
		$rsize = $1;
		$rsize *= 1024 if $2 eq 'M';
	}
    if( $vsize =~ /(\d+)(\w)\+$/) {
	    $vsize = $1;
	    $vsize *= 1024 if $2 eq 'M';
	}

    if( $rshrd =~ /(\d+)(\w)\+$/) {
	    $rshrd = $1;
	    $rshrd *= 1024 if $2 eq 'M';
	}
	return ($cpu, $rsize, $vsize, $rshrd);

}

1;
1;
