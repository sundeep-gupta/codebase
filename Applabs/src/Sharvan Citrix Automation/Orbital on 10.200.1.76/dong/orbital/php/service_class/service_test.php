<?php

	/*
	* Include section
	*/
	include("../includes/header.php");
	include("service_lib.php");


	$param["ClassID"] = (int) 10001;
	$ret = testServerInterfaceIn("ServiceClassGet", $param);
	echo "GET:  " . htmlspecialchars($ret);

	$serviceClassRec = getServiceClasses(10001);
	$ret = testServerInterfaceOut("ServiceClassChange", $serviceClassRec);
	echo "<br><br>GET2:  " . htmlspecialchars($ret);

	//$ruleArray &= $serviceClassRec['SRC_DEST_IP_PORT_ARRAY'];
	$serviceClass['ClassID'] = 10001;
	$serviceClass['ClassName'] = "ttt";
	$ruleRec['Source']['IPAddress']['Dotted'] = "192.168.0.5";
	$ruleRec['Destination']['IPAddress']['Dotted'] = "192.168.0.6";
	$ruleRec['Destination']['Port'] = "80";
	$ruleRec2['Source']['IPAddress']['Dotted'] = "10.1.0.8";
	$ruleRec2['Destination']['IPAddress']['Dotted'] = "10.1.0.9";
	$ruleRec2['Destination']['Port'] = "60";
	$serviceClass['SRC_DEST_IP_PORT_ARRAY'][] = $ruleRec;
	$serviceClass['SRC_DEST_IP_PORT_ARRAY'][] = $ruleRec2;
	$ret = testServerInterfaceOut("ServiceClassChange", $serviceClass);
	echo "<br><br>SET:  " . htmlspecialchars($ret);

	$ret = changeServiceClass($serviceClass);
	echo "<br><br>RET:  ";
	var_dumper($ret);

	$param["ClassID"] = (int) 10001;
	$ret = testServerInterfaceIn("ServiceClassGet", $param);
	echo "<br><br>FINAL GET:  " . htmlspecialchars($ret);

	/*
	   $serviceClassRec['debug'] = true;
	   var_dumper($serviceClassRec);
	   //$ruleArray[] &= $serviceClassRec['SRC_DEST_IP_PORT_ARRAY'];
	   //exit(0);
	  // return(changeServiceClass($serviceClassRec));
       return(testServerInterfaceOut("ServiceClassChange", $serviceClassRec));
	   */

?>
