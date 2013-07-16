<?
	$programs = GetAllProgramsInfoMenu();
	$programsCnt = count($programs);
	$prefixes=GetPrefixes();
	$prefixCnt = count($prefixes);
	for ($x=0;$x<$prefixCnt;$x++) {
		$statuses[$x] = GetPrefixStatuses($prefixes[$x]["id"]);
		$prefixStatusCnts[$x] = count($statuses[$x]);
	}

	//$menuNums=$prefixCnt*2+5;  //Programs + (numPrograms) * 2 + System + MRCs + Companies + Users
	//numPrograms * 2 constitutes the Program and Status Steps menu nodes
	//	dumpvar($prefixstatus);
	//	dumpvar($certs);
?>
<div id="mainMenu">
  <ul id="menuList">
    <li class="menubar"><a href="#" id="a-r1" class="actuator">Programs</a>
      <ul id="m-r1" class="menu">
        <li><a href="editProg.php?pid=0">NEW</a></li>
        <li><a href="programMaint.php">ALL</a></li>
<?
	$menuCnt = 0;
	for($x=0,$currentProgram=0,$currentPrefix=0,$isfirst=true;$x<$programsCnt;$x++) {
	    //close out the current program and start a new program and prefix
	    if ($currentProgram != $programs[$x]["id"]) {
	        //end the current program submenu
	        if ($currentProgram!=0) {
	            print("</ul></li></ul></li>");
	        }
	        
			printf("<li><a href=# id=a%d class=actuator>%s</a><ul id=m%d class=submenu>
					<li><a href=\"editProg.php?pid=%d\">Details</a></li>",
//						$menuCnt, substr($programs[$x]["programName"], 0, 15).((strlen($programs[$x]["programName"]) > 15) ? "..." :""),
						$menuCnt, substr($programs[$x]["prefix"], 0, 15).((strlen($programs[$x]["prefix"]) > 15) ? "..." :""),
						$menuCnt++,
						$programs[$x]["id"]);
	        $currentProgram = $programs[$x]["id"];
			$currentPrefix = $programs[$x]["prefix_id"];
			printf("<li><a href=\"editMTA.php?pid=".$programs[$x]["id"]."\">MTA</a></li>");
	    }
	    
	    //close
	    if ($currentPrefix != $programs[$x]["prefix_id"]) {
	        if ($currentPrefix != 0) {
	            print("</ul></li>");
	        }
			$currentPrefix = $programs[$x]["prefix_id"];
	    }
        printf("<li><a href=# id=a%d class=actuator>Prefix: %s</a><ul id=m%d class=submenu>",
                $menuCnt, $programs[$x]["prefix"],
				$menuCnt++);
		//now print out all the stuff for the current prefix
?>
            <!-- <li><a href="skuMaint.php?p=<?=$programs[$x]["prefix_id"]?>">SKUs</a></li>  -->
            <li><a href="prodMaint.php?pid=<?=$programs[$x]["prefix_id"]?>">Platforms</a></li>
<!--            <li><a href="contactMaint.php?p=<?=$programs[$x]["prefix_id"]?>">Email Contacts</a></li>  -->
            <li><a href="emailMaint.php?p=<?=$programs[$x]["prefix_id"]?>">Canned Email</a></li>
            <li><a href="statusMaint.php?p=<?=$programs[$x]["prefix_id"]?>">Status</a></li>
            <li><a href="stepsMaint.php?p=<?=$programs[$x]["prefix_id"]?>">Steps</a></li>
            <li><a href="#" id="a<?=$menuCnt?>" class="actuator">Status Steps</a>
              <ul id="m<?=$menuCnt++?>" class="submenu">
<?
				$statuses = GetPrefixStatuses($programs[$x]["prefix_id"]);
				$statusescnt = count($statuses);
				for ($y=0; $y<$statusescnt; $y++) {
					printf("<li><a href=statSteps.php?p=%d&s=%d>%s</a></li>",$programs[$x]["prefix_id"],$statuses[$y]["id"],$statuses[$y]["name"]);
				}
?>
              </ul>
            </li>
           <li><a href="calendar.php?p=<?=$programs[$x]["prefix_id"]?>">Calendar</a></li>
<!--            <li><a href="#">Events</a></li> -->
<?
	}
