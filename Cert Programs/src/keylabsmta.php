<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$program = 1;

  $SQL = "select * from programMTA where id='$program'";
  $MTA = DoSQL($SQL);	

	$titleString = "KeyLabs Master Test Agreement";
	$NOTABS = 1;
?>



<div id=head style="height: 65px">
	  <table width=100%>
		<tr valign=middle align=center>
			<td align=left><br><a href="<?php echo $Config["root_path"]; ?>index.php"><IMG src="<?=$Config["root_path"]?>graphics/logo.gif" border="0"></a></td>
			<td align=right><b><?=$titleString?></b></td>
		</tr>
	  </table>

</div>
<link rel="stylesheet" href="/graphics/mainstyle.css" type="text/css">
<link rel="stylesheet" href="/graphics/boxes.css" type="text/css">
    <br>
		<div align="center">
		<div align=left class="greyboxheader">
		  <table cellspacing=0 cellpadding=0 border=0 width=100%>
		    <tr>
			  <td><strong><?=$titleString; ?></strong></td>
			  <td align=right>&nbsp;</td>
			</tr>
		  </table>
		</div>		
		
		<div class="toplessgreybox">
      <?=$MTA[0]["mtaText"]?>
		</div>
		
		</div>
	<br>		  

	 </form>
<? include("footer.php"); ?>
