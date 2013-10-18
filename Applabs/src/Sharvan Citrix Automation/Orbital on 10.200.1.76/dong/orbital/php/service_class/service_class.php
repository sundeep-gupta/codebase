<?
   /************************************************************************
    *  Includes section
	************************************************************************/

	include("../includes/header.php");
	include ("service_lib.php");
	$Auth->CheckRights(AUTH_LEVEL_ADMIN);


   /************************************************************************
    *  Parameters section
	************************************************************************/

	$action = (isset($HTTP_GET_VARS['action']) ? $HTTP_GET_VARS['action'] : '');
	$serviceID = (isset($HTTP_GET_VARS['serviceID']) ? $HTTP_GET_VARS['serviceID'] : 1);
	$serviceName = (isset($HTTP_GET_VARS['serviceName']) ? $HTTP_GET_VARS['serviceName'] : '');


   /************************************************************************
    *  Set up variables
	************************************************************************/
	$serviceClassArray = getServiceClasses();
	$error = false;
	$processed = false;


   /************************************************************************
    *  Execute actions
	************************************************************************/
	if (value_not_null($action)) {
		switch ($action) {

		    // Server Actions
			case 'newClass':
				// Create Service class
				$lastID = (int) findLastServiceID($serviceClassArray);
				createServiceClass($lastID + 1, $serviceName);

				// Refresh
				echo HTML::InsertRedirect("service_class.php?serviceID=" . ($lastID+1));
				exit(0);
				// redirect
				//header("Location: http://" . $_SERVER['HTTP_HOST'] . dirname($_SERVER['PHP_SELF']) . "/service_class.php");
				break;

			case 'modify':
				// Modify service Class
				$response = modifyServiceClass($serviceID, $serviceName);
				//echo 'Delete RESP<br><br>  ' . var_dumper($response);

				// Refresh
				echo HTML::InsertRedirect("service_class.php?serviceID=" . $serviceID);
				exit(0);
				break;

			case 'delete':
				// Delete service class
				deleteServiceClass($serviceID);

				// Refresh
				echo HTML::InsertRedirect("service_class.php", 0);
				exit(0);
				break;

			// UI Actions
			case 'newClassUI':
				break;
			case 'modifyUI':
				break;
			case 'deleteUI':
				break;
			default:
				break;
		}
	}

	$serviceClassArray = orderServiceClasses($serviceClassArray);

?>

<script type="text/javascript" src="../includes/library.js"></script>
<script type="text/javascript" src="serviceScript.js"></script>
<script language="javascript">
	<!--

	/***********************************************************************
	 * JavaScript Section
	 ***********************************************************************/

	function onModifyUI(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceID=" + id.value +
			                    "&action=modifyUI";
		}
	}

	function onModify(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceName=" + serviceName.value +
								"&serviceID=" + id.value +
								"&action=modify";
		}
	}

	function onDeleteUI(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceID=" + id.value +
			                    "&action=deleteUI";
		}
	}

	function onDelete(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceID=" + id.value +
			                    "&action=delete";
		}
	}

	function onNewClassUI(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceID=" + id.value +
			                    "&action=newClassUI";
		}
	}

	function onNewClass(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class.php?serviceName=" + serviceName.value +
								"&serviceID=" + id.value +
								"&action=newClass";
		}
	}

	function onSaveNew(serviceName, id) {
		if (serviceName.value.length > 0) {
			document.location = "./service_class_config.php";
		}
	}

	function onBack(serviceName, id) {
		document.location = "./service_class.php?serviceID=" + id.value;
	}

	function onCancel(serviceName, id) {
		document.location = "./service_class.php?serviceID=" + id.value;
	}

	//-->
</script>

<!--
  - Main HTML Block
 -->
<TABLE cellspacing=0 cellpadding=0><TR><TD width=700></TR></TABLE>

<font class="pageheading">Configure Settings: Service Class</font><BR><BR>
<form name="serviceClass">

<table border="0" width=600 cellspacing="0" cellpadding="0">
  <tr>
    <td>
	  <table border="0" width="100%" cellspacing="0" cellpadding="0">
		<tr>

		  <td valign="top">
		    <table name="serviceTable" border="1" rules="none" width="100%" cellspacing="0" cellpadding="2">
			  <tr class="tableHeadingRow">
				<td class="headingContent">Service Name</td>
				<td class="headingContent" align="right">Service Rules</td>
				<td class="headingContent" align="right">Action&nbsp;</td>
			  </tr>

