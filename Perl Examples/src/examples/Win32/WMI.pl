use strict;
use Win32::OLE('in');

use constant wbemFlagReturnImmediately => 0x10;
use constant wbemFlagForwardOnly => 0x20;

my @computers = (".");
foreach my $computer (@computers) {
   print "\n";
   print "==========================================\n";
   print "Computer: $computer\n";
   print "==========================================\n";

   my $objWMIService = Win32::OLE->GetObject("winmgmts:\\\\$computer\\root\\CIMV2") or die "WMI connection failed.\n";
   my $colItems = $objWMIService->ExecQuery("SELECT * FROM Win32_PerfRawData_PerfOS_Memory", "WQL",
                  wbemFlagReturnImmediately | wbemFlagForwardOnly);

   foreach my $objItem (in $colItems) {
      print "AvailableBytes: $objItem->{AvailableBytes}\n";
      print "AvailableKBytes: $objItem->{AvailableKBytes}\n";
      print "AvailableMBytes: $objItem->{AvailableMBytes}\n";
      print "CacheBytes: $objItem->{CacheBytes}\n";
      print "CacheBytesPeak: $objItem->{CacheBytesPeak}\n";
      print "CacheFaultsPersec: $objItem->{CacheFaultsPersec}\n";
      print "Caption: $objItem->{Caption}\n";
      print "CommitLimit: $objItem->{CommitLimit}\n";
      print "CommittedBytes: $objItem->{CommittedBytes}\n";
      print "DemandZeroFaultsPersec: $objItem->{DemandZeroFaultsPersec}\n";
      print "Description: $objItem->{Description}\n";
      print "FreeSystemPageTableEntries: $objItem->{FreeSystemPageTableEntries}\n";
      print "Frequency_Object: $objItem->{Frequency_Object}\n";
      print "Frequency_PerfTime: $objItem->{Frequency_PerfTime}\n";
      print "Frequency_Sys100NS: $objItem->{Frequency_Sys100NS}\n";
      print "Name: $objItem->{Name}\n";
      print "PageFaultsPersec: $objItem->{PageFaultsPersec}\n";
      print "PageReadsPersec: $objItem->{PageReadsPersec}\n";
      print "PagesInputPersec: $objItem->{PagesInputPersec}\n";
      print "PagesOutputPersec: $objItem->{PagesOutputPersec}\n";
      print "PagesPersec: $objItem->{PagesPersec}\n";
      print "PageWritesPersec: $objItem->{PageWritesPersec}\n";
      print "PercentCommittedBytesInUse: $objItem->{PercentCommittedBytesInUse}\n";
      print "PercentCommittedBytesInUse_Base: $objItem->{PercentCommittedBytesInUse_Base}\n";
      print "PoolNonpagedAllocs: $objItem->{PoolNonpagedAllocs}\n";
      print "PoolNonpagedBytes: $objItem->{PoolNonpagedBytes}\n";
      print "PoolPagedAllocs: $objItem->{PoolPagedAllocs}\n";
      print "PoolPagedBytes: $objItem->{PoolPagedBytes}\n";
      print "PoolPagedResidentBytes: $objItem->{PoolPagedResidentBytes}\n";
      print "SystemCacheResidentBytes: $objItem->{SystemCacheResidentBytes}\n";
      print "SystemCodeResidentBytes: $objItem->{SystemCodeResidentBytes}\n";
      print "SystemCodeTotalBytes: $objItem->{SystemCodeTotalBytes}\n";
      print "SystemDriverResidentBytes: $objItem->{SystemDriverResidentBytes}\n";
      print "SystemDriverTotalBytes: $objItem->{SystemDriverTotalBytes}\n";
      print "Timestamp_Object: $objItem->{Timestamp_Object}\n";
      print "Timestamp_PerfTime: $objItem->{Timestamp_PerfTime}\n";
      print "Timestamp_Sys100NS: $objItem->{Timestamp_Sys100NS}\n";
      print "TransitionFaultsPersec: $objItem->{TransitionFaultsPersec}\n";
      print "WriteCopiesPersec: $objItem->{WriteCopiesPersec}\n";
      print "\n";
   }
}	