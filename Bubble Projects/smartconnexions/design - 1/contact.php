<?php
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta http-equiv="content-type" content="text/html; charset=windows-1250">
  <meta name="description" content="Web designing and hosting group focussed developing cost effective and efficient solutions">
  <meta name="keywords" content="web designing, web hosting, logo designing, database profiling">
  <meta name="Developer" content="Razikh, http://insha.in">
  <meta name="generator" content="PSPad editor, www.pspad.com">
  <title>Welcome to SmartConnexions</title>
  <link rel="stylesheet" type="text/css" href="sc.css" />
  <script type="text/javascript" language="JavaScript1.2" src="menufiles/stmenu.js"></script>
  
 
 
 
  </head>
  <body>
  
   <div id="frame">
<div id="topmenubar">
<div id="topmenubarmenu">

<p class="topmenu"><a href="index.html">Home</a> | <a href="#">Contact</a> | <img src="images/phone7.png"><strong><i>+91-40-42219396</i></strong</p>
</div>
</div>

<div id="titlebar">

</div>
<!--<div id="mainmenu">
<script type="text/javascript" language="JavaScript1.2" src="sc.js"></script>
</div>-->
<div id="pictureslide">
<!--<img src="images/menupic.jpg">-->
<img src="menupic.jpg" USEMAP="#title" BORDER=0>
<map name="title">
  <area name="denmark" shape="rect" coords="823,0,850,148" href="denmark.html"  alt="" target="_self">
  <area shape="default" href="denmark.html" target="_self">
</map>
</div>
<div id="main">
<!--<div id="dul">
   <h1></h1>
   </div> -->

   <div id="cdata">
<p>
<h4>Reach us at:</h4>
<b>Smartconnexions</b><br />
Plot # 14-c, <br />
beside Sai Raj Appartments <br />
Indian Airlines Padmanabha Colony <br />
Thirumalagherry , <br />
Secunderabad -500015 <br />
Contact # +91-40-42219396 <br />
E-Mail: info@smartconnexions.in<br />
</p>
<h4>Submit your queries!</h4>
  
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
   
   
   <div id="tempholder"></div>
<script language="JavaScript" src="dhtmllib.js"></script>
<script language="JavaScript" src="scroller.js"></script>
<script language="JavaScript">

/*
Mike's DHTML scroller (By Mike Hall)
Last updated July 21st, 02' by Dynamic Drive for NS6 functionality
For this and 100's more DHTML scripts, visit http://www.dynamicdrive.com
*/

//Change only this part to add messages,,,,,,Copy Paste aan entire line and edit messages
//SET SCROLLER APPEARANCE AND MESSAGES
var myScroller1 = new Scroller(0, 0, 200, 200, 0, 0); //(xpos, ypos, width, height, border, padding)
myScroller1.setColors("#006600", "#e3eceb", "#009900"); //(fgcolor, bgcolor, bdcolor)
myScroller1.setFont("Verdana,Arial,Helvetica", 2);
myScroller1.addItem("<b>Now offering Immigration services to Denmark. Click on <a href='denmark.html'>Migrate to Denmark</a> for more details</b>");
myScroller1.addItem("<b>Do you intend to immigrate to UK? Check our UK Tier 1 services. </b>");


//SET SCROLLER PAUSE
myScroller1.setPause(2500); //set pause beteen msgs, in milliseconds

function runmikescroll() {

  var layer;
  var mikex, mikey;

  // Locate placeholder layer so we can use it to position the scrollers.

  layer = getLayer("placeholder");
  mikex = getPageLeft(layer);
  mikey = getPageTop(layer);

  // Create the first scroller and position it.

  myScroller1.create();
  myScroller1.hide();
  myScroller1.moveTo(mikex, mikey);
  myScroller1.setzIndex(100);
  myScroller1.show();
}

window.onload=runmikescroll
</script>
<div id="placeholder" style="position:relative; width:200px; height:300px;"> 

</div>
   
   
   </div>
   </div>
   <div id="footer">
   <p class="footer">&copy 2009 Smartconnexions | Designed & Maintained by <a href="http://www.crea2ive.com">.Crea2ive.</a></p>
   </div>   
   
   

  </body>
</html>
