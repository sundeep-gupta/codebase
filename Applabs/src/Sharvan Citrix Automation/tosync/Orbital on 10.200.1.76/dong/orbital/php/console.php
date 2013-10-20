<?
   define('PAGE_IS_HA_CLUSTER_INDEPENDANT', true);
   include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<script>
<!--
function setfocus(){document.ConsoleForm.Command.focus();}
// -->
</script>

<BODY onLoad=setfocus()>

<CENTER>
<?

	//
	// Execute a command on the OrbitalServer
	//
	if (isset($_GET["Command"]) )
	{
		$Command = $_GET["Command"];
		$Response = SendCommand($Command, "");
      echo "<textarea wrap=soft rows=20 cols=80 readonly>" . $Response . "</textarea>";
	}

	//
	// Execute a command which does not run inside of the server
	//
	else if (isset($_GET["CommandExt"]) )
	{
		$Command = $_GET["CommandExt"];

		if ($Command == "Reboot")
		{
			echo "<CENTER><H2>Attempting to reboot the system</H2></CENTER>";
			exec("/sbin/reboot");
		}
	}

?>

	<FORM name="ConsoleForm" action="console.php">
		Command: <INPUT type="text" name="Command">
		<INPUT type="Submit" name="CommandButton" value="Send" type="Get">
	</FORM>


	<BR><BR>
	<H3>Useful Commands</H3>
	<LI><B>Croak</B> - Causes the filter to core dump.</LI>
	<LI><B>Reboot</B> - Reboots the machine.</LI>
	<LI><B>HaltReboot</B> - Oh no, I didn't mean to do that. Stops the current reboot.</LI>

</CENTER>
</BODY>

<?
//
// Copyright 2002,2003 Orbital Data Corporation
//
/*
 * $Author: Mark Cooper $
 * $Modtime: 5/27/03 5:13p $
 * $Log: /source/vpn_filter/http_root/console.php $
 *
 * 7     5/27/03 7:08p Mark Cooper
 *
 * 6     5/15/03 4:07p Mark Cooper
 *
 * 5     5/02/03 12:31p Mark Cooper
 */
?>
