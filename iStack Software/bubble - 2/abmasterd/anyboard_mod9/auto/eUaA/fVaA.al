# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eUaA;

#line 170 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eUaA.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eUaA/fVaA.al)"
sub fVaA {
	my ($self, $input) = @_;
	my $sk = $input->{sortkey};
	my $dsc = $input->{dsc};
	my $docd = $self->{docdir};
	my $kQz = $self->{kQz};
	my @dlist = $docd->list();
	my @dsca=();
	$dsca[$sk] = !$dsc;
	 
	my @rows;
	my @zJz=(1, 3, 4, 6, 7);
	my $skidx = $zJz[$sk];
	
	if($sk == 3 || $sk == 4) {
		@dlist = sort {$a->[2] cmp $b->[2] || $a->[$skidx] <=> $b->[$skidx] } @dlist;
	}else {
		@dlist = sort {$a->[2] cmp $b->[2] || $a->[$skidx] cmp $b->[$skidx] } @dlist;
	}
	@dlist = reverse @dlist if $dsc;

	my %uidmap = ();
	my $filecnt=0;
	my $filesize=0;
	my $dircnt=0;
	for(@dlist) {
		my ($path, $name, $type, $perm, $gJz, $gid, $size, $mtime, $ctime)  = @$_;
		my $url;
		my $lnk;
		my $icon;
		my @cmds;
		if(not exists $uidmap{$gJz}) {
			$uidmap{$gJz} = eval 'getpwuid($gJz)';
			$uidmap{$gJz} = $gJz if $uidmap{$gJz} eq "";
		}
		my $usru = $uidmap{$gJz};
			
		if($type eq 'TDIR') {
		   next if $name eq '.';
		   next if $name eq '..' && $docd->path() eq "";
		   $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>sVa::kZz($docd->path(),$name) });
		   $lnk = sVa::cUz($url, $name eq '..'? "Parent folder": $name);
		   $icon = $self->eWaA($type, $name);
		   if($name ne '..') {
		   	my $du = sVa::sTa($self->{cgi}, {docmancmd=>'deletesubdir', kQz=>$kQz, dir=>$docd->path(), dsc=>$dsc, filename=>$name, sortkey=>$sk, confirm=>1});
		   	my $dulnk = sVa::fUaA($du, "Delete", "Are you sure you want to delete the folder $name ?");
		   	push @cmds, $dulnk;
			$dircnt ++;
		   }
		}elsif($type eq 'TFILE') {
		   $url = sVa::sTa($self->{cgi}, {docmancmd=>'fDaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
		   $lnk = sVa::hFa($url, $name, "_tgt");
		   $icon = $self->eWaA($type, $name);
		   if(sVa::fIaA($name) =~ /text|octet-stream/ ) {
		   	my $edu = sVa::sTa($self->{cgi}, {docmancmd=>'rA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
			my $edulnk = sVa::hFa($edu, "Edit", "_ed");
			push @cmds, $edulnk;

		   }
		   my $du = sVa::sTa($self->{cgi}, {docmancmd=>'fAaA', kQz=>$kQz, dir=>$docd->path(), dsc=>$dsc, filename=>$name, sortkey=>$sk, confirm=>1});
		   my $dulnk = sVa::fUaA($du, "Delete", "Are you sure you want to delete the file $name ?");
		   my $ru = sVa::sTa($self->{cgi}, {docmancmd=>'fGaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name});
		   my $rulnk = sVa::hFa($ru, "Replace", "_ed");
		   push @cmds, $rulnk, $dulnk;
		   $filecnt ++;
		}
		push @rows, [$icon." ".$lnk, 
			sVa::hFa(
		   		sVa::sTa($self->{cgi}, {docmancmd=>'eZaA', kQz=>$kQz, dir=>$docd->path(), filename=>$name}),
				sprintf("%04o",$perm) 
			),
			$kQz, 
			qq(<span class="FileSize" title="$size bytes">).sVa::fWaA($size).qq(</span>), 
			sVa::dU('STD',$mtime, 'oP'),
			join(" ", @cmds) ];
		
	}
	my $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path()});
	my @ths = ("Filename", "Permission", "User ID", "Size", "Time", "Commands");
	@ths = map { qq(<a href="$url;sortkey=$_;dsc=). $dsca[$_]. qq("><font color="#ffcc00">).$ths[$_].qq(</font></a>) } 0..4; 
 	sVa::gYaA "Content-type: text/html\n\n";
 	print $self->{header};
 	print sVa::tWa();
	print $input->{msg} if $input->{msg} ne "";
	my @ds = split ("/", $docd->path());
	my $pp ="/";
	my $cp = pop @ds;
	my @ps;
	for my $d(@ds) {
		$pp =sVa::kZz($pp, $d);
		my $url = sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$pp });
		my $lnk = sVa::cUz($url, $d||"Top level");
		push @ps, $lnk;
	}
	push @ps, sVa::cUz(sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() }), qq(<b>$cp</b>));
	print join(" <b>&gt&gt;</b> ", @ps);

 my $upformurl = sVa::sTa($self->{cgi}, {docmancmd=>'fHaA', kQz=>$kQz, dir=>$docd->path()});
	my $upformlnk = sVa::hFa($upformurl, "Upload files");
 my $addformurl = sVa::sTa($self->{cgi}, {docmancmd=>'rA', kQz=>$kQz, dir=>$docd->path()});
	my $addformlnk= sVa::hFa($addformurl, "New text file");
 my $mkdirurl = sVa::sTa($self->{cgi}, {docmancmd=>'fNaA', kQz=>$kQz, dir=>$docd->path()});
	my $mkdirlnk= sVa::hFa($mkdirurl, "New folder");

	my @navlnks = ($upformlnk, $addformlnk, $mkdirlnk);
	push @navlnks, $self->{vSa},   sVa::cUz($self->{uQa}, "Main page");

	print "<br>", join(" \&nbsp;|\&nbsp; ", @navlnks);

	my $colsel = [0..5];
	if($self->{_short_view}) {
		$colsel = [0, 3,4,5]; 
	}
 	print sVa::fMa(ths=>\@ths, rows=>\@rows, colsel=>$colsel,  sVa::oVa($tabattr));
	print "<p>";
	print "Folder path: ", sVa::cUz(sVa::sTa($self->{cgi}, {docmancmd=>'fVaA', kQz=>$kQz, dir=>$docd->path() }), $docd->path() || "Top level"), "<br>";
	print "Number of files: $filecnt<br>";
	print "Number of folders: $dircnt<br>" if $dircnt >0;
 	print $self->{footer};
}

# end of eUaA::fVaA
1;
