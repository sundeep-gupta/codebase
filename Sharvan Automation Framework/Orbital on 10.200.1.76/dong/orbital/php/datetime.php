<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>


<font class="pageheading">Configure Settings: Date/Time</font><BR><BR>

<DIV class="settings_table">
<FORM>
<TABLE>
   <!-- SYSTEM TIME -->
   <?
   if ( isset($_GET["SetDate"] ) )
   {
      $NewDate = $_GET["DateValue"];
      $SetCommand = "/usr/bin/sudo /bin/date --set=\"$NewDate\"";
      system($SetCommand);
   }
   ?>

   <TR>
      <TH>Time:</TH>
      <TD>
         <INPUT type="text" name="DateValue" value="<? echo strftime ("%b %d, %Y %H:%M:%S"); ?>">
      </TD>
   </TR>
   <TR><TH></TH><TD><INPUT type="submit" name="SetDate" value="Update"></TD></TR>
</TABLE>
</FORM>
</DIV>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>
