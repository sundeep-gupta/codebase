<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");  
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>


<Script>
<!--
   function confirmSubmit()
   {
      if(IPAddressCheck(document.UpdateNetworkSettings.IPAddress, "IP Address")) return;  
      if(IPAddressCheck(document.UpdateNetworkSettings.NetworkMask, "Network Mask")) return;       
      if(HostnameCheck(document.UpdateNetworkSettings.Gateway, "Gateway")) return; 
      if(HostnameCheck(document.UpdateNetworkSettings.Hostname, "Hostname")) return;      
      if(HostnameCheck(document.UpdateNetworkSettings.DNSServer , "DNSServer")) return;      
      if (!confirm("Are you sure you wish to change the network settings and restart Orbital (This will take serveral minutes)?")) {
         return;
      }

      var subform=document.UpdateNetworkSettings;
      subform.submit();
	   
   }
// -->
</Script>

<?
   if (isset($_GET["IPAddress"])){
      $IPAddress = $_GET["IPAddress"];

      $Param["Class"] = "SYSTEM";      
      $Param["Attribute"]["NetworkInfo"]["Address"]["Dotted"] = $IPAddress;
      $Param["Attribute"]["NetworkInfo"]["Mask"]["Dotted"] = $_GET["NetworkMask"];
      $Param["Attribute"]["NetworkInfo"]["Gateway"]["Dotted"] = $_GET["Gateway"];
      $Param["Attribute"]["NetworkInfo"]["Dns"]["Dotted"] = $_GET["DNSServer"];
      $Param["Attribute"]["NetworkInfo"]["Dhcp"] = $_GET["Dhcp"];
      $Param["Attribute"]["NetworkInfo"]["Hostname"] = $_GET["Hostname"];

      $Results = xu_rpc_http_concise(
                                    array(
                                       'method' => "Set",
                                       'args'      => $Param,                 
                                       'host'      => RPC_SERVER,
                                       'uri'    => RPC_URI,
                                       'port'      => RPC_PORT
      ));

      HTML::InsertCountdownRedirect(RESTART_TIME, "http://" . $IPAddress . "/index.php");
      SendCommand("reboot", "");
      exit();
   }
   
   $Results =  GetSystemInfo();
   $IPAddress =   $Results["Address"];
   $NetworkMask = $Results["Mask"];
   $Gateway =     $Results["Gateway"];
   $DNSServer =   $Results["Dns"];
   $Dhcp =  $Results["Dhcp"];
   $Hostname =    $Results["Hostname"];

?>

<font class="pageheading">Configure Settings: Management IP</font><BR><BR>

<TABLE>
   <TR>
   <TH>
      Interface Settings:
   </TH>

      <TD>
         <FORM name="UpdateNetworkSettings" action="managementip.php">
            <DIV class="no_bg_color">
            <TABLE>
               <TR align=center>
                  <TD align=left>
                     Mode:
                  </TD>
                  <TD align=left>
                     <?
                        //echo HTML_FORM::AddRadioButtons("Dhcp", array("Static IP&nbsp;&nbsp;", "DHCP"), array(0,1), $Dhcp, 0);
                        echo HTML_FORM::AddRadioButtons("Dhcp", array("Static IP&nbsp;&nbsp;"), array(0));
                     ?>
                  </TD>
               </TR>

               <TR>
                  <TD>
                     IP Address:
                  </TD>
                  <TD>
                     <INPUT name="IPAddress" SIZE="15" MAXLENGTH="15" type="text" value="<?=$IPAddress?>">
                  </TD>
               </TR>
               <TR>
                  <TD>
                     Network Mask:
                  </TD>
                  <TD>
                     <INPUT name="NetworkMask" SIZE="15" MAXLENGTH="15" type="text" value="<?=$NetworkMask?>"></INPUT>
                  </TD>
               </TR>
               <TR>
                  <TD>
                     Gateway:
                  </TD>
                  <TD>
                     <INPUT name="Gateway" SIZE="25" MAXLENGTH="25" type="text" value="<?=$Gateway?>"></INPUT>
                  </TD>
               </TR>
               <TR>
                  <TD>
                     DNS Server:
                  </TD>
                  <TD>
                     <INPUT name="DNSServer" SIZE="25" MAXLENGTH="25" type="text" value="<?=$DNSServer?>"></INPUT>
                  </TD>
               </TR>
               <TR>
                  <TD>
                     Hostname:
                  </TD>
                  <TD>
                     <INPUT name="Hostname" SIZE="25" MAXLENGTH="25" type="text" value="<?=$Hostname?>"></INPUT>
                  </TD>
               </TR>
               <TR align=right>
                  <TD></TD>
                  <TD>
                     <INPUT type="button" name="UpdateNetworkSettings" value="Update" onClick="confirmSubmit()"></INPUT>
                     <BR><BR>
                  </TD>
               </TR>

            </TABLE>
            </DIV>
         </FORM>
      </TD>
   </TD>
   </TR>
   </TABLE>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
