use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../../Lib";
use VSO;
use Config::INI::Simple;

my $Conf=new Config::INI::Simple;


$Conf->read("$Bin/../UserScenariosConfig.Ini") ;
VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','AutoAdminLogon',1,'REG_SZ');
VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','DefaultUserName',$Conf->{Filter}->{'Admin UserName'},'REG_SZ');
VSO::SetRegKeyValue('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon','Defaultpassword',$Conf->{Filter}->{'Admin Password'},'REG_SZ');