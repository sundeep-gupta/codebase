#!/usr/bin/perl -w

my(%frmFlds); #defining alocal variable

%frmFlds=getFormData() ; #calling getFormData function

print "Content-Type: text/html\n\n";#header information
`cat /var/log/squid/access.log >> access.log` ;#concatinating files
$LOGFILE="access.log";
open(LOGFILE);

foreach $line(<LOGFILE>) {
	($time,$elapsed,$sourceip,$code,$bytes,$method,$url,$name,$status,$type)=split(' ' ,$line);
    $time=~s/^\d+\.\d+/ localtime $&/e;
    print ("$time”,”$url \n\n") if $name=~m/$file{username}/;
}
close(LOGFILE);

sub getFormData {
	my($buffer,%searchField,$pair,@pairs);
    if ($ENV{'REQUEST_METHOD'} eq 'POST') {
		read (STDIN,$buffer,$ENV{'CONTENT_LENGTH'});
        @pairs = split(/&/,$buffer);
        foreach $pair(@pairs) {
			($name,$value) = split(/=/,$pair);
            $name = decodeURL($name);
            $value=decodeURL($value);
            $searchField{$name}=$value;
		}
		return(%searchField);
	}
}

sub decodeURL {
	$_ =shift;
    tr/+/ /;
    s/%(..)/pack('c',hex($1))/eg;
    return($_);
}