?>
</li></ul></li></ul></li></ul>
    <li class="menubar">
      <a href="#" id="a-r2" class="actuator">System</a>
      <ul id="m-r2" class="menu">
        <li>
          <a href="#" id="a<?=$menuCnt?>" class="actuator">Accounts</a>
          <ul id="m<?=$menuCnt++?>" class="submenu">
            <li><a href="MRCadd.php">NEW</a></li>
            <li><a href="MRCcalc.php">Calculator</a></li>
            <li><a href="MRCmaint.php?st=a&ed=g">A-G</a></li>
            <li><a href="MRCmaint.php?st=h&ed=o">H-O</a></li>
            <li><a href="MRCmaint.php?st=p&ed=u">P-U</a></li>
            <li><a href="MRCmaint.php?st=v&ed=z">V-Z</a></li>
            <li><a href="MRCmaint.php?st=0&ed=9">0-9</a></li>
          </ul>
        </li>
        <li><a href="calendar.php">Calendar</a></li>
        <li>
          <a href="#" id="a<?=$menuCnt?>" class="actuator">Companies</a>
          <ul id="m<?=$menuCnt++?>" class="submenu">
          	<li><a href="companyEdit.php?f=add&cid=1&st=a&ed=g">NEW</a></li>
            <li><a href="companyList.php?st=a&ed=g">A-G</a></li>
            <li><a href="companyList.php?st=h&ed=o">H-O</a></li>
            <li><a href="companyList.php?st=p&ed=u">P-U</a></li>
            <li><a href="companyList.php?st=v&ed=z">V-Z</a></li>
            <li><a href="companyList.php?st=0&ed=9">0-9</a></li>
          </ul>
        </li>
        <li><a href="emailMaint.php?p=0">Emails</a></li>
        <li><a href="eventMaint.php?a=0">Event Add</a></li>
        <li><a href="logSubjectMaint.php">Log Subjects</a></li>
        <li><a href="permMaint.php">Permissions</a></li>
        <li><a href="prefixMaint.php">Prefixes</a></li>
        <li>
          <a href="#" id="a<?=$menuCnt?>" class="actuator">Resources</a>
          <ul id="m<?=$menuCnt++?>" class="submenu">
          	<li><a href="resourceAdd.php">NEW Resource</a></li>
            <li><a href="reservationAdd.php">NEW Reservation</a></li>
            <li><a href="resourceList.php?t=host">Hosts</a></li>
            <li><a href="resourceList.php?t=rack">Racks</a></li>
            <li><a href="reservations.php">Reservations</a></li>
            <li><a href="resourceList.php?t=ipsubnet">Subnets</a></li>
            <li><a href="resourceList.php?t=other">Other</a></li>
<?
  # resourceType 1 is IP subnet
  $SQL = "select name from resource where resourceType_id='1' order by name";
  $menuSubnets = DoSQL($SQL, SQL_SELECT);
  $menuSubnetsCnt = count($menuSubnets);
  for ($i=0; $i<$menuSubnetsCnt; $i++) {
?>
            <li><a href="resourceList.php?t=ip&id=<?=substr($menuSubnets[$i]["name"],0,11)?>"><?=$menuSubnets[$i]["name"]?></a></li>
<?
  }
?>
          </ul>
        </li>
        <li><a href="skuMaint.php">Price List</a></li>
        <li><a href="certLog.php?ppl=0">System Log</a></li>
        <li>
          <a href="#" id="a<?=$menuCnt?>" class="actuator">Users</a>
          <ul id="m<?=$menuCnt++?>" class="submenu">
          	<li><a href="userEdit.php?f=add&cid=1&st=a&ed=g">NEW</a></li>
            <li><a href="userList.php?st=a&ed=g">A-G</a></li>
            <li><a href="userList.php?st=h&ed=o">H-O</a></li>
            <li><a href="userList.php?st=p&ed=u">P-U</a></li>
            <li><a href="userList.php?st=v&ed=z">V-Z</a></li>
          </ul>
        </li>
      </ul>
    </li>
  </ul>
</div>
<script type="text/javascript">
	var oldonload = window.onload;
  
 	function newonload() {
  
 		if (oldonload)
 		    oldonload();
		initializeMenu("m-r1", "a-r1");
		initializeMenu("m-r2", "a-r2");
<?
 		for($x=0;$x<$menuCnt;$x++)
 		    printf("initializeMenu(\"%s\", \"%s\");",
 		            "m".$x,
 		            "a".$x);
?>
 	}
     window.onload = newonload;
     //-->
</script>
