<?
	include_once("session.php");
	include_once("cert_functions.php");
	
	$activetab = "testing";
	$titleString = "Main Index Page";
	if (isset($_GET["sortBy"])) {
		//the user clicked on a column.  i need to set the new column/sort orders
		//  and re-direct back to clean off the url line
		if ($_GET["sortBy"] == $_SESSION["indexSortCol"]) {
			$_SESSION["indexSortDir"] = ($_SESSION["indexSortDir"] == "ASC") ? "DESC" : "ASC";
		} else {
			$_SESSION["indexSortDir"] = "DESC";
		}
		$_SESSION["indexSortCol"] = $_GET["sortBy"];
		header("location: ".$_SERVER["HTTP_REFERER"]);
	}
	
	//just in case we haven't set one yet.
	if (!isset($_SESSION["indexSortCol"]))
	    $_SESSION["indexSortCol"] = "1";

	if (!isset($_SESSION["indexSortDir"]))
	    $_SESSION["indexSortDir"] = "DESC";

	//sortBy=1>Cert ID
	//sortBy=2>Company
	//sortBy=3>Product, ver
	//sortBy=4>Status
	//sortBy=5>Eng
	//sortBy=6>Start Date, Days
	//now set up the orderby statement
	$orderby = " ORDER BY ";
	switch($_SESSION["indexSortCol"]) {
	    case 1: $orderby .= "ppl.id ".$_SESSION["indexSortDir"];
	            break;
	    case 2: $orderby .= "CompanyName ".$_SESSION["indexSortDir"];
	            break;
	    case 3: $orderby .= "pdc.name ".$_SESSION["indexSortDir"];
	            break;
	    case 4: $orderby .= "Status ".$_SESSION["indexSortDir"];
	            break;
	    case 5: $orderby .= "Initials ".$_SESSION["indexSortDir"];
	            break;
	    case 6: $orderby .= "schedStartDate ".$_SESSION["indexSortDir"];
	            break;
	    default: $orderby = "";
	}
	$SortImg = "<img src=\"graphics/".$_SESSION["indexSortDir"].".gif\">";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="/graphics/main.css" type="text/css">
  <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
  <script src="/graphics/menuExpandable3.js"></script>
  <!-- this needs to be the last css loaded -->
  <!--[if IE 6]>
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
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
		<? // i think for the index page i'll show every cert that the current user has access to ?>
        <br>
		<div align="center">
		<div align=left class="greyboxheader"><strong>
		  Testing Information
		</strong></div>		
		
		<div class="toplessgreybox">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#2f6fab"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td bgcolor="#f9f9f9">
		
		<table width="100%" cellpadding="4" cellspacing="0" bgcolor="#f9f9f9">
			<tr bgcolor="#E4E4E4">
				<td><b><a href=?sortBy=1>Cert ID</a>&nbsp;<?=($_SESSION["indexSortCol"]=="1") ? $SortImg : ""?></b></td>
				<td><b><a href=?sortBy=2>Company</a>&nbsp;<?=($_SESSION["indexSortCol"]=="2") ? $SortImg : ""?></b></td>
				<td><b><a href=?sortBy=3>Product, ver</a>&nbsp;<?=($_SESSION["indexSortCol"]=="3") ? $SortImg : ""?></b></td>
				<td><b>Platform(s) Tested</b></td>
				<td><b><a href=?sortBy=4>Status</a>&nbsp;<?=($_SESSION["indexSortCol"]=="4") ? $SortImg : ""?></b></td>
				<td><b><a href=?sortBy=5>Eng</a>&nbsp;<?=($_SESSION["indexSortCol"]=="5") ? $SortImg : ""?></b></td>
				<td><b><a href=?sortBy=6>Start Date, Days</a>&nbsp;<?=($_SESSION["indexSortCol"]=="6") ? $SortImg : ""?></b></td>
        <td><b>Files</b></td>
				<td><b>Options</td>
			</tr>

	        <?
				//  this has been moved to menu.php so it will actually happen for every page
				//    -- to enabe index sorting i have to re-do the query with the order by changed
				if (isset($_GET["pid"]) && isset($_GET["sid"])) {
					$certs = GetCerts($_GET["pid"], $_GET["sid"], $orderby);
					$certscnt = count($certs);
					if ($certscnt > 0) {
						for($x=0;$x<$certscnt;$x++) {
						    $data = $certs[$x];
						    //get the platforms for each cert -- this will get really slow later on this way and should be looked at
						    $products = GetPPLPlatforms($data["id"]);
						    $prodstr = "";
						    if (is_array($products)) {
							    foreach($products as $value)
							        $prodstr .= $value["name"].", ".$value["version"]."<br>";
								$data["productsTested"] = substr($prodstr, 0, -4);
						    } else {
						        $data["productsTested"] = "<p class=none>None</p>";
						    }
						    //get the files for each cert -- this will get really slow later on this way and should be looked at
						    $files = GetPPLFiles($data["id"]);
                $filescnt = count($files);
						    include("index_item.php");
						}
					} else {
						print("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone colspan=8>None</td></tr>");
					}
				} else {
				    print("<tr onMouseOver=\"this.oldbgcolor=this.bgColor; this.bgColor='#" .$Config["highlite_color"] ."'\" onMouseOut=\"this.bgColor=this.oldbgcolor\"  bgcolor=\"#f9f9f9\"><td class=listnone colspan=8>Please select an item from the menu on the left</td></tr>");
				}
			?>
		</table>
		
</td>
      </tr>
    </table></td>
  </tr>
</table>		

		
		</div>
		<br>
		</div>
	<br>	
      </div>
    </div>
  </div>
</body>
</html>
