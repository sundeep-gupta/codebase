#!/usr/bin/perl
 #!/usr/bin/perl –w

my(%frmFlds); #defining local variable
%frmFlds=getFormData(); #calling getFormData function
print "Content-Type: text/html\n\n";#header information
print "<html><title> USERS LIST </TITLE>";
print "<body bgcolor=\"#ffddbb\">";
print "the member in";
print $file{branches};
print "are\n";

if($file{branches} eq "ece") {
	`cat /etc/squid/ecelanusers > test` ;#concatinating files
    print `uniq test`;
}

if($file{branches} eq "eee") {
	`cat /etc/squid/eeelanusers > test` ;
    print `uniq test`;
}

if($file{branches} eq "cse") {
	`cat /etc/squid/cselanusers > test` ;
    print `uniq test`;
}

if($file{branches} eq "it"){
	`cat /etc/squid/itlanusers > test` ;
    print `uniq test`;
}

if($file{branches} eq "mec") {
	`cat /etc/squid/meclanusers > test` ;
    print `uniq test`;
}

if($file{branches} eq "chem") {
	`cat /etc/squid/chemlanusers > test` ;
    print `uniq test`;
}

print"</body></html>";


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