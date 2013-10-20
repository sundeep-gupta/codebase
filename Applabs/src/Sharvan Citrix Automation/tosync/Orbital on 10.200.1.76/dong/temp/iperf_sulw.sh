#For large session UDP test, need to run with -l 500 and -w 500 
#to preserve BW for TCP
while true
do
iperf -s -u -l 500 -w 500
done
