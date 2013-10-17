#!/usr/bin/start perl

if (fork()==0){
	system "start perl Write.pl W 21 20 30";
	exit;
}
if (fork()==0){
	system "start perl Write.pl X 22 30 40";
	exit;
}
if (fork()==0){
	system "start perl Read.pl G 23" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl H 24" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl I 25";
	exit;
}
if (fork()==0){
	system "start perl Read.pl J 26" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl K 27" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl L 28" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl M 29" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl N 30" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl O 31";
	exit;
}
if (fork()==0){
	system "start perl Read.pl P 32" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl Q 33" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl R 34" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl S 35" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl T 36" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl U 37" ;
	exit;
}
if (fork()==0){
	system "start perl Read.pl V 38" ;
	exit;
}