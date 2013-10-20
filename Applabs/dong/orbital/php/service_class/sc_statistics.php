<?
	/***********************************************************************
	 * Include Section
	 ***********************************************************************/
	include("../includes/header.php");
	include("service_lib.php");
	$Auth->CheckRights(AUTH_LEVEL_VIEWER);

	/***********************************************************************
	 * Parameter Section
	 ***********************************************************************/
	$action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
	$serviceID = (isset($HTTP_GET_VARS['serviceID']) ? $HTTP_GET_VARS['serviceID'] : '1');
	$error = false;
	$processed = false;

	/***********************************************************************
	 * Action Section
	 ***********************************************************************/
    if (value_not_null($action)) {
		switch ($action) {

		    // Server Actions
			case 'reset':
			    $resp = resetUserCounters($serviceID);
				//echo 'Response: ';
				//var_dumper($resp);
				break;
			default:
				break;
		}
	}

	/***********************************************************************
	 * Variable Section
	 ***********************************************************************/
	$serviceStatArray = getStatistics();
	//echo '<br>Stats';
	//var_dumper($serviceStatArray);


	/***********************************************************************
	 * JavaScript Section
	 ***********************************************************************/
?>
<script type="text/javascript" src="../includes/library.js"></script>
<script type="text/javascript" src="serviceScript.js"></script>

<script language="javascript">
<!--

	function onDetails(id) {
	  document.location = "./sc_statistics.php?serviceID=" + id.value + 
	                      "&action=details";
	}

	function onReset(id) {
	  document.location = "./sc_statistics.php?serviceID=" + id.value + 
	                      "&action=reset";
	}

	function onBack(id) {
	   document.location = "./sc_statistics.php?serviceID=" + id.value;
	}

//-->
</script>


<? 
	if($action=='details') { 
		foreach ($serviceStatArray as $serviceStatRec) {
			if ($serviceID == getServiceID($serviceStatRec)) {
			    $selServiceStatRec = $serviceStatRec;
				break;
			} 
		} 
		if (!isset($selServiceStatRec)) {
		    // Should not happen - go back to service Rec
		}
?>
<font class="pageheading">Monitoring: Service Class Statistics: <?php echo getServiceName($selServiceStatRec); ?></font><BR><BR>
			      
<FORM name="service_class_stat_back">
<INPUT type="hidden" name="serviceID" value="<?=$serviceID ?>">
<div>
  <TABLE>
	<TR>
	  <TH>Item:&nbsp;</TH>
	  <TD align="center">Since System Reboot</TD>
	  <TD align="center">Since User Reset</TD>
    </TR>
	<TR>
	  <TH>Current Accelerated Connections:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['CurrentFlowControlConnections']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['CurrentFlowControlConnections']); ?></TD>
	</TR>
	<TR>
	  <TH>Total Accelerated Connections:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['TotalFlowControlConnections']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['TotalFlowControlConnections']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Accelerated Send Bytes:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANFlowControlSendBytes']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendBytes']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Accelerated Send Bytes:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANFlowControlSendBytes']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendBytes']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Accelerated Send Packets:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANFlowControlSendPackets']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendPackets']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Accelerated Send Packets:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANFlowControlSendPackets']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendPackets']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Passthrough Send Bytes:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANPassthroughSendBytes']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANPassthroughSendBytes']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Passthrough Receive Bytes:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANPassthroughReceiveBytes']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANPassthroughReceiveBytes']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Passthrough Send Packets:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANPassthroughSendPackets']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANPassthroughSendPackets']); ?></TD>
    </TR>
	<TR>
	  <TH>Total Passthrough Receive Packets:&nbsp;</TH>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANPassthroughReceivePackets']); ?></TD>
	  <TD align="right"><?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANPassthroughReceivePackets']); ?></TD>
    </TR>
	<TR>
	  <TH>Duration:&nbsp;</TH>
	  <TD align="right"><?php echo getSystemUptime($serviceStatRec); ?></TD>
	  <TD align="right"><?php echo getUserUptime($serviceStatRec); ?></TD>
	</TR>
	<TR>
	  <TH>&nbsp;</TH>
	  <TD align="center" >
		<INPUT type="button" name="sc_back" value="Back" 
		       onClick="onBack(document.service_class_stat_back.serviceID)"/>&nbsp;&nbsp
	  </TD>
	  <TD>&nbsp;</TD>
    </TR>
