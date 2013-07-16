<?
	include_once("session.php");
	include_once("../cert_functions.php");

	$activetab = "admin";
	$titleString = "SKU Maintenance";

	if (isset($_GET["sortBy"])) {
		//the user clicked on a column.  i need to set the new column/sort orders
		//  and re-direct back to clean off the url line
		if ($_GET["sortBy"] == $_SESSION["skuMaintSortCol"]) {
			$_SESSION["skuMaintSortDir"] = ($_SESSION["skuMaintSortDir"] == "ASC") ? "DESC" : "ASC";
		} else {
			$_SESSION["skuMaintSortDir"] = "DESC";
		}
		$_SESSION["skuMaintSortCol"] = $_GET["sortBy"];
		header("location: skuMaint.php");
	}

	//just in case we haven't set one yet.
	if (!isset($_SESSION["skuMaintSortCol"]))
	    $_SESSION["skuMaintSortCol"] = "1";

	if (!isset($_SESSION["skuMaintSortDir"]))
	    $_SESSION["skuMaintSortDir"] = "DESC";

	//sortBy=1>SKU
	//sortBy=2>Description
	//sortBy=3>Price
	//now set up the orderby statement
	$orderby = " ORDER BY ";
	switch($_SESSION["skuMaintSortCol"]) {
	    case 1: $orderby .= "SKU ".$_SESSION["skuMaintSortDir"];
	            break;
	    case 2: $orderby .= "description ".$_SESSION["skuMaintSortDir"];
	            break;
	    case 3: $orderby .= "price ".$_SESSION["skuMaintSortDir"];
	            break;
	    default: $orderby = "";
	}
	$SortImg = "<img src=\"/graphics/".$_SESSION["skuMaintSortDir"].".gif\">";
	
	//get me all the skus
	$skus = GetPriceList($orderby);
	$skuscnt = count($skus);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title>KeyLabs Certification System</title>
 
  <link rel="stylesheet" href="/graphics/main.css" type="text/css">
  <link rel="stylesheet" href="/graphics/menuExpandable3.css" type="text/css">
  <script type="text/javascript">
  cookieName = 'adminopenMenus';
  </script>
  <script src="/graphics/menuExpandable3.js"></script>
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
        <? include("adminMenu.php"); ?>
      </div>
      <div id=right>
        <br>
        <div align=center>
          <div class=greyboxheader align=left>
            <b>SKU Maintenance</b>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=5 border=0>
              <tr>
                <td width=10%><a href="?sortBy=1"><b>SKU</b></a>&nbsp;<?=($_SESSION["skuMaintSortCol"]=="1") ? $SortImg : ""?></td>
                <td><a href="?sortBy=2"><b>Description</b></a>&nbsp;<?=($_SESSION["skuMaintSortCol"]=="2") ? $SortImg : ""?></td>
                <td width=10% align=center><a href="?sortBy=3"><b>Price</b></a>&nbsp;<?=($_SESSION["skuMaintSortCol"]=="3") ? $SortImg : ""?></td>
                <td width=10%><b>Options</b></td>
              </tr>
<?
        for ($i=0; $i<$skuscnt; $i++) {
?>        
              <tr onMouseOver="this.oldbgcolor=this.bgColor; this.bgColor='#<?=$Config["highlite_color"]; ?>'" onMouseOut="this.bgColor=this.oldbgcolor"  bgcolor="#f9f9f9">
                  <td><?=$skus[$i]["SKU"]?></td>
                  <td><?=$skus[$i]["description"]?></td>
                  <td align=center><?=$skus[$i]["price"]?></td>
                  <td><a href="skuEdit.php?plid=<?=$skus[$i]["id"]?>">Edit</a></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Add a new SKU</td><td align=right><input type=button name="Add" value="Add" onclick="window.location.href='skuEdit.php?plid=0'"></td>
              </tr>
            </table>
          </div>
		<br>
      </div>
    </div>
  </div>
</body>
</html>
