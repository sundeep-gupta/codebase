while true
do
date
/tools/bin/perl /tmp/smoke/Script/ftp_pasv.pl -u 10.10.1.120
date
echo " ==================="
echo
echo
rm -rf *.file
done

