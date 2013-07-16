<?
	include("header.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<?
   function AddStopButton($IsTestRunning = true)
   {
      if (! $IsTestRunning)
      {
         return;
      }
      echo
         "<br /><center>",
         HTML_FORM::Begin("SelfTestServer"),
         HTML_FORM::AddSubmit("StopTest", "Stop Test"),   
         HTML_FORM::End(),
         "</center><br />\n";
   }

   $IsTestRunning = GetParameter("SelfTestRunning");
   $StopFileName = SYSTEM_DUMP_DIR . "iperf_test.stop";

   if ($IsTestRunning)
   {
      echo HTML::InsertRedirect("./system_test.php?DisplayResults=&#bottomofpage", 5);
   }

   if (isset($_GET["DisplayResults"]))
   {
      ShowStatusMessage("Test Results(" . ($IsTestRunning?"RUNNING...":"COMPLETE") . ")");

      AddStopButton($IsTestRunning);
      echo "<pre>",
         htmlspecialchars(implode("",file(SYSTEM_DUMP_DIR . "iperf_test.output"))),
      "</pre>\n";

      AddStopButton($IsTestRunning);
      echo "<A name=\"bottomofpage\"></A>\n<br />\n";
      
      echo "<DIV class='no_bg_color'>";
      $Grapher = new PERF_GRAPHER();
      echo $Grapher->Render();
      echo "</DIV>";

   }
   elseif (isset($_GET["StartTest"]))
   {
      //
      // Clean up any old iperf sessions...with a kill -9 sledgehammer
      //
      chdir(HTTP_ROOT_DIR);
      exec("pkill -9 wget");
      exec("pkill -9 iperf");
      if ($IsTestRunning)
      {
         touch($StopFileName);
         for($i = 0; GetParameter("SelfTestRunning") && $i < 6; $i++)
         {
            usleep(500000);
         }
      }

      $ServerIP = $_GET["ServerIP"];
      $Duration = $_GET["Duration"];
      $ServerPort = $_GET["ServerPort"];

      $MaxSendRate = (int)(GetParameter("SlowSendRate") / 1000);

      //
      // After the test was kicked off, forward to the results page
      //
      echo HTML::InsertRedirect("./system_test.php?DisplayResults=&#bottomofpage", 5);

      //
      // Now start the test
      //
      @unlink($StopFileName);
      $Handle = fopen(SYSTEM_DUMP_DIR . "iperf_test.output", "w");
      if ($Handle) {
         fclose($Handle);
         ShowStatusMessage("Test Results (STARTING TESTS...)");
         $PSelf = $_SERVER['PHP_SELF'];

         exec("wget -t 1 -O - " .
            escapeshellarg(
               "http://127.0.0.1" . //  $_SERVER['SERVER_NAME']
               ":" . $_SERVER['SERVER_PORT'] .
               str_replace(strrchr($PSelf, "/"), "", $PSelf) . "/iperf_test.php" .
               "?ServerIP="    . rawurlencode($ServerIP) .
               "&ServerPort="  . rawurlencode($ServerPort) .
               "&MaxSendRate=" . rawurlencode($MaxSendRate) .
               "&Duration="    . rawurlencode($Duration)
            ) .
            " >/dev/null 2>&1 &"
         );
      }
   }
   elseif (isset($_GET["StartServer"]))
   {
      $ListenPort = $_GET["ListenPort"];
      $SrvOutFileName = SYSTEM_DUMP_DIR . "iperf_test_server.output";

      //
      // Clean up any old iperf sessions...with a kill -9 sledgehammer
      //
      exec("pkill -9 iperf");
      // Reset the file.
      if (($Handle = fopen(SYSTEM_DUMP_DIR . "iperf_test.output", "w"))) {
         fclose($Handle);
      }
      //
      // Now start the iperf server
      //
      exec(
         "iperf -s -p $ListenPort >" .
         escapeshellarg($SrvOutFileName) .
         " 2>&1 &"
      );
      usleep(500000);
      ShowStatusMessage("Iperf Server Started");
      echo "<pre>",
         htmlspecialchars(implode("",file($SrvOutFileName))),
      "</pre>\n";
      AddStopButton();
   }
   elseif (isset($_GET["StopTest"]))
   {
      chdir(HTTP_ROOT_DIR);
      exec("pkill -9 wget");
      exec("pkill -9 iperf");
      touch($StopFileName);
      if (! $IsTestRunning)
      {
         echo HTML::InsertRedirect("./debug.php", 2);
      }
      ShowStatusMessage("Stopping tests...");
   }
   else
   {
      echo HTML::InsertRedirect("./debug.php", 0);
   }
   ?>
   </BODY>
   </HTML>
