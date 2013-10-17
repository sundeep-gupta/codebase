#!/usr/bin/start perl
if (fork()==0){
	system "start perl Read.pl R 124" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl S 125" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl T 126" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl U 127" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl V 128" ;
	exit;
}