use Win32::IPHelper;
use Data::Dumper;

#my $adapter_desc = 'Intel(R) PRO/1000 EB Network Connection with I/O Acceleration #2';
#add_ip_address($adapter_desc,'172.32.2.120','255.255.255.0');
sub add_ip_address {
    my ($adapter_desc, $new_ip, $mask) = @_;
	my ($IfIndex, $NTEContext,$NTEInstance, @IP_ADAPTER_INFO);

    $ret = Win32::IPHelper::GetAdaptersInfo(\@IP_ADAPTER_INFO);
	$ip_err =  ($ret == 0)? undef : "GetAdaptersInfo() error %u: %s\n", $ret, Win32::FormatMessage($ret);
	return undef  if $ip_err;

	my $adapter_name = undef;
	foreach $adapter (@IP_ADAPTER_INFO) {
		if($adapter->{'Description'} eq $adapter_desc) {
			$adapter_name = $adapter->{'AdapterName'};
		}
	}
	$ip_err =  ($adapter_name) ? undef : "Could not find the adapter with given description";
	return undef if $ip_err;

	$ret = Win32::IPHelper::GetAdapterIndex(\$adapter_name ,\$IfIndex);
	$ip_err =  ($ret == 0)? undef : "GetAdapterIndex() error %u: %s\n", $ret, Win32::FormatMessage($ret);
	return undef  if $ip_err;

	$ret = Win32::IPHelper::AddIPAddress($new_ip,$mask,$IfIndex,\$NTEContext,\$NTEInstance);
	$ip_err =  ($ret == 0)? undef : "AddIPAddress() error %u: %s\n", $ret, Win32::FormatMessage($ret);
	return undef if $ip_err;

	return $NTEContext; # Return the context to which IP is added.
}

1;