<?
	for($i=0;$i<count($serviceClassArray);$i++) {
		$serviceClass =&  $serviceClassArray[$i];
		$curServiceID = getServiceID($serviceClass);

		// If nothing selected - select first item in the list
		if(isset($serviceID)) {
			$selServiceID = $serviceID;
		} else {
			$selServiceID = $curServiceID;
		}

		if ($selServiceID == $curServiceID) {
			$selServiceClass =& $serviceClass;
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
				  onclick="document.location.href='./service_class.php?serviceID=<?php echo $curServiceID . $actionFragment; ?>'">
			    <td class=<?php echo $tdClass; ?>
				    title=" Service Class Rules ">
					<?php if (isUserDefinedClass($serviceClass)) {
							echo "<a href=\"./service_class_config.php?serviceID=" . $curServiceID . "\">" . getServiceName($serviceClass) . "</a>";
					      } else {
							echo getServiceName($serviceClass);
						  }
					?>

				</td>
				<td class=<?php echo $tdClass;?> align="right">
				  <?php echo getRulecount($serviceClass); ?>
				</td>
				<td class=<?php echo $tdClass;?> align="right">
				  <?php if ($selServiceID == $curServiceID) { ?>
				    <img src="../images/icon_arrow_right.gif" border="0" alt="">&nbsp;
				  <? } else { ?>
					<a href="./service_class.php?selected_box=customers&serviceID=<?php echo $curServiceID?>"><img src="../images/icon-link.gif" border="0" alt="Info" title=" Info "></a>&nbsp;
				  <? } ?>
				</td>
			  </tr>

<?
	} // for statement
?>

			  <tr>
				<td colspan="3">
				  <table border="0" width="100%" cellspacing="0"
					 cellpadding="2">
					<tr>
					  <td align="right" class="smallText">
						<INPUT type="button" name="new_sc"
							   value="New Service Class"
							   title=" New Service Class Name "
							   onClick="onNewClassUI(document.serviceClass.Servername, document.serviceClass.Serverid)">
						</INPUT>
						  &nbsp;
					  </td>
					</tr>
				  </table>
				</td>
			  </tr>
			</table>
		  </td>

<?
	if(isset($selServiceID)) {
?>

		  <td width="25%" valign="top">
			<table border="1" width="100%" cellspacing="0" cellpadding="2"
			       rules="none">
			  <tr class="infoBoxHeading">
				<td class="infoBoxHeading">
				  <b>

<?php
		if ($action == 'newClassUI') {
			echo "&nbsp";
		} else {
			echo getServiceName($selServiceClass);
		}
?>
                  </b>
                </td>
			  </tr>
			<!--</table>

			<table border="0" width="180" cellspacing="0" cellpadding="2">-->
			  <INPUT type="hidden" name="Servername"
			         value="<?=getServiceName($selServiceClass)?>">
			  <INPUT type="hidden" name="Serverid"
			         value="<?=$selServiceID?>">

<?php
		if($action == "deleteUI") {
?>

			  <tr>
				<td class="infoBoxContent"><b>Delete Service Class:</b></td>
			  </tr>
			  <tr>
				<td class="infoBoxContent">Are you sure you want to delete this service class?</td>
			  </tr>

			  <tr>
				<td class="infoBoxContent"><b></b></td>
			  </tr>
			  <tr>
				<td class="infoBoxContent"><br><b>WARNING:</b> There are <?php echo getRuleCount($selServiceClass); ?> rules still linked to this service class!</td>
			  </tr>

			  <tr>
				<td align="center" class="infoBoxContent">
				  <br><INPUT type="button" name="sc_delete" value="Delete"
				       onClick="onDelete(document.serviceClass.Servername, document.serviceClass.Serverid)" />
				  <INPUT type="button" name="sc_cancel" value="Cancel"
				       onClick="onCancel(document.serviceClass.Servername, document.serviceClass.Serverid)"/>
				</td>
			  </tr>

<?
		} else if($action == 'newClassUI' || $action == 'modifyUI') {
?>

			  <tr>
				<td class="infoBoxContent">
				  <b><? echo ($action=='newClassUI'? 'New Service Class:' : 'Modify Service Class:'); ?></b>
			    </td>
			  </tr>

			  <tr>
				<td class="infoBoxContent">
				  Service Name:

<?
			if($action == 'newClassUI') {
?>

				  <INPUT type="text" name="new_sc_name" value="" size="18"/>
			    </td>

			  <tr>
				<td align="left" class="infoBoxContent">
				  <INPUT type="button" name="sc_save_done" value="Create"
				    onClick="onNewClass(document.serviceClass.new_sc_name, document.serviceClass.Serverid)">
				  </INPUT>
			    </td>
			  </tr>
			  <!--<tr>
			    <td align="left" class="infoBoxContent">
				  <INPUT type="button" name="sc_save_new"
				         value="Save & Add Rule"
						 onClick="onSaveNew(document.serviceClass.new_sc_name, document.serviceClass.Serverid)"/>
			    </td>
			  </tr>-->
			  <tr>
			    <td align="left" class="infoBoxContent">

<?
			} else {
?>

				  <INPUT type="text" name="new_sc_name"
				         value="<? echo getServiceName($selServiceClass); ?>"
						 size="18"/>
				 </td>

				<tr>
				  <td class="infoBoxContent">
					<INPUT type="button" name="sc_save"
					       value="   Save   "
						   onClick="onModify(document.serviceClass.new_sc_name, document.serviceClass.Serverid)"/>

<?
			}
?>

				  <INPUT type="button" name="sc_cancel" value="Cancel"
				         onClick="onCancel(document.serviceClass.Servername, document.serviceClass.Serverid)"/>
				</td>
			  </tr>

<?
		} else {
?>

			  <tr>
				<td align="center" class="infoBoxContent">
				  <INPUT type="button" name="sc_edit" value="Rename"
				         title=" Modify Service Class Name "
						 onClick="onModifyUI(document.serviceClass.Servername, document.serviceClass.Serverid)"/>
<?php
            if (isUserDefinedClass($selServiceClass)) {
?>
				  <INPUT type="button" name="sc_delete" value="   Delete   "
				         title=" Delete Service Class "
						 onClick="onDeleteUI(document.serviceClass.Servername, document.serviceClass.Serverid)"/>
<?php
			}
?>
				</td>
			  </tr>
			  <tr>
				<td class="infoBoxContent">
				  <br>Service Rules: <?php echo getRuleCount($selServiceClass); ?>
			    </td>
			  </tr>

<?
		}
?>
		    </table>
		  </td>
	    </tr>

</table>
</form>
</TABLE>

<?
	} // if statement for selection box
?>


<?
	include(HTTP_ROOT_INCLUDES_DIR . "footer.php");
?>
