<?
	include_once("session.php");
	include_once("cert_functions.php");

	//permissions on this page are messed up
	if (isset($_GET["PREVMONTH"])) {
		$_SESSION["CurrentMonth"]--;
		header("location: calendar.php");
	} else if (isset($_GET["NEXTMONTH"])) {
		$_SESSION["CurrentMonth"]++;
		header("location: calendar.php");
	}
	
	//just in case we haven't gotten a month yet, start now.
	if (!isset($_SESSION["CurrentMonth"]))
		$_SESSION["CurrentMonth"] = date("n");

	$noneString = "<font color=#ff1111>None</font>";
	//$program = GetProgInfo($_SESSION["CurrentProgramID"]);
	
	$titleString = $program["prefix"]." calendar";
	//include("header.php");
	//include("menu.php");
	//print("<div id=mainpage style='visibility:inherit'>");

	//first thing to do is figure out how many days this month, where
	//  day 1 is in the week, and what the header should be
	$today = date("j");
	$currentMonth = date("n");

	$tmp = mktime(0, 0, 0, $_SESSION["CurrentMonth"], 1);
	$NumDays = date("t", $tmp) + 1; //so that i am not a day short each month.
	$StartDay = date("w", $tmp);
	$MonthStr = date("F Y", $tmp);
	$year = date("Y", $tmp);

	$certs = GetMonthsCerts($tmp, $_GET["p"]);
  $events = GetMonthsEvents($tmp);
//  dumpvar($events); exit;
	
	//dumpvar($certs);

	//figure out how many weeks in the month there are.
	$tmp = (($NumDays - (8 - $StartDay)) / 7);
	$NumWeeks = floor($tmp) + 1;
	$NumWeeks += (floor($tmp) == $tmp) ? 0 : 1;
	$RowHeight = 90 / $NumWeeks;
	$titleString = "Prefix Calendar";
	$activetab = "admin";
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
  <title><?=$titleString?></title>

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
<?
	printf("<center><table border=1 height=\"500\" width=\"95%%\"><tr height=\"5%%\"><td colspan=7 bgcolor=\"#888888\" align=center><a href=\"?PREVMONTH=1\">&lt;&lt;</a>&nbsp;<b>%s</b>&nbsp;<a href=\"?NEXTMONTH=1&\">&gt;&gt;</a></td></tr><tr height=\"5%%\">\n", $MonthStr);
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Sunday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Monday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Tuesday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Wednesday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Thursday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Friday</b></td>\n");
	print("<td width=\"14%\" bgcolor=\"#888888\" align=\"center\"><b>Saturday</b></td>\n");
	print("</tr>");

	//now fill out the first week till the start day
	if ($StartDay != 0) {
	    printf("<tr class=calendar height=%d%%>\n", $RowHeight);
	    for($x=0;$x<$StartDay;$x++) {
	        print("<td bgcolor=\"#aaaaaa\">&nbsp;</td>\n");
	    }
	}

	for($currentday=1,$x=$StartDay;$currentday!=$NumDays;$currentday++,$x++) {
	  if (($x % 7) == 0) {
	      printf("</tr>\n<tr class=calendar height=%d%%>\n", $RowHeight);
	  }
	  //first print out the opening stuff
	  printf("<td bgcolor=\"%s\" valign=\"top\" onmouseover=\"this.oldcolor=this.bgColor; this.bgColor='#ffff00'\" onmouseout=\"this.bgColor=this.oldcolor\"><b>%d</b><br>", ($today == $currentday && $month == $currentMonth) ? "#88dd00" : "#dddddd", $currentday);
	  //now find any certs that need to be printed out on this day, skipping the weekends
	  if ($x%7 != 0 && $x%7 != 6) { //6 = saturday 0=sunday
		$daycerts = $certs["days"][$currentday];
		$certcnt = count($daycerts);
	    for($y=0;$y<$certcnt;$y++) {
          $companyName = GetCompanyForID($certs["res"][$daycerts[$y]]["id"]);
	        printf("<a title=\"%s\" href=\"/CertPrograms/certLog.php?ppl=%d\">%s</a><br>", $companyName[0]["name"], $certs["res"][$daycerts[$y]]["id"], $certs["res"][$daycerts[$y]]["certName"]." [".
					$certs["res"][$daycerts[$y]]["initials"]."]");
	    }
		$dayevents = $events["days"][$currentday];
	  $eventcnt = count($dayevents);
	   for ($z=0;$z<$eventcnt;$z++) {
      printf("<br><i><a title=\"%s\" href=\"eventMaint.php?e=%s\">%s</a></i>", $events["res"][$dayevents[$z]]["description"],$events["res"][$dayevents[$z]]["id"], substr($events["res"][$dayevents[$z]]["description"],0,15));
     }
	  }
	  printf("&nbsp;</td>\n");
	}

	//now fill out the rest of the schedule
	while (($x % 7) != 0) {
	    print("<td bgcolor=\"#aaaaaa\">&nbsp;</td>\n");
	    $x++;
	}
	print("</tr></table></center>\n");
?>
		<!-- content should be in <p> tags to prevent the ie 3 pixel bug described on http://www.positioniseverything.net/explorer/threepxtest.html -->
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
