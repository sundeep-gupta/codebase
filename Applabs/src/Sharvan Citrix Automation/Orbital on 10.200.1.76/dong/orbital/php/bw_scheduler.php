<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

   $Result  = OrbitalGet("LIMIT", array("MAXSENDRATE","MAXRECVRATE"));
   $SendLimit = $Result["MAXSENDRATE"] / 1000;
   $RecvLimit = $Result["MAXRECVRATE"] / 1000;
   $SplitRate = GetParameter("UI.UseSplitRates");
   $SendRate = (int)(GetParameter("SlowSendRate") / 1000);
   $RecvRate = (int)(GetParameter("SlowRecvRate") / 1000);
   $BandwidthCrtlScheduler = GetParameter("UI.UseBandwidthControlScheduler");
   $SoftboostEnable = isSoftboost();
   if (isset($_GET["boost_status"]))
   {
      // echo 'boost status = ' . $_GET["boost_status"] . '<BR>';
      $Val = strtolower($_GET['boost_status']);
      $Val = $Val == "true" || $Val == "on";
      if ($Val != $SoftboostEnable) {
         $PassThrough = GetParameter("PassThrough");
         if (! $PassThrough) {
            SetParameter("PassThrough", true);
         }
         SetParameter("UI.Softboost", $Val);
         if (! $PassThrough) {
            sleep(1);
            SetParameter("PassThrough", false);
         }
         $SoftboostEnable = isSoftboost();
      }
   }
?>


<Script>
<!--
   function onSchedulerUpdate() {
      if(!document.ConfigureBWScheduler.UI_UseBandwidthControlScheduler.checked)
      {
         <?if($BandwidthCrtlScheduler) { ?>
            if(confirm("Are you sure you want to disable the Bandwidth Control Scheduler?" +
            " If OK, all the defined rules will be deleted.") == false)
               return;
         <?}?>
      }
      if(ValidateRates(document.ConfigureBWScheduler))
      {
         var subform=document.ConfigureBWScheduler;
         subform.submit();
      }
   }

   function ValidateRates(TheForm) {
      if (parseInt(TheForm.SendRate.value)+"" != TheForm.SendRate.value) {
         alert("Send Rate must be an Integer number");
         TheForm.SendRate.value = <?=$SendRate?>;
         return false;
      }
      if (TheForm.SendRate.value > <?=$SendLimit?>) {
         alert("Send Rate must not be greater than current license limit of <?=$SendLimit?>");
         return false;
      }
      if (TheForm.SendRate.value < 16) {
         alert("Send Rate must be at least 16 Kbps.");
         return false;
      }
      <? if ($SplitRate) { ?>
         if (parseInt(TheForm.RecvRate.value)+"" != TheForm.RecvRate.value) {
            alert("Recv Rate must be an Integer number");
            TheForm.RecvRate.value = <?=$RecvRate?>;
            return false;
         }
         if (TheForm.RecvRate.value > <?=$RecvLimit?>) {
            alert("Recv Rate must not be greater than current license limit of <?=$RecvLimit?>");
            return false;
         }
         if (TheForm.RecvRate.value < 16) {
            alert("Receive rate must be at least 16Kbps.");
            return false;
         }
      <? } ?>
      return true;
   }
   function ValidateDate(TheForm) {
      if (!TheForm.WeekEnd.checked && !TheForm.WeekDay.checked) {
         alert("Must have one or both of 'Day of Week' checked.");
         return false;
      }
      return true;
   }
   function ValidateSystem(TheForm) {
      if (!ValidateDate(TheForm)) return false;
      if (!ValidateRates(TheForm)) return false;
      return true;
   }
   function ValidateFlow(TheForm) {
      if (!ValidateDate(TheForm)) return false;
      if (!ValidateRates(TheForm)) return false;
      if (TheForm.Agent.value == "") {
         alert("Must supply IP Address of Destination Orbital System.");
         return false;
      }
      return true;
   }

   function onUpdate() {
      var status = document.Softboost_status.boost_status
      var checked = 0;
      var result = true;
      for (var i=0; i < status.length; i++)
      {
         if (status[i].value == "Softboost")
         {
            checked = status[i].checked;
            result = confirm("Are you sure that you want to change Bandwidth Management mode?" +
               " This will reset all accelerated connections.");
         }
      }
      document.location = "./bw_scheduler.php" + (result ? ("?boost_status=" + checked) : "");
   }
// -->
</Script>

