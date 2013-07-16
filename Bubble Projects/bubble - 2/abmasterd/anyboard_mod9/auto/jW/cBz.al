# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package jW;

#line 3069 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/jW.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/jW/cBz.al)"
sub cBz {
 my ($self) = @_; 
 return if $abmain::use_sql;
 my @pN;
 my $line;
 my $ddir= $self->nDz('iC');
 my $mf= $self->nDz('msglist');
 my $ftmp = $mf."_t";
 open F, ">$ftmp";
 opendir DIR, $ddir or abmain::error('sys', "Fail to open directory: $!");
 local $_;
LOOP2: while($_ = readdir DIR) {
	   next if $_ !~ /\.dat$/;
 my $file= abmain::kZz($ddir, $_) ; 
 	   my $entry = lB->new ();
 if($entry->load($self, 0, $file)) {
		$entry->{body}= undef;
		delete $entry->{body};
		push @pN, $entry;
 print F join("\t", @{$entry}{@lB::mfs}), "\n";
		next LOOP2;
	   }

 open pK, "<$file" or next; 
 while(<pK>) {
 if(/<!--X=([^\n]+)-->/) {
 	       my $entry = lB->new ( split /\t/, $1);
 close pK;
	       $entry->nBa($self);
	       $entry->{body}= undef;
	       delete $entry->{body};
 push @pN, $entry;
 print F join("\t", @{$entry}{@lB::mfs}), "\n";
 next LOOP2;
 }
 }
 close pK;
 }
 close F;
 @pN = sort { $a->{mM} <=> $b->{mM} } @pN;
 $self->oF();
 my @rows;
 for(@pN) {
 push @rows, [@{$_}{@lB::mfs}];
 }
 $bYaA->new($mf, {index=>2, schema=>"AbMsgList", paths=>$self->dHaA($mf) } )->iRa(\@rows, {kG=>"On writing file $mf: $!"});
 $self->pG();
}

# end of jW::cBz
1;
