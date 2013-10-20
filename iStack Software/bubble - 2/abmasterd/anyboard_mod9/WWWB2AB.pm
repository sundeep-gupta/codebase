package WWWB2AB;


use strict;

#This program converts WWWBoard to AnyBoard
# see http://netbula.com/anyboard/abformat.html

use vars qw(%mons %days_cnt @mfs @mfs2 %proced $ABDir $wwwboard_dir);

%mons =
 ('Jan',1,'Feb',2,'Mar',3,'Apr',4,'May',5,'Jun',6,
 'Jul',7,'Aug',8,'Sep',9,'Oct',10,'Nov',11,'Dec',12);
%days_cnt =
 (1,0,2,31,3,59,4,90,5,120,6,151,7,181,
 8,212,9,243,10,273,11,304,12,334);

@mfs = qw(aK jE fI wW hC mM size pQ xE email eZz 
	to mood tP rhost mtime scat track kRa attached_objtype attached_objid status rate cnt viscnt fpos readers sort_key key_words);
@mfs2 = qw(rlink_title img aliases body hack modifier);

%proced=();
sub convert_wwwforum{
	my ($w3bmdir, $abdir) = @_;
	$wwwboard_dir = $w3bmdir;
	$ABDir = $abdir;

	print "Content-type: text/html\n\n";
	print "<html><body><pre>";

	print "\nConverting Messages in $wwwboard_dir....\n";

	unlink "$ABDir/.msglist"; #let's delete the old index file

	if(not opendir (MESSAGES,$wwwboard_dir)) {
		 print "Error: Can't open $wwwboard_dir:$!\n";
		 return 0;
		 
	}
	my @messages = readdir (MESSAGES);
	closedir (MESSAGES);
	my @mnos;
	foreach my $message (@messages) {
		$message =~ /(\d+)\.(\w+)$/;
		my $cG = $1;
		my $ext = $2;
		push @mnos, [$cG, $ext];
	}
	for my $mref (sort {$a->[0] <=> $b->[0]} @mnos) {
		my ($cG, $ext) = ($mref->[0], $mref->[1]);
		next if $proced{$cG};
		convert_msg($cG,0,$ext);
	}
	print "\nFinished conversion: now AnyBoard will regenerate the forum, this may take a while \n";
	print "</pre>\n";
	return 1 if scalar(@mnos);
}

#The function below takes a hash which contains the message fields

sub write_ab_msg{
 my %msg = @_;
 return if not $msg{fI}; #error, missing sequence number
 return if not $msg{aK};  #error, missing top sequence number
 local *INDEX;
 local *MSGDAT;
 open INDEX, ">>$ABDir/.msglist"; #append to index
 for(@mfs) {
	$msg{$_} =~ s/(\t|\n)/ /g; #make sure we don't have tabs in original data
 }
 print INDEX join("\t", @msg{@mfs}), "\n";
 close INDEX;

 my $df= "$ABDir/postdata/".$msg{fI}.".dat";
 open MSGDAT, ">$df" or die "Can't open file $df:$!";
 print MSGDAT "AB8DF\n";
 my $Bound="WWWCONV_SAGGSAGSAHAOSOSIQ".time().rand(); #just some random string
 $Bound =~ s/\.//g;
 print MSGDAT 
 "Content-type: multipart/form-data; boundary=$Bound\n",
 "Content-disposition: form-data; name=message_data$msg{fI}\n\n";
 for(@mfs, @mfs2) {
	print MSGDAT "--$Bound\n";
	print MSGDAT "Content-disposition: form-data; name=$_\n",
 "Content-type: text/plain\n\n";
 print MSGDAT $msg{$_}, "\n";
 }
 print MSGDAT "--$Bound--\n";
 close MSGDAT;
 print "wrote message $msg{fI}\n";
}



sub convert_msg{
 my ($msg, $top, $w3b_ext) = @_;
 $proced{$msg} = 1;
	local *FILE;
	if(not open (FILE, "$wwwboard_dir/$msg.$w3b_ext")) {
		print "Can't open file: $wwwboard_dir/$msg.$w3b_ext: $!\n";

 }
	my @file = <FILE>;
	close (FILE);
	my $title = "";
	my $hC = "";
	my $email = "";
	my $date = "";
	my $body = "";
	my $jE = 0;
	my @followups;
	my $textarea = 0;
 my $see_author=0;
	foreach my $line (@file) {
		if ($textarea == 0) {
			if ($line =~ /<title>(.*)<\/title>/i) {
				$title = $1;
			}
			elsif
			  (($line =~
			  /Posted by <a href="mailto:(.*)">(.*)<\/a> \(.*\)/i)
			  || ($line =~
			  /Posted by <a href="mailto:(.*)">(.*)<\/a>/i)) {
				$email = $1;
				$hC = $2;
				$see_author=1;
			}
			elsif
			  (($line =~ /Posted by (.*) \(.*\)/i)
			  || ($line =~ /Posted by (.*)/i)) {
				$hC = $1;
				$date = $2;
				$see_author=1;
			}
			if($see_author==1 && $line =~ /on (.*):<p>/i) {
				$date = $1;
				$textarea = 1;
				$see_author =2;
 }
			next;
		}
		elsif ($textarea == 1) {
			if ($line =~ /In Reply to: <a\s+href="(\d+).$w3b_ext">/i) {
				$jE = $1;
				if($top ==0 && $jE){
					print "trying to do non-top $msg\n";
					return;
				}
			}
			elsif ($line =~ /<a name="followups">/i) {
				$textarea = 2;
			}
			else {
				$body = $body.$line;
			}
			next;
		}
		elsif ($textarea == 2) {
			if ($line =~ /<a\s+href="(\d+).$w3b_ext">/i) {
				push (@followups,$1);
			}
			elsif ($line =~ /<a name="postfp">/i) {
				last;
			}
			next;
		}
	}
 if($top==0 && not $jE){
		$top = $msg;
 }
	return unless ($title);

	if ($date =~ /(\w*) (\d*), (\d*) at (\d*):(\d*):(\d*)/) {
		my $mon = $1;
		my $nQ = int($2);
		my $year = int($3);
		my $hour = int($4);
		my $min = int($5);
		my $sec = int($6);
		if ($year > 19000) { $year -= 17100; }
		$year -= 1900;
		$mon = substr($mon,0,3);
		$mon = int($mons{$mon});
		my $mdays = (($year-69)*365)+(int(($year-69)/4));
		$mdays += $days_cnt{$mon};
		if ((int(($year-68)/4) eq (($year-68)/4)) && ($mon>2)) { $mdays++; }
		$mdays += $nQ;
		$mdays -= 366;
		$date = ($mdays*86400)+18000;
		my $dsthour = (localtime($date))[2];
		if ($dsthour>0) { $date-=3600; }
		$date += ($hour*3600);
		$date += ($min*60);
		$date += $sec;
 }
 write_ab_msg(
		aK=>$top, jE=>$jE,
 		 fI=>$msg, wW=>$title,
 		 hC=>$hC, email=>$email,
			mM=>$date, body=>$body, size=>length($body)
 );
 return if $jE;
 print "Converting followups: ", join(" ", @followups),"\n" if @followups;
 for(@followups) {
	#recurse to followups
	convert_msg($_, $top, $w3b_ext);
 }
}

1;
