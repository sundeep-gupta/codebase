#This script calls iperfc_file_loop on multiple clients.
#The purpose of this test is to generate ~4000 IPERF session
#using various files (instead of using the default data) over multiple flows.
#------------------------------------------------
# The script must be executed from Kabul, for now
#-----------------------------------------------
ssh lin36 '/tools/tests/dong/iperfc_file_loop 30.30.20.76 100' &
ssh lin38 '/tools/tests/dong/iperfc_file_loop 30.30.40.78 100' &
ssh lin39 '/tools/tests/dong/iperfc_file_loop 30.30.60.79 100' &
