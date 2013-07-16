#!/usr/bin/perl -w

my(%frmFlds);

%frmFlds=getFormData();#calling getFormData function

if($frmFlds{username} eq "principal") {
	open (FILEHANDLER1, "+>>/etc/squid/principal/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/principal/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/principal/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/principal/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/principal/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "ecelan") {
	open (FILEHANDLER1, "+>>/etc/squid/ecelan/ip");
	print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/ecelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/ecelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/ecelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/ecelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "cselan") {
	open (FILEHANDLER1, "+>>/etc/squid/cselan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/cselan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/cselan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/cselan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER1, "+>>/etc/squid/ecelan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/ecelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/ecelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/ecelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/ecelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "hods") {
	open (FILEHANDLER1, "+>>/etc/squid/ecelan/ip");
	print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/ecelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/ecelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/ecelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/ecelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "cselan") {
	open (FILEHANDLER1, "+>>/etc/squid/cselan/ip");
	print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/cselan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/cselan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/cselan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
  	open (FILEHANDLER1, "+>>/etc/squid/hods/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/hods/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/hods/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/hods/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/hods/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "eeelan") {
	open (FILEHANDLER1, "+>>/etc/squid/ecelan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/ecelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/ecelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/ecelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/ecelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "cselan") {
	open (FILEHANDLER1, "+>>/etc/squid/cselan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/cselan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/cselan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/cselan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLopen (FILEHANDLER1, "+>>/etc/squid/eeelan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/eeelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/eeelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/eeelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/eeelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
}  elsif($frmFlds{username} eq "eselan") {
	open (FILEHANDLER1, "+>>/etc/squid/ecelan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/ecelan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/ecelan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/ecelan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/ecelan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "cselan") {
	open (FILEHANDLER1, "+>>/etc/squid/cselan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/cselan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/cselan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/cselan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLopen (FILEHANDLER1, "+>>/etc/squid/cselan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/cselan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/cselan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/cselan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/cselan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
 	#}ER5,"+>> /etc/squid/cselan/match");
	print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "itlan") {
	open (FILEHANDLER1, "+>>/etc/squid/itlan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/itlan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/itlan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/itlan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/itlan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "mechlan") {
	open (FILEHANDLER1, "+>>/etc/squid/mechlan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/mechlan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/mechlan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/mechlan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/mechlan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
} elsif($frmFlds{username} eq "chemlan") {
	open (FILEHANDLER1, "+>>/etc/squid/chemlan/ip");
    print FILEHANDLER1 "$frmFlds{ipaddress}\n";
    open (FILEHANDLER2,"+>>/etc/squid/chemlan/domainname");
    print FILEHANDLER2 "$frmFlds{domainname}\n";
    open(FILEHANDLER3,"+>>/etc/squid/chemlan/content");
    print FILEHANDLER3 "$frmFlds{content}\n";
    open(FILEHANDLER4,"+>>/etc/squid/chemlan/ports");
    print FILEHANDLER4 "$frmFlds{port}\n";
    open(FILEHANDLER5,"+>> /etc/squid/chemlan/match");
    print FILEHANDLER5 "$frmFlds{match}\n";
}
print "Content-Type: text/html \n\n";#header information
print " name : $frmFlds{username}\n";
print " ipaddress: $frmFlds{ipaddress}\n\n";
print "domainname: $frmFlds{domainname}\n\n";
print " port: $frmFlds{port}\n\n";
print " wordmatch: $frmFlds{match}\n\n";
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













