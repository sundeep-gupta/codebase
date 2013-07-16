use FileHandle; use IPC::Open2; $pid = open2( \*Reader, \*Writer, "ade useview".
" view-1" ); 
while (sysread(Reader, $line,1)) {
   print $line;
}
Writer->autoflush(); # default here, actually 
syswrite Writer, "ls\n";
#print @got;
while (sysread(Reader, $line,1)) {
   print $line;
}
close Reader;
close Writer;
