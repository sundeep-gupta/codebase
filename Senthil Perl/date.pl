use Date::Calc qw(Delta_Days);
@nat = (2004, 9, 16);      # 16 Jun 1981
@bree  = (2004, 10, 10);      # 18 Jan 1973
$difference = Delta_Days(@nat, @bree);
print "There were $difference days between Nat and Bree\n";

