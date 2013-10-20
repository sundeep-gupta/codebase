# configuration file for xml_engine.pl

@header_list =
  (
   {
    type     => "SYSTEM",
    attr     => "UpTime",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },

   {
    type     => "SYSTEM",
    attr     => "Started",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "HostName",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "Version",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "BuildNumber",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "ExecutableName",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "PrimaryLicenseFileStatus",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SecondaryLicenseFileStatus",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },

  );


@title  =
  qw(
     BigMatcher
     Insert
     Zlib
     Lzs
     DataFile
     Run_Time
     DelayRouterScript
     SlowBytesTransmitted
     LineRate(MBitsperSec)
     CompressionClearTextBytes
     CompressionCipherTextBytes
     CompressionRatio
     TestTimeStamp
     TimeStamp

     LastErrors
     ClearErrors
     StartingLogRecordNumber
     PassthroughReason
     Passthrough
     ActiveRecvEndPoints
     DesiredRecvWindow
     AvailablePackets
     RecvWindowRatio
     TotalPacketCount
     VMConsumption
     PassThroughTableSize
     SocketCount
     SkbuffTotal
     SkbuffActive
     FastPayloadTransmittedGood
     FastBytesTransmitted
     SlowPayloadTransmittedGood
     FastPayloadReceivedGood
     FastBytesReceived
     SlowPayloadReceivedGood
     SlowBytesReceived
     VMUsage
     CompressionRewindTextBytes
     CompressionRewinds
     DecompressionClearTextBytes
     DecompressionCipherTextBytes
     DecompressionRewinds
     CompressConnectionCount
     CompressSendPacketCount
     CompressRecvPacketCount
     ProcessID
    );



@config_list = 
  (
   {
    type     => "",
    attr     => "Test Setting",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "stringliteral",
    action   => "Get",
    value    => "\$test_setting",
   },

   {
    type     => "",
    attr     => "RunTime",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "literal",
    action   => "Get",
    value    => "\$run_time",
   },

   {
    type     => "",
    attr     => "Delay Setting",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "literal",
    action   => "Get",
    value    => "\$delay_setting",
   },

   {
    type     => "SYSTEM",
    attr     => "SlowBytesTransmitted",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },

   {
    type     => "SYSTEM",
    attr     => "CompressionClearTextBytes",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },

   {
    type     => "SYSTEM",
    attr     => "CompressionCipherTextBytes",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },

   {
    type     => "",
    attr     => "TestTimeStamp",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "literal",
    action   => "Get",
    value    => "\$time_stamp",
   },




   {
    type     => "SYSTEM",
    attr     => "TimeStamp",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "LastErrors",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "ClearErrors",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "StartingLogRecordNumber",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "PassthroughReason",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "Passthrough",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "ActiveRecvEndPoints",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "DesiredRecvWindow",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "AvailablePackets",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "RecvWindowRatio",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "TotalPacketCount",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "VMConsumption",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "PassThroughTableSize",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SocketCount",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SkbuffTotal",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SkbuffActive",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "FastPayloadTransmittedGood",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "FastBytesTransmitted",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SlowPayloadTransmittedGood",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "FastPayloadReceivedGood",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "FastBytesReceived",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SlowPayloadReceivedGood",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "SlowBytesReceived",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "VMUsage",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },

   {
    type     => "SYSTEM",
    attr     => "CompressionRewindTextBytes",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "CompressionRewinds",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "DecompressionClearTextBytes",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "DecompressionCipherTextBytes",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "DecompressionRewinds",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "arrayofhashofhash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "CompressConnectionCount",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "CompressSendPacketCount",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "CompressRecvPacketCount",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
   {
    type     => "SYSTEM",
    attr     => "ProcessID",
    set      => "",
    callback => "",
    print_callback => "",
    datatype => "hash",
    action   => "Get",
    value    => "",
   },
  );
