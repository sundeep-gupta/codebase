<?
   include_once("includes/header.php");
   include_once("performance_profiler_lib.php");
   $Auth->CheckRights(AUTH_LEVEL_VIEWER);

   //
   // Reset the stats
   // 
	if (isset($_GET["ResetStats"])) {
      CallRPCMethod("ResetPerfCounters");
      CallRPCMethod("ServiceClassResetCounter");      
      CallRPCMethod("ResetSimulatedCompressionStats");
      echo HTML::InsertRedirect();
		exit();
   }   
   
   //
   // Set the system line speed
   //
   if (isset($_GET["LineSpeed"])){
      SetParameter("SlowSendRate", 1000 * (int)$_GET["LineSpeed"]);
   }
   $SlowSendRate = (int)(GetParameter("SlowSendRate"));
   
   
   //
   // Do the actual setting of Simulator.LANIPs
   //
   //
   $LANIPs = GetParameter("Simulator.LANIPs");
   if (isset($_GET["FormName"]) && $_GET["FormName"]=="LANIPs"){
      if (isset($_GET["Add"])){
         $NewIPMask["Display"] = $_GET["NewIPMask"];
         array_push($LANIPs, $NewIPMask);
      }
      else if (isset($_GET["Delete"])){
         $IPMaskToDelete = $_GET["LANIPs"];

         $NewResults = array();
         foreach ($LANIPs as $IPMask){
            if ($IPMask["Display"] != $IPMaskToDelete){
               array_push($NewResults, $IPMask);
            }
         }
         $LANIPs = $NewResults;
      }

      SetParameter("Simulator.LANIPs", $LANIPs);
      echo HTML::InsertRedirect();     
   }   

   if (isset($_GET["DisplayGraphFor"])){
         SetParameter("UI.Graph.Duration", $_GET["DisplayGraphFor"]);
      }
      $GraphDisplayDuration = GetParameter("UI.Graph.Duration");


   if (max($UncompAvgLineSpeedSent, $UncompAvgLineSpeedRecv) > $SlowSendRate){
      echo "<FONT color='red' size='+1'>Warning: your line usage appears to be higher<BR> then the WAN link speed you configured!</FONT><BR><BR>";
   }
?>
   

   <DIV class="settings_table">
   <font class=pageheading>Monitoring: Performance Profiler: Configuration</font><BR><BR>
   <TABLE>
      <TR><TH>Your WAN Link Speed:</TH>
          <TD>
            <FORM name="SetSpeed">
               <INPUT type="text" name="LineSpeed" value=<?=(int)($SlowSendRate/1000)?> size=5></INPUT>&nbsp;Kbps&nbsp;&nbsp;
               <INPUT type="submit" name="SetLineSpeed" value="Set"></INPUT>
            </FORM>
          </TD>
      </TR>

      <TR><TH>Configure LAN Subnets:</TH><TD>
		<?

			//
			// Add the section on configuring LAN ports/subnets
			//

			$LANItems = array();
			foreach ($LANIPs as $IPMask){
				array_push($LANItems, $IPMask["Display"]);
			}

			if (sizeof($LANItems) == 0){ array_push($LANItems, "NONE CONFIGURED"); }

			$Form = new HTML_FORM();
			echo
				"<DIV class=\"no_bg_color\">",
				"<TABLE>",
				$Form->Begin("LANIPs"),
				"<TR>",
					"<TD>New IP/Mask:</TD>" ,
					"<TD>", $Form->AddTextField("NewIPMask", "", 12) . "<BR>Example: 192.168.1.0/24</TD>",
					"<TD>", $Form->AddSubmit("Add","Add") .
				"</TR>",
				"<TR>",
					"<TD>Current IPs:</TD>" ,
					"<TD>", $Form->AddList("LANIPs", $LANItems, 6) . "</TD>",
					"<TD align=left>", $Form->AddSubmit("Delete","Delete") . "</TD>",
				"</TR>",
				$Form->End(),
				"</TABLE>",
				"</DIV>";
		?>
		</TD></TR>
      
      <TR><TH>Display Line Usage Graph Over:</TH>
          <TD>
            <? if ($GraphDisplayDuration == "minute"){ echo "Last Minute"; }
               else { echo "<A href=?DisplayGraphFor=minute class=biglink>Last Minute</A>";}
               echo " | ";
               if ($GraphDisplayDuration == "hour"){ echo "Last Hour"; }
               else { echo "<A href=?DisplayGraphFor=hour class=biglink>Last Hour</A>";}
               echo " | ";
               if ($GraphDisplayDuration == "day"){ echo "Last Day"; }
               else { echo "<A href=?DisplayGraphFor=day class=biglink>Last Day</A>";}
            ?>
          </TD>
      </TR>

      <TR><TH>Reporting:</TH><TD><A href='performance_profiler_export.php' class=biglink>Export PDF Report</A></TD></TR>
   </TABLE>


   <BR><BR>
   <DIV class=helptext>
      <IMG src='./images/icon-info.gif'>&nbsp;
      WAN Link Speed: You must configure your WAN Link speed. For example, if
      you have a T1 line enter 1500 into the box.<BR><BR>
      
      <IMG src='./images/icon-info.gif'>&nbsp;
      LAN Subnets: specifying your LAN subnets will allow the Performance Profiler
      to exclude traffic that is not directed to or from the WAN. Additionally, it
      will allow the profiler to correctly calculate outbound (WAN destined) and 
      inbound (LAN destined) line utilization.
   </DIV>

   <BR><BR><BR>
<?
   include("includes/footer.php");
?>
