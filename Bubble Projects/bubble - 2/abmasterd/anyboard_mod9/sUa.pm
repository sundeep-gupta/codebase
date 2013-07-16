package sUa;


sub yGz {
 eval 'use AutoSplit';
 my ($xO, $xRa, $outfile, $altf, $no_auto) = @_;

open F, "<$xO" or error("Can't open script $xO: $!");
my @arr = <F>;
close F;

if (not -d $xRa) {
 	mkdir $xRa, 0755 or error("Can't make dir $xRa: $!");
}
my $xTa = kZz($xRa, "auto");
if (not -d $xTa) {
	mkdir $xTa, 0755 or error("Can't make dir $xTa: $!");
}

my $all= join("", @arr);

error('inval', "Can't split the code") if not $all =~ /#IF_AUTO/; 

study $all;

print "Content-type: text/html\n\n";
print "<html><body><h1>Splitting the script, check for errors!!</h1><pre>";


$all =~ s/^zV$//gm;

$all =~ s/^bAz$//gm;


	$all =~ s/^#IF_AUTO\s+//gm;

$all =~ s/"/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9"/"$xRa"/g;

my @aRz = split /(^package\s+[^\n]+;\s*$)/m, $all;
my $main = shift @aRz;
while(@aRz) {
 my $pak = shift @aRz;
 my $code = shift @aRz;
 $code =~ s/^BEG_AUTO_FUNC.*?^BEG_AUTO_FUNC//sm;
 $pak =~ /package\s+(.*);/;
 my $pkn = $1;
 my $pk = kZz($xRa, "$pkn.pm");
 open F, ">$pk";
 print F $pak, "\n", $code;
 close F;
 print "Saving modules $pkn.pm\n";
 AutoSplit::autosplit("$pk", "$xTa");
 print "Split modules $pkn.pm\n";
if($no_auto) {
 $code =~ s/^__END__$/\n/mg;
}else {
 $code =~ s/\n__END__.*/\n/s;

}
 open F, ">$pk";
 print F $pak, "\n", $code;
 close F;
} 

my $use_alt=0;
if($outfile && open (F, ">$outfile")) {
}else {
 $outfile = $altf;
 open F, ">$outfile" or error("On open $outfile: $!");
 $use_alt = 1;
}
print F $main;
close F;
chmod 0755, $outfile;
print "</pre>";
print "The script has been split into smaller files.<br/>";
print qq(<hr/><a href="javascript:history.go(-1)">Go back</a></body></html>);

}
sub kZz{
 my ($root, @compos)= @_;
 for(@compos) {
	last if not $_;
 $_ =~ s#^/?##;
 $root =~ s#/*$#/#;
 $root .= $_; 
 }
 return $root;
}

sub error{
	my ($msg)= @_; 
	print "Content-type: text/html\n\n";
	print "<html><body><font color=red>$msg</font></body></html>";
	exit(0);
}
1;

