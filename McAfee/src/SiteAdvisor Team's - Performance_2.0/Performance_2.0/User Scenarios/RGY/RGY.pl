use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use Logger;

my $Log=new Logger();
my $Url;

#Open the log file for writing
open(LOG,">> $Bin/../Logs/UserScenarios.log") or warn;
$|=1;
$Log->Message(2,*LOG,"Executing RGY.pl...");


if(open(HMPG,"$Bin/RGYSites.txt")){

    while(<HMPG>){

        $Url=$_;
        chomp $Url;
        eval{

            system("perl","$Bin/../IE/IENavigate.pl","/url",$Url,"/desc","RGY");
        };
        if($@ || $?){

            $Log->Error(2,*LOG,"Error in opening IEnavigate.pl for URL $Url");
        }
    }

}
else{

    $Log->Error(2,*LOG,"Error in opening file $Bin/Homepages.txt..");
}
