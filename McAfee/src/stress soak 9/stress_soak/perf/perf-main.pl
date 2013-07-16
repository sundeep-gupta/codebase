#!/usr/bin/perl
use Includes::Virex;

print "debug start\n";

$value1=&ConfigReaderValue ("MainScriptpath");
$value2=&ConfigReaderValue ("CounterFilename");
$value6=&ConfigReaderValue ("FirstTestScript");
$value7=&ConfigReaderValue ("SecondTestScript");
$value8=&ConfigReaderValue ("ThirdTestScript");
$value10=&ConfigReaderValue ("ReportFile");
$value11=&ConfigReaderValue ("CommandOnTestOver");
$value12=&ConfigReaderValue ("FourthTestScript");
$value13=&ConfigReaderValue ("FifthTestScript");
$value14=&ConfigReaderValue ("SixthTestScript");
$value15=&ConfigReaderValue ("SeventhTestScript");
$value16=&ConfigReaderValue ("EighthTestScript");
$value17=&ConfigReaderValue ("NinethTestScript");
$value18=&ConfigReaderValue ("TenthTestScript");
$value19=&ConfigReaderValue ("EleventhTestScript");
$value20=&ConfigReaderValue ("TwelvethTestScript");


$value91=&ConfigReaderValue ("FirstTestRuns");
$value92=&ConfigReaderValue ("SecondTestRuns");
$value93=&ConfigReaderValue ("ThirdTestRuns");
$value94=&ConfigReaderValue ("FourthTestRuns");
$value95=&ConfigReaderValue ("FifthTestRuns");
$value96=&ConfigReaderValue ("SixthTestRuns");
$value97=&ConfigReaderValue ("SeventhTestRuns");
$value98=&ConfigReaderValue ("EighthTestRuns");
$value99=&ConfigReaderValue ("NinethTestRuns");
$value100=&ConfigReaderValue ("TenthTestRuns");
$value101=&ConfigReaderValue ("EleventhTestRuns");
$value102=&ConfigReaderValue ("TwelvethTestRuns");


$temp1=$value91+$value92;
$temp2=$temp1+$value93;
$temp3=$temp2+$value94;
$temp4=$temp3+$value95;
$temp5=$temp4+$value96;
$temp6=$temp5+$value97;
$temp7=$temp6+$value98;
$temp8=$temp7+$value99;
$temp9=$temp8+$value100;
$temp10=$temp9+$value101;
$temp11=$temp10+$value102;


sleep 10;


system ("cd $value1");


$counter_value=`cat counter.txt`;

if ($counter_value == 0) 
{
system(`echo "---------Creating System Profile for reference-----------" >> $value10`);
# Check if the NWA is installed on system`.

if (-e "/Library/NETAepoagt/")
{ 
 system(`echo "NWA seems to be installed on the system" >> $value10`);
}
else 
{ 
 system(`echo "NWA doesn't seem to be installed on the system" >> $value10`);
}



$virexbuild = `cat /Applications/VirusScan.app/Contents/Info.plist |grep -e 'All rights reserved' `;
$hostname = `hostname`;
$engine = `Includes/uvscanv --engine /Library/Frameworks -d /usr/local/vscanx/dats/0000 |grep engine`;
$dats = `Includes/uvscanv --engine /Library/Frameworks -d /usr/local/vscanx/dats/0000 |grep data`;

system(`echo "$virexbuild" >> $value10`);
system(`echo "$virexbuild" >> $value10`);
system(`echo "$engine" >> $value10`);
system(`echo "$dats" >> $value10`);

system (`system_profiler > /tmp/sysprofile.txt`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Machine Name:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Machine Model:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'CPU Type:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'CPU Speed:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text ' Memory:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Serial Number:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'IPv4 Addresses:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Subnet Masks:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'System Version:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Kernel Version:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'Boot Volume:' >> $value10`);
system (`cat /tmp/sysprofile.txt | grep --binary-files=text 'User Name:' >> $value10`);
system(`echo "---------------------------------..-------------------------" >> $value10`);



$newcountervalue=$counter_value+1;
print("$newcountervalue\n");
system(`echo "$newcountervalue"> counter.txt`);

##############
system(`$value11`);
##############


}



if (( $counter_value > 0) && ($counter_value <= $value91))


{
print("one loop\n");
system ("perl $value6"); 
}

if (( $counter_value > $value91) && ($counter_value <= $temp1))

{
print( "two loop\n");
system ("perl $value7");
}

if (($counter_value > $temp1) && ($counter_value <= $temp2))
{
print ("three loop\n");
system ("perl $value8");
}


if (($counter_value > $temp2) && ($counter_value <= $temp3))
{
print ("four loop\n");
system ("perl $value12");
}


if (($counter_value > $temp3) && ($counter_value <= $temp4))
{
print ("five loop\n");
system ("perl $value13");
}

if (($counter_value > $temp4) && ($counter_value <= $temp5))
{
print ("six loop\n");
system ("perl $value14");
}

if (($counter_value > $temp5) && ($counter_value <= $temp6))
{
print ("seven loop\n");
system ("perl $value15");
}

if (($counter_value > $temp6) && ($counter_value <= $temp7))
{
print ("eigth loop\n");
system ("perl $value16");
}

if (($counter_value > $temp7) && ($counter_value <= $temp8))
{
print ("nine loop\n");
system ("perl $value17");
}
if (($counter_value > $temp8) && ($counter_value <= $temp9))
{
print ("ten loop\n");
system ("perl $value18");
}

if (($counter_value > $temp9) && ($counter_value <= $temp10))
{
print ("eleven loop\n");
system ("perl $value19");
}

if (($counter_value > $temp10) && ($counter_value <= $temp11))
{
print ("twelve loop\n");
system ("perl $value20");
}





else
{

print ("\n\n********************\n");
#print ("\nSending the result file (perfresult.txt) through e-mail\n");
#system ("perl sendmail.pl sanjeev@virex.com");
print ("\nRuns Complete Good Bye\n");
print ("\n**********************\n\n");
exit;
}

















