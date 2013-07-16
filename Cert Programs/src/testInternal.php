<?
	include_once("session.php");
	include_once("cert_functions.php");

  if (isset($_POST["sendMe"])){
  
  	$headers["Subject"] = "Test Email from the Web Server";
  	$headers["From"] = FROM_ADDRESS;
    $to = "TestInternal@keylabs.com,kroberts@keylabs.com,rich@keylabs.com";
  	$body="This is a test.";
  
    SendMail($to, $headers, $body);	
  
    echo "Message Sent";
  }
?>  
  <form action="" method="POST">
    <input type=submit name="sendMe" value="sendMe">
  </form>
