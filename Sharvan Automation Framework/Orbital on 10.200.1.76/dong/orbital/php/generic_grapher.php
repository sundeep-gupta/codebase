<?
	include("includes/header.php");
	$Auth->CheckRights(AUTH_LEVEL_VIEWER);


	//
	// Display the Adapter grapher
	//
   $Adapters = OrbitalGet("ADAPTER", array("InstanceNumber", "DisplayName") );

   $AdapterSchema = OrbitalGet("ADAPTER_SCHEMA");
	$i = 0;
   foreach ($AdapterSchema as $Name=>$Value)
   {
   	if ($Value["DataType"] == "PERF_COUNTER_LOW_RES")
   	{
   		$AdapterCounters[$i]["DisplayName"] = $Name;
   		$i ++;
   	}
   }

	//
	// Connection list
	//
   $Connections = OrbitalGet("CONNECTION", array("ClientLogicalAddress", "ClientPhysicalAddress",
            												 "ServerLogicalAddress", "ServerPhysicalAddress",
            												 "Duration", "InstanceNumber", "BytesTransferred", "IdleTime") );


	$ConnList = array();
	foreach ($Connections as $ix=>$Connection)
	{
		$ConnList[$ix]["DisplayName"] = 
					FormatTCPAddressCompact($Connection["ClientLogicalAddress"]) . "=>" .
					FormatTCPAddressCompact($Connection["ServerLogicalAddress"]) .
					"(" . $Connection["InstanceNumber"] . ")";
					
		$ConnList[$ix]["InstanceNumber"] = $Connection["InstanceNumber"];
	}

	//
	// System 
	//
   $SystemSchema = OrbitalGet("SYSTEM_SCHEMA");
	$i = 0;
   foreach ($SystemSchema as $Name=>$Value)
   {
   	if ($Value["DataType"] == "PERF_COUNTER_LOW_RES")
   	{
   		$SystemCounters[$i]["DisplayName"] = $Name;
   		$i++;
   	}
   }

?>
	<FORM>
		Adapters: 
			<?=DrawDropdown("Adapters", "DisplayName", "InstanceNumber", $Adapters)?>
			<?=DrawDropdown("AdaptersCounters", "DisplayName", "DisplayName", $AdapterCounters)?>
			<INPUT type="Submit" name="AddGraph" value="Add Graph" type="Get">
	</FORM>

	<FORM>
		Connnections: 
			<?=DrawDropdown("InstanceNumber", "DisplayName", "InstanceNumber", $ConnList)?>
			<INPUT type="hidden" name="GraphType" value="Connection">
			<INPUT type="Submit" name="AddGraph" value="Add Graph" type="Get">			
	</FORM>

	<FORM>
		System: 
			<?=DrawDropdown("PerfCounter", "DisplayName", "DisplayName", $SystemCounters)?>
			<INPUT type="hidden" name="GraphType" value="System">
			<INPUT type="Submit" name="AddGraph" value="Add Graph" type="Get">
	</FORM>
<?

//	var_dumper($_GET);
//	var_dumper($_SESSION['GRAPH_LIST']);
	

	// 
	// Used to track info for GenericGraph.php 
	//
	class GENERIC_GRAPHER
	{
		var $ThisVarNotUsed;
		var $GraphList = array();
		
		function GENERIC_GRAPHER()
		{
			if (isset($_SESSION['GRAPH_LIST'])) $this->GraphList = $_SESSION['GRAPH_LIST'];
		}

		function AddGraph($ParamList)
		{
			$GraphType = $_GET['GraphType'];
			if ( isset($_GET['InstanceNumber']) ) $InstanceNumber = $_GET['InstanceNumber']; 
			else $InstanceNumber = -1;
			if ( isset($_GET['PerfCounter']) ) $PerfCounter = $_GET['PerfCounter'];
			else $PerfCounter = "";

			foreach ($this->GraphList as $GraphItem)
			{
				// See if this graph is new
				//
				if ( ($GraphItem['GraphType'] == $GraphType) &&
					  ($GraphItem['InstanceNumber'] == $InstanceNumber) &&
					  ($GraphItem['PerfCounter'] == $PerfCounter) )
				{
					//echo "Graph is NOT new...NOT adding...<br>\n";
					return;
				}					  
			}

			$GraphItem['GraphType'] = $GraphType;
			$GraphItem['InstanceNumber'] = $InstanceNumber;
			$GraphItem['PerfCounter'] = $PerfCounter;
			
			array_push($this->GraphList, $GraphItem);	
			
			$_SESSION['GRAPH_LIST'] = $this->GraphList;
			
		}//AddGraph()
		
		function DeleteGraph($GraphNumber)
		{
			$i = 0;
			$NewGraphList = array();
			foreach ($this->GraphList as $GraphItem)
			{
				if ($i != $GraphNumber)
				{
					array_push($NewGraphList, $GraphItem);
				}
				$i++;
			}

			$_SESSION['GRAPH_LIST'] = $NewGraphList;
			$this->GraphList = $NewGraphList;
		}
		
		function RenderAll()
		{
			foreach ($this->GraphList as $GraphItem)
			{
				$GraphType = $GraphItem['GraphType'];
			
				if ($GraphType == "System")
				{
					$PerfCounter = $GraphItem['PerfCounter'];

					$GraphData = OrbitalGet("SYSTEM", $PerfCounter);

					$graph = new PerformanceGrapher($PerfCounter,
																array($PerfCounter),
																array("red"));
					$graph->AddDataPoints($PerfCounter, $GraphData[$PerfCounter]["Rate"]);
					$graph->RenderGraph(1000*1000);
				}
			}

		}//RenderAll()
		
		
		//
		// Display the graphs in memory...for debugging uses...
		//
		function ToString()
		{
			echo " === GRAPHS === <br>\n";
			foreach ($this->GraphList as $GraphItem)
			{
				echo "Graph: " . $GraphItem['GraphType'] . " : " . $GraphItem['PerfCounter'] . "<br>\n";
			}
		}
	}


	$Grapher = new GENERIC_GRAPHER();
	
	//
	// Add a new graph...
	//
	if (isset($_GET['AddGraph']))
	{
		echo "Adding a graph...<br>\n";
		
		$Grapher->AddGraph($_GET);
	}
	else if (isset($_GET['DeleteGraph']))
	{
		$GraphNum = $_GET['GraphNum'];
		$Grapher->DeleteGraph($GraphNum);
	}
	
	$Grapher->ToString();
//	$Grapher->RenderAll();


	//
	// Render all the current graphs...
	//
	/*
	if (isset($_SESSION['GRAPH_LIST']))
	{
		$GraphList = $_SESSION['GRAPH_LIST'];
		
		foreach ($GraphList as $OneGraph)
		{
			$GraphType = $OneGraph['GraphType'];
			
			// Graph a connection
			if 	  ($GraphType == "Connection")
			{

			}
			else if ($GraphType == "System") 
			{
				$PerfCounter = $OneGraph['PerfCounter'];
				
				$GraphData = OrbitalGet("SYSTEM", $PerfCounter);
				
		      $graph = new PerformanceGrapher($PerfCounter ,
		      											array($PerfCounter),
		      											array("red"));
		      $graph->AddDataPoints($PerfCounter, $GraphData[$PerfCounter]["Rate"]);
		      $graph->RenderGraph(300);
				
			}
		}
	}
	*/

?>
<?
/*
 * $Log: $
 *
 *
 */
?>