<?
   function MakeRule() {
      global $SplitRate;
      $Rule = NULL;
      $FromTime = ($_GET["FromHour"] * 60) + $_GET["FromMinute"];
      $ToTime   = ($_GET["ToHour"]   * 60) + $_GET["ToMinute"];
      if ($FromTime != $ToTime) {
         $Rule["Time"]["MinuteOfDay"]["Begin"] = $FromTime;
         $Rule["Time"]["MinuteOfDay"]["End"] = $ToTime;
      }
      if (isset($_GET["WeekEnd"]) && !isset($_GET["WeekDay"])) {
         $Rule["Time"]["DayOfWeek"] = array("Sunday","Saturday");
      }
      if (isset($_GET["WeekDay"]) && !isset($_GET["WeekEnd"])) {
         $Rule["Time"]["DayOfWeek"] = array("Monday","Tuesday","Wednesday","Thursday","Friday");
      }
      if (isset($_GET["Agent"])) {
         $Rule["Agent"]["IP"]["Dotted"] = $_GET["Agent"];
      }
      $Rule["Actions"]["SendRate"] = $_GET["SendRate"]*1000;
      $Rule["Actions"]["RecvRate"] = $_GET[($SplitRate ? "RecvRate" : "SendRate")] * 1000;
      $Rule["ObjectType"] = $_GET["ObjectType"];
      return $Rule;
   }

   function IsSelected($boolean) { return ($boolean ? " selected " : ""); }
   function IsChecked($boolean) { return ($boolean ? " checked " : ""); }
   function MakeHours($Time) {
      for ($Hour = 0; $Hour < 24; $Hour++) {
         echo "<option " . IsSelected((int)($Time/60) == $Hour) . "> " .sprintf("%02d",$Hour) . "\n";
      }
   }
   function MakeMinutes($Time) {
      for ($Minutes = 0; $Minutes < 60; $Minutes += 15) {
         echo "<option " . IsSelected(($Time%60) == $Minutes) ."> " . sprintf("%02d",$Minutes) . "\n";
      }
   }
   function ShowTime($Rule,$Disabled) {
      $FromTime = isset($Rule["MinuteOfDay"]) ? $Rule["MinuteOfDay"]["Begin"] : 0;
      $ToTime = isset($Rule["MinuteOfDay"]) ? $Rule["MinuteOfDay"]["End"] : 0;
      $D = $Disabled ? " disabled " : "";
      if (!isset($Rule["DayOfWeek"])) {
         $WeekDays = true;
         $WeekEnds = true;
      } else {
         $WeekDays = $Rule["DayOfWeek"][0] != "Sunday";
         $WeekEnds = $Rule["DayOfWeek"][0] == "Sunday";
      }
      ?>
         <td align=right>
            <table>
            <tr>
            <td align=right>
               From:
            </td>
            <td nowrap>
               <select Name=FromHour <?=$D?> >
               <? MakeHours($FromTime); ?>
               </select>
               <select Name=FromMinute <?=$D?> >
               <? MakeMinutes($FromTime); ?>
               </select>
            </td>
            </tr>
            <tr>
            <td align=right>
               To:
            </td>
            <td>
               <select Name=ToHour <?=$D?> >
                  <? MakeHours($ToTime); ?>
               </select>
               <select Name=ToMinute <?=$D?> >
                  <? MakeMinutes($ToTime); ?>
               </select>
            </td>
            </tr>
            </table>
         </td>
         <td nowrap>
         <input type=checkbox name=WeekDay <?=IsChecked($WeekDays) ?> <?=$D?> > M-F
         <input type=checkbox name=WeekEnd <?=IsChecked($WeekEnds) ?> <?=$D?> > S/S
         </td>
      <?
   }
   function ShowRule($Rule,$RuleNumber,$ShowAgent,$ShowDelete,$Actions,$Status,$ObjectName) {
      global $SplitRate;
      echo "<tr>";
      echo "<td align=center> " . $Status . " </td>";
      echo "<form onsubmit=\"return Validate".$ObjectName."(this)\">";
      if (isset($Rule["Time"])) {
         ShowTime($Rule["Time"],false);
      } else {
         ShowTime(NULL,false);
      }
      echo "</td>";
      if ($ShowAgent) {
         echo "<td align=center><input type=text size=11 name=Agent value=\"".$Rule["Agent"]["IP"]["Dotted"]."\"></td>";
         $ObjectType = "FLOW";
      } else {
         $ObjectType = "SYSTEM";
      }
      echo "<td align=center> <input type=text size=4 name=SendRate value=" . ($Actions["SendRate"]/1000) . "> </td>";
      if ($SplitRate) {
         echo "<td align=center> <input type=text size=4 name=RecvRate value=" . ($Actions["RecvRate"]/1000) . "> </td>";
      }
      if ($ShowDelete) {
         echo "<td align=center> <input type=checkbox name=Delete> </td>";
         echo "<td align=center> <input type=submit value=Update> </td>";
         echo "<input type=hidden name=UpdateRule value=1>";
         echo "<input type=hidden name=RuleNumber value=".$RuleNumber.">";
         echo "<input type=hidden name=ObjectType value=".$ObjectType.">";
         echo "</form>";
         echo "<form> <td> <input type=submit value=\"&uarr;\"> <input type=hidden name=MoveUp   value=".$RuleNumber."> </td> </form>";
         echo "<form> <td> <input type=submit value=\"&darr;\"> <input type=hidden name=MoveDown value=".$RuleNumber."> </td> </form>";
      } else {
         echo "<td></td><td align=center colspan=3><input type=submit value=Add></td>";
         echo "<input type=hidden name=ObjectType value=".$ObjectType.">";
         echo "<input type=hidden name=AddRule value=1>";
         echo "</form>";
      }
      echo "</tr>";
   }
   if ( (!IsPageARefresh()) && (isset($_GET["AddRule"]))  ) {
      $Rules = GetParameter("Rules.Storage");
      $Rule = MakeRule();
      array_push($Rules,$Rule);
      SetParameter("Rules.Storage",$Rules);
   } else if (isset($_GET["UpdateRule"])) {
      $Rules = GetParameter("Rules.Storage");
      if (isset($_GET["Delete"])) {
         unset($Rules[$_GET["RuleNumber"]]);
         $Rules = array_values($Rules);
         SetParameter("Rules.Storage",$Rules);
      } else {
         $Rule = MakeRule();
         $Rules[$_GET["RuleNumber"]] = $Rule;
         SetParameter("Rules.Storage",$Rules);
      }
      } else if (isset($_GET["FormName"])) {
         $TempRules = GetParameter("Rules.Storage");
         if (!isset($_GET["UI_UseBandwidthControlScheduler"]) && sizeof($TempRules))
         {
            // empty all rules if disable the Bandwidth Control Scheduler
            SetParameter("Rules.Storage", array());
         }
         SetParameter("SlowSendRate",$_GET["SendRate"]*1000);
         SetParameter("SlowRecvRate",$_GET[($SplitRate ? "RecvRate" : "SendRate")]*1000);
/*
   } else if (isset($_GET["SetDefault"])) {
      SetParameter("SlowSendRate",$_GET["SendRate"]*1000);
      SetParameter("SlowRecvRate",$_GET[($SplitRate ? "RecvRate" : "SendRate")]*1000);
*/
   } else if (isset($_GET["MoveUp"])) {
      $RuleNumber = $_GET["MoveUp"];
      if ($RuleNumber != 0) {
         $Rules = GetParameter("Rules.Storage");
         $ThisRule = $Rules[$RuleNumber];
         $PrevRule = $Rules[$RuleNumber-1];
         $Rules[$RuleNumber] = $PrevRule;
         $Rules[$RuleNumber-1] = $ThisRule;
         SetParameter("Rules.Storage",$Rules);
      }
   } else if (isset($_GET["MoveDown"])) {
      $RuleNumber = $_GET["MoveDown"];
      $Rules = GetParameter("Rules.Storage");
      if ($RuleNumber < sizeof($Rules)-1) {
         $ThisRule = $Rules[$RuleNumber];
         $PrevRule = $Rules[$RuleNumber+1];
         $Rules[$RuleNumber] = $PrevRule;
         $Rules[$RuleNumber+1] = $ThisRule;
         SetParameter("Rules.Storage",$Rules);
      }
   }
   $Rules = GetParameter("Rules.Storage");
   $SlowSendRate = (int)(GetParameter("SlowSendRate") / 1000);
   $SlowRecvRate = (int)(GetParameter("SlowRecvRate") / 1000);

