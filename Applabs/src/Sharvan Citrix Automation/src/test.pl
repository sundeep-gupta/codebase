

my %hash;
%hash = (
        key1 => 'value1',
        key2 => 'value2',
        key3 => 'value3',
    );


for my $key ( keys %hash ) {
        my $value = $hash{$key};
        print "$key => $value\n";
    }

	@xx = ("adsf","fadf","fasdfsd");
	print $#xx;