<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<?
   function ValidateAddress($Address){
      if (PingHost($Address))
      {
         return "<font color='black'>$Address</font>";
      }
      else
      {
         return "<font color='red'>$Address</font>&nbsp;&nbsp;<img src='./images/icon-warning.gif'>";
      }
   }

   function RemoveProxy($Which,$Num) {
      $Proxies = GetParameter($Which);
      unset($Proxies[$Num]);
      $Result = array_values($Proxies);
      if (MSG_BOX::Ask("Remove Proxy?", "Are you sure you wish to delete this proxy?") == MSG_BOX_YES){
         SetParameterAsXML($Which,$Result);
         echo HTML::InsertRedirect();
      }
   }

   function AddFullProxy() {
      $Proxies = GetParameter("Tcp.FullProxyTuples");
      foreach ($Proxies as $p) {
         if ($p["Client"]["Begin"]["Dotted"] == $_GET["ClientVIP"]) {
            if ($p["Server"]["Begin"]["Dotted"] != $_GET["ServerIP"]) {
               echo "<BR><H2><I>Addition ignored, Duplicate Local VIP " . $_GET["ClientVIP"] . "</I></H2> <BR>";
            }
            return;
         }
      }
      $P["Client"]["Begin"]["Dotted"] = $_GET["ClientVIP"];
      $P["Client"]["End"]["Dotted"]   = $_GET["ClientVIP"];
      $P["Server"]["Begin"]["Dotted"] = $_GET["ServerIP"];
      $P["Server"]["End"]  ["Dotted"] = $_GET["ServerIP"];
      $P["Description"]                 = $_GET["Description"];
      $Proxies[sizeof($Proxies)] = $P;
      SetParameterAsXML("Tcp.FullProxyTuples",$Proxies);
      echo HTML::InsertRedirect();
   }

   if (isset($_GET["Action"])) {
      if ($_GET["Action"] == "Add") {
         if($_GET["ClientVIP"] !== "" && $_GET["ServerIP"] != "")
         {
         	AddFullProxy();
         }
         else
         {
            ThrowException("Error: Either Local VIP or Target IP is empty", false);
         }
      }
   }else if (isset($_GET["DeleteFull"])) {
      RemoveProxy("TCP.FullProxyTuples",$_GET["DeleteFull"]);
   }
   $FullProxies = GetParameter("TCP.FullProxyTuples");

?>


   <font class="pageheading">Configure Settings: Proxy</font><BR><BR>


   <!-- SHOW CURRENT FULL PROXIES -->
   <TABLE>


      <TR>
      <TH>Local VIP</TH><TH></TH><TH>Target IP</TH><TH>Description</TH><TH></TH>
      </TR>

      <!-- BEGIN FULL PROXY RENDERING -->

      <?
         $ProxyNum = 0;
         foreach ($FullProxies as $Full)
         { ?>
         <TR>
         <TD>
            VIP: <?=ValidateAddress($Full["Client"]["Begin"]["Dotted"])?>
         </TD>
         <TD align="center">
            =>
         </TD>
         <TD>
            IP: <?=ValidateAddress($Full["Server"]["Begin"]["Dotted"])?>
         </TD>
         <TD>
            <?=$Full["Description"]?>
         </TD>
         <form name='DeleteFull'>
         <TD>
            <INPUT type='hidden' name='DeleteFull' Value='<?=$ProxyNum?>'>
            <INPUT type='submit' value=Delete>
            <? if (array_key_exists("Status",$Full)) {
                echo " Error: " . $Full["Status"];
               }
            ?>
         </TD>
         </form>
         </TR>
      <? $ProxyNum++;
         }
      ?>
      <FORM name="ProxyModeForm" action="proxies.php">
         <INPUT type="hidden" name="Action" value="Add">
         <INPUT type="hidden" name="Which" value="Full">

         <TR>
            <TD>
               <INPUT type="text" name="ClientVIP" size=12>
            </TD>

            <TD></TD>

            <TD>
               <INPUT type="text" name="ServerIP" size=12>
            </TD>

            <TD>
               <INPUT type="text" name="Description" size=18>
            </TD>

            <TD>
               <INPUT type="Submit" name="AddProxy" value="   Add  " type="Get">
            </TD>
         </TR>
      </FORM>
      </TABLE>

      <BR>
      <DIV class=helptext>
         <IMG src='./images/icon-info.gif'>&nbsp;
         Proxies are used to redirect traffic through a local (or distant) IP address.
         Connections to the "Local VIP" are forwarded on to the "Target IP". The "Target IP" may
         be another VIP or a destination server.
      </DIV>


      <? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
