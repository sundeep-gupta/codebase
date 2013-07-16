<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");

   //
   // If a line is to long, and doesn't contain any spaces, it doesn't
   // get wrapped by the web browser. This will truncate any line that
   // continues on, for more then MaxLength characters with no spaces
   //
   function TruncIfNoSpaces($InLine, $MaxLength)
   {
      $CharsBetweenSpace = 0;
      for ($i=0; $i<strlen($InLine); $i++)
      {
         $CharsBetweenSpace++;
         if ($InLine[$i] == " ")
         {
            $CharsBetweenSpace = 0;
         }

         if ($CharsBetweenSpace>$MaxLength)
         {
            return (substr($InLine, 0, $i) . "...");
         }
      }

      return $InLine;
   }

   $Result = xu_rpc_http_concise(
                  array(
                     'method' => "LogInfoRequest",
                     'host'   => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'   => RPC_PORT
                  )
   );


   $MinRecordNumber = $Result["Left"];
   $MaxRecordNumber = $Result["Right"];

   $Count = GetParameter("Log.DisplayRecordCount");
   $SearchBackwards = false;

   if (isset($_GET["StartRecord"]) && $_GET["StartRecord"] != "") {
      $StartRecord = (int)$_GET["StartRecord"];

   } else if (isset($_GET["RecordDate"]) && $_GET["RecordDate"] != "") {
      if (($Date = strtotime($_GET["RecordDate"])) === -1) {
         echo "<h2><red>Invalid Date: " . $_GET["RecordDate"] . "</red></h2>";
         $RecordNumber = max($MinRecordNumber,$MaxRecordNumber-$Count);
      } else {
        $LogInfo = xu_rpc_http_concise(
                     array(
                        'method' => "LogDateToRecordNumber",
                        'args'      => array(array($Date)),
                        'host'      => RPC_SERVER,
                        'uri'    => RPC_URI,
                        'port'      => RPC_PORT,
                     )
         );
         $StartRecord = $LogInfo[0];
      }

   } else {
      $StartRecord = $MaxRecordNumber - 1;
      $SearchBackwards = true;;
   }

   if (isset($_GET["Backwards"]) ) $SearchBackwards = true;

   $Param["StartRecord"] = $StartRecord;
   $Param["Count"]        = $Count;
   if ( $SearchBackwards ){ $Param["Backwards"] = true; }

   if (GetParameter("UI.Log.ShowSystemRecords")){ $Param["Types"]["system_status"] = 1;}
   if (GetParameter("UI.Log.ShowAdapterRecords")){ $Param["Types"]["adapter_status"] = 1;}
   if (GetParameter("UI.Log.ShowFlowRecords")){ $Param["Types"]["fast_flow_status"] = 1; $Param["Types"]["slow_flow_status"] = 1;}
   if (GetParameter("UI.Log.ShowConnectionRecords")){ $Param["Types"]["connection_status"] = 1;}
   if (GetParameter("UI.Log.ShowTextRecords")){ $Param["Types"]["text"] = 1;}
   if (GetParameter("UI.Log.ShowAlertRecords")){ $Param["Types"]["alert"] = 1;}
   if (GetParameter("UI.Log.ShowOpenCloseRecords")){
               $Param["Types"]["openconnection"] = 1;
               $Param["Types"]["closeconnection"] = 1;
   }

   $LogInfo = xu_rpc_http_concise(
                  array(
                     'method' => "LogRequest",
                     'args'      => $Param,
                     'host'      => RPC_SERVER,
                     'uri'    => RPC_URI,
                     'port'      => RPC_PORT,
                  )
   );

   // Records get returned in reverse order, unless we are returning searching backwards...confusing i know
   if (!isset($_GET["Backwards"]) && isset($_GET["StartRecord"])){
      $LogInfo = array_reverse($LogInfo);
   }

   //
   // Show the next/prev bar
   //
   $LastRecord = $MaxRecordNumber - 1;
   $Startup = GetSystemParam("StartingLogRecordNumber");
   $Entry = end($LogInfo);
   $PrevPage = $Entry["RecordNumber"];
   $Entry = reset($LogInfo);
   $NextPage = $Entry["RecordNumber"];

   if (sizeof($LogInfo) > 0) {
      $FirstDate = FormatDate($LogInfo[0]["Date"]);
   } else {
      $FirstDate = "";
   }

?>
   <body>
   <font class="pageheading">System Tools: View Log</font><BR><BR>
   <CENTER>
   <TABLE  width=400>
      <TR align="center">
         <TD>
            <form>
               <input type=hidden name=StartRecord value=<?=$Startup?> >
               <input type=submit value=Startup style="width: 65px">
            </form>
         </TD>
         <TD>
            <form>
               <input type=hidden name=StartRecord value=<?=$MinRecordNumber?> >
               <input type=submit value="&laquo; Oldest" style="width: 65px">
            </form>
         </TD>
         <TD>
            <form>
               <input type=hidden name=StartRecord value=<?=$PrevPage?> >
               <input type=hidden name=Backwards>
               <input type=submit value="&larr; Prev" style="width: 65px">
            </form>
         </TD>
         <TD>
            <form>
               <input type=hidden name=StartRecord value=<?=$NextPage?> >
               <input type=submit value="Next &rarr;" style="width: 65px">
            </form>
         </TD>
         <TD>
            <form>
               <input type=hidden name=Backwards>
               <input type=submit value="Last &raquo;" style="width: 65px">
            </form>
         </TD>

         <TD nowrap>
            <FORM>
               Record #
               <INPUT type=number name="StartRecord" size=7 value=<?=$StartRecord?>>
               <INPUT type=submit value="Goto" style="width: 65px">
            </FORM>
         </TD>
         <TD nowrap>
            <FORM>
               <LABEL for="RecordDate"> Date: </LABEL>
               <INPUT type=text name="RecordDate" value="<?=$FirstDate?>">
               <INPUT type="Submit" value="Goto" type="Get" style="width: 65px">
            </FORM>
         </TD>
      <TR>
   </TABLE>
   </CENTER>
<TABLE class="full_boxed">
<?
   $EvenLine = true;
   foreach($LogInfo as $LogElement) {
      echo "<TR>";
      if (array_key_exists("Fault",$LogElement)) {
         echo "<TD>???</TD> <TD> ??? </TD> <TD> " . $LogElement["Fault"] . "</TD>";
         echo "";
      } else {
         echo
         "<TD nowrap> <a href=\"./log_record.php?RecordNumber=" . $LogElement["RecordNumber"]. "\" >" . $LogElement["RecordNumber"].
               "<img src=\"./images/icon-info.gif\" border=\"0\" alt=\"Click Here For Detailed Log Record Information\"> </a> </TD>";
         echo "<TD nowrap> &nbsp;";
            echo FormatDate($LogElement["Date"]);
         echo "&nbsp;</TD>";
         echo "<TD>";
         if ($LogElement["Type"] == "alert") { echo "<font color='red'>"; }
               echo htmlspecialchars(TruncIfNoSpaces($LogElement["Text"], 80), ENT_QUOTES);
         if ($LogElement["Type"] = "alert") { echo "</font>"; }
         echo "</TD>\n";
      }
      echo "</TR>\n";
   }

echo "</TABLE>";

include(HTTP_ROOT_INCLUDES_DIR ."footer.php");

//
// Copyright 2002, 2003, 2004 Orbital Data Corporation
//
?>
