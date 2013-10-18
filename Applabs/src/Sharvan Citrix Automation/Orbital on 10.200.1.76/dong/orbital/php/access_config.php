<? include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>   
   
   <font class="pageheading">Security: Access</font><BR><BR>

<?
   if (isset($_GET["SSHAccess"])){
      $NewStatus = ($_GET["NewStatus"] == "Enable");
      
      SetParameter("SSHRunning", $NewStatus);
   }

   if (isset($_GET["WebUI"])){
      $NewStatus = ($_GET["NewStatus"] == "Enable");
      
      if ($NewStatus){
         SetParameter("HTTP.Port", 80);
      }else{
         if (MSG_BOX::Ask("Disable WebUI?", "Are you sure you wish to do this? This will disable all access to the WebUI (including this page)?") == MSG_BOX_YES){
            SetParameter("HTTP.Port", 0);
         }else{
            echo HTML::InsertRedirect("./access_config.php", 1);
         }
      }
   }

   exec("/sbin/chkconfig --list sshd", $Response);
   $SSHRunning = (strpos($Response[0], "on") == true);
   
   $WebUIRunning = GetParameter("HTTP.Port");
?>

   <TABLE>
      <TR>
         <FORM>
         <INPUT type="hidden" name="SSHAccess">
         <TH>            
            SSH Access:
         </TH>
         <TD>
            Status: <B><?=$SSHRunning?"Running":"Stopped"?></B>
         </TD>
         <TD>
            <INPUT type="Submit" name="NewStatus" value="<?=$SSHRunning?"Disable":"Enable"?>">
         </TD>
         </FORM>
      </TR>
      
      <TR>
         <FORM name="WebAccess">
         <INPUT type="hidden" name="WebUI">
         <TH>            
            Web Access:
         </TH>
         <TD>
            Status: <B><?=$WebUIRunning?"Running":"Stopped"?></B>
         </TD>
         <TD>
            <INPUT type="Submit" name="NewStatus" value="<?=$WebUIRunning?"Disable":"Enable"?>">
         </TD>
         </FORM>
      </TR>
   </TABLE>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
