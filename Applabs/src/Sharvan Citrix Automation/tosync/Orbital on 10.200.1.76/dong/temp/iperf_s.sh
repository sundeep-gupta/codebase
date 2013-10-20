while true
do
sudo sh -c "ulimit -s 126 && ulimit -n 4096 && ulimit -a && iperf -s
done

