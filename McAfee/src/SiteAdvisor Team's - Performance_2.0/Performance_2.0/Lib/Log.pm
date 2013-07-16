package Log;

use strict;
use warnings;
use File::Path;
use File::Basename qw(fileparse);

our $VERSION="1.0";

#--------------------------------------------------------------------------
# The Constructor
#--------------------------------------------------------------------------
sub new {
    my $class = shift;
    my $File=shift;
    my $Options=shift;
    my $LogObject;
    my $LogDir;
    my $LogFile;

    ($LogFile,$LogDir)=fileparse($File);

    $LogDir=~s/\/$//;		#remove the trailing fwd slash
    mkpath $LogDir;		#Create the directory if it does not exist.

    if($Options->{overwrite}==1){

        open(LOG,"> $File") or die;
    }
    else{

        open(LOG,">> $File") or die;
		print LOG "\n ***************************** Appending New Text *********************\n";
    }
	*STDERR=*LOG;
    my $self = bless $LogObject={file=> $File,
						  verbose => $Options->{verbose},
						  filehandle=> *LOG,
						  overwrite=> $Options->{overwrite},
						  buffer => $Options->{buffer}}, $class;
    return $self;
}

#--------------------------------------------------------------------------
# The Error method
#--------------------------------------------------------------------------
sub Error{

    my $Object=shift;
    my $VerboseLevel=shift;
    my $Text=shift;
    my $Handle=$Object->{filehandle};
    my ($Package,$ScriptName,$LineNumber)=caller();

    if($VerboseLevel <= $Object->{verbose}){

        if($VerboseLevel==1){

            print  "[".localtime(time)."] - (Error) $Text\n";
        }
        print  $Handle "[".localtime(time)."] - (Error) $Text\n";
    }
    else{

        return 0;
    }
}

#--------------------------------------------------------------------------
# The Info method
#--------------------------------------------------------------------------
sub Info{

    my $Object=shift;
    my $VerboseLevel=shift;
    my $Text=shift;
    my $Handle=$Object->{filehandle};
    my ($Package,$ScriptName,$LineNumber)=caller();

    if($VerboseLevel <= $Object->{verbose}){

        if($VerboseLevel==1){

            print "[".localtime(time)."] - (Info) $Text\n";
        }
        print  $Handle "[".localtime(time)."] - (Info) $Text\n";
    }
    else{

        return 0;
    }
}

#--------------------------------------------------------------------------
# The Warn method
#--------------------------------------------------------------------------
sub Warn{

    my $Object=shift;
    my $VerboseLevel=shift;
    my $Text=shift;
    my $Handle=$Object->{filehandle};
    my ($Package,$ScriptName,$LineNumber)=caller();

    if($VerboseLevel <= $Object->{verbose}){

        if($VerboseLevel==1){

            print "[".localtime(time)."] - (Warning) $Text\n";
        }
        print  $Handle "[".localtime(time)."] - (Warning) $Text\n";
    }
    else{

        return 0;
    }
}


1;
