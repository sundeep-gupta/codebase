package sNa;


BEGIN{
 use vars qw(@zIz);
 @zIz = (
 [MC=> '5[1-5]', 16, 10, "Master Card"],
 [VISA=>'4', 16, 10, "Visa"],
 [VISA=>'4', 13, 10, "Visa"],
 [DISC=>'6011', 16, 10, "Discover"],
 [AMEX=>'34|37', 15, 10, "American Express"],
 [DCCB=>'30[0-5]|36|38', 14, 10, "Diners Club/Carte Blanche"],
 [JCB=>'3', 16, 10, "JCB"],
 [ENR=>'2014|2149', 15, 1, "enRoute"],
 [JCB=>'2131|1800', 15, 10, "JCB"]
 );
}

sub zYz{
 my $zUz = shift;
 $zUz =~ s/\D//g;
 my @digits = reverse split //, $zUz;
 my $len = length($zUz);
 return undef if($len < 13);
 my $sum =0;
 for(my $i=0; $i<$len; $i++) {
 my $tmp = $digits[$i]*(1+ ($i%2));
	$sum += int $tmp/10 + $tmp%10;

 }

 for (@zIz) {
 next if $len != $_->[2];
 next if not $zUz =~ /^($_->[1])/;
 next if ($sum % $_->[3]);
 return $_->[0];
 }
 return undef;
}

1;
