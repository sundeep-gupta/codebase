#---------------------------------------------------------------------------------------------------
#Author: Shailendra Mahapatra
#Date: 21-Jan-2008
#Purpose: Manages Perfmon.
#---------------------------------------------------------------------------------------------------
package McPerfmon;

use strict;
use warnings;
use FindBin qw($RealBin);

#-----------------------------------------------------
#Constructor.If any mandatory parameters are missing
# the method returns a 0.else a hash on success.
#-----------------------------------------------------
sub new{

    my $self=shift;
    my $Options=shift;
    my $oMcPerfMon;

    $oMcPerfMon->{SampleInterval}=$Options->{SampleInterval};
    $oMcPerfMon->{Template}=$Options->{Template};
    $oMcPerfMon->{LogFile}=$Options->{LogFile};
    $oMcPerfMon->{LogFormat}=$Options->{LogFormat} ;
    $oMcPerfMon->{Name}=$Options->{Name}|| return 0;

    return bless $oMcPerfMon;
}
#-----------------------------------------------------
# This method adds counters to Perfmon.
# Returns a 1 on success and 0 on failure
#-----------------------------------------------------
sub AddCounter{

    my $self=shift;
    my $ReturnCode=0;
    my $CountersFile;

    $CountersFile=GenerateCounterFile($self->{Template},$self->{Name});
    $ReturnCode=system("logman","create","counter",$self->{Name},"-cf",$CountersFile,"-o","$self->{LogFile}","-f",$self->{LogFormat},"-si",$self->{SampleInterval},"-v","nnnnnn");
    $ReturnCode=$ReturnCode >> 8;
    if($ReturnCode==0){
        return 1;
    }
    else{
        return 0;
    }
}
#-----------------------------------------------------
# This method deletes counters from Perfmon.
# Returns a 1 on success and 0 on failure
#-----------------------------------------------------
sub DeleteCounter{

    my $self=shift;
    my $ReturnCode=0;
    $self->StopCounter();
    $ReturnCode=system("logman","delete",$self->{Name});
    if($ReturnCode==0){
        return 1;
    }
    else{
        return 0;
    }

}

#-----------------------------------------------------
# This method starts a counters from Perfmon.
# Returns a 1 on success and 0 on failure
#-----------------------------------------------------
sub StartCounter{

    my $self=shift;
    my $ReturnCode=0;
    $ReturnCode=system("logman","start",$self->{Name});
    if($ReturnCode==0){
        return 1;
    }
    else{
        return 0;
    }
}

#-----------------------------------------------------
# This method stops a counters from Perfmon.
# Returns a 1 on success and 0 on failure
#-----------------------------------------------------
sub StopCounter{

    my $self=shift;
    my $ReturnCode=0;
    $ReturnCode=system("logman","stop",$self->{Name});
    if($ReturnCode==0){
        return 1;
    }
    else{
        return 0;
    }
}

sub GenerateCounterFile{

    my $inFile=shift;
    my $ProcessName=shift;
    my $NewLine;

    open(F,"$inFile") or die;
    open(CNTRS,"> $ENV{TEMP}\\$ProcessName.lst");
    while(<F>){

        if(m/%ProcessName%/){

            $NewLine=$_;
            $NewLine=~s/%ProcessName%/$ProcessName/i;
            print CNTRS $NewLine;
        }
        else{

            print CNTRS $_;
        }
    }
    close F;
    close CNTRS;
    return "$ENV{TEMP}\\$ProcessName.lst";

}

1;
