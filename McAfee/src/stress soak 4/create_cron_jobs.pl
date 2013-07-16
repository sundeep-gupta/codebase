#!/usr/bin/perl
use Includes::Virex;


#################Accepts soak/stress and clean/mixed and creates a new file with name crontabjobs.txt

system ("rm crontabjobs.txt"); 
$ods_cleandata_path=&ConfigReaderValue ("ODS_CleanDatasetPath");
$ods_mixeddata_path=&ConfigReaderValue ("ODS_MixedDatasetPath");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
print("ODS Clean dataset Path : $ods_cleandata_path\n");
print("ODS Mixed dataset Path : $ods_mixeddata_path\n");
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
$abc = $ARGV[0];
$def = $ARGV[1];


if (( $abc eq soak) && ($def eq clean))
{
print("soak clean\n");
system ("perl -p -e 's!ReplaceWithCorrectPath!$ods_cleandata_path!g' cron-ods-clean-soak.txt > crontabjobs.txt"); 
exit;
}



if (( $abc eq soak) && ($def eq mixed))
{
print("soak mixed\n");
system ("perl -p -e 's!ReplaceWithCorrectPath!$ods_mixeddata_path!g' cron-ods-mixed-soak.txt > crontabjobs.txt"); 
exit;
}


if (( $abc eq stress) && ($def eq clean))
{
print("stress clean\n");
system ("perl -p -e 's!ReplaceWithCorrectPath!$ods_cleandata_path!g' cron-ods-clean-stress.txt > crontabjobs.txt"); 
exit;
}


if (( $abc eq stress) && ($def eq mixed))
{
print("stress mixed\n");
system ("cat cron-ods-mixed-stress.txt > crontabjobs.txt"); 
exit;
}

else
{

print ("\n\n********************\n");
print ("\nAre you sure your code is error free\n");
print ("\n**********************\n\n");
exit;
}


