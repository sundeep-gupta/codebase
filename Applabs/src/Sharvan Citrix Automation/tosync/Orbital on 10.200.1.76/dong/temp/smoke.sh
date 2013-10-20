while true
do
date
sleep 60
/tools/bin/perl /tools/tests/dong/telnet_test.pl -s 30.30.20.166 -c 20.20.20.56
date
echo " =================="
echo
echo
rm -rf /logs/tmp/*
sleep 60
date
/tools/bin/perl /tools/tests/dong/wget_ftp.pl -u 30.30.20.166
date
echo " =================="
done

