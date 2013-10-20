<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);

?>
<Script>
<!--
   function init()
   {
      onBooleanChecked();
   }

   function confirmSubmit()
   {
      var error = 0;
      var backOff = document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.value;
      var index = backOff.indexOf("%");
      if(index >= 0)
      {
         backOff = backOff.substring(0, index);
      }
      if(isFloatNumber(backOff) == false)
      {
         error = 1;
      }
      else
      {
         backOff = parseFloat(backOff);
         if(backOff > 100 || backOff < 0)
            error = 1;
      }

      if(error)
      {
         alert("Invalid value for Congestion Backoff. The value is between 0 to 100.");
         document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.focus();
         document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.select();
         return;
      }

      var rateRatio = document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.value;
      var index = rateRatio.indexOf("%");
      if(index >= 0)
      {
         rateRatio = rateRatio.substring(0, index);
      }

      if(isFloatNumber(rateRatio) == false)
      {
         error = 1;
      }
      else
      {
         backOff = parseFloat(rateRatio);
         if(rateRatio > 100 || rateRatio < 0)
            error = 1;
      }
      if(error)
      {
         alert("Invalid value for MinMax Rate Ratio. The value is between 0 to 100.");
         document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.focus();
         document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.select();
         return;
      }

      var minRate = document.ConfigureBWManagement.Flow_Bwc_MinRate.value;
      var index = minRate.indexOf("/");
      if(index >= 0)
      {
         minRate = minRate.substring(0, index-2);
      }
      if(isNumber(minRate) == false)
      {
         alert("Invalid value for Min Rate.");
         document.ConfigureBWManagement.Flow_Bwc_MinRate.focus();
         document.ConfigureBWManagement.Flow_Bwc_MinRate.select();
         return;
      }
      var subform=document.ConfigureBWManagement;
      subform.submit();

   }

   function onBooleanChecked()
   {
      if(document.ConfigureBWManagement.Flow_bwc_ControllerOn.checked)
      {
         document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.disabled = false;
         document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.disabled = false;
         document.ConfigureBWManagement.Flow_Bwc_MinRate.disabled = false;
         document.ConfigureBWManagement.Flow_bwc_ControllerOn.value = 0;
      }
      else
      {
         document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.disabled = true;
         document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.disabled = true;
         document.ConfigureBWManagement.Flow_Bwc_MinRate.disabled = true;
         document.ConfigureBWManagement.Flow_bwc_ControllerOn.value = 1;
      }

   }

   function onResetDefaults()
   {
      if(confirm("Are you sure you want to reset the Bandwidth Management values to the defaults?\n" +
               "If yes, please click the \"Update\" button to submit the changes after click the \"OK\" button."))
      {
         <?
         //
         // Get all the parameters
         //
         $Parameters = GetAllParameters();
         $bw_CongestionBackoff = "";
         $bw_MinMaxRateRatio = "";
         $bw_MinRate = "";
         $bw_ControllerOn = "";       

         foreach($Parameters as $Param => $Value)
         {
            if(strcmp($Param, "Flow.bwc.ControllerOn") == 0)
            {
               if (!$Value["Default"]) {
                  $bw_ControllerOn = $Value["DefaultText"];
               }
               else
               {
                  $bw_ControllerOn = $Value["Text"];
               }
            }

            if(strcmp($Param, "Flow.bwc.CongestionBackoff") == 0)
            {
               if (!$Value["Default"]) {
                  $bw_CongestionBackoff = $Value["DefaultText"];
               }
               else
               {
                  $bw_CongestionBackoff = $Value["Text"];
               }
            }

            if(strcmp($Param, "Flow.Bwc.MinMaxRateRatio") == 0)
            {
               if (!$Value["Default"]) {
                  $bw_MinMaxRateRatio = $Value["DefaultText"];
               }
               else
               {
                  $bw_MinMaxRateRatio = $Value["Text"];
               }
            }

            if(strcmp($Param, "Flow.Bwc.MinRate") == 0)
            {
               if (!$Value["Default"]) {
                  $bw_MinRate = $Value["DefaultText"];
               }
               else
               {
                  $bw_MinRate = $Value["Text"];
               }
            }
            if(!empty($bw_ControllerOn) && !empty($bw_CongestionBackoff) &&  !empty($bw_MinMaxRateRatio) &&
                        !empty($bw_MinRate) )
               break;
         }

         ?>
         document.ConfigureBWManagement.Flow_bwc_CongestionBackoff.value = "<?=$bw_CongestionBackoff?>";
         document.ConfigureBWManagement.Flow_Bwc_MinMaxRateRatio.value = "<?=$bw_MinMaxRateRatio?>"
         document.ConfigureBWManagement.Flow_Bwc_MinRate.value = "<?=$bw_MinRate?>"
         document.ConfigureBWManagement.Flow_bwc_ControllerOn.checked = "<?=$bw_ControllerOn?>";
         onBooleanChecked();
      }
   }
// -->
</Script>

<font class="pageheading">Settings: Bandwidth Management</font><BR>
<BODY onLoad="init()" >
<?

   $Table = new HTML_TABLE();
   $ParamForm = new HTML_PARAMETER_FORM();

   echo
      "<BR><BR>",
      "<div class=\"settings_table\">",
      $Table->Begin(),
      $ParamForm->BeginFormName("ConfigureBWManagement"),
      $Table->AddEntry("Enabled:", $ParamForm->AddBooleanParam_onClick("Flow.bwc.ControllerOn", "onBooleanChecked()")),
      $Table->AddEntry("Congestion Backoff:", $ParamForm->AddTextParam("Flow.bwc.CongestionBackoff", 4, 4)),
      $Table->AddEntry("MinMax Rate Ratio:",  $ParamForm->AddTextParam("Flow.Bwc.MinMaxRateRatio", 4)),

      $Table->AddEntry("Min Rate:",   $ParamForm->AddTextParam("Flow.Bwc.MinRate", 8)),
      $Table->AddEntry2Row("", $ParamForm->AddButton("ConfigureBWManagement", "Update", "confirmSubmit()"),
                      $ParamForm->AddButton("SetDefault", "Reset to Defaults", "onResetDefaults()")),
      $ParamForm->End(),
      $Table->End(),
      "</DIV>";
   echo "</CENTER><BR><BR>";

?>

<BR>
   <DIV class=helptext>
      <IMG src='./images/icon-info.gif'>&nbsp;
      The Bandwidth Management feature detects line congestion caused by traffic that may not be directly visable to
      this network acceleration appliance. With this feature enabled, the send rate for accelerated network traffic
      will be reduced until no more congestion occurs. This feature allows this acceleration device to automatically
      respond to variations in network traffic conditions, or changes in available network bandwidth.

   </DIV>

   <DIV class=helptext>
      Enabled checkbox: Enable and disable automatic bandwidth management. If this box is not checked, this acceleration
      appliance will always attempt to send data at the same rate. If the box is checked, this acceleration applicance
      will adjust the send rate to current conditions.

   </DIV>

   <DIV class=helptext>
   Congestion Backoff: Sets the maximum allowable packet loss rate between this appliance and its partner. If packet
   loss exceets the specified value, the send rate will be reduced until the packet loss falls below this amount.
   </DIV>

   <DIV class=helptext>
   MinMax Rate Ratio: Sets the maximum bandwidth of this acceleration appliance as a percentage of the maximum bandwidth
   defined by the Bandwidth Scheduler.
   </DIV>

   <DIV class=helptext>
   Min Rate: The absolute minimum bandwidth this acceleration appliance will adjust down to expressed in kilo-bits / second
   </DIV>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>



