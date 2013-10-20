<?
   include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);

	//
	// Query the filter for Web information
	//

	function GetWebInfo()
	{
		$objpath = "\Parameter\*";
		$result = xu_rpc_http_concise(
						array(
							'method'	=> "GetWebInfo",
							'args'		=> array($objpath),						
							'host'		=> RPC_SERVER,
							'uri'		=> RPC_URI,
							'port'		=> RPC_PORT
						)
		);

		TestForFault($result, true);		
		return $result;
	}

?>

<!--
<BODY>
// -->


<? 
	$wi = GetWebInfo();
	$counter = 0;

	echo "<table>";

	foreach($wi as $p)
	{
		$counter++;
		$pageid = $p["PageId"];
		$time = $p["Time"];
		$file = $p["File"];
		$url = $p["ShortURL"];
		$transfers = $p["Transfers"];
		$dur = $p["Duration"];
		$bytes = $p["Bytes"];
		
		echo "<tr><td align=right>$time</td><td> &nbsp; </td>";
		echo "<td><a href=webpagetransfers.php?pageid=$pageid>$url</a> ($transfers files, $dur sec, $bytes k)</td></tr>\n";
	}

	echo "</table>";

?>


<?	
//
// Copyright 2002,2003 Orbital Data Corporation
//
/*
 * $Author: Paul Sutter $ 
 * $Modtime: 5/24/03 2:12p $ 
 * $Log: /source/vpn_filter/http_root/WebPages.php $
 * 
 * 4     5/24/03 2:12p Paul Sutter
 */
?>
