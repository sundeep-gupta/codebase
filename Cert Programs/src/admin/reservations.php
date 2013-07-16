<?
	include_once("../inc/session.php");
	include_once("../cert_functions.php");
  $activetab = "admin";

  if (isset($_POST["Update"])) {
    foreach($_POST["comment"] as $key => $value) {
      $SQL = "update reservation set comment='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
    foreach($_POST["startDate"] as $key => $value) {
      $SQL = "update reservation set startDate='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
    foreach($_POST["endDate"] as $key => $value) {
      $SQL = "update reservation set endDate='$value' where id='$key'";
      DoSQL($SQL, SQL_UPDATE);
    }
  }

  if (isset($_GET["d"])) {
    $reservation = $_GET["d"];
    $SQL = "delete from reservation where id='$reservation'";
    DoSQL($SQL, SQL_UPDATE);
  }

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

	//sortBy=1>resource
	//sortBy=2>startDate
	//sortBy=3>endDate
	//sortBy=4>comment
	//now set up the orderby statement
	$orderby = " ORDER BY ";
	switch($_SESSION["indexSortCol"]) {
	    case 1: $orderby .= "name ".$_SESSION["indexSortDir"];
	            break;
	    case 2: $orderby .= "startDate ".$_SESSION["indexSortDir"];
	            break;
	    case 3: $orderby .= "endDate ".$_SESSION["indexSortDir"];
	            break;
	    case 4: $orderby .= "comment ".$_SESSION["indexSortDir"];
	            break;
	    default: $orderby = "";
	}
	$SortImg = "<img src=\"../graphics/".$_SESSION["indexSortDir"].".gif\">";

  $SQL = "SELECT reservation.id, name, startDate,endDate,reservation.comment FROM reservation,resource where resource_id=resource.id $orderby";
  $reservations = DoSQL($SQL, SQL_SELECT);
  $reservationsCnt = count($reservations);
  $titleString = "Reservations";
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
  <link rel="stylesheet" href="/graphics/ie6.css" type="text/css">
  <![endif]-->
  <!-- this needs to be the last css loaded -->
</head>
<body>
  <div id=leftfullheight>&nbsp;</div>
  <div id=top>
    <div id=header>
      <? include("../inc/header.php"); ?>
    </div>
  </div>
  <div id=middle>
    <div id=middle2>
      <div id=left>
        <? include("../inc/adminMenu.php"); ?>
      </div>
      <div id=right>
        <br>
        <form name="editStatusForm" action="" method="post">
        <div align=center>
          <div class=greyboxheader align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b><?=$titleString?></td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
        </div>
        <div align=center>
          <div class=greybox>
            <table width=100% cellspacing=0 cellpadding=1 border=0>
              <tr>
                <td><b><a href=?sortBy=1>Resource</a>&nbsp;<?=($_SESSION["indexSortCol"]=="1") ? $SortImg : ""?></b></td>
                <td><b><a href=?sortBy=2>Start Date</a>&nbsp;<?=($_SESSION["indexSortCol"]=="2") ? $SortImg : ""?></b></td>
                <td><b><a href=?sortBy=3>End Date</a>&nbsp;<?=($_SESSION["indexSortCol"]=="3") ? $SortImg : ""?></b></td>
                <td><b><a href=?sortBy=4>Comment</a>&nbsp;<?=($_SESSION["indexSortCol"]=="4") ? $SortImg : ""?></b></td>
                <td><b>Options</b></td>
              </tr>
<?
        for ($i=0; $i<$reservationsCnt; $i++) {
?>        
              <tr>
                  <td><input type=text name=name[<?=$reservations[$i]["id"];?>] size=50 maxlength=50 value="<?=$reservations[$i]["name"]; ?>" READONLY></td>
                  <td><input type=text name=startDate[<?=$reservations[$i]["id"];?>] size=10 maxlength=10 value="<?=$reservations[$i]["startDate"]; ?>"></td>
                  <td><input type=text name=endDate[<?=$reservations[$i]["id"];?>] size=10 maxlength=10 value="<?=$reservations[$i]["endDate"]; ?>"></td>
                  <td><input type=text name=comment[<?=$reservations[$i]["id"];?>] size=50 maxlength=100 value="<?=$reservations[$i]["comment"]; ?>"></td>
                  <td><a href="reservations.php?d=<?=$reservations[$i]["id"] ?>">Delete</a></td>
              </tr>
<? } ?>
            </table>
          </div>
          </div>
          <div align=center>
          <div class="greyboxfooter" align=left>
            <table width=100% border=0 cellspacing=0 cellpadding=0>
              <tr>
                <td><b>Update Reservations</td><td align=right><input type=submit name="Update" value="Update"></td>
              </tr>
            </table>
          </div>
          </form>
<br>
      </div>
    </div>
  </div>
</div>
</body>
</html>
