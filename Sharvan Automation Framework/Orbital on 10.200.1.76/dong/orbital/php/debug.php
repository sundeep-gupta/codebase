<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   if (!file_exists("/usr/bin/zip"))
   {
      ThrowException("Could not find all system tools.<BR> Check that zip is in the<BR> system dir of the Orbital box!", true);
   }


   if (isset($_GET["FtwTestTime"]) )
   {
      $FtwTestTime = $_GET["FtwTestTime"];
      $Response = SendCommand("Watchdog.TestFTW", $FtwTestTime);
      ShowStatusMessage("FTW test was run.");
   }
?>

<SCRIPT language="JavaScript">
function warningMessage()
{
   if(confirm("Fail-To-Wire test is a service disruption. Are you sure you want to continue?"))
      document.Failed_To_Wire.submit();
}

</SCRIPT>

   <font class="pageheading">Diagnostics: Diagnostic Tool</font><BR><BR>
   <font class="pageheading">Fail-To-Wire Card</font><BR><BR>

<?if ($HaRunning) print "Not available in High Availability configuration<br><br>";?>
   <FORM name="Failed_To_Wire" action="debug.php">
   <TABLE>
      <TR><TH colspan=2>Fail-To-Wire Card</TH></TR>
      <TR>
         <TD>Time to stay Failed-To-Wire:&nbsp;&nbsp;<input name="FtwTestTime" value="30" size="4" type="text" <?if ($HaRunning) print "disabled";?>>seconds</TD>
         <TD><input name="Fail" type="submit" onClick="warningMessage(); return false;" <?if ($HaRunning) print "disabled";?>>
      </TR>
   </TABLE>
   </FORM>
   <BR><BR>

   <font class="pageheading">Tools</font><BR><BR>

