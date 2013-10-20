if [ $# -ne 2 ]; then
   echo "usage $0 <Server> <src_files>
   exit 1
fi
wget ftp://$1/patches/$2


