# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package eCa;

#line 109 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/eCa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/eCa/eIa.al)"
#notes on eIa();

sub eIa {
	my $self = shift;
	my $expr = shift;
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
	my @ignored = ();
	my @words = ();
	my $verbose_flag_tmp = $verbose_flag;
	$verbose_flag = shift;
	chomp $expr;	
	undef $syntax_error;
	#DEBUG("********** dOa() debug **********\n");	
	my $match = dOa($expr, \%indexdb, \@ignored);
	#DEBUG("**********         end debug         **********\n");	
	if ($syntax_error) {
		$errstr = $syntax_error;
		$verbose_flag = $verbose_flag_tmp;
		return undef;
	}
	my $result =  eOa($match,$filesdbpath, $titlesdbpath, \@words, \@ignored);
	
	untie(%indexdb);
	untie(%filesdb);
	untie(%titlesdb);
	$verbose_flag = $verbose_flag_tmp;
	return $result;
}

# end of eCa::eIa
1;
