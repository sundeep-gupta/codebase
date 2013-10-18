#This script calls the Dbc_performance script to 
#run with DBC, MBC, and None
#The BW is set to 15 and 45Mbps using HB (for now)
#
#The test result will be saved in the host running the script (/var/tmp)
#-------------------------------------------------
./Dbc_performance -o 10.200.38.55 -s 30.30.30.76 -r 10.200.38.65 -c 2
./Dbc_performance -o 10.200.38.55 -s 30.30.30.76 -r 10.200.38.65 -c 1
./Dbc_performance -o 10.200.38.55 -s 30.30.30.76 -r 10.200.38.65 
