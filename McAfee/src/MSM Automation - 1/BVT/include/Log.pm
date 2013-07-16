package Log;
##############################################################
# Author : Sundeep Gupta
# Copyright (c) 2010, McAfee Inc.  All rights reserved.
# $Header: $
# 
# Modification History
# 
# sgupta6 091024 : comments added
# sgupta6 091023 : Created
##############################################################

use Const;
use System;
sub new {
    my ($package, $filename, $mode) = @_;

	my $self = {'filename' => $filename,
	            'info'     => 'INFO',
		        'error'    => 'ERROR',
				'warning'  => 'WARNING',
				};
    $self->{'hostname'} = &System::get_object_reference()->get_hostname();
    open(my $fh, ">> $filename") or warn "Could not open the file [$filename] to write";
    if ($fh) {
	    $self->{'handle'} = $fh;
		bless $self, $package;
		return $self;
	}

	return undef;
}

sub info {
    my ($self, $message) = @_;
    return unless $message;

    my ($sec, $min, $hour, $mday, $mon, $year, undef, undef, undef) = localtime;
    syswrite( $self->{'handle'}, sprintf("%s [ %02d/%02d/%04d %02d:%02d:%02d ] : %s : %s\n", 
                                         $self->{'info'}, $mday, $mon, $year+1900 , $hour, $min, $sec, $self->{'hostname'},  $message));

}

###############################################################################################################
# Description : Writes the error into the log 
# INPUT       : $message - The message to be written into the log.
# RETURN      : NONE
###############################################################################################################
sub error {
    my ($self, $message) = @_;
    return unless $message;
    my ($sec, $min, $hour, $mday, $mon, $year, undef, undef, undef) = localtime;
    syswrite( $self->{'handle'}, sprintf("%s [ %02d/%02d/%04d %02d:%02d:%02d ] %s : %s\n", 
                                         $self->{'error'}, $mday, $mon, $year+1900, $hour, $min, $sec,$self->{'hostname'}, $message));
}

sub warning {
    my ($self, $message) = @_;
    return unless $message;
    my ($sec, $min, $hour, $mday, $mon, $year, undef, undef, undef) = localtime;
    syswrite( $self->{'handle'}, sprintf("%s [ %02d/%02d/%04d %02d:%02d:%02d ] %s : %s\n", 
                                         $self->{'warning'}, $mday, $mon, $year+1900, 
										 $hour, $min, $sec,$self->{'hostname'}, $message));


}

1;
