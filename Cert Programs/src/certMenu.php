<?
	$ar = explode("/", $_SERVER["SCRIPT_NAME"]);
	$filename = $ar[count($ar)-1];
	if ($filename!="certLog.php")
		printf("<a href=\"certLog.php?ppl=%d\">Cert Log</a>", $_GET["ppl"]);
	else
    	print("Cert Log");
	print("&nbsp;|&nbsp;");

	if ($filename!="certInfo.php")
		printf("<a href=\"certInfo.php?ppl=%d\">Cert Info</a>", $_GET["ppl"]);
	else
    	print("Cert Info");
	print("&nbsp;");

	if (isset($_SESSION["Permissions"]["KeyLabs"])) {
	    print("|&nbsp;");
		if ($filename!="certUpdate.php")
			printf("<a href=\"certUpdate.php?ppl=%d\">Cert Update</a>", $_GET["ppl"]);
		else
			print("Cert Update");
			
		print("&nbsp;|&nbsp;");
		if ($filename!="certStatus.php")
			printf("<a href=\"certStatus.php?ppl=%d\">Status Update</a>", $_GET["ppl"]);
		else
			print("Status Update");
			
		print("&nbsp;|&nbsp;");
		if ($filename!="newLog.php")
			printf("<a href=\"newLog.php?ppl=%d\">Add Log Entry</a>", $_GET["ppl"]);
		else
			print("Add Log Entry");
			
		print("&nbsp;|&nbsp;");
		if ($filename!="chooseEmail.php")
			printf("<a href=\"chooseEmail.php?ppl=%d\">Send Email</a>", $_GET["ppl"]);
		else
			print("Send Email");
	}
?>
