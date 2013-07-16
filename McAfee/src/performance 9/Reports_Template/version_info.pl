#!/usr/bin/perl -w

my $ver_file = "$ENV{ROOT_PATH}/ssm_perf/Reports/version_info";
my $version_info;
my $pref_file = "/Library/Preferences/com.Mcafee.AntiMalware.plist";
system("rm $ver_file") if (-e $ver_file);
system("touch $ver_file");

if (! -e "$pref_file") {
    $version_info .= "/Library/Preferences/com.Mcafee.AntiMalware.plist is not found! \n";
    $version_info .= "Hence cannot obtain the Product,Build,Engine and DAT versions \n";
} else {
    my @versions = qw(Product_Version Build_Number Update_EngineVersion Update_DATVersion); 
    my $version_info;
    $version_info .= "PRODUCT   McAfee Security Suite\n";
    foreach my $ver (@versions) {
        my $info = `defaults read /Library/Preferences/com.Mcafee.AntiMalware $ver`;
        $version_info .= "Product-Version   $info" if ($ver =~ Product_Version);
        $version_info .= "Build-Number   $info" if ($ver =~ Build_Number);
        $version_info .= "Engine-Version  $info" if ($ver =~ Update_EngineVersion);
        $version_info .= "DAT-Version   $info" if ($ver =~ Update_DATVersion);
    }
open (FP,">$ver_file");
print FP "$version_info\n";
close(FP);
}
