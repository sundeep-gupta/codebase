<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

   <font class="pageheading">Configure Settings: Interface</font><BR><BR>
   <DIV class="settings_table">
   <!-- ADAPTER BLOCK -->
   <TABLE width=500>
   <TR>
   <TH>
      Adapter Infomation:
   </Th>

   <TD>

<?
   $prodName = ProdName();

   if($prodName == ORBITAL_LC)
   {
      $LINK_CONSTANTS = array(0 => "Auto", 1 => "100 Full", 2 => "100 Half", 3 => "10 Full", 4 => "10 Half");
      $LINK_CONSTANTS_VALUES = array(0,1,2,3,4);
   }
   else
   {
      // assume that prod name is Orbital 5500
      $LINK_CONSTANTS = array(0 => "Auto", 1 => "1000 Full", 2 => "100 Full", 3 => "100 Half", 4 => "10 Full", 5 => "10 Half");
      $LINK_CONSTANTS_VALUES = array(0,1,2,3,4,5);
   }

   //
   // Now set the adapter link/duplex settings
   //
   if (isset($_GET["LinkSpeedDuplex"]))
   {
      $Adapters = OrbitalGet("ADAPTER", array("InstanceNumber", "LinkSpeedDuplex") );
      $NumAdapters = sizeof($Adapters);

      for ($i=0; $i<$NumAdapters; $i++)
      {
         $AdapterNumber = $Adapters[$i]["InstanceNumber"];
         if (isset($_GET[$AdapterNumber])) {
            $Param["LinkSpeedDuplex"] = (int)$_GET[$AdapterNumber];
            $Result = OrbitalSet("ADAPTER", $Param, $AdapterNumber);
         }
      }
   }

   //
   // Display the adapter link/duplex settings
   //
   $Adapters = OrbitalGet("ADAPTER", array("InstanceNumber", "DisplayName", "Hidden", "LinkSpeedDuplex", "Duplex", "WireSpeed") );

   echo HTML_FORM::Begin("ethernet.php");
      foreach($Adapters as $ix => $value) {
         if (!$value["Hidden"]) {
            $i = $value["InstanceNumber"];
            $DisplayName = $value["DisplayName"];
            if ($DisplayName != "") {
               echo "<a href=\"./adapter_info.php?InstanceNumber=" . $i . "\"><img src=\"./images/icon-nic_card.gif\" border=\"0\" alt=\"Click Here For Adapter Info\"> $DisplayName </a>&nbsp;Link/Duplex:";
            }
            echo HTML_FORM::AddDropdown($i, $LINK_CONSTANTS, $LINK_CONSTANTS_VALUES, $value["LinkSpeedDuplex"] );
            if($value["WireSpeed"] != 0)
               echo "(" . FormatThroughput($value["WireSpeed"]) . "/" . $value["Duplex"] . ")<BR>";
            else
               echo "(Down)<BR>";
         }
         echo "<BR>";
      }
   echo HTML_FORM::AddSubmit("LinkSpeedDuplex", "Update Adapter Configuration");
   echo HTML_FORM::End();
?>
   </TD>
   </TR>
   
   <!-- FTW Card Info Block -->
   <TR>
   <TH>
      FTW Card Type:
   </TH>
   <TD>
      <B><?=GetSystemParam("FTWCardType")?></B><BR>
   </TD>
   </TR>
   
   </TABLE>
   </DIV>
<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
