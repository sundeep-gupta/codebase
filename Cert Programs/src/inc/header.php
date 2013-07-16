<!-- <html> -->
<title><?=$titleString?><?=(isset($_SESSION["username"])) ? " - ".$_SESSION["username"] : ""?></title>
<!-- <body> -->

<table width="100%" height=100% border="0" cellspacing="0" cellpadding="0" height="40">
  <tr style="height: 100%">
    <td width="40%" id=menuheaderleft>
	<?=(isset($titleCenter)) ? "<center>" : ""?>
  <? $userid = $_SESSION["id"]; ?>

	  <table width=100%>
		<tr valign=middle align=center>
			<td><a href="<?php echo $Config["root_path"]; ?>index.php"><IMG src="<?=$Config["root_path"]?>graphics/logo.gif" border="0"></a></td>
			<td><b><?=$titleString?><?=(isset($_SESSION["username"])) ? " - <font size=-1>".$_SESSION["username"]."</font>" : ""?></b><? if (isset($_SESSION["username"])) { echo "<br><a href=\"changePass.php?u=$userid\">Change Password</a>"; } ?></td>
		</tr>
	  </table>
	<?=(isset($titleCenter)) ? "</center>" : ""?>	
	</td>
	<? if (isset($_SESSION["id"])) { ?>
		<?
      if (!$NOTABS) {
		    if ($activetab != "testing")
		        unset($_SESSION["supervisorMode"]);
		        
			if (isset($_SESSION["supervisorMode"]))
			    $activetab = "prgadmin";
		?>
	    <td width="60%" height=100% valign="bottom" id=menuheader>
		<?php /* CODE TO BUILD TABS GET TO GO HERE!  YEAH! */ ?>
		  <ul>
			<li<? if ($activetab == "logout") { echo ' id="current"';}?>><a href="?logout=1">Logout</a></li>
			<?
				if (isset($_SESSION["Permissions"]["KeyLabs"])) { // only display this tab if the user is a keylabser
			?>
			<li<? if ($activetab == "admin") { echo ' id="current"';}?>><a href="<?php echo $Config["root_path"]; ?>admin/index.php">System Admin</a></li>
			<? } ?>
			<?
			    if (isset($_SESSION["Permissions"]["isSupervisor"])) {
			?>
			<li<? if ($activetab == "prgadmin") { echo ' id="current"';}?>><a href="<?php echo $Config["root_path"]; ?>index.php?supervisorMode=1">My Programs</a></li>
			<? } ?>
			<li<? if ($activetab == "products") { echo ' id="current"';}?>><a href="<?php echo $Config["root_path"]; ?>products/index.php">My Products</a></li>		
			<li<? if ($activetab == "testing") { echo ' id="current"';}?>><a href="<?php echo $Config["root_path"]; ?>index.php?testerMode=1">My Testing</a></li>
			  
		  </ul>
		</td>
		<? } ?>
	<? } ?>
  </tr>
</table>
<?php
// } // end of if session id active
?>
