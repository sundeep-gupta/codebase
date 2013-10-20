<?php

   /************************************************************************
    *  Includes section
	************************************************************************/
   require_once("../includes/configure.php");
   require_once("../includes/orbital_lib.php");

   /************************************************************************
    * Constants
	************************************************************************/

   // General values
   define('START_USER_SC_ID', 100);
   define('PASSTHROUGH_SC_ID', 2);

   // Errors
   define('SUCCESS', 'OK');
   define('ERR_INVALID_IP', 'Not a valid IP Address');
   define('ERR_INVALID_PORT', 'Not a valid Port - must be from 0 to 65536');
   define('ERR_INVALID_MASK', 'Not a valid Mask - must be from 0 to 32');
   define('ERR_INVALID_SERVICE_NAME', 'Not a valid service name');

   // Index for errors
   define('ERR_SUCCESS_INDEX', 1);
   define('ERR_SOURCE_IP_INDEX', 2);
   define('ERR_DEST_IP_INDEX', 3);
   define('ERR_FROM_PORT_INDEX', 4);
   define('ERR_TO_PORT_INDEX', 5);


   /************************************************************************
    *  Debugging Functions
	************************************************************************/

	function testRPCIn($params) 
	{
		$host = $uri = $port = $method = $args = $debug = null;
		$timeout = $user = $pass = $secure = $debug = $output = null;	

		extract($params);

		// default values
		if(!$port) {
			$port = 80;
		}
		if(!$uri) {
			$uri = '/';
		}
		if(!$output) {
			$output = array(version => 'xmlrpc');
		}

		$response_buf = "";
		if ($host && $uri && $port) {
			$request_xml = xmlrpc_encode_request($method, $args, $output);
			//echo "REQUEST: " . $request_xml;
			$response_buf = xu_query_http_post($request_xml, $host, $uri, 
			                                   $port, $debug,
											   $timeout, $user, $pass, $secure);


			// If we didn't get a response, don't try and decode it.
			if (!isset($response_buf) || ($response_buf=="") ) return;
			$retval = $response_buf;

			//$retval = find_and_decode_xml($response_buf, $debug);
		}
		return $retval;
	}

	function testServerInterfaceIn($method, $params)
	{
		$ret  = testRPCIn(
			array(
				'method' => $method,
				'args'      => $params,
				'host'      => RPC_SERVER,
				'uri'    => RPC_URI,
				'port'      => RPC_PORT
			) 
		);
		return($ret);
	}

	function testRPCOut($params) {
		$host = $uri = $port = $method = $args = $debug = null;
		$timeout = $user = $pass = $secure = $debug = $output = null;	

		extract($params);

		// default values
		if(!$port) {
			$port = 80;
		}
		if(!$uri) {
			$uri = '/';
		}
		if(!$output) {
			$output = array(version => 'xmlrpc');
		}

		$response_buf = "";
		if ($host && $uri && $port) {
			$request_xml = xmlrpc_encode_request($method, $args, $output);
			//echo "REQUEST: " . $request_xml;
			$retval = $request_xml;
			//$response_buf = xu_query_http_post($request_xml, $host, $uri, $port, $debug,
		//                       $timeout, $user, $pass, $secure);


			// If we didn't get a response, don't try and decode it.
			//if (!isset($response_buf) || ($response_buf=="") ) return;

			//$retval = find_and_decode_xml($response_buf, $debug);
		}
		return $retval;
	}

	function testServerInterfaceOut($method, $params)
	{
		$ret  = testRPCOut(
			array(
				'method' => $method,
				'args'      => $params,
				'host'      => RPC_SERVER,
				'uri'    => RPC_URI,
				'port'      => RPC_PORT
			) 
		);
		return($ret);
	}

   /************************************************************************
    *  General purpose functions
	************************************************************************/
   // XXX hack until we understand why we have to pass in a serviceID to the 
   // server
	function findLastServiceID($serviceClassArray)
	{
		$maxServiceID = 1000;
		for($i=0;$i<count($serviceClassArray);$i++) {
			$serviceClass =&  $serviceClassArray[$i];
			$serviceID = (int) $serviceClass['ClassID'];
			if ($serviceID > $maxServiceID) $maxServiceID = $serviceID;
		}
		return $maxServiceID;
	}


	/* 
	 * Order the service classes in an array by policy
	 */
	function orderServiceClasses($serviceClassArray)
	{
		$nextIndex = 0;
//echo '<BR> BEFORE: ', var_dumper($serviceClassArray);
	    for ($i=0; $i<count($serviceClassArray); $i++) {

			// no index on this item - leave it alone
//echo ' E ' . $i;
		    //if (!isset($serviceClassArray[$i]['Index'])) continue;
//echo ' - ' . $serviceClassArray[$i]['Index'];

			// Swap this item with the one that has the next index
			for ($j = $i+1; $j<count($serviceClassArray); $j++) {
//echo ' T ' . $j;
			    if (isset($serviceClassArray[$j]['Index']) &&
				    $nextIndex == $serviceClassArray[$j]['Index']) {
//echo ' - ' . $serviceClassArray[$j]['Index'];

				    // execute the swap
					$tmp = $serviceClassArray[$i];
					$serviceClassArray[$i] = $serviceClassArray[$j];
					$serviceClassArray[$j] = $tmp;
//echo ' SWAP (i,j) ' . $i . ' ' . $j;
					break;
				}
			}
			$nextIndex++;
//echo ' NI: ', $nextIndex;
		}
//echo '<BR><BR> AFTER: ', var_dumper($serviceClassArray);
//echo '<BR>';
		return($serviceClassArray);
	}

	/* 
	 * Determines if a class is user defined or system defined
	 */

	function isUserDefinedClassID($serviceID)
	{
	    if ($serviceID < START_USER_SC_ID) {
		    return(false);
		}
		return(true);
	}

	function isUserDefinedClass($serviceClassRec)
	{
	    return(isUserDefinedClassID($serviceClassRec['ClassID']));
	}

	function value_not_null_or_asterisk($port)
	{
	    return(value_not_null($port) && ($port != '*'));
	}

	function getFormattedTime($upTime)
	{
	    $secs = $upTime % 60;
		$mins = ($upTime / 60) % 60;
		$hours = ($upTime / 3600) % 24;
		$days = (int) ($upTime / 86400);
		return $days . 'd ' . $hours . 'h ' . $mins . 'm ' . $secs . 's';
	}

	function serviceNumberFormat($num)
	{
		// Gig
	    if ($num > 1000000000) {
		    return(number_format($num/1000000000, 1) . 'G');
		}

		// Meg
	    if ($num >= 1000000) {
		    return(number_format($num/1000000, 1) . 'M');
		}

		// K
	    if ($num >= 1000) {
		    return(number_format($num/1000,1) . 'K');
		}

		return($num);
	}

   /************************************************************************
    *  Generic Call to the server
	************************************************************************/

	function callServerInterface($method, $params)
	{
		$service_class_array  = xu_rpc_http_concise(
			array(
				'method' => $method,
				'args'      => $params,
				'host'      => RPC_SERVER,
				'uri'    => RPC_URI,
				'port'      => RPC_PORT
			) 
		);
		return($service_class_array);
	}

   /************************************************************************
    *  Data Access functions
	************************************************************************/

	/*
	 * Source IP
	 */
	function getDisplaySourceIP($ruleRec)
	{
	    return(getSourceIP($ruleRec, 'ANY'));
	}

	function getEditorSourceIP($ruleRec)
	{
	    return(getSourceIP($ruleRec, '*'));
	}

	function getSourceIP($ruleRec, $defaultRange)
	{
		if (isset($ruleRec['Source']['IPAddressMask']['Display'])) {
			$sourceIP = $ruleRec['Source']['IPAddressMask']['Display'];
			return $sourceIP;
		}
		return($defaultRange);
	}

	/*
	 * Dest IP
	 */
	function getDisplayDestIP($ruleRec)
	{
	    return(getDestIP($ruleRec, 'ANY'));
	}

	function getEditorDestIP($ruleRec)
	{
	    return(getDestIP($ruleRec, '*'));
	}

	function getDestIP($ruleRec, $defaultRange)
	{
		if (isset($ruleRec['Destination']['IPAddressMask']['Display'])) {
			$destIP = $ruleRec['Destination']['IPAddressMask']['Display'];
			return $destIP;
		}
		return($defaultRange);
	}

	/*
	 * Source Port
	 */
	function getDisplaySourcePort($ruleRec)
	{
	    return(getSourcePort($ruleRec, '*'));
	}

	function getEditorSourcePort($ruleRec)
	{
	    return(getSourcePort($ruleRec, ''));
	}

	function getSourcePort($ruleRec, $defaultRange = '*')
	{
		if (isset($ruleRec['Destination']['PortRange']['Begin'])) {
			$sourcePort = $ruleRec['Destination']['PortRange']['Begin'];
			return $sourcePort;
		} else if (isset($ruleRec['Destination']['Port'])) {
			$sourcePort = $ruleRec['Destination']['Port'];
			return $sourcePort;
		}
		return($defaultRange);
	}

	/*
	 * Dest Port
	 */
	function getDisplayDestPort($ruleRec)
	{
	    return(getDestPort($ruleRec, '*'));
	}

	function getEditorDestPort($ruleRec)
	{
	    return(getDestPort($ruleRec, ''));
	}

	function getDestPort($ruleRec, $defaultRange = '*')
	{
		if (isset($ruleRec['Destination']['PortRange']['End'])) {
			$sourcePort = $ruleRec['Destination']['PortRange']['End'];
			return $sourcePort;
		}
		return($defaultRange);
	}

	/*
	 * Port Range
	 */
	function getPortRange($ruleRec)
	{
		$sourcePort = getSourcePort($ruleRec);
		$destPort = getDestPort($ruleRec);
		if ($sourcePort == '') {
			$ret = $destPort;
		} else if ($destPort == '' || $destPort == '*') {
			$ret = $sourcePort;
		} else {
			$ret = $sourcePort . '-' . $destPort;
		}
		return $ret;
	}

	function getServiceName($serviceClassRec)
	{
	    if (isset($serviceClassRec['ClassName'])) {
		    return $serviceClassRec['ClassName'];
		}
		return('');
	}

	function getServiceID($serviceClassRec)
	{
	    if (isset($serviceClassRec['ClassID'])) {
		    return $serviceClassRec['ClassID'];
		}
		return('');
	}

	function getCompression($serviceClassRec)
	{
	    if (isset($serviceClassRec['Policy']['Compression'])) {
		    return (boolean) $serviceClassRec['Policy']['Compression'];
		}
		return(false);
	}

	function getFlowControl($serviceClassRec)
	{
	    if (isset($serviceClassRec['Policy']['FlowControl'])) {
		    return (boolean) $serviceClassRec['Policy']['FlowControl'];
		}
		return(false);
	}

	function getCIFS($serviceClassRec)
	{
	    if (isset($serviceClassRec['Policy']['CIFS'])) {
		    return (boolean) $serviceClassRec['Policy']['CIFS'];
		}
		return(false);
	}

	function getRuleCount($serviceClassRec)
	{
	    return(isset($serviceClassRec['SRC_DEST_IP_PORT_ARRAY']) ?
				count($serviceClassRec['SRC_DEST_IP_PORT_ARRAY']):
				0);
	}

	function getServiceDisplayable($serviceClassRec)
	{
	    if (getServiceID($serviceClassRec) == PASSTHROUGH_SC_ID) {
		    return(false);
		}
		return(true);
	}




   /************************************************************************
    *  Server API calls for service class functions
	************************************************************************/
	function getServiceClasses($id = 0)
	{
		// get the service classes
		$param["ClassID"] = (int) $id;
		$serviceClassArray = callServerInterface("ServiceClassGet", $param);
		return $serviceClassArray;
	}

	function createServiceClass($id, $name)
	{
		$param["ClassName"] = $name;
		$param["ClassID"] = (int) $id;
		$param['Policy']['FlowControl'] = (boolean) 1;
		$param['Policy']['Compression'] = (boolean) 1;
		$param['Policy']['CIFS'] = (boolean) 1;
		return(callServerInterface("ServiceClassCreate", $param));
	}

	function modifyServiceClass($id, $name)
	{
		$serviceClassRec["ClassID"] = (int)$id;
		$serviceClassRec["ClassName"] = $name;
		return(callServerInterface("ServiceClassRename", $serviceClassRec));
	}

	function changeServiceClass($serviceClassArray)
	{
		return(callServerInterface("ServiceClassChange", $serviceClassArray));
	}

	function deleteServiceClass($id)
	{
		$param["ClassID"] = (int) $id;
		return(callServerInterface("ServiceClassDelete", $param));
	}


   /************************************************************************
    *  Server API calls for service rules functions
	************************************************************************/
	function createRuleRec($sourceIP, $destIP, $fromPort, $toPort) 
	{
		if (value_not_null_or_asterisk($sourceIP)) {
			$ruleRec['Source']['IPAddressMask']['Display'] = $sourceIP;
		}
		if (value_not_null_or_asterisk($destIP)) {
			$ruleRec['Destination']['IPAddressMask']['Display'] = $destIP;
		}

		// If both values are null 
		if (!value_not_null_or_asterisk($fromPort) && !value_not_null_or_asterisk($toPort)) {
		    // Do not put any values in the xml

		// If both values are not null 
		} else if (value_not_null_or_asterisk($fromPort) && value_not_null_or_asterisk($toPort)) {

			// Place a range in the xml
			$ruleRec['Destination']['PortRange']['Begin'] = $fromPort;
			$ruleRec['Destination']['PortRange']['End'] = $toPort;

		// Only one value is null 
		} else {

			// Place the one non null value in the xml
			if (value_not_null_or_asterisk($fromPort)) {
				$ruleRec['Destination']['Port'] = $fromPort;
			}
			if (value_not_null_or_asterisk($toPort)) {
				$ruleRec['Destination']['Port'] = $toPort;
			}
		}
		return $ruleRec;
	}

	function modifyServiceRule($serviceID, $ruleID, $sourceIP, $destIP, 
				   $fromPort,  $toPort)
	{
		$serviceClassRec = getServiceClasses($serviceID);
		$ruleRec = createRuleRec($sourceIP, $destIP, $fromPort, $toPort);
		$serviceClassRec['SRC_DEST_IP_PORT_ARRAY'][$ruleID] = $ruleRec;
		//unset($serviceClassRec['Index']);
		//echo "<br><br>Index : " . $serviceClassRec['Index'];
		//var_dumper($serviceClassRec);
		//exit(0);
		$test = testServerInterfaceOut("ServiceClassChange", $serviceClassRec);
		//echo "<br><br>MODIFY:  ", htmlspecialchars($test);
		return(changeServiceClass($serviceClassRec));
	}

	function createServiceRule($serviceID, $sourceIP, $destIP, 
                            $fromPort,  $toPort)
	{
		$serviceClassRec = getServiceClasses($serviceID);
		$ruleRec = createRuleRec($sourceIP, $destIP, $fromPort, $toPort);
		$serviceClassRec['SRC_DEST_IP_PORT_ARRAY'][] = $ruleRec;
		//unset($serviceClassRec['Index']);
		//echo "<br><br>Index : " . $serviceClassRec['Index'];
		//echo '<br>ServiceRec: ' . var_dumper($serviceClassRec);
		$test = testServerInterfaceOut("ServiceClassChange", $serviceClassRec);
		//echo "<br><br>ADD:  ", htmlspecialchars($test);
		return(changeServiceClass($serviceClassRec));
	}

	function deleteServiceRule($serviceID, $ruleID)
	{
		$serviceClassRec = getServiceClasses($serviceID);
		unset($serviceClassRec['SRC_DEST_IP_PORT_ARRAY'][(int) $ruleID]);
		//echo 'Del: ';
		//var_dumper($serviceClassRec);
		return(changeServiceClass($serviceClassRec));
	}


   /************************************************************************
    *  Server API methods for policy functions
	************************************************************************/

	function setPolicy($serviceID, $flowControl, $compression/*, $cifs*/)
	{
		$param['ClassID'] = (int) $serviceID;
		$param['Policy']['FlowControl'] = (boolean) (($flowControl == 'true') ? 1 : 0);
		$param['Policy']['Compression'] = (boolean) (($compression == 'true') ? 1 : 0);
		//$param['Policy']['CIFS'] = (boolean) (($cifs == 'true') ? 1 : 0);
		//echo 'Policy: ' . $flowControl . $compression . $cifs;
		//var_dumper($param);
		//$test = testServerInterfaceOut("ServiceClassSetPolicy", $param);
		//echo '<br><br>Output: ';
		//var_dumper($param);
		//echo '<br>';
		return(callServerInterface("ServiceClassSetPolicy", $param));
	}

	function setPolicies($serviceArray)
	{
	    $serviceLines = explode(' ', $serviceArray);
		//var_dumper($serviceLines);
		foreach ($serviceLines as $serviceLine) {
		    $fields = explode('-', $serviceLine);
			$serviceID = $fields[0];
			$flowControl = $fields[1];
			$compression = $fields[2];
		    //sscanf($serviceLine, "%d-%s-%s", $serviceID, $flowControl, $compression);
			//if (isUserDefinedClassID($serviceID)) {
			//echo 'SetPolicy ' . $serviceLine . 'D ' .$serviceID . 'E ' . $flowControl . 'F ' . $compression;
			$resp =  setPolicy($serviceID, $flowControl, $compression);
			//var_dumper($resp);
			//} 
		}
	}

	function setServiceClassOrder($serviceArray)
	{
	    $serviceLines = explode(' ', $serviceArray);
		//var_dumper($serviceLines);
		foreach ($serviceLines as $serviceLine) {
		    $fields = explode('-', $serviceLine);
			$serviceID = $fields[0];
			if (isUserDefinedClassID($serviceID)) {
				$rec['ClassID'] = (int) $serviceID;
				$classIDs[] = $rec;
				//$classIDs['ClassID'][] = $serviceID;
			}
		}
		$param[] = $classIDs;
		//echo 'PARAM ';
		//var_dumper($param);
		return(callServerInterface("ServiceClassUpdateOrder", $param));
	}

	function moveServiceClass($serviceID, $direction)
	{
	    $serviceClassArray = getServiceClasses();
		$serviceClassArray  = orderServiceClasses($serviceClassArray);
		$i = 0;
		foreach ($serviceClassArray as $serviceClassRec) {
			// Do not do anything for predefined classes
			if (!isUserDefinedClass($serviceClassRec)) {

			// If we are going up and
			} else  {
			    /*$orderRec['ClassID'] = $serviceClassRec['ClassID'];
				$orderRec['Index'] = $serviceClassRec['Index'];
			    $param[] = $orderRec;*/
			    /*$param['ClassID'][] = $serviceClassRec['ClassID'];
				$param['Index'][] = $serviceClassRec['Index'];
				*/
				$rec['ClassID'] = $serviceClassRec['ClassID'];
				$classIDs[] = $rec;
				if ($serviceClassRec['ClassID'] == $serviceID) {
					$serviceIDIndex = $serviceClassRec['Index'];
				}
			}
		}

		if ($direction == 'UP') {
		    if ($serviceIDIndex > 0) {
				$tmp = $classIDs[$serviceIDIndex-1];
				$classIDs[$serviceIDIndex-1] = 
				      $classIDs[$serviceIDIndex];
				$classIDs[$serviceIDIndex] = $tmp;
			}
		}
		if ($direction == 'DOWN') {
		    if ($serviceIDIndex +1 < count($classIDs)) {
				$tmp = $classIDs[$serviceIDIndex+1];
				$classIDs[$serviceIDIndex+1] = 
				      $classIDs[$serviceIDIndex];
				$classIDs[$serviceIDIndex] = $tmp;
			}
		}

		$param[] = $classIDs;
		echo 'PARAM ';
		var_dumper($param);

		return(callServerInterface("ServiceClassUpdateOrder", $param));
	}

   /************************************************************************
    *  Service class functions for statistics functions
	************************************************************************/
	function getStatistics()
	{
		$param = null;
		return(callServerInterface("ServiceClassGetStat", $param));
	}


	function getSystemUpTime($serviceStatRec)
	{
	    $upTime = (int) $serviceStatRec['EpochCounters']['Elapsed'];
		return getFormattedTime($upTime);
	}

	function getUserUpTime($serviceStatRec)
	{
	    $upTime = (int) $serviceStatRec['UserCounters']['Elapsed'];
		return getFormattedTime($upTime);
	}

	function resetUserCounters($serviceID)
	{
		$param["ClassID"] = (int) $serviceID;
		return(callServerInterface("ServiceClassResetCounter", $param));
	}


   /************************************************************************
    *  Validation routines
	************************************************************************/

	/*
	 * Validate components of a service rule - usually called before creating
	 * a rule
	 */
	function validateServiceRule($sourceIP, $destIP, $fromPort, $toPort)
	{
		$errors[ERR_SUCCESS_INDEX] = TRUE;
	    if (($err = validIPWithMask($sourceIP)) != SUCCESS) {
		    $errors[ERR_SOURCE_IP_INDEX] = $err;
			$errors[ERR_SUCCESS_INDEX] = FALSE;
		}
	    if (($err = validIPWithMask($destIP)) != SUCCESS) {
		    $errors[ERR_DEST_IP_INDEX] = $err;
			$errors[ERR_SUCCESS_INDEX] = FALSE;
		}
	    if (($err = validPort($fromPort)) != SUCCESS) {
		    $errors[ERR_FROM_PORT_INDEX] = $err;
			$errors[ERR_SUCCESS_INDEX] = FALSE;
		}
	    if (($err = validPort($toPort)) != SUCCESS) {
		    $errors[ERR_TO_PORT_INDEX] = $err;
			$errors[ERR_SUCCESS_INDEX] = FALSE;
		}
		return($errors);
	}

	/*
	 * Validate IP with a mask
	 */
	function validIPWithMask($ipWithMask)
	{
	    $ipArray = explode("/", $ipWithMask);

		if(count($ipArray)>2) {
			// To many /'s
			return ERR_INVALID_IP;
		}

		if (isset($ipArray[1]) && 
		    ($error = validMask($ipArray[1])) != SUCCESS) {
		    return $error;
		}

		return(validIP($ipArray[0]));
	}

	/*
	 * Validate just the ip
	 */
	function validIP($ip)
	{
		if ($ip == '*' || strlen($ip) == 0) {
		    return SUCCESS;
		}

		$ip = explode(".", $ip);
		if(count($ip)!=4) {
			return ERR_INVALID_IP;
		}

		foreach($ip as $block) {
			if(!is_numeric($block) || $block>255 || $block<0) {
				return ERR_INVALID_IP;
			}
		}

		return SUCCESS;
	}

	/*
	 * Validate the mask
	 */
	function validMask($mask)
	{
		if (!is_numeric($mask) || $mask>32 || $mask<0) {
			return ERR_INVALID_MASK;
		}
		return SUCCESS;
	}

	/*
	 * Validate a port
	 */
	function validPort($port)
	{
	    if ($port == '*' || strlen($port) == 0) {
		    return SUCCESS;
		} 

		if(!is_numeric($port) || $port>65536 || $port<0) {
			return ERR_INVALID_PORT;
		}
		
		return SUCCESS;
	}
?>
