# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package rNa;

#line 941 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/rNa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/rNa/sSa.al)"
sub sSa {
 my ($self, $isadm, $xZa, $page, $vXa, $vIa, $pat, $detail, $sortkey, $sortorder, $oformat, $extract_fields) = @_;
 	my $vOa = $self->uFa($xZa, "def");
 	my $form = new aLa($xZa);
 	$form->cDa($vOa);
 	my $design = aLa->new("design", \@uBa, $self->{cgi});
 	my $fmtf = $self->uFa($xZa, "fmt");
 	$design->zOz();
 	$design->load($fmtf);
 	my $usrok = $self->tDa($design->{allowedreaders}) || $self->tDa($design->{extraeditors});
 	#error('deny', "You are not allowed to view data")  if not $usrok;
 my $usermod = $design->{modbyuser};
 	my $wGa = $form->aSa();
 	$form->bSa($design->{fullview}||$wGa);
 	$form->pFa('file', $self->sAa($xZa));
 	$form->pFa('ifile', $self->sAa($xZa,1));
	$form->zQz($self->{cgi});

 	$form->sRa('usedb', $design->{usedb});
 	$form->sRa('bBaA', $xZa);

 my @rows;
 my $id;
 	$design->{uSa} =~ s/^\W+//;
 	$design->{uSa} =~ s/\W+$//;
 my $pgsz = $design->{pagesize} || 20;
 	my @idxes = split /\W+/, $design->{uSa};

 if($design->{wBa}) {
		$self->tHa();
 }
 if(not ($isadm  || $usrok || $design->{vAa} || $design->{wBa})) {
 		error("deny", "Access to data is restricted to administrator");
	}
 my $uXa = $self->uFa($xZa, "idx");

 	my $DBT = $design->{usedb} ? 'zGa' : 'jEa';
 	require zGa if $design->{usedb};
 	my $uNa = $DBT->new($uXa, {schema=>"FMDataIndex"});

 my $jKa = $uNa->iQa({noerr=>1});
 my @ids = map { $_->[0] } @$jKa;
 my $tot = @ids;
 my $pgs = int ($tot/$pgsz) + (($tot%$pgsz)?1:0);
 my $sidx = $pgsz * $page;
 my $eidx = $sidx + $pgsz -1;
 $eidx = $tot -1 if $eidx > $tot -1;
 if($page eq 'A') {
		$sidx =0; $eidx = $tot -1;
 }
 my $ix=0; 
 for $ix ( $sidx..$eidx ) {
		my $row = $jKa->[$ix];
 my $t =  $row->[2];
		my $did = $row->[0];
		next if (($vXa && $t < $vXa)  || ($vIa && $t> $vIa));
		my $matched =0;
		$form->load($self->rXa($xZa, $did), undef, {aefpid=>$did});
 if($design->{usedb}) {
			push @$row, @{$form}{@idxes};

 }else {
			my $i =7; 
			for(@idxes) {
				$row->[$i] = $form->{$_};
				$i++;
			}
 }
		if($pat) {
			my @arr = $form->dHa();
			for(@arr) {
				$matched = 1 if $_ =~ /$pat/i;
				last if $matched;
			}
		}
 if ($matched || not $pat) {
 	push @rows, $row;
		}
 }

 my $sortidx=-1;
	my $i=0;
 my @idxfn;
	for (; $i< scalar(@idxes); $i++) {
		if (lc($idxes[$i]) eq lc($sortkey)) {
			$sortidx = $i;
			$sortidx += 7;
 }
		$idxfn[$i] = $form->yIa($idxes[$i]);
	}

	if($sortidx >=0) {
		@rows = sort {$a->[$sortidx] cmp $b->[$sortidx]} @rows ;
		@rows = reverse @rows if $sortorder eq 'd';
	}
 my @rowsb;
	my $curusr = lc($self->{wOa});
 for my $jRa (@rows) {
		my @row;
 my $id = $jRa->[0];
 my $t = $jRa->[2];
 my $mt = $jRa->[3];
 my $kQz = $jRa->[4];
 
		my $uKa= sVa::sTa($self->{cgi}, {_aefcmd_=>'uGa', idx=>$id, uVa=>$xZa});
		my $uMa= "#$id";

		my $umod = "";
 if($curusr eq lc($kQz)) {
 	$umod = sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$id, uVa=>$xZa, byusr=>1}), "Modify");
			$kQz = qq(<font color="#cc0000">$kQz</font>);
 }else {
			next if not $usrok;
 }

		if($design->{usedb}) {
			$form->load($self->rXa($xZa, $id), undef, {aefpid=>$id});
		}

		for($i=0; $i<scalar(@idxes); $i++) {
			my $k = $idxes[$i];
			my $v;
			if($design->{usedb}) {
				$v = $form->{$k};
			}else {
				$v = $jRa->[$i+7];
			}
			if($detail) {
 		push @row, sVa::cUz($uMa, $form->rYa($k, $v) );
			}else {
 		push @row, sVa::cUz($uKa, $form->rYa($k, $v) );
 }
 }

		if($usrok || $isadm) {
			push @row, $kQz;
		}

 	push @row, sVa::cUz($uKa, sVa::dU('STD', $t, 'oP'));
 
	        if($isadm) {
 	push @row, 
 	sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"rFa", idx=>$id, uVa=>$xZa}), "Delete").
 	"  ".sVa::cUz(sVa::sTa($self->{cgi}, {_aefcmd_=>"moddata", idx=>$id, uVa=>$xZa}), "Modify");
 }else {
			push @row, $umod;
		}

 push @rowsb, [@row];
 }

	sVa::gYaA "Content-type: text/html\n\n";
 print $self->{header};
 print sVa::tWa();
 my $nav = $self->yMa('didx', $xZa);
 	print $nav, qq(<br>);

 	print qq(<div class="pagelist">Page );
 for ( $i=0; $i < $pgs; $i++) {
 my $p = $i+1;
 	if ($i ne $page) {
 		print sVa::cUz(sVa::sTa($self->{cgi_full}, {_aefcmd_=>'dataidx', uVa=>$xZa, pg=>$i}), $p), " \&nbsp";
 }else {
			print "<font color=red><b>$p</b></font>";
 }
 }
 	print qq(</div>);
 if(@rowsb) {
 	        print qq(<div align="center"><b>), "Showing ",  scalar(@rowsb), qq( entries.</b>);
		if($vIa || $vXa || $pat) {
			print "<br>";
			if($vXa){
				print sVa::dU("SHORT", $vXa, "oP"), "--";
			}
			if($vIa){
				print sVa::dU("SHORT", $vIa, "oP"), "--";
			}
			if($pat) {
				print "Match pattern: $pat";
			}
		}
		print "</div>";
		if( $usrok || $isadm) {
 		print sVa::fMa(
 				ths=>[map{ qq(<font color="white">$_</font>) } (@idxfn, "User", "Time", "" )],
 		rows=>\@rowsb, sVa::oVa($tabattr));
		}else {
 		print sVa::fMa(
 				ths=>[map{ qq(<font color="white">$_</font>) } (@idxfn, "Time", "" )],
 		rows=>\@rowsb, sVa::oVa($tabattr));
		}

 }else {

 	print "<center>No data found</center>";
 }
 my $sf= aLa->new("find", \@vVa, $self->{cgi});
	#$sf->sRa('flat', 1);
	$sf->dNa('uVa',$xZa);
	$sf->aCa([sortkey=> "select", "=----\n".join("\n", map {lc($_)."=$_"} @idxes), "Sort by", $sortkey]); 
	$sf->dNa('sortorder',$sortorder);
	print "<center>", $sf->form(), "</center>";
	if($detail) {
		print "<p><pre>\n";
 	for my $idx (@rows) {
			my ($id, $t) = @$idx;
			$form->load($self->rXa($xZa, $id), undef, {aefpid=>$id});
			print qq(<a name="$id"><br>);
			if(scalar(@$extract_fields)>0) {	
				print join("\t", @{$form}{@$extract_fields}), "\n";
				
			}else {
				print $form->form(1);
			}
		}
		print "</pre>";
	}
 print $self->{footer};			
}

# end of rNa::sSa
1;
