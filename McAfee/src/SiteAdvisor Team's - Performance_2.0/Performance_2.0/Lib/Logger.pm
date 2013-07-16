package Logger;

use 5.008008;
use strict;
use warnings;
use Carp;
use Time::Format qw(%time);

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use VS ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our @EXPORT_OK = qw(Error Warning Message);

our $VERSION = '1.0';

sub Error{

    my $Obj=shift || die "Object not defined\n";
    my $LogType=shift;
    my $LogFile=shift;
    my $Text=shift;

    select($LogFile);
    $|=1;
    select(STDOUT);
    $|=1;

    #For writing to the screen only
    if($LogType == 1){

        print "[ Error   ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the screen and log file.
    if($LogType == 2){

        print "[ Error   ]--> ".GetTimeStamp()." $Text\n";
        print $LogFile "[ Error   ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the log file only
    if($LogType == 3){

        print $LogFile "[ Error   ]--> ".GetTimeStamp()." $Text\n";
    }

}

sub Message{

    my $Obj=shift || die "Object not defined\n";
    my $LogType=shift;
    my $LogFile=shift;
    my $Text=shift;

    select($LogFile);
    $|=1;
    select(STDOUT);
    $|=1;

    #For writing to the screen only
    if($LogType == 1){

        print "[ Message ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the screen and log file.
    if($LogType == 2){

        print "[ Message ]--> ".GetTimeStamp()." $Text\n";
        print $LogFile "[ Message ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the log file only
    if($LogType == 3){

        print $LogFile "[ Message ]--> ".GetTimeStamp()." $Text\n";
    }

}


sub Warning{

    my $Obj=shift || die "Object not defined\n";
    my $LogType=shift;
    my $LogFile=shift;
    my $Text=shift;

    select($LogFile);
    $|=1;
    select(STDOUT);
    $|=1;

    #For writing to the screen only
    if($LogType == 1){

        print "[ Warning ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the screen and log file.
    if($LogType == 2){

        print "[ Warning ]--> ".GetTimeStamp()." $Text\n";
        print $LogFile "[ Warning ]--> ".GetTimeStamp()." $Text\n";
    }

    #For writing to the log file only
    if($LogType == 3){

        print $LogFile "[ Warning ]--> ".GetTimeStamp()
        ." $Text\n";
    }

}

sub GetTimeStamp{

    my $Date=$time{'yyyy/mm/dd'};
    my $Time=$time{'hh:mm:ss'};
    my $TimeStamp=$Date. " ". $Time;

    return $TimeStamp;

}

sub AUTOLOAD{
    our $AUTOLOAD;
    print "The Autoload method called by $AUTOLOAD\n";
}


sub new{
    my $Invocant=shift;
    my $Class=ref($Invocant) || $Invocant;
    my $Obj={};
    bless($Obj,$Class);
    return $Obj;
}

sub DESTROY{

}
1;
__END__

