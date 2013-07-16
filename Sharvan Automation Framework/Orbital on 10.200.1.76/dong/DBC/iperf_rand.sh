
if  [ $# -ne 3 ]; then
   echo "usage $0 <server> <#sess> <file."
   exit 1
fi

randbin `cat $3` | iperf -c $1 -I -P $2 -t 9999999 -i 60
