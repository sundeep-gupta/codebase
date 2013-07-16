# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 274 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/query.al)"
sub query { 	
	my ($self, $pats, $reg) = @_;
	my $kFa= $self->{kFa};
	my $filesdbpath = $self->{filesdbpath};
	my $titlesdbpath = $self->{titlesdbpath};
	my %indexdb;
	my %filesdb;
	my %titlesdb;
	return undef unless (-f $kFa && -r _);
	return undef unless (-f $filesdbpath && -r _);
	return undef unless (-f $titlesdbpath && -r _);
	return undef unless	
		eJa(\%indexdb,$kFa, $eCa::sep); 
	my %matches;
	my %limit;
	my %exclude;
	my @ignored;
	my $key;
	my $word;
	my $mustbe_words = 0;
	my @words = ();
	my $glob_regexp = undef;
	for (@$pats) {		# globbing feature... e.g. uni* passw?
		if ($reg || /\*|\?/) {
			s/\*/\.\*/g;
			s/\?/\./g;
			if ($reg) {
				s/$/\.\*/;
				s/^/\.\*/;
 }
			$glob_regexp = $glob_regexp ? $glob_regexp."|^$_\$" : "^$_\$" ;
		}
		else {
			push @words, $_;
		}
	}
	if ($glob_regexp) {
		my $regexp = qq/$glob_regexp/;
		eBa(\%indexdb, \@words, $regexp);
	}

	#DEBUG("looking up ", join(", ", @words ), "\n");
	foreach $word (@words) {
		my $rc = 0;
#		#DEBUG($word);
		if ($word =~ /^-(.*)/) {
 			my $keys = $indexdb{lc $1};
			$rc = eKa($keys,\%exclude);
		} elsif ($word =~ /^\+(.*)/) {
			$mustbe_words++;
 			my $keys = $indexdb{lc $1};
			$rc = eKa($keys,\%limit);
		} else {
 			my $keys = $indexdb{lc $word};
			$rc = eKa($keys,\%matches);
		}
#		#DEBUG("\n");
		if (not $rc) { push @ignored, $word }
	}
	
	if ($mustbe_words) {
		for $key(keys %limit) {
			next unless $limit{$key} >= $mustbe_words;
			$matches{$key}  += $limit{$key} ;
		}
		for $key(keys %matches) {
			delete $matches{$key} unless $limit{$key};
		}
	}
	for $key(keys %exclude) {
		delete $matches{$key};
	}
	my $result =  eOa(\%matches,$filesdbpath, $titlesdbpath, \@words, \@ignored);
	untie(%indexdb);
	return $result;
}

# end of eCa::query
1;
