<?
   /************************************************************************
    *  Includes section
	************************************************************************/

	include("../includes/header.php");
	include("service_lib.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);


   /************************************************************************
    *  Get parameters from URL
	************************************************************************/

	$action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
	$serviceID = (isset($HTTP_GET_VARS['serviceID']) ? $HTTP_GET_VARS['serviceID'] : '');
	$sourceIP  = (isset($HTTP_GET_VARS['sourceIP']) ? $HTTP_GET_VARS['sourceIP'] : '');
	$destIP  = (isset($HTTP_GET_VARS['destIP']) ? $HTTP_GET_VARS['destIP'] : '');
	$fromPort  = (isset($HTTP_GET_VARS['fromPort']) ? $HTTP_GET_VARS['fromPort'] : '');
	$toPort  = (isset($HTTP_GET_VARS['toPort']) ? $HTTP_GET_VARS['toPort'] : '');
	$ruleID = (isset($HTTP_GET_VARS['ruleID']) ? $HTTP_GET_VARS['ruleID'] : 0);


   /************************************************************************
    *  Execute the action
	************************************************************************/

	if (value_not_null($action)) {
		switch ($action) {

			// Server Actions
			case 'newRule':
				$errors = validateServiceRule($sourceIP, $destIP, 
				                              $fromPort, $toPort);
				//var_dump($errors);
				if ($errors[ERR_SUCCESS_INDEX]) {
					$response = createServiceRule($serviceID, $sourceIP, 
					                              $destIP, $fromPort, 
												  $toPort);
				} else {
				    $action = 'newRuleUIError';
				}
				// echo 'Add RESP<br><br>  ' . var_dumper($response);
				//echo 'RESP<br><br>  ' . htmlspecialchars($response);
				//echo HTML::InsertRedirect("service_class_config.php?serviceID=" . $serviceID, 0);
				//exit(0);
				break;
			case 'modify':
				$errors = validateServiceRule($sourceIP, $destIP, 
				                              $fromPort, $toPort);
				//var_dump($errors);
				if ($errors[ERR_SUCCESS_INDEX]) {
				    $response = modifyServiceRule($serviceID, $ruleID, $sourceIP,
				                                  $destIP, $fromPort, $toPort);
				} else {
				    $action = 'modifyUIError';
				}
				//echo 'Modify RESP<br><br>  ' . var_dumper($response);
				//echo 'RESP<br><br>  ' . htmlspecialchars($response);
				//echo HTML::InsertRedirect("service_class_config.php?serviceID=" . $serviceID, 0);
				//exit(0);
				break;
			case 'delete':
				$response = deleteServiceRule($serviceID, $ruleID);
				//echo 'Delete RESP<br><br>  ' . var_dumper($response);
				//echo 'RESP<br><br>  ' . htmlspecialchars($response);
				echo HTML::InsertRedirect("service_class_config.php?serviceID=" . $serviceID, 0);
				exit(0);
				break;

			// UI Actions
			case 'modifyUI':
				break;
			case 'deleteUI':
				break;
			default:
				break;
		}
	}

   /************************************************************************
    *  Set up the variables
	************************************************************************/
	$serviceClassRec  = getServiceClasses((int) $serviceID);
	$error = false;
	$processed = false;
	$serviceName = getServiceName($serviceClassRec);
	$totalCount = 0;
	if (isset($serviceClassRec['SRC_DEST_IP_PORT_ARRAY'])) {
		$ruleArray =& $serviceClassRec['SRC_DEST_IP_PORT_ARRAY'];
		$totalCount = count($ruleArray);
	}
	


   /************************************************************************
    *  Java Script section
	************************************************************************/
?>
<script type="text/javascript" src="../includes/library.js"></script>
<script type="text/javascript" src="serviceScript.js"></script>

<script language="javascript">
<!--

	function onModifyUI(serviceID, ruleID) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value + "&ruleID=" + ruleID.value + "&action=modifyUI";
	}

	function onModify(serviceID, ruleID, sourceIP, destIP, fromPort, toPort) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value +
							"&ruleID=" + ruleID.value + 
							"&sourceIP=" + sourceIP.value +
							"&destIP=" + destIP.value +
							"&fromPort=" + fromPort.value +
							"&toPort=" + toPort.value +
							"&action=modify";
	}

	function onDeleteUI(serviceID, ruleID) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value + "&ruleID=" + ruleID.value + "&action=deleteUI";
	}

	function onDelete(serviceID, ruleID) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value + "&ruleID=" + ruleID.value + "&action=delete";
	}

	function onNewRuleUI(serviceID) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value + "&action=newRuleUI";
	}

	function onNewRule(serviceID, sourceIP, destIP, fromPort, toPort) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value +
							"&sourceIP=" + sourceIP.value +
							"&destIP=" + destIP.value +
							"&fromPort=" + fromPort.value +
							"&toPort=" + toPort.value +
							"&action=newRule";
	}



	function onCancel(serviceID, ruleID) {
		document.location = "./service_class_config.php?serviceID=" + serviceID.value + "&ruleID=" + ruleID.value;
	}

