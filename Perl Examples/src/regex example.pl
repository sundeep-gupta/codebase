$scalar = "The root has many leaves";

print("String has root.\n") if $scalar =~ m/root/;

$scalar =~ s/root/tree/;

$scalar =~ tr/h/H/;

print("\$scalar = $scalar\n");

print("printing at \@ sundeep");
