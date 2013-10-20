# create a new directory and copy eit dats there
if (-e "/usr/local/McAfee/AntiMalware/dats/13") { system("rm -fr /usr/local/McAfee/AntiMalware/dats/13");}
system("mkdir /usr/local/McAfee/AntiMalware/dats/13") == 0 or Virex_LVT::mumble(*LOG,"Error", "\nError: Could not create Directory\n");

# Copy eit dats 
system("cp /usr/local/Virex_LVT/eit/dat/avv/* /usr/local/McAfee/AntiMalware/dats/13/.");
system("chmod 777 /usr/local/McAfee/AntiMalware/dats/13/*");
system("chmod 777 /usr/local/McAfee/AntiMalware/dats/13/");
		
# change the datno variale
$datno=13;
# Change the plist file to point to eit dat directory
