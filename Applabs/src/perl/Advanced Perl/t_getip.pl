        use Win32::IPHelper;
  use Data::Dumper;

    my @IP_ADAPTER_INFO;
  $ret = Win32::IPHelper::GetAdaptersInfo(\@IP_ADAPTER_INFO);

  if($ret == 0)
  {
    print Data::Dumper->Dump([\@IP_ADAPTER_INFO], [qw(IP_ADAPTER_INFO)]);
  }
  else
  {
    printf "GetAdaptersInfo() error %u: %s\n", $ret, Win32::FormatMessage($ret);
  }