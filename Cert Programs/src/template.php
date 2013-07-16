<?
	include_once("session.php");
	include_once("cert_functions.php");
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>Untitled</title>
 
  <link rel="stylesheet" href="graphics/main.css" type="text/css">
  <link rel="stylesheet" href="graphics/menuExpandable3.css" type="text/css">
  <script src="graphics/menuExpandable3.js"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
</head>
<body>
  <div id=leftfullheight>&nbsp;</div>
  <div id=top>
    <div id=header>
      <? include("header.php"); ?>
    </div>
  </div>
  <div id=middle>
    <div id=middle2>
      <div id=left>
        <? include("menu.php"); ?>
      </div>
      <div id=right>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
	  	<p>firstthe main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>the main page content goes here<br>last</p>
      </div>
    </div>
  </div>
  <!--<div id=bottom>
    <div id=footer>
      bottom content
    </div>	 
  </div> -->
</body>
</html>
