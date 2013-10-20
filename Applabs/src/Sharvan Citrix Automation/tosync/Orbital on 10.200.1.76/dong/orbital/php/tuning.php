<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>


<font class="pageheading">Configure Settings: Tuning</font><BR><BR>

<?
      //
      // Get the acceleration by ip mode      
      if (isset($_GET["AccelIPsMode"])){
         $AccelMode = (int)$_GET["AccelIPsMode"];
         $CurAccelIPs = GetParameter("Acceleration.AcceleratedIPs");
         if ($AccelMode == 1){
            if (sizeof ($CurAccelIPs)>0 && MSG_BOX::Ask("Question?", "Are you sure you wish to clear all IP/Mask acceleration entries?") == MSG_BOX_YES){
               SetParameter("Acceleration.AcceleratedIPs", array() );
            }else{
               echo HTML::InsertRedirect("tuning.php", 0);
            }
         }else{
            SetParameter("Acceleration.OnlyAccelIPsOnList", $AccelMode==2);
         }         
      }
?>

<div class="settings_table">
<TABLE>
   <TR>
   <TH>
      Window Settings:
   </TH>

   <TD>

      <?
            //
            // Set the Window Size:
            //      9 - 512K
            //     10 - 1M
            //     11 - 2M
            //     ...
            if ( isset($_GET["LanScaleLimit"]) )
            {
               $SlowWindowShift = $_GET["WanScaleLimit"];
               SetParameter("Tcp.SlowWindowSize", pow (2, $SlowWindowShift)-1 );

               $FastWindowShift = $_GET["LanScaleLimit"];
               SetParameter("Tcp.FastWindowSize", pow (2, $FastWindowShift)-1 );
            }
            else
            {
               $SlowWindowSize = GetParameter("Tcp.SlowWindowSize");
               $SlowWindowShift = (int)log10( base_convert($SlowWindowSize+1, 10, 2) );

               $FastWindowSize = GetParameter("Tcp.FastWindowSize");
               $FastWindowShift = (int)log10( base_convert($FastWindowSize+1, 10, 2) );
            }

      ?>

      <FORM>
            <DIV class="no_bg_color">
            <TABLE>
               <TR>
                  <TD>
                     WAN Scale Limit:
                  </TD>

                  <TD align=left>

                  <?
                     $ScalingVals = array();
                     for ($i=10; $i<=27; $i++)
                     {
                        array_push($ScalingVals, $i);
                     }
                     echo HTML_FORM::AddDropdown("WanScaleLimit", $ScalingVals, $ScalingVals, $SlowWindowShift-10);
                  ?>
                 </TD>
               </TR>
               <TR>
                  <TD>
                     LAN Scale Limit:
                  </TD>

                  <TD>

                  <?
                     $ScalingVals = array();
                     for ($i=10; $i<=20; $i++)
                     {
                        array_push($ScalingVals, $i);
                     }
                     echo HTML_FORM::AddDropdown("LanScaleLimit", $ScalingVals, $ScalingVals, $FastWindowShift-10);
                  ?>
               </TD>
             </TR>

            <TR>
               <TD></TD>
               <TD>
                  <?=HTML_FORM::AddSubmit();?>
               </TD>
            </TR>
         </TABLE>
         </DIV>
      </FORM>
      </TD>
   </TD>
   </TR>
   
   <!-- Connection Timeouts -->
   <TR>
   <TH>
      Connection Timeout:
   </TH>
   <TD>

   <?
      $Table = new HTML_TABLE();
      $ParamForm = new HTML_PARAMETER_FORM();
      echo 
         "<DIV class=\"no_bg_color\">",
         "<TABLE>",
         $ParamForm->Begin("ConnectionTimeout"),
         "<TR>",
            "<TD>Idle Connection Timeout:</TD>" ,
            "<TD>", $ParamForm->AddTextParam("Tcp.FullyOpenOrphanTime", 15) . "</TD>",
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD>", $ParamForm->AddSubmit() . "</TD>",
         "</TR>",
         $ParamForm->End(),
         "</TABLE>",
         "</DIV>";
   ?>
   
   </TD>
   </TR>

   <!-- Accelerated/Unaccelerated Ports -->
   <!--
   <TR>
   <TH>
      Accelerated Ports:
   </TH>
   <TD>-->
   <?/*
      $FieldNames = array("Accelerate All Ports", 
                          "Accelerate Only the Above Ports", 
                          "Accelerate Everything But the Above Ports");
      $Table = new HTML_TABLE();
      $ParamForm = new HTML_PARAMETER_FORM();
      echo 
         "<DIV class=\"no_bg_color\">",
         $Table->Begin(),
         $ParamForm->Begin("AcceleratedPorts"),

         $Table->AddEntry2($ParamForm->AddPortListParam("AcceleratedPorts", $FieldNames)),
         $Table->AddEntry("", $ParamForm->AddSubmit() ),
         $ParamForm->End(),
         $Table->End(),
         "<DIV class=\"no_bg_color\">";*/
   ?>
   <!--
   </TD>
   </TR>-->

   <!-- Accelerated/Unaccelerated IPs -->
   <!--
   <TR>
   <TH>
      Accelerated IPs:
   </TH>
   <TD>-->
   <?/*   
      $Results = GetParameter("Acceleration.AcceleratedIPs");
      
      if (isset($_GET["FormName"]) && $_GET["FormName"]=="AcceleratedIPs"){
         if (isset($_GET["Add"])){
            $NewIPMask["Display"] = $_GET["NewIPMask"];
            array_push($Results, $NewIPMask);
         }
         else if (isset($_GET["Delete"]) && isset($_GET["AccelIPs"])){
            $IPMaskToDelete = $_GET["AccelIPs"];
            
            $NewResults = array();
            foreach ($Results as $IPMask){
               if ($IPMask["Display"] != $IPMaskToDelete){
                  array_push($NewResults, $IPMask);
               }
            }
            $Results = $NewResults;
         }
         
         SetParameter("Acceleration.AcceleratedIPs", $Results);
      }
      
      $AccelItems = array();
      foreach ($Results as $IPMask){
         array_push($AccelItems, $IPMask["Display"]);
      }
   
      if (sizeof($AccelItems)==0){
         $AccelMode = 1;
         array_push($AccelItems,"-- EMPTY --");
      }else{
         $AccelMode = (GetParameter("Acceleration.OnlyAccelIPsOnList")?2:3);
      }      
            
      $Table = new HTML_TABLE();
      $Form = new HTML_FORM();
      echo 
         "<DIV class=\"no_bg_color\">",
         "<TABLE>",
         $Form->Begin("AcceleratedIPs"),
         "<TR>",
            "<TD>New IP:</TD>" ,
            "<TD>", $Form->AddTextField("NewIPMask", "", 12) . "<BR>Example: 192.168.1.0/24</TD>",
            "<TD>", $Form->AddSubmit("Add","Add") .             
         "</TR>",
         "<TR>",
            "<TD>Current IPs:</TD>" ,
            "<TD>", $Form->AddList("AccelIPs", $AccelItems, 6, 120) . "</TD>",
            "<TD align=left>", $Form->AddSubmit("Delete","Delete") . "</TD>",
         "</TR>",
         "<TR>",
            "<TD>Mode:</TD>" ,
            "<TD colspan=2>", $Form->AddRadioButton("AccelIPsMode", "1", $AccelMode==1) . "Accelerate All Traffic<BR>" .
                    $Form->AddRadioButton("AccelIPsMode", "2", $AccelMode==2) . "Only Traffic With a Source or Destination IP Listed Above<BR>" .
                    $Form->AddRadioButton("AccelIPsMode", "3", $AccelMode==3) . "Never Accelerate Traffic With a Source or Destination IP Listed Above<BR>" .
            "<TD></TD>",
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD align=left>", $Form->AddSubmit("ChangeMode","Change Mode") . "</TD>",
            "<TD></TD>",
         "</TR>",
         $Form->End(),
         "</TABLE>",
         "</DIV>";*/
   ?>
   <!--
   </TD>
   </TR>-->

   <!-- Special Ports -->
   <TR>
   <TH>Special Ports:</TH>
   <TD>
   <?
      $Table = new HTML_TABLE();
      $ParamForm = new HTML_PARAMETER_FORM();
      echo 
         "<DIV class=\"no_bg_color\">",
         "<TABLE>",
         $ParamForm->Begin("ConnectionTimeout"),
         "<TR>",
            "<TD>FTP Control:</TD>" ,
            "<TD>", $ParamForm->AddTextParam("Ports.FtpControl", 15) . "</TD>",
         "</TR>",
         "<TR>",
            "<TD>Rshell:</TD>" ,
            "<TD>", $ParamForm->AddTextParam("Ports.Rshell", 15) . "</TD>",
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD>", $ParamForm->AddSubmit() . "</TD>",
         "</TR>",
         $ParamForm->End(),
         "</TABLE>",
         "</DIV>";
   ?>
   </TD>   
   </TR>

   <!-- IP Forwarding -->
   <TR>
   <TH>Virtual Inline:</TH>
   <TD>
   <?
      $Table = new HTML_TABLE();
      $ParamForm = new HTML_PARAMETER_FORM();
      echo 
         "<DIV class=\"no_bg_color\">",
         "<TABLE>",
         $ParamForm->Begin("IPForwarding"),
         "<TR>",
            "<TD>Enable IP Fowarding:</TD>" ,
            "<TD>", $ParamForm->AddBooleanParam("System.IPForwardMode") . "</TD>",
         "</TR>",
         "<TR>",
            "<TD></TD>" ,
            "<TD>", $ParamForm->AddSubmit() . "</TD>",
         "</TR>",
         $ParamForm->End(),
         "</TABLE>",
         "</DIV>";
   ?>
   </TD>
   </TR>

</TABLE>
</div>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