<?   
   $TraceZipFile = GetHostname() . "-" . date("G-i-s") . "-orbital.zip";   

   if (!file_exists(SYSTEM_DUMP_DIR) )
   {
      ThrowException(SYSTEM_DUMP_DIR . " does not exist!!!", true);
   }

   if ( (isset($_GET["Tracing"])) && ($_GET["Tracing"] == "Start") )
   {
      SetParameter("Trace", true);      
      SetParameter("Trace.Packets", $_GET["PacketContents"] == 1);      

      if (chdir(SYSTEM_DUMP_DIR)){
         exec("rm -f " . "trace.zip");
      }else{
         ThrowException("Unable to change to: " . SYSTEM_DUMP_DIR);
      }
   }

   if ( (isset($_GET["Tracing"])) && ($_GET["Tracing"] == "Stop") )
   {
      // Stop tracing
      SetParameter("Trace", false);
      
      // Now remove the old trace zip, zip up the trace files, and then delete the trace files
      chdir(SYSTEM_DUMP_DIR);      
      exec("rm -f " . "*zip");
      if (chdir(SYSTEM_TRACE_DIR)){
         exec("zip " . SYSTEM_DUMP_DIR . $TraceZipFile . " *OrbTrace osstats.*.txt");
         exec("rm " . "*OrbTrace osstats.*.txt");
      }else { ThrowException("Unable to change to: " . SYSTEM_DUMPT_DIR); }
   }


   //
   // Now zip up the core files and any other related files
   //
   if (isset($_GET["GetCore"]) )
   {
      ShowStatusMessage("Zipping core files...");
      
      chdir(SYSTEM_DUMP_DIR);      
      exec("rm -f " . "*zip");
      
      if ( @chdir(SYSTEM_DUMP_DIR . "corezip")){
         exec("rm -Rf " . "*");
      }
      
      $TraceFileTimeSpan = ((int)$_GET["Timespan"]) * 60; 
      
      //
      // Where are we going to put everything
      
      echo ( exec("mkdir " . SYSTEM_DUMP_DIR . "corezip/") );
      
      //
      // Add each core file selected
      //
      $CoreFileDate = -1;
      $CoreFilesAdded = 0;
      foreach ($_GET as $CoreFilename => $value )
      {
         chdir(SYSTEM_TRACE_DIR);      
         
         if (substr($CoreFilename, 0, 5) == "core_")
         {
            $CoreFilename = str_replace("_", ".", $CoreFilename );
            $CoreTargetDir = SYSTEM_DUMP_DIR . "corezip/" . $CoreFilename;
            
            echo ( exec("mkdir $CoreTargetDir") );
            $Command = "cp -p $CoreFilename $CoreTargetDir";
            $Results = exec($Command);
            
            $CoreFileDate = filemtime(SYSTEM_TRACE_DIR . $CoreFilename);
            $CoreFilesAdded ++;
            
            $FileStartTime = ($CoreFilesAdded==1) ? ($CoreFileDate - $TraceFileTimeSpan) : $FileEndTime;
            $FileEndTime   = $CoreFileDate + 5; // 5 seconds after the core file time


            //
            // Now move the traces
            //
            if (isset($_GET["GetTraces"]) )
            {
               if ($dh = opendir(SYSTEM_TRACE_DIR)) {
                  while (($Filename = readdir($dh)) !== false) {
                     if ( substr($Filename, 0, 6) == "Trace." )
                     {
                        $Filedate = filemtime(SYSTEM_TRACE_DIR . $Filename);
                        
                        if ( ($Filedate > $FileStartTime) && ($Filedate < $FileEndTime) )
                        {
                           $Command = "cp -p $Filename $CoreTargetDir\$Filename";
                           echo ( exec($Command) );
                        }
                     }
                  }
                  closedir($dh);
               }
            }               

            //
            // Now move the logs
            //
            chdir(SYSTEM_LOG_DIR);                
            if (isset($_GET["GetTraces"]) )
            {
               if ($dh = opendir(SYSTEM_LOG_DIR)) {
                  while (($Filename = readdir($dh)) !== false) {
                     if ( substr($Filename, 0, 4) == "Log." )
                     {
                        $Filedate = filemtime(SYSTEM_LOG_DIR . $Filename);
                        if ( ($Filedate > $FileStartTime) && ($Filedate < $FileEndTime) )
                        {
                           $Command = "cp -p $Filename $CoreTargetDir\$Filename";
                           echo ( exec($Command) );
                        }
                     }
                  }
                  closedir($dh);
               }
            }               

         }
         
      }//NextCoreFile
      if ($CoreFilesAdded == 0) { ThrowException("You must select at least one core file!", TRUE); }

      //
      // Bundle up the core files
      //
      chdir(SYSTEM_DUMP_DIR . "corezip/");                         
      $Command = "zip -r " . SYSTEM_DUMP_DIR . "$TraceZipFile *";         
      exec ( $Command );

      ShowStatusMessage("...done.");
      
      // Now provide a link to the file      
      if (file_exists(SYSTEM_DUMP_DIR . $TraceZipFile))
      {
         echo ("<BR><BR><A href='./temp/" . $TraceZipFile . "' class=biglink>Click here to retrieve the last core/trace/log file</A>");
      }
      else {ThrowException("Unable to find zip file. Contact support!"); }
      
      echo("<BR><BR>");
      exit();
   }


   $Table = new HTML_TABLE();
   $Form = new HTML_FORM();
   echo 
      $Table->Begin(),
      $Form->Begin("GetCorefiles"),
      $Table->AddHeader1("CORE RETRIEVAL");
      $Table->AddHeader2("Filename", "Date/Time");
      
      $NumCoreFiles = 0;
      if ($dh = opendir(SYSTEM_TRACE_DIR)) {
         while (($filename = readdir($dh)) !== false) {
            if ( substr($filename, 0, 5) == "core." )
            {
               $Filesize = ToPrintableBytes( filesize(SYSTEM_TRACE_DIR . $filename) );
               $Filedate = date("F j, Y, g:i a", filemtime(SYSTEM_TRACE_DIR . $filename));
               
               echo $Table->AddEntry($Form->AddCheckBox($filename, FALSE) . $filename, 
                                 "$Filesize - $Filedate", "row-1");
               $NumCoreFiles ++;
            }
         }
         closedir($dh);
      }
   if ($NumCoreFiles == 0){
      echo "<TR><TD colspan=2><CENTER>NO CORE FILES FOUND</CENTER></TD></TR>";
   }
   
   echo      
      $Table->AddEntry2("Retrieve Core: " . $Form->AddCheckBox("GetCore", TRUE) .  
                       "Trace: " . $Form->AddCheckBox("GetTraces", TRUE) .  
                       "Log: " . $Form->AddCheckBox("GetLogs", TRUE).
                       "&nbsp;&nbsp;" . "Timespan: " . $Form->AddTextField("Timespan", "20", 2) . " minutes".
                       "&nbsp;&nbsp;" . $Form->AddSubmit("", "Get Core Files"), "row-3-center" ),         
      $Form->End(),
      $Table->End(),
      "<br>";


   //
   // Display the UI for turning on/off tracing
   //
   $IsTracing = GetParameter("Trace");
   $TracingType = GetParameter("Trace.Packets");

   echo("<TABLE>");
   echo("<TR>");
      echo("<TH colspan=2>TRACING</TH>");
   echo("</TR>");

   echo HTML_FORM::Begin("Tracer");
   echo("<TR>\n");
      echo("<TD>Trace Type:");
         echo HTML_FORM::AddDropdown("PacketContents", array("Only Headers", "Packet Contents"), array(0, 1), $TracingType );
         echo("</TD>");         
         echo("<TD>");         
            if ($IsTracing) echo HTML_FORM::AddSubmit("Tracing", "Stop");   
            else            echo HTML_FORM::AddSubmit("Tracing", "Start");   
         echo HTML_FORM::End();
      echo("</TD>");         
   echo("</TR></TABLE>\n");
   

   if (file_exists(SYSTEM_DUMP_DIR . $TraceZipFile))
   {
      echo ("<BR>  </BR><A href='./temp/" . $TraceZipFile . "' class=biglink>Click here to retrieve the last trace</A><BR><BR>");
   }
   echo("<BR>");
   /////////////////////////////////////////////////////////////////
   
   //
   // Provide a link to get system info
   //
   echo("<TABLE>");
   echo("<TR>");
      echo("<TH colspan=2>SYSTEM INFO</TH>");
   echo("</TR>");
   
   echo("<TR>\n");
      echo("<TD>");
      echo("<A href=\"./system_info.php\" target=_blank>Get System Info</A>");
   echo("</TR>");
   echo("</TABLE>");        
   echo("<BR><BR>");
