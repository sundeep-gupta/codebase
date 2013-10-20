<?
	/***********************************************************************
	 * Include section
	 **********************************************************************/
	include("../includes/header.php");
	include("service_lib.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);

	/***********************************************************************
	 * Parameter section
	 **********************************************************************/
	$action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
	$serviceID = (isset($HTTP_GET_VARS['serviceID']) ? $HTTP_GET_VARS['serviceID'] : '');
	$flowControl = (isset($HTTP_GET_VARS['flowControl']) ? $HTTP_GET_VARS['flowControl'] : '');
	$compression  = (isset($HTTP_GET_VARS['compression']) ? $HTTP_GET_VARS['compression'] : '');
	$cifs = (isset($HTTP_GET_VARS['cifs']) ? $HTTP_GET_VARS['cifs'] : '');
	$serviceArray = (isset($HTTP_GET_VARS['serviceArray']) ? $HTTP_GET_VARS['serviceArray'] : '');

	/***********************************************************************
	 * Action section
	 **********************************************************************/
	if (value_not_null($action)) {
		switch ($action) {

			// Server Actions
			case 'setPolicy':
				$resp = setPolicy($serviceID, $flowControl, $compression);
				//echo '<br><br>Response: ';
				//var_dumper($resp);
				//echo '<br>';
				break;

			// UI Actions
			case 'moveUp':
				$resp = moveServiceClass($serviceID, "UP");
				//echo '<br>Move Up: ' . $serviceID;
				//echo '<br><br>Response: ';
				//var_dumper($resp);
				break;
			case 'moveDown':
				$resp = moveServiceClass($serviceID, "DOWN");
				//echo '<br>Move Down: ' . $serviceID;
				//echo '<br><br>Response: ';
				//var_dumper($resp);
				break;
			case 'applyChanges':
				//echo 'APPLY:' . $serviceArray;
				setPolicies($serviceArray);
				$resp2 = setServiceClassOrder($serviceArray);
				//echo '<br><br>Response: ';
				//var_dumper($resp);
			    break;
			default:
				break;
		}
	}

	/***********************************************************************
	 * Variables section
	 **********************************************************************/
	$serviceClassArray  = getServiceClasses();
	$error = false;
	$processed = false;

	$serviceClassArray  = orderServiceClasses($serviceClassArray);

	/***********************************************************************
	 * JavaScript section
	 **********************************************************************/
?>



<script type="text/javascript" src="../includes/library.js"></script>
<script type="text/javascript" src="serviceScript.js"></script>

<script language="javascript">
<!--


	function onSetPolicy(id, flowControl, compression/*, cifs*/) {
		document.location = "./service_class_policy.php?serviceID=" + id;
		/*
		document.location = "./service_class_policy.php?serviceID=" + id + 
		                    "&flowControl=" + flowControl.checked +
		                    "&compression=" + compression.checked +
		                    "&cifs=" + "true"cifs.checked +
							"&action=setPolicy";
	*/
	}


	function onMoveUp(id) {
		//document.location = "./service_class_policy.php?serviceID=" + id + 
		//					"&action=moveUp";
		var table = getServiceTable();

	    // Find the current index
		var curIndex = selectedRowIndex(table);

		// Swap with above
		//DebugOut("start");
		//DebugOut(curIndex);
		if (curIndex > 1) {
			swapRow(table, curIndex-1, curIndex);
		}
		enableApplyCancel();
	}

	function onMoveDown(id) {
		//document.location = "./service_class_policy.php?serviceID=" + id + 
		//					"&action=moveDown";
		var table = getServiceTable();

	    // Find the current index
		var curIndex = selectedRowIndex(table);

		// Swap with above
		//DebugOut("start");
		//DebugOut(table.rows.length);
		if (curIndex < table.rows.length-3) {
			swapRow(table, curIndex, curIndex+1);
		}
		enableApplyCancel();
	}

	function onApply() {
		var serviceIDArray = "";
		var curID = "";
		var inputs = document.getElementsByTagName("input");
	    for (var i=0; i<inputs.length; i++) {
			if (inputs[i].type == "checkbox") {
			    var a = inputs[i].name.split("_");
				if (a[1] != curID) {
					if (curID == "") {
						serviceIDArray = serviceIDArray + a[1];
					} else {
						serviceIDArray = serviceIDArray + " " + a[1];
					}
					curID = a[1];
				}

				serviceIDArray = serviceIDArray + "-" + inputs[i].checked;
			}
		}
	    var serviceID = selectedRowServiceID();
		document.location = "./service_class_policy.php?serviceID=" + 
		                     serviceID + "&serviceArray=" + serviceIDArray + 
							"&action=applyChanges";
	}

	function onCancel() {
		document.location = "./service_class_policy.php";
	}


	function enableApplyCancel()
	{
	    var el = document.getElementsByName("policyApply");
		el[0].disabled = false;
	    var el = document.getElementsByName("policyCancel");
		el[0].disabled = false;
	}

	function disableMoveUpDown()
	{
	    var el = document.getElementsByName("policyMoveUp");
		el[0].disabled = true;
	    var el = document.getElementsByName("policyMoveDown");
		el[0].disabled = true;
	}

	function enableMoveUpDown()
	{
	    var el = document.getElementsByName("policyMoveUp");
		el[0].disabled = false;
	    var el = document.getElementsByName("policyMoveDown");
		el[0].disabled = false;
	}


//-->
</script>

    <!--*******************************************************************
     * Main HTML Block
     ********************************************************************-->
<TABLE cellspacing=0 cellpadding=0><TR><TD width=700/></TR></TABLE>
<form name="serviceClassPolicy">

<font class="pageheading">Configure Settings: Service Class Policy</font><BR><BR>

<table border="0" width=600 cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
	  <table id="serviceTable" border="1" width="100%" cellspacing="0" cellpadding="2" rules="none">
	    <tr class="tableHeadingRow">
		  <td class="headingContent">Service Name</td>
		  <td class="headingContent" align="center">Flow Control</td>
		  <td class="headingContent" align="center">Compression</td>
		  <!--<td class="headingContent" align="center">CIFS</td>-->
	    </tr>

<?
	$i = 0;
	if (isset($serviceClassArray)) foreach ($serviceClassArray as $serviceClassRec) {

		// only display classes that need it
		if (!getServiceDisplayable($serviceClassRec)) continue;
		$curID = getServiceID($serviceClassRec);
		if ($curID  == $serviceID) {
			$selServiceClassRec = $serviceClassRec;
			$trID = 'id="defaultSelected"';
			$trClass = 'dataTableRowSelected';
			$actionFragment = '&action=modifyUI';
			$tdClass = 'dataTableContentSelected';
		} else {
			$trClass = 'dataTableRow';
			if (($i % 2) == 0)  {
				$trID = '';
				$actionFragment = '';
				$tdClass = '"dataTableContentEvenRow"';
			} else {
				$trID = '';
				$actionFragment = '';
				$tdClass = '"dataTableContent"';
			}
		}
?>

	    <tr <?php echo $trID; ?>  class=<?php echo $trClass; ?> 
		    onmouseover="rowOverEffect(this)" 
		    onmouseout="rowOutEffect(this)" 
			onclick="selectRow(this)"
		    <?php /*echo "onclick=\"onSetPolicy(" . $curID . ", " .
			  "document.serviceClassPolicy.flowControl_" . $curID . ", " .
			  "document.serviceClassPolicy.compression_" . $curID . ", " .
			  "document.serviceClassPolicy.cifsBox" . $curID .
			  ")\" ";*/ ?>>
		  <td class=<?php echo $tdClass; ?>>
		    <?php echo getServiceName($serviceClassRec); ?>
		  </td>
		  <td class=<?php echo $tdClass; ?> align="center">
		    <input type=checkbox name=flowControl_<?php echo $curID; ?>
			  <?php if (getFlowControl($serviceClassRec)) echo 'checked'; ?>
			       onclick="enableApplyCancel()"/>
		  </td>
		  <td class=<?php echo $tdClass; ?> align="center">
		    <input type=checkbox name=compression_<?php echo $curID; ?> 
			  <?php if (getCompression($serviceClassRec)) echo 'checked'; ?>
			       onclick="enableApplyCancel()"/>
		  </td>
	    </tr>

<?
	    $i++;
	} // For statement - looping through rules
?>

         <tr>
           <td colspan="5">
		     <table border="0" width="100%" cellspacing="0" cellpadding="2">
               <tr>
                 <td align="right" class="smallText">
                   <INPUT type="button" name="policyMoveUp" value="Move Up" 
				          title=" Move Up " 
						  <?php if (!isset($selServiceClassRec) || !isUserDefinedClass($selServiceClassRec)) echo 'disabled'; ?>
						  <?php echo "onclick=\"onMoveUp(this)\""?> />
                   <INPUT type="button" name="policyMoveDown" value="Move Down"
				          title=" Move Down " 
						  <?php if (!isset($selServiceClassRec) || !isUserDefinedClass($selServiceClassRec)) echo 'disabled'; ?>
						  <?php echo "onclick=\"onMoveDown(" . $serviceID . ")\""?> />
                   <INPUT type="button" name="policyCancel" value="Cancel"
				          title=" Cancel " disabled
						  onclick="onCancel()"/>
                   <INPUT type="button" name="policyApply" value="Apply"
				          title=" Apply " disabled
						  onClick="onApply()"/>
						  
           &nbsp;
                 </td>
               </tr>
	         </table>
	       </td>
	     </tr>

	  </table>
	</td>
  </tr>

</table>
</form>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
