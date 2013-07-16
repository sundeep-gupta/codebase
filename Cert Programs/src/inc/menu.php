<?
	if (isset($_SESSION["id"])) {
    $counts = GetCertsMenu();

		$prefixstatus = GetPrefixesAndStatuses();
		$prefixstatuscnt = count($prefixstatus);

	?>

<script type="text/javascript" src="/graphics/cory.js"></script>

	<div id="mainMenu">
		<ul id="menuList">
		<?
			$didntopen = false;
		    $currprefix = "fdafdafdafdafda";
		    $menus = array();
		    //make a copy so that i don't screw other things up
		    $certs2 = $certs;

		    for($x=0;$x<$prefixstatuscnt;$x++) {
		        if ($currprefix != $prefixstatus[$x]["prefixID"]){
		            if (($currprefix != "fdafdafdafdafda") && (!$didntopen)) {
		                //close off the current root menu
						        print("</ul></li>");
		            }
				 	//if i don't have rights to this prefix or the current cert, skip it
				 	if ($counts[$prefixstatus[$x]["prefixID"]]["count"] == 0) {
			 	     $didntopen = true;
			 	     continue;
				 	}
//			 		if (!isset($_SESSION["Permissions"]["prefix-".$prefixstatus[$x]["prefixID"]])) {
//			 	    $didntopen = true;
//			 	    continue;
//				 	}
					$didntopen = false;
		            $currprefix = $prefixstatus[$x]["prefixID"];
		            //open a new root menu
		            printf("<li class=menubar><a href=# id=a%s class=actuator>%s (%d)</a><ul id=m%s class=menu>",
		                    $prefixstatus[$x]["prefixID"],
		                    $prefixstatus[$x]["prefix"],
		                    (isset($counts[$prefixstatus[$x]["prefixID"]]["count"])) ? $counts[$prefixstatus[$x]["prefixID"]]["count"] : 0,
		                    $prefixstatus[$x]["prefixID"]);
					 $menus[] = $prefixstatus[$x]["prefixID"];
	                if (isset($_SESSION["Permissions"]["prefix-".$prefixstatus[$x]["prefixID"]])) {
	                	printf("<li><a href=certStatusTable.php?pid=%d&sid=1>Status Matrix</a></li>",
								$prefixstatus[$x]["prefixID"]);
	                }
		        }
		        //print the current status out with its count
		        printf("<li><a href=index.php?pid=%d&sid=%d>%s (%d)</a></li>",
		                $prefixstatus[$x]["prefixID"],
		                $prefixstatus[$x]["statusID"],
		                $prefixstatus[$x]["name"],
					    (isset($counts[$prefixstatus[$x]["prefixID"]][$prefixstatus[$x]["statusID"]])) ? $counts[$prefixstatus[$x]["prefixID"]][$prefixstatus[$x]["statusID"]] : 0);
		    }
		?>
		<li style="visibility: hidden">&nbsp;</li>
<!--	  <li style="list-style: none outside"><a href="?logout=1" id="logout" class="actuator" style="background: url(/graphics/square.gif) no-repeat 0em 0.3em;">Logout</a> -->
		</ul></li>
	  </ul></div>
	<script type="text/javascript">
		var oldonload = window.onload;

		function newonload() {

			if (oldonload)
			    oldonload();
			<?
				$menuscnt = count($menus);
				for($x=0;$x<$menuscnt;$x++)
				    printf("initializeMenu(\"%s\", \"%s\");",
				            "m".$menus[$x],
				            "a".$menus[$x]);
			?>
		}
	    window.onload = newonload;
	    //-->
	</script>
<? } ?>
