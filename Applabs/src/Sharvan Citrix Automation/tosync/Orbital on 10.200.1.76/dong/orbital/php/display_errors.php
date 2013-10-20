<?
   include("includes/header.php");
   $Auth->CheckRights(AUTH_LEVEL_ADMIN);
?>

<HTML>
<HEADER>
		<TITLE>System Error</TITLE>
</HEADER>
	

<BODY>	
<CENTER>
<? 
	$LastErrors = GetSystemParam("LastErrors"); 
	ThrowException($LastErrors);
	GetSystemParam("ClearErrors"); 
?>


<BR><BR>
<IMG SRC="./images/warning-medium.gif">
</CENTER>

</BODY>
</HTML>