//-->
</script>

<!--
  - Main HTML Block
 -->
<TABLE cellspacing=0 cellpadding=0><TR><TD width=700/></TR></TABLE>
<form name="serviceClassConfig">
<INPUT type="hidden" name="serviceID" value="<?=$serviceID?>">
<INPUT type="hidden" name="ruleID" value="<?=$ruleID?>">

<font class="pageheading">Configure Settings: Service Class Rules: <?echo $serviceName?></font><BR><BR>

<table border="0" width=700 cellspacing="0" cellpadding="0">
  <tr>
	<td>
	  <table border="0" width="700" cellspacing="0" cellpadding="0">
	    <tr>

		  <td valign="top">
		    <table name="serviceTable" border="1" width="100%" cellspacing="0" cellpadding="2"
			       rules="none">
			  <tr class="tableHeadingRow">
				<td class="headingContent">Source IP</td>
				<td class="headingContent">Destination IP</td>
				<td class="headingContent" align="right">Port&nbsp;</td>
				<td class="headingContent" align="right">Action&nbsp;</td>
			  </tr>

<?
	$i = 0;
	if (isset($ruleArray)) foreach ($ruleArray as $ruleRec) {
		//$service_class =  $service_class_array[$i];
		//echo "<br><br>REC  ";
		//var_dumper($ruleRec);
		//echo "<br><br> Array:  ";
		//var_dumper($ruleArray);
		//$ruleRec = $ruleArray;

		if ($i == $ruleID) {
			$selRuleRec = $ruleRec;
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
				  onclick="document.location.href='./service_class_config.php?serviceID=<?php echo $serviceID?>&ruleID=<?php echo $i?>&action=modifyUI'">
			    <td class=<?php echo $tdClass; ?>>
				  <?php echo getDisplaySourceIP($ruleRec); ?>
			    </td>
			    <td class=<?php echo $tdClass; ?>>
				  <?php echo getDisplayDestIP($ruleRec); ?>
				</td>
				<td class=<?php echo $tdClass; ?> align="right">
				  <?php echo getPortRange($ruleRec); ?>
				</td>
				<td class=<?php echo $tdClass; ?> align="right">
				  <?php if ($i == $ruleID) { ?>
				    <img src="../images/icon_arrow_right.gif" border="0" alt="">&nbsp;
				  <? } else { ?>
					<a href="./service_class_config.php?serviceID=<?php echo $serviceID; ?>&ruleID=<?php echo $i; ?>"><img src="../images/icon_info.gif" border="0" alt="Info" title=" Info "></a>&nbsp;
				  <? } ?>
				</td>
			  </tr>

<?
	    $i++;
	} // For statement - looping through rules
?>

			  <tr>
				<td colspan="4">
				  <table border="0" width="100%" cellspacing="0" 
				         cellpadding="2">
					<tr>
					  <td align="right" class="smallText">
						<INPUT type="button" name="newRuleUI" 
						       value="New Rule..." 
							   onClick="onNewRuleUI(document.serviceClassConfig.serviceID)"/>&nbsp;
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>

			</table>
		  </td>

<?
	if (isset($selRuleRec) || ($action=='newRuleUI') || 
	    ($action == 'newRuleUIError'))  {
?>

		  <td width="30%" valign="top">
			<table border="1" width="100%" cellspacing="0" cellpadding="2"
			       rules="none">
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading" colspan="2">
				  <b><?php echo $serviceName; ?></b>
				</td>
			  </tr>

<?
		if ($action == 'newRuleUI' || $action == 'modifyUI' || 
		    $action == 'newRuleUIError' || $action == 'modifyUIError' || 
		    $action == 'deleteUI') {
			if ($action == 'newRuleUI' || $action == 'newRuleUIError') {
			   $infoBoxTitle = "Add Rule:";
			} else if ($action == 'modifyUI' || $action == 'modifyUIError') {
			   $infoBoxTitle = "Modify Rule:";
			} else if ($action == 'deleteUI') {
			   $infoBoxTitle = "Delete Rule:";
			}
?>

			  <tr>
				<td class="infoBoxContent" colspan="2"><b><?php echo $infoBoxTitle; ?></b></td>
			  </tr>

<? 
		}
		if ($action == 'newRuleUI' || $action == 'modifyUI' ||
		    $action == 'newRuleUIError' || $action == 'modifyUIError')  { 

			if ($action == 'modifyUI') {
				$sourceIP = getEditorSourceIP($selRuleRec);
				$destIP = getEditorDestIP($selRuleRec);
				$fromPort = getEditorSourcePort($selRuleRec);
				$toPort = getEditorDestPort($selRuleRec);
			}
?>
			  <tr>
				<td class="infoBoxContent">Source IP/Mask: </td>
				<td class="infoBoxContent">
				  <INPUT type="text" name="newSourceIP" 
				         <?php echo "value=\"" . $sourceIP . "\""; ?>
				         MAXLENGTH="20" size="16"></INPUT>
				</td>
			  </tr>
			  <?php if (isset($errors[ERR_SOURCE_IP_INDEX])) {
			            echo "<tr><td  class=\"infoBoxError\" colspan=2>" . $errors[ERR_SOURCE_IP_INDEX] . '</td></tr>';
			        }
			  ?>
			  <tr>
				<td class="infoBoxContent"> Destination IP/Mask: </td>
				<td class="infoBoxContent">
				  <INPUT type="text" name="newDestIP" 
				         <?php echo "value=\"" . $destIP . "\""; ?>
				         MAXLENGTH="20" size="16"></INPUT>
				</td>
			  </tr>
			  <?php if (isset($errors[ERR_DEST_IP_INDEX])) {
			            echo "<tr><td  class=\"infoBoxError\" colspan=2>" . $errors[ERR_DEST_IP_INDEX] . '</td></tr>';
			        }
			  ?>
			  <tr>
				<td class="infoBoxContent">Example: </td>
				<td class="infoBoxContent">192.168.1.0/24 </td>
			  </tr>
			  <tr>
				<td class="infoBoxContent"> Port: </td>
				<td class="infoBoxContent">
				  <INPUT type="text" name="newPortFrom" 
				         <?php echo "value=\"" . $fromPort . "\""; ?>
						 size="5"/>&nbsp;-
				  <INPUT type="text" name="newPortTo" 
				         <?php echo "value=\"" . $toPort . "\""; ?>
						 size="5"/>
				</td>
			  </tr>
			  <?php if (isset($errors[ERR_FROM_PORT_INDEX])) {
			            echo "<tr><td  class=\"infoBoxError\" colspan=2>" . $errors[ERR_FROM_PORT_INDEX] . '</td></tr>';
			        }
			  ?>
			  <?php if (isset($errors[ERR_TO_PORT_INDEX])) {
			            echo "<tr><td  class=\"infoBoxError\" colspan=2>" . $errors[ERR_TO_PORT_INDEX] . '</td></tr>';
			        }
			  ?>
			  <tr>
				<td align="center" class="infoBoxContent">

				<?php if ($action == 'newRuleUI') { ?>

				  <INPUT type="button" name="newRule" value="  Save  " 
				        onClick="onNewRule(document.serviceClassConfig.serviceID, document.serviceClassConfig.newSourceIP, document.serviceClassConfig.newDestIP, document.serviceClassConfig.newPortFrom, document.serviceClassConfig.newPortTo)"/>

				<?php } else { ?>

				  <INPUT type="button" name="sc_save" value="  Save  " 
				        onClick="onModify(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID, document.serviceClassConfig.newSourceIP, document.serviceClassConfig.newDestIP, document.serviceClassConfig.newPortFrom, document.serviceClassConfig.newPortTo)"/>

				<?php } ?>

				</td>
				<td align="left" class="infoBoxContent">
				  <INPUT type="button" name="cancel" value="Cancel" 
				         onClick="onCancel(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID)"/>
				</td>
			  </tr>

<? 
		} else if ($action == 'deleteUI') {
?>

			  <tr>
				<td class="infoBoxContent">Are you sure you want to delete this rule?</td>
			  </tr>
			  <tr>
				<td class="infoBoxContent"><b></b></td>
			  </tr>
			  <tr>
				<td align="center" class="infoBoxContent"><br>
				  <INPUT type="button" name="sc_delete" value="Delete" 
				         onClick="onDelete(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID)"/>
				  <INPUT type="button" name="cancel" value="Cancel" 
				         onClick="onCancel(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID)"/>
				</td>
			  </tr>

<?
		} else {
?>

			  <tr>
				<td align="center" class="infoBoxContent">
				  <INPUT type="button" name="modifyUI" value="Modify" 
				         onClick="onModifyUI(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID)"/>
				  <INPUT type="button" name="deleteUI" value="Delete" 
				         onClick="onDeleteUI(document.serviceClassConfig.serviceID, document.serviceClassConfig.ruleID)"/>
				</td>
			  </tr>

			  <tr>
				<td class="infoBoxContent"><br>Source IP: <?php echo getDisplaySourceIP($selRuleRec, 'ANY'); ?></td>
			  </tr>
			  <tr>
				<td class="infoBoxContent"><br>Destination IP: <?php echo getDisplayDestIP($selRuleRec, 'ANY'); ?></td>
			  </tr>
			  <tr>
				<td class="infoBoxContent"><br>Port: <?php echo getPortRange($selRuleRec); ?></td>
			  </tr>
<? 
		} 
?>

			</table>
		  </td>
	    </tr>

	  </table>
	</td>
  </tr>

</table>
</form>

<?
	} // is selected
?>

<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
