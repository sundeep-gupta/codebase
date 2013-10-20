<?
	include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_VIEWER);

	//
	// Query the filter for Web information
	//

	function GetWebPageTransfers($pageid, $pixels, $condense)
	{
		$result = xu_rpc_http_concise(
						array(
							'method'	=> "GetWebPageTransfers",
							'args'		=> array(array($pageid, $pixels, $condense)),
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
	$pageid = $_GET["pageid"];
	$pixels = 400;
	$condense = 0;

	$wi = GetWebPageTransfers($pageid, $pixels, $condense);

	$counter = 0;

	// legend

	echo "<table align=center cellspacing=0 border><tr><td>";
	echo " &nbsp; <image width=9 height=9 src=/Traces/reqw.gif> Request wait &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/respw.gif> Response wait &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/transfer.gif> Content &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/error.gif> Abort &nbsp; ";
	echo "</td></tr></table><br>\n";

	// body

	echo "<table>";
	foreach($wi as $p)
	{
		$counter++;
		$url = $p["URL"];
		$session = $p["SessionId"];
		$start = $p["StartTime"];

		$leading = $p["Leading"];
		$reqwait = $p["Reqwait"];
		$respwait = $p["Respwait"];
		$transferring = $p["Transferring"];
		$aborting = $p["Aborting"];
		$tail = $p["Tail"];

		echo "<tr><td align=right>$session</td><td align=right>$url</td>";
		echo "<td>";
		if ($leading) echo "<image width=$leading height=9 src=/Traces/horiz.gif>";
		if ($reqwait) echo "<image width=$reqwait height=9 src=/Traces/reqw.gif>";
		if ($respwait) echo "<image width=$respwait height=9 src=/Traces/respw.gif>";
		if ($transferring) echo "<image width=$transferring height=9 src=/Traces/transfer.gif>";
		if ($aborting) echo "<image width=$aborting height=9 src=/Traces/error.gif>";
		if ($tail) echo "<image width=$tail height=9 src=/Traces/horiz.gif>";
		echo "</td></tr>\n";
	}

	echo "</table>";
?>

	<br><br><br><br>

<?
	$pageid = $_GET["pageid"];
	$pixels = 400;
	$condense = 1;

	$wi = GetWebPageTransfers($pageid, $pixels, $condense);

	$counter = 0;

	// legend

	echo "<table align=center cellspacing=0 border><tr><td>";
	echo " &nbsp; <image width=9 height=9 src=/Traces/reqw.gif> Request wait &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/respw.gif> Response wait &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/transfer.gif> Content &nbsp; ";
	echo " &nbsp; <image width=9 height=9 src=/Traces/error.gif> Abort &nbsp; ";
	echo "</td></tr></table><br>\n";

	// body

	echo "<table>";
	foreach($wi as $p)
	{
		$counter++;
		$url = $p["URL"];
		$session = $p["SessionId"];
		$start = $p["StartTime"];

		$leading = $p["Leading"];
		$reqwait = $p["Reqwait"];
		$respwait = $p["Respwait"];
		$transferring = $p["Transferring"];
		$aborting = $p["Aborting"];
		$tail = $p["Tail"];

		echo "<tr><td align=right>$session</td><td align=right>$url</td>";
		echo "<td>";
		if ($leading) echo "<image width=$leading height=9 src=/Traces/horiz.gif>";
		if ($reqwait) echo "<image width=$reqwait height=9 src=/Traces/reqw.gif>";
		if ($respwait) echo "<image width=$respwait height=9 src=/Traces/respw.gif>";
		if ($transferring) echo "<image width=$transferring height=9 src=/Traces/transfer.gif>";
		if ($aborting) echo "<image width=$aborting height=9 src=/Traces/error.gif>";
		if ($tail) echo "<image width=$tail height=9 src=/Traces/horiz.gif>";
		echo "</td></tr>\n";
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
