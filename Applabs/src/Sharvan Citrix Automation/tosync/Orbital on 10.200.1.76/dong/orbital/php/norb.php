<?
   include("includes/header.php");
   if (isset($_GET["Reset"])) {
      $Attr["ResetIt"] = true;
      OrbitalSet("NORB_CONNECTION",$Attr,(int)$_GET["Reset"]);
   }
   if (isset($_GET["Allow"])) {
      $Attr["ResetIt"] = false;
      OrbitalSet("NORB_CONNECTION",$Attr,(int)$_GET["Allow"]);
   }
   if (isset($_GET["Stop"])) {
      $Attr["StopIt"] = true;
      OrbitalSet("NORB_CONNECTION",$Attr,(int)$_GET["Stop"]);
   }
   if (isset($_GET["Resume"])) {
      $Attr["StopIt"] = false;
      OrbitalSet("NORB_CONNECTION",$Attr,(int)$_GET["Resume"]);
   }
?>

      <!-- DISPLAY THE AUTO-UPDATE CHECK BOX -->
      <?

      if (isset($_COOKIE["GraphRefreshRate"]))
      {
         $GraphRefreshRate = $_COOKIE["GraphRefreshRate"];
      }else
      {
         $GraphRefreshRate = GRAPH_DEFAULT_REFRESH_RATE;
      }

      if (isset($_GET["AutoRefresh"]))
      {
         $AutoRefresh = (int)$_GET["AutoRefresh"];
      }
      else
      {
         $AutoRefresh = 0;
      }


      if ($AutoRefresh)
      {
         $RandNum = time();

         echo <<< END
         <HTML>
         <HEAD>
         <TITLE>Orbital Data - Main</TITLE>
         <META http-equiv="refresh" content="$AutoRefresh;URL=./norb.php?AutoRefresh=$AutoRefresh">
         <META http-equiv="Expires" content="$AutoRefresh"">
         <META http-equiv="Pragma" content="no-cache">
         <META http-equiv="Cache-control" content="no-cache">
         </HEAD>
END;
      }

      //
      // This is getting include here...instead of at the top, to fix a Netscape 4.78 refreshing problem
      //
      ?>
      <BODY>
      <div align="center">
      Auto-refresh <B><?=$AutoRefresh?"ON":"OFF"?></B>: <A href="./index.php?AutoRefresh=<?=$AutoRefresh?0:$GraphRefreshRate?>">Toggle</A>


      <!-- DISPLAY THE CURRENT SYSTEM TIME -->
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <B>Time: <?=strftime ("%b %d %Y %H:%M:%S")?></B>

      <BR><BR>

<br>




<!-- THIS IS THE MAIN SETTINGS BLOCK -->
<TABLE  class="width500" cellspacing="1">

   <!-- SYSTEM STATUS BLOCK -->
   <TR cellspacing="40" cellpading="40">
   <TD width="200" valign="top" align="right" class="caption_box">
      Orbital Status:&nbsp;&nbsp;
   </TD>

   <TD class="col-1">

      <TABLE width="100%">
      <FORM>
         <TR width="100%"><TD width="50%" align="left">
         <?php
            $PassThrough = GetParameter("PassThrough");
            if (!$PassThrough)
            {
               echo "<FONT color=\"red\" size=\"+1\">NORMAL</FONT>&nbsp;&nbsp;<br></TD>";
            }
            else
            {
               echo "<FONT color=\"red\" size=\"+1\">STOPPED</FONT>&nbsp;&nbsp;<br>";
            }
         ?>
         </TD></TR>

      </FORM>
      </TABLE>
      <BR>
   </TD>
   </TR>

   <!-- SYSTEM THROUGHPUT BLOCK -->
   <TR bgcolor="#427bb5">
   <TD width="200" valign="top" align="right" class="caption_box">
      Throughput:&nbsp;&nbsp;
   </TD>

   <TD class="col-2">


      <TABLE><TR>
      <TD>
         Max:
               <B><?= FormatThroughput(GetParameter("SlowSendRate")) ?></B>
         <br>
         <a href="bw_scheduler.php">Adjust Using BW Scheduler</a>
      </TD>

      </TR></TABLE>

   </TD>
   </TR>

</TR>
</TABLE>
</DIV>

<!-- DISPLAY THE CONNECTION LIST -->
<BR>
<?
      $NumConnectionsToShow = GetParameter("UI.ConnList.ConnectionsShown");
      $Result = OrbitalGet("NORB_CONNECTION",
                           array("IdleTime", "Address", "BytesSent",
                                 "Status", "ResetIt", "StopIt", "InstanceNumber"),
                           -1, $NumConnectionsToShow);
                           
      function SortIt($a,$b) {
         if ($a["IdleTime"] == $b["IdleTime"]) return 0;
         return ($a["IdleTime"] < $b["IdleTime"]) ? -1 : 1;
      }
      usort($Result,"SortIt");
?>


   <TABLE class="width950" align="center">
      <TR align=center class="table_header"><TD colspan=8><?=sizeof($Result)?> Active Non-Orbital Connections</TD></TR>
      <TR align=center class="table_header">
         <th>Src</th>
         <th><=></th>
         <th>Dst</th>
         <th>Idle</th>
         <th>Bytes Xfered</th>
         <th>Status</th>
         <th></th>
         <th></th>
      </TR>

<?
   foreach ($Result as $Conn)
   {
   ?>
      <TR class="row-1">
         <TD><?=FormatIPAddressPort($Conn["Address"]["Src"])?></TD>
         <TD align="center"><=></TD>
         <TD><?=FormatIPAddressPort($Conn["Address"]["Dst"])?></TD>
         <TD align="center"><?=(int)$Conn["IdleTime"]?>&nbsp;Secs</TD>
         <TD align="center"><?=$Conn["BytesSent"]?></TD>
         <TD align="center"><?=$Conn["Status"]?></TD>
         <TD align="center">
            <form>
               <?
                  if ($Conn["ResetIt"]) {
                     echo "<input type=hidden name=Allow value=".$Conn["InstanceNumber"]." >";
                     echo "<input type=submit value=Allow>";
                  } else {
                     echo "<input type=hidden name=Reset value=".$Conn["InstanceNumber"]." >";
                     echo "<input type=submit value=Reset>";
                  }
               ?>
            </form>
         </td>
         <td align="center">
            <form>
               <?
                  if ($Conn["StopIt"]) {
                     echo "<input type=hidden name=Resume value=".$Conn["InstanceNumber"]." >";
                     echo "<input type=submit value=Resume>";
                  } else {
                     echo "<input type=hidden name=Stop value=".$Conn["InstanceNumber"]." >";
                     echo "<input type=submit value=\"Drop All\">";
                  }
               ?>
            </form>
         </td>
      </TR>
   <?
   }

?>
   </TABLE>
</BODY>

<? include(HTTP_ROOT_INCLUDES_DIR ."footer.php"); ?>

</HTML>

<?
//
// Copyright 2002,2003 Orbital Data Corporation
//
?>
