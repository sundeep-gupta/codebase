# NOTE: Derived from /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package dDa;

#line 193 "/home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/dDa.pm (autosplit into /home/httpd/vhosts/bubble.co.in/httpdocs/abmasterd/anyboard_mod9/auto/dDa/eNa.al)"
sub eNa
{
 my($self, $url, $method, $eSa, $dJa, $cook) = @_;
 my($service, $host, $page, $oE);
 my($eEa, $status_s, $eMa);
 my($dTa) = 0;
 my($result) = 0;
 ($service, $host, $page, $oE) = &dKa($url);
 $self->{eQa}=$host;
 $self->{dYa}=$url;
 $self->{_error} =undef;

 if ($service ne "http") {
		printf($dDa::LOG "Error: not an http service [%s]\n", $service)
			if ($dDa::LOG ne "");
		return 0;
 }
 my $status;

OUTERLOOP:
 while ($dTa < $dDa::eGa) {

		print $dDa::LOG "Connecting to [$host$page]..." if ($dDa::LOG ne "");

		if ($oE) {
			$result = $self->dZa($oE, $host);
		}
		else {
			$result = $self->dZa($service, $host);
		}

 		my $nA = $self->{sock};
		if ($result) {

			print $dDa::LOG "connected\n" if ($dDa::LOG ne "");

			# Send the request
			$self->eRa($host, $page, $method, $eSa, $dJa, $cook);

			# Get the status line
			
			my $cnt =4;
			while($cnt >0) {
				my $b;
				my $c = read($nA, $b, $cnt); 
				if ($c <=0) {
					$self->{_error} .= "\nFailed to read response: $!";
					return;
				}
				$status_s .= $b;
				$cnt -= $c;
			}

			if(lc($status_s) ne 'http') {
				$self->finish();
				$self->{_error} .= "\nInvalid reponse line $status_s";
				last;
			}
			$eMa = <$nA>;
			$status = int ((split /\s+/, $eMa)[1]);

			$self->{_stat_line} = $status_s.$eMa;
			$self->eDa();
			if($self->{dMa} && $self->{eTa}->{'content-type'}) {
			            my $tm = $self->{dMa};
				   if($self->{eTa}->{'content-type'} =~ /$tm/io) {
					$self->finish();
					last;
				   }
			}
			$dTa++;
			if ($dTa > $dDa::eGa) {
				last;
			}
			#$status = int ((split /\s+/, $eMa)[1]);

			if ($status == 301 || $status == 302 ){

				$eEa = $self->{eTa}->{location};

				$self->finish();

				if($eEa !~ /^http:/i) {
					$eEa = eAa($self->{dYa}, $eEa);
				}

				print $dDa::LOG "Redirecting [$host$page] to $eEa\n" if ($dDa::LOG ne "");

				# Connect to the new one
				($service, $host, $page) = &dKa($eEa);
				$self->{dYa}= $eEa;
				$self->{eQa} = $host;
				$self->{dSa}->{$eEa} =1 if $self->{dSa};
				$eSa = undef;
				$method = 'GET';
				print $dDa::LOG " [$host$page]\n" if ($dDa::LOG ne "");

				$dTa++;
			} else {
				last;
			}
		} else {
			$self->{_error} .= "\nConnection to $host failed: $!";
			last;
		}
 }

 $self->{cur_status} = $status;
 $result;
}

# end of dDa::eNa
1;
