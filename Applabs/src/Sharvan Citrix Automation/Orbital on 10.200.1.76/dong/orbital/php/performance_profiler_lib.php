<?
   //
   // Read back and calculate most of the interesting numbers
   //
   $SlowSendRate     = (int)(GetParameter("SlowSendRate"));
   $SimData      	   = OrbitalGet("TCP_SIMULATED");
   $UncompBytesSent  = $SimData["Total_UncompressedBytesSent"];
   $CompBytesSent    = $SimData["Total_CompressedBytesSent"];
   $CompRatioSent    = FormatRatio($UncompBytesSent,	$CompBytesSent);

   $UncompBytesRecv  = $SimData["Total_UncompressedBytesRecv"];
   $CompBytesRecv    = $SimData["Total_CompressedBytesRecv"];
   $CompRatioRecv    = FormatRatio($UncompBytesRecv,	$CompBytesRecv);

   $TotalBytesXfered = $UncompBytesSent + $UncompBytesRecv;
	$TotalCompRatio   = FormatRatio($UncompBytesSent + $UncompBytesRecv,  $CompBytesSent + $CompBytesRecv);

   $SysStatsTemp              = OrbitalGet("SYSTEM", "TimeSincePerfCounterReset");
   $TimeSincePerfCounterReset = (int)$SysStatsTemp["TimeSincePerfCounterReset"];
   $TTSpeed = $SlowSendRate;

   if ($UncompBytesSent !=0 && $CompBytesSent!=0 && $TimeSincePerfCounterReset!=0) {
      $UncompAvgLineSpeedSent     = ($UncompBytesSent / $TimeSincePerfCounterReset) * 8;
      $CompAvgLineSpeedSent       = ($CompBytesSent   / $TimeSincePerfCounterReset) * 8;
      $EffectiveThroughputSent 	 = ( $UncompBytesSent  / $CompBytesSent ) * $SlowSendRate;
   }else{
      $UncompAvgLineSpeedSent  = 0;
      $CompAvgLineSpeedSent    = 0;
      $EffectiveThroughputSent = 0;
   }
   
   if ($CompBytesRecv!=0 && $UncompBytesRecv!=0 && $TimeSincePerfCounterReset!=0){
      $UncompAvgLineSpeedRecv     = ($UncompBytesRecv / $TimeSincePerfCounterReset) * 8;
      $CompAvgLineSpeedRecv       = ($CompBytesRecv   / $TimeSincePerfCounterReset) * 8;
      $EffectiveThroughputRecv 	 = ($UncompBytesRecv  / $CompBytesRecv ) * $SlowSendRate;
   }else{
      $UncompAvgLineSpeedRecv  = 0;
      $CompAvgLineSpeedRecv    = 0;
      $EffectiveThroughputRecv = 0;
   }
      
   //
   // Achievable line usage requires a bit of a fuzzy math. The assumption is
   // that we can boast the customers line usage is compressed and then boosted
   // up to whatever the customers line capacity is.
   //
   if ($UncompAvgLineSpeedSent > $UncompAvgLineSpeedRecv){  // The sending direction is the limiter
      $TTSpeed = ($UncompBytesSent / $CompBytesSent) * $SlowSendRate;
   }else if($UncompAvgLineSpeedRecv != 0){
      $TTSpeed = ($UncompBytesRecv / $CompBytesRecv) * $SlowSendRate;
   }
?>