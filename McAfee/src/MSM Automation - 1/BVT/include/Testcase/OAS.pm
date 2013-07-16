# Copyright (c) 2010, McAfee Inc.  All rights reserved.

package Testcase::OAS;
use strict;
use Const;
use Testcase;
use File::Find;
our @ISA = ('Testcase');
sub new {
    my ($package, $rh_param) = @_;
    my $self = Testcase->new($rh_param);
    bless $self, $package;
    return $self;
}

sub init {
    my ($self) = @_;
    my $data_dir = $self->{'data_dir'};
    my $log      = $self->{'log'} ;
    my $system   = &System::get_object_reference();
    
    if($self->{'config'}->{'write'}->{'file_count'}) {
        $system->remove_dir( $data_dir) if -e $data_dir;
        $system->mkdir($data_dir);
    } elsif ( not -d $data_dir) {
        $log->error("$data_dir does not exist") ;
        return $FAIL;
    }
    return $PASS;
}

sub _execute_write {
    my ($self, $file_count, $source_dir) = @_;
    my $rh_result = {};
    for (my $i = 1 ; $i <= $file_count; $i++) {
        open(FP,"> $source_dir/oas_data.$i") or die "$source_dir/oas_data.$i \n";   
        syswrite(FP, $self->{'config'}->{'write'}->{'data'});
        close (FP);
    }
    return $rh_result;
}

sub _verify_write {
    my ($self, $file_count, $source_dir) = @_;
    my $product = $self->{'product'};
    for (my $i = 1; $i <= $file_count; $i++ ) {
        if ( $product->verify_oas(&Cwd::abs_path( "$source_dir/oas_data.$i" ) ) ) {
		return $PASS;
        } else {
		return $FAIL;
    	}
    }
}

sub _execute_read {
    my ($self, $source_dir) = @_;
    &File::Find::find(  { 'no_chdir' => 1, 'wanted' => sub { 
		if ( -f $File::Find::name) {
			open(my $fh, $File::Find::name) or 
                                syswrite(\*STDERR, "Could not open file : ${File::Find::name}\n");
			close $fh if $fh;
		}
	} }, $source_dir);
}

sub _verify_read {
    my ($self, $source_dir) = @_;
    my $product = $self->{'product'};
    &File::Find::find( { 'no_chdir' => 1,
        'wanted' => sub {
            if ( $product->verify_oas( $File::Find::path )) {
		return $PASS;
            } else {
		return $FAIL;
            }
        } }, $source_dir );

}


