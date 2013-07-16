<?php
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <meta name="generator" content="PSPad editor, www.pspad.com">
  <title>.Crea2ive. Contact form!</title>
  <link rel="stylesheet" type="text/css" href="crea2ive.css" />
  <script type="text/javascript" language="JavaScript1.2" src="stmenu.js"></script>
  </head>
  <body bgcolor="#333333">
  
   <div id="frame">
   <div id="bar">
   <h1></h1>
   </div>
   <div id="main">
   <div id="dul">
   <h1></h1>
   </div>
   <div id="cdata">
      
  <h1>Submit form for a quick quote!</h1>
  
<form id="form" method="post" action="emailer/emailer.php"> 
<p class="pline">Your Name<br /><input type="text" name="Name" value="" /></p> 
<p class="pline">Your Email<br /><input type="text" name="Email" value="" /></p> 
<p class="pline">Subject<br /><input type="subject" name="subject" value=""/></p>
<p class="pline">Requirements and/or Questions<br /><textarea name="Comments" rows="5" cols="40"></textarea></p> 
<p>
<input type="submit" name="Submit" value="Submit" /> 
<input type="reset" name="Reset" value="Clear Form" />

<input type="hidden" name="reply_to_field" value="Email" />
<input type="hidden" name="required_fields" value="Name,Comments" />
<input type="hidden" name="required_email_fields" value="Email" />
<input type="hidden" name="recipient_group" value="0" />
<input type="hidden" name="error_page" value="" />
<input type="hidden" name="thanks_page" value="" />
<input type="hidden" name="send_copy" value="no" />
<input type="hidden" name="copy_subject" value="Subject of Copy Email" />
<input type="hidden" name="copy_tomail_field" value="Email" />
<input type="hidden" name="mail_type" value="vert_table" />
<input type="hidden" name="mail_priority" value="1" />
<input type="hidden" name="return_ip" value="1" />
</p>
</form>
   
   </div>
   <div id="rm">
   
   
   <script type="text/javascript" language="JavaScript1.2" src="crea2ive.js"></script>
   <br />
   <br />
   <span class="icon_mail"><b>info@crea2ive.com</b></span>
   
   </div>
   </div>
   <div id="bottom">
   <p class="footer">.Crea2ive. &copy; 2008</p>
   </div>   
   
   

  </body>
</html>