</TABLE>
</FORM>
</DIV>
</CENTER><BR><BR>

<? 
	} else {
?>

<font class="pageheading">Monitoring: Service Class Statistics</font><BR><BR>

<table class="dataTable"  width=650 cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <table border="0" width="100%" cellspacing="0" cellpadding="0" rules="none">
		<tr>
		  <td valign="top">
		    <table name="statsTable" class="sortable" id="statsTable" border="1" width="100%" cellspacing="0" cellpadding="0" rules="none">
			  <tr class="tableHeadingRow">
			    <td class="headingContent" id="statsHeader">Service Class Name</td>
			    <td class="headingContent" align="right" id="statsHeader">Current Accelerated Connections</td>
			    <td class="headingContent" align="right" id="statsHeader">Total Accelerated Connections (Since System Boot)</td>
			    <td class="headingContent" align="right" id="statsHeader">Total Accelerated Connections (Since User Reset)</td>
			    <td class="headingContent" align="right" id="statsHeader">Total Accelerated Bytes (Since System Boot)</td>
			    <td class="headingContent" align="right" id="statsHeader">Total Accelerated Bytes (Since User Reset)</td>
			    <td class="headingContent" align="right" id="statsHeader">Total Accelerated Packets (Since User Reset)</td>
			    <td class="headingContent" align="right" id="statsHeader">Action&nbsp;</td>
			  </tr>

<?
		// Loop through statistics
		$i=0;
		foreach ($serviceStatArray as $serviceStatRec) {
			$curServiceID = getServiceID($serviceStatRec);

			if ($curServiceID == $serviceID) {
				$selServiceStatRec = $serviceStatRec;
				$selServiceID = $curServiceID;
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
				    onclick="document.location.href='./sc_statistics.php?serviceID=<?php echo $curServiceID . $actionFragment; ?>'">
			    <td class=<?php echo $tdClass; ?>>
			      <?php echo getServiceName($serviceStatRec); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['CurrentFlowControlConnections']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['TotalFlowControlConnections']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['UserCounters']['TotalFlowControlConnections']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['EpochCounters']['WANFlowControlSendBytes']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendBytes']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php echo serviceNumberFormat($serviceStatRec['UserCounters']['WANFlowControlSendPackets']); ?>
			    </td>
			    <td class=<?php echo $tdClass;?> align="right">
				  <?php if (isset($selServiceID) && $selServiceID == $curServiceID) { ?>
				  <img src="../images/icon_arrow_right.gif" border="0" alt="">&nbsp;
				  <?php } else { ?>
				  <a href="./sc_statistics.php?&serviceID=<?php echo $curServiceID?>"><img src="../images/icon-link.gif" border="0" alt="Info" title=" Info "></a>&nbsp;
				  <?php } ?>
			    </td>
			  </tr>

<?
		    $i++;
		}
?>
			</table>
		  </td>

<?
		if(isset($selServiceStatRec)) {
?>

		  <td width="25%" valign="top">
			<table border="1" width="100%" cellspacing="0" cellpadding="0" rules="none">
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading">
				  <b><?php echo $selServiceStatRec['ClassName']; ?></b>
				</td>
			  </tr>
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading"><b>&nbsp</b></td>
			  </tr>
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading"><b>&nbsp</b></td>
			  </tr>
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading"><b>&nbsp</b></td>
			  </tr>
			<!--</table>

			<table border="0" width="100%" cellspacing="0" cellpadding="0">-->
			  <form name="service_class_stat">
			  <INPUT type="hidden" name="serviceID" value="<?=$selServiceID?>">

			  <tr>
				<td align="center" class="infoBoxContent">
				  <INPUT type="button" name="sc_detail" style="width: 65px" 
				         value="Details..." 
						 onClick="onDetails(document.service_class_stat.serviceID)"/>
				  <INPUT type="button" name="sc_reset" style="width: 65px" 
				         value="   Reset    " 
						 onClick="onReset(document.service_class_stat.serviceID)"></INPUT>
				</td>
			  </tr>
			  </form>
			</table>
		  </td>
		</tr>
	  </table>
	</td>
  </tr>
</table>
<?
		}
	}
?>
<? include(HTTP_ROOT_INCLUDES_DIR . "footer.php"); ?>