?>
   
      
   <font class="pageheading">Line Tester</font><BR><BR>

<?
      //
      // Display the server test options
      //
      echo("<TABLE>");
      echo("<TR>");
         echo("<TH colspan=5>IPERF TEST (SERVER)</TH>");
      echo("</TR>");
                
      echo HTML_FORM::Begin("sytem_test", "system_test.php");
         echo("<TR>\n");
            echo("<TD>Listen Port:");
            echo   HTML_FORM::AddTextField("ListenPort", "5001", 12);
            echo("</TD>");         

         echo("<TD>");         
         echo   HTML_FORM::AddSubmit("StartServer", "Start Server");   
         echo   HTML_FORM::End();
         echo("</TD>");               
         echo("</TR>\n");
      echo("</TABLE>\n");    
      echo("<BR>\n\n");     
      
      
      //
      // Display the client test options
      //
      echo("<TABLE>");
      echo("<TR>");
         echo("<TH colspan=5>IPERF TEST (CLIENT)</TH>");
      echo("</TR>");
                
      echo HTML_FORM::Begin("system_test", "system_test.php");
      echo("<TR>\n");
         echo("<TD class=\"col-1\" align=center>Server IP: ");
         echo HTML_FORM::AddTextField("ServerIP", "", 12) ;
         echo("</TD>");         
         
         echo("<TD class=\"col-1\" align=center>Duration:");
         echo   HTML_FORM::AddDropdown("Duration", array("5", "15","30","60","100","300"), array(5, 15,30,60,100,300), 0);
         echo(" seconds</TD>");         

         echo("<TD class=\"col-1\" align=center>Port: ");
         echo   HTML_FORM::AddTextField("ServerPort", "5001", 4);
         echo("</TD>");         

         echo("<TD class=\"col-1\" align=center>");         
         echo   HTML_FORM::AddSubmit("StartTest", "Start Test");   
         echo   HTML_FORM::End();
         echo("</TD>");
      echo("</TR></TABLE><BR>\n");

?>

   <BR>
   <font class="pageheading">Ping/Traceroute</font><BR><BR>
   <TABLE>
      <TR>
         <TH colspan=4>Ping</TH>
         <FORM action="net_tools.php">
      </TR>
      <TR>
         <TD>IP Address: <INPUT type="text" name="IPAddress" size="12" ></TD>
         <TD>Packet Size: <INPUT type="text" name="DataSize" value="32" size="5" > Bytes</TD>
         <TD>Num Pings: <INPUT type="text" name="NumPings" value="5" size="4" ></TD>
         <TD>
            <INPUT type="submit" name="Ping" value="Run Ping">
         </TD>
         </FORM>
      </TR>
   </TABLE>

   <BR>
   <TABLE>
      <TR>
         <TH colspan=3>Traceroute</TH>
         <FORM action="net_tools.php">
      </TR>
      <TR>
         <TD>IP Address: <INPUT type="text" name="IPAddress" size="12" ></TD>
         <TD>Max Hops: <INPUT type="text" name="MaxHops" value="10" size="4" ></TD>
         <TD>
            <INPUT type="submit" name="Traceroute" value="Run Traceroute">
         </TD>
         </FORM>
      </TR>
   </TABLE>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
