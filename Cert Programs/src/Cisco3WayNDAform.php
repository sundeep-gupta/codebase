<?
	$titleString = "Cisco 3-Way NDA Approval Page";
	$titleCenter = true;
?>
<link rel="stylesheet" href="<?php echo $Config["root_path"]; ?>graphics/main.css" type="text/css">
<!-- <div id=leftfullheight>&nbsp;</div> -->
<div id=top>
	<div id=header>
	<? include("header.php"); ?>
	</div>
</div>
<div id=middlelogin>
	<br>
	<form id=loginFrm name=loginFrm action="" method=post>
		<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="80%" valign="top">
					<p>Welcome, Joe User, to the Cisc 3-way NDA Approval Page.</p>
					<p>The content below comes from <a href="http://www.cisco.com/">Cisco Systems</a> and is Cisco's 3-Way NDA.  It must be agreed to before you may proceed with testing at KeyLabs. After executing the agreement you will receive a copy of the text via email.  KeyLabs and then Cisco will execute the agreement after you.</p>
					<div class=greyboxheader>
						<div align=center>
							<table width="95%"  border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<div align=center>
											<iframe src="http://www.cisco.com" height=400px width=100%></iframe>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<p>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td align=center><input type=submit name=agree value="I Agree">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type=submit name=noagree value="I Decline"></td>
			</tr>
		</table>
	</form>
	<p>&nbsp;</p>
	<center>
		<p>&nbsp;</p>
	</center>
	</div>
</div>
<? include_once("footer.php"); ?>
