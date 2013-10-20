while true
do
#sudo sh -c "ulimit -s 128 && ulimit -n 4096 && ulimit -a && iperf -s"
sudo sh -c "ulimit -s 256 && ulimit -n 8192 && ulimit -a && iperf -s"
sleep 10
done

