use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../Lib";
use Logger;

my $Log=new Logger();
my $Error=0;
my $ModuleName;
my @ErrorText;

open(LOG,"> $Bin/Setup.log") || die;
open(PM,"$Bin/Perlmodules.txt") || die;

$Log->Message(2,*LOG,"Checking if Perl is in PATH Variable...");
if($ENV{PATH}=~m/perl\\bin/gi){
    
    $Log->Message(2,*LOG,"Perl is present in PATH Variable...");
}
else{
    
    $Log->Error(2,*LOG,"Perl is not present in PATH Variable...");
    $Error=1;
}

$Log->Message(2,*LOG,"Checking if Perl modules are installed...");
while($ModuleName=<PM>){
    
    chomp $ModuleName;
    $ModuleName=~s/\s*$//gi;
    $Log->Message(2,*LOG,"Checking for Module $ModuleName...");
    open(ERR,"perl -M$ModuleName |");
    print <ERR>;
    @ErrorText=<ERR>;
    if(scalar @ErrorText){
        
        $Log->Error(2,*LOG,"Module $ModuleName is not Installed");
        $Error=1;
    }
}