?>

   <font class="pageheading">Configure Settings: Bandwidth Management</font><BR><BR>

   <DIV class="settings_table">
<TABLE width="500">
   <TR>
   <TH>
      Status:&nbsp;&nbsp;
   </TH>

         <FORM name="Softboost_status">

         <? if ($SoftboostEnable)
            { ?>
               <td><input type="radio" name="boost_status" value="Hardboost" onClick="onUpdate()">
         <? }
            else
            {?>
               <td><input type="radio" name="boost_status" value="Hardboost" CHECKED onClick="onUpdate()">
         <? } ?>
            &nbsp;Hardboost&nbsp;&nbsp;<input type="radio" name="boost_status"
         <? if ($SoftboostEnable)
            { ?>value="Softboost" CHECKED onClick="onUpdate()">
         <? }
            else
            {
               ?>value="Softboost" onClick="onUpdate()">
         <? } ?>
            &nbsp;Softboost</td>
            <!--
            <td align="center">
             <INPUT type="button" name="status_update" value="Update" onClick="onUpdate()"></INPUT>
            </td>
            -->
         </FORM>

   </TR>
</TABLE></DIV><BR><BR>

<? if($SoftboostEnable) { ?>
   <font class="pageheading">Configure Settings: Bandwidth Scheduler</font><BR><BR>
   <DIV class="settings_table">
<TABLE width="500">
   <TR>
   <TH>
      Status:
   </TH>

   <TD>
     Automatic (when in Softboost mode)
   </TD>
   </TR>
</TABLE></DIV><BR><BR>
<?
} else { ?>

<font class="pageheading">Bandwidth Scheduler</font>
<DIV class="settings_table">
   <?
   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();

   echo
      "<BR>",
      $Table->Begin(),
      $ParamForm->Begin("ConfigureBWScheduler"),
      $Table->AddEntry(
         "Full Bandwidth:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>Partial Bandwidth:",
         $ParamForm->AddBooleanParam("Adapter.PassthroughTrafficAccount",false,array("<BR>",""))
      ),
      $Table->AddEntry("Allow Bandwidth Control Scheduler:",   $ParamForm->AddBooleanParam("UI.UseBandwidthControlScheduler")),
      $Table->AddEntry("Allow Separate Send/Receive Rates:",   $ParamForm->AddBooleanParam("UI.UseSplitRates")),
      $Table->AddEntry("Allow Separate Rate by Destination:",   $ParamForm->AddBooleanParam("UI.UseFlowBWRules")),
      $Table->AddEntry("Maximum System Bandwidth Control (Send):",   $ParamForm->AddTextField("SendRate", $SlowSendRate, 6) . "Kbps"),
      $Table->AddHiddenEntry("Maximum System Bandwidth Control (Received):",   $ParamForm->AddTextField("RecvRate", $SlowRecvRate, 6) . "Kbps", $SplitRate),
      $Table->AddEntry("", $ParamForm->AddButton("ConfigureBWScheduler", "Update",  "return onSchedulerUpdate()") ),
      $ParamForm->End(),
      $Table->End(),
      "<BR><BR>";
   if($BandwidthCrtlScheduler) {
   ?>



   <br><br>
   <table width=550 >
   <tr>
   <th colspan=<?=($SplitRate ? 9 : 8) ?> align=center>
      System Bandwidth Control Scheduler
   </th>
   </tr>
   <tr>
      <th align=center> Status </th>
      <th align=center> Time Of Day </th>
      <th align=center> Day Of Week </th>
      <th align=center> Send Kbps </th>
      <? if ($SplitRate) {
            echo "<th> Recv Kbps </th>";
         }
      ?>
      <th align=center> Delete </th>
      <th colspan=3> </th>
   </tr>
<?
   for ($ix = 0; $ix < sizeof($Rules); ++$ix) {
      if ($Rules[$ix]["ObjectType"] == "SYSTEM" && isset($Rules[$ix]["Actions"]["SendRate"])) {
         //
         // This is a system rule
         //
         ShowRule($Rules[$ix],$ix,false,true,$Rules[$ix]["Actions"],$Rules[$ix]["Status"],"System");
      }
   }
   $DefaultRates = array("SendRate"=>$SlowSendRate*1000,"RecvRate"=>$SlowRecvRate*1000);
?>
   <tr>
      <? ShowRule(NULL,"Add",false,false,$DefaultRates,"<i>n/a</i>","System"); ?>
   </tr>
   </table>
<? if (GetParameter("UI.UseFlowBWRules")) { ?>


   <br><br>
   <table width=700>
      <tr><th colspan=10>
            <?=ProdName()?> to <?=ProdName()?> Bandwidth Control Scheduler
      </th></tr>
      <tr>
         <th> Status </td>
         <th align=center> Time Of Day </th>
         <th align=center> Day Of Week </th>
         <th align=center> Via <?=ProdName()?> </th>
         <th align=center> Send Kbps </th>
         <? if ($SplitRate) {
               echo "<th> Recv Kbps </th>";
            }
         ?>
         <th align=center> Delete </th>
         <th colspan=3> </th>
      </tr>
   <?
      for ($ix = 0; $ix < sizeof($Rules); $ix++) {
         if ($Rules[$ix]["ObjectType"] == "FLOW" && isset($Rules[$ix]["Actions"]["SendRate"])) {
            ShowRule($Rules[$ix],$ix,true,true,$Rules[$ix]["Actions"],$Rules[$ix]["Status"],"Flow");
         }
      }
   ?>
      <? ShowRule(NULL,"Add",true,false,$DefaultRates,"<i>n/a</i>","Flow") ?>
      </TABLE>
<?
      }
   }
}
   include(HTTP_ROOT_INCLUDES_DIR . "footer.php");


//
// Copyright 2002,2003,2004 Orbital Data Corporation
//
?>
