<?
	$titleString = "Login required to access the certification pages.";
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
			<input type=hidden name=time value=<?=mktime()?>>
			<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="80%" valign="top">
                  <table width="95%"  border="0" cellspacing="5" cellpadding="0">
                    <tr>
                      <td><p><strong>There's never been a better time to get certified! </strong></p>
                        <p> Come to KeyLabs for the most prestigious industry certifications programs available. As one of the most experienced providers of outsourced Internet solutions, KeyLabs can help you establish, administer and deliver a complete product certification program from start to finish. </p>
                        <p>Take advantage of logo and certification programs to increase awareness of vendor and partner products in the marketplace. Participation in these certification programs demonstrate that your company's products meet a specific quality standard established by industry-leading vendors. The result? Increased recognition and marketing power. </p>
                        <p>                        
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp; </td>
                    </tr>
                    <tr>
                      <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/CTDP_Program_Logo_187x73.gif" width="187" height="73"></div></td>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/whql_text.gif" width="129" height="49"></div></td>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/yesnds1_sml.gif" width="82" height="121"></div></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/realsystem_certified_logo.gif" width="114" height="43"></div></td>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/solready.jpg" width="84" height="84"></div></td>
                          <td width="33%"><div align="center"><img src="<?php echo $Config["root_path"]; ?>graphics/suntone.gif" width="120" height="120"></div></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td><div align="center">
                        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><div align="center"></div>                              <div align="center"></div></td>
                          </tr>
                        </table>
                      </div></td>
                    </tr>
                  </table>
                <p>&nbsp;</p></td>
                <td width="20%" valign="top">
				
				
				  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td>
					  <div class="greyboxheader">
					  <table width="175"  border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td><strong>Returning Users </strong></td>
                        </tr>
                        <tr>
                          <td><font color='red'><?=$loginMessage;?></font>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>Username:</td>
                        </tr>
                        <tr>
                          <td><div align="right">
                              <input type="text" id="username" name="username" size=25 maxlength=50 value="">
                          </div></td>
                        </tr>
                        <tr>
                          <td>Password:</td>
                        </tr>
                        <tr>
                          <td><div align="right">
                              <input type="password" name="password" size=25 maxlength=32 value="">
                          </div></td>
                        </tr>
                        <tr>
                          <td><div align="center"><a href="/CertPrograms/inc/forgotpassword.php">I forgot my password.</a> </div></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td><div align="center">
                              <input type="submit" name="submit" value="Login now">
                          </div></td>
                        </tr>
                      </table>
					</div>
					</td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>
					  <div class="greyboxheader">
					  <table width="175"  border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td><strong>New Users </strong></td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>New users <a href="<?php echo $Config["root_path"]; ?>registration/index.php">register here</a>.</td>
                        </tr>
                      </table>			
					  </div>
					</td>
                    </tr>
                  </table>
</div></td>
              </tr>
            </table>
		    <p>&nbsp;</p>
		</form>
		<center>
			<p>&nbsp;</p>
</center>
<script>
		window.document.getElementById('username').focus();
</script>
</div>
</div>
<? include_once("footer.php"); ?>
