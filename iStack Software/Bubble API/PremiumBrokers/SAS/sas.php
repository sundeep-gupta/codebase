<?php

/* Config Section */

$pass		= 'demo';	           // Set the password.
$cookiename	= 'sascookie';		   // Optional change: Give the cookie a name. Default is sascookie
$expirytime	= time()+3600;		   // Optional change: Set an expiry time for the password (in seconds). Default is 1 hour.
$msg		= 'Password incorrect.';   // Optional change: Error message displayed when password is incorrect. Default is "Password incorrect".

/* End Config */

/* Logout Stuff - Sept 5, 2005 */

if (isset($_REQUEST['logout'])) {
    echo 'I am here';
	setcookie($cookiename,'',time() - 3600);							// remove cookie/password
	if (substr($_SERVER['REQUEST_URI'],-12)=='?logout=true') {			// if there is '?logout=true' in the URL
		$url=str_replace('?logout=true','',$_SERVER['REQUEST_URI']);	// remove the string '?logout=true' from the URL
		header('Location: '.$url);										// redirect the browser to original URL
	}
	show_login_page('');
	exit();
}

$logout_button='<form action="'.$_SERVER['REQUEST_URI'].'" method="post"><input type="submit" name="logout" value="Logout" /></form>';
$logout_text='<a href="'.$_SERVER['REQUEST_URI'].'?logout=true">Logout</a>';

/* End Logout Stuff */

/* FUNCTIONS */
$encrypt_pass=md5($pass);	// encrypt password

function setmycookie() {
global $cookiename,$encrypt_pass,$expirytime;
 echo 'Setting'; 
	setcookie($cookiename,$encrypt_pass,$expirytime);
}	

function show_login_page($msg) {
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Authorization Required</title>
<link rel="stylesheet" type="text/css" href="../images/bubblepb.css"/>
</head>
<body>
<div id='wrap'>
<div id='header'>
<h1 id="logo" style="position: absolute; left: 33; top: 16">
		<img border="0" src="images/plogo5.jpg" width="30" height="63" align="middle">Premium<span class="green">Brokers</span><span class="gray"></span></h1>	
		<h2 id="slogan" style="position: absolute; left: 398px; top: 26px">... Valuing relations ... forever !!</h2><ul >
<li id='current'>

<a href="index.php"><span>Home</span></a></li>
<li >
<a href="controller.php?action=About"><span>About</span></a></li>
<li >
<a href="controller.php?action=Broking"><span>Broking</span></a></li>
<li >
<a href="controller.php?action=Insurance"><span>Insurance</span></a></li>
<li >
<a href="controller.php?action=RealEstate"><span>Real Estate</span></a></li>
<li >
<a href="controller.php?action=Advisory"><span>Advisory</span></a></li>

<li >
<a href="controller.php?action=Opportunities"><span>Opportunities</span></a></li>
<li >
<a href="controller.php?action=Training"><span>Training</span></a></li>
<li >
<a href="controller.php?action=Contact"><span>Contact</span></a></li>
</ul></div><div id='content-wrap'>
<img src="../images/headerpic.jpg" alt="headerphoto" 
                  class="no-border" height="120" width="820"/>
</div>

<div id='main'>
	<form action="" method="POST">
	<h1>Authorization Required </br></h1>
<p>Please enter the password below <em>Use "demo" to login. Use a wrong password to see the error message</em>.</p>
	<p>Once logged in, you won't need to re-enter the password for one hour, the expiry time can be customized to your liking by altering the variable $expirytime in the Config Section of sas.php.</p>
	<p>You will need to enable cookies for SAS to work as expected.</p>
			Password:&nbsp;<input type="password" name="password" size="20">&nbsp;
			<input type="submit" value="Login">
			<input type="hidden" name="sub" value="sub">
	</form>
	<div class=error><?=$msg?></div>
</div>

<div id='rightbar'>
<h1>News Updates</h1>
			<p> Our new client is Blah Blah Blah :)</p>	
			<h1>Testimonials</h1>
			<p>Bubble provides best service in class (not outside the class:))</p></div><div id='footer'>
<p class="align-left">© 2008 <strong>Premium Brokers</strong> |
		Design by <a href="http://www.bubble.co.in/">Bubble Inc.,</a>
		</p><div id='footer-right'>
<p class="align-right">
		<a href="http://www.bubble.co.in/bubbleprojects/BrightSide/index.html">Home</a>&nbsp;|&nbsp;
  		<a href="http://www.bubble.co.in/bubbleprojects/BrightSide/index.html">SiteMap</a>&nbsp;|&nbsp;

   		</p></div></div></div></body></html> 
<? }

/* END FUNCTIONS */

$errormsg='';
if (substr($_SERVER['REQUEST_URI'],-7)!='sas.php') {// if someone tries to request sas.php
	if (isset($_POST['sub'])) {						// if form has been submitted
		$submitted_pass=md5($_POST['password']);	// encrypt submitted password
		if ($submitted_pass<>$encrypt_pass) {		// if password is incorrect
			$errormsg=$msg;
			show_login_page($errormsg);
			exit();
		} else {									// if password is correct
			setmycookie();
		}
	} else {
		if (isset($_COOKIE[$cookiename])) {			// if cookie isset
			if ($_COOKIE[$cookiename]==$encrypt_pass) {	// if cookie is correct
			   // do nothing
			} else {								// if cookie is incorrect
				show_login_page($errormsg);
				exit();
			}
		} else {									// if cookie is not set
			show_login_page($errormsg);
			exit();
		}
	}
} else {
	echo 'Try requesting demo.php';
}
?>