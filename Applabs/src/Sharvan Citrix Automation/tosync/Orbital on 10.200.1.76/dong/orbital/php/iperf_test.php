<?
   include("includes/orbital_lib.php");
   
   $END_HTML = "\n</pre></body></html>\n";
   $POSSIBLE_RATES = array(
      500, 800, 1000, 1500, 2000, 4000, 5000, 10000, 15000, 25000, 50000, 75000,
      100000, 150000, 200000, 250000, 350000, 450000, 600000, 750000
   );

   function TeeOut($FileHandle, $TextOut) {
      fwrite($FileHandle, $TextOut);
      echo(htmlspecialchars($TextOut));
      flush();
   }

   if (isset($_GET) && is_array($_GET) && sizeof($_GET) > 1) {
      $ServerIP   = $_GET['ServerIP'];
      $ServerPort = $_GET['ServerPort'];
      $MaxRate    = $_GET['MaxSendRate'] * 1000;
      $Duration   = $_GET['Duration'];
   } else {
      $args = isset($argv) && is_array($argv) ? $argv : $_SERVER['argv'];
      if (isset($argv) && is_array($argv) && sizeof($args) >= 4) {
         $ServerIP   = $args[1];
         $ServerPort = $args[2];
         $MaxRate    = $args[3] * 1000;
         $Duration   = $args[4];
      }
   }
   if (! isset($ServerIP) || ! isset($ServerPort) || ! isset($MaxRate) ||
         ! isset($Duration)) {
      echo("The parameters passed in were incorrect. Expecting:\n");
      echo("iperf_test.php HOSTIP PORT MAX_RATE DURATION\n");
      exit($END_HTML);
   }
   if (! ($Output = fopen(SYSTEM_DUMP_DIR . "iperf_test.output", "w"))) {
      exit($END_HTML);
   }
   if ( $_SERVER["HTTP_HOST"] != "127.0.0.1"){
      TeeOut($Output, "Internal Error: iperf client not started from localhost! Aborting test.");
      exit($END_HTML);
   }

   //
   // Start the tests
   //
   error_reporting(E_ALL);
   $PreTestSlowSendRate = GetParameter("SlowSendRate");
   SetParameter("SelfTestRunning", true);

    TeeOut($Output,
      "Beginning batch iperf test...\n" .
      "Max Rate: " . ($MaxRate/1e6) . " Mbps\n" .
      "Server IP: $ServerIP\n" .
      "Test Time: $Duration\n" .
      "\n\n"
   );

   // print results every 10-30 seconds, to prevent http connection timing out.
   if (($PrintInterval = ($Duration / 4 > 30) ? 30 : $Duration / 4) < 10) {
      $PrintInterval = 10;
   }
   $StopFileName = SYSTEM_DUMP_DIR . "iperf_test.stop";
   $LastRate = -1;
   foreach ($POSSIBLE_RATES as $CurRate) {
      if (file_exists($StopFileName)) {
         @unlink($StopFileName);
         break;
      }
      $CurRate *= 1000;
      if ($CurRate > $MaxRate) {
         $CurRate = $MaxRate;
      }
      if ($LastRate == $CurRate) {
         break;
      }
      $LastRate = $CurRate;
      SetParameter("SlowSendRate", $CurRate);
      TeeOut($Output,
         "=====  STARTING TEST AS " .
         (GetParameter("SlowSendRate") / 1e6) .
         " Mbps ======\n"
      );
      $Pipe = popen(
         "iperf" .
         " -c " . escapeshellarg($ServerIP) .
         " -t " . escapeshellarg($Duration) .
         " -p " . escapeshellarg($ServerPort) .
         " -i " . escapeshellarg($PrintInterval) .
         " 2>&1",
         "r"
      );
      while (! feof($Pipe)) {
         TeeOut($Output, fgets($Pipe));
      }
      pclose($Pipe);
      TeeOut($Output, "\n\n");
   }
   TeeOut($Output, "====== TESTS COMPLETE =======\n");
   fclose($Output);

   //
   // Restore the send rate to it's old value
   //
   SetParameter("SlowSendRate", $PreTestSlowSendRate );
   SetParameter("SelfTestRunning", false);
   echo($END_HTML);
?>
