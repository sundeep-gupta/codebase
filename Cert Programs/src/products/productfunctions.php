<?php

function getPrefixID ($plid) {  // Pass in the Price List ID of the item you are working with, and it will give you the prefix_id in the prefix table.
	$sql = "SELECT prefix_id FROM priceList WHERE id = $plid";
	$result = DoSQL($sql, SQL_SELECT, 1, false);

	return $result[0]["prefix_id"];
}

function getStatusID($plid) { // Pass in the id of the Price List item you are working with, and we return the id from the status table for the status_id.pl table
	$prefix_id = getPrefixID ($plid);

	$sql = "SELECT id FROM status WHERE name = 'Registered' and prefix_id = $prefix_id";
	$result = DoSQL($sql);
	return $result[0]["id"];
}


function prefixNumberInc($plid) {  // Pass in the ID of the priceList item, it looks up the prefix number for that, incs it, stores the new value, and returns it.
	$id = getPrefixID ($plid);	
	
	// Pass This the priceList:prefix_id
	$sql = "SELECT number FROM prefix WHERE id = $id";
	$result = DoSQL($sql, SQL_SELECT, 1, false);
	$number = $result[0]["number"]+1;
	$usql = "UPDATE prefix SET number = $number WHERE id = $id";
	$uresult = DoSQL($usql, SQL_UPDATE);
	return $number;
}


function Timeframe($selectname) {

	$sql = "SELECT id, name FROM timeframe WHERE active = 1";
	$result = DoSQL($sql);

	echo '<select name="' .$selectname .'">';
	
	foreach ($result as $timeframe) {
		echo '<option value="' .$timeframe["id"] .'">' .$timeframe["name"] .'</option>';
	}
	
	echo '</select>';
}

function GenerateCertList() {

	/*
	
	#SELECT id, programName FROM program ORDER BY id
	
	#SELECT id, SKU, price, description FROM priceList WHERE program_id = 1 ORDER BY id
	
	SELECT pl.id, pl.SKU, pl.price, pl.description, p.programName FROM priceList pl, program p WHERE p.id = pl.program_id ORDER BY p.id, pl.SKU
	*/

$sql1 = "SELECT pl.id, pl.SKU, pl.price, pl.description, p.programName FROM priceList pl, program p WHERE p.id = pl.program_id AND p.active = 1 AND pl.registerable = 1 ORDER BY p.id, pl.SKU";

// Query, TYPE, # of queries, Debug
$result1 = DoSQL($sql1, SQL_SELECT, 1, false);
	foreach ($result1 as $program)
	{
		//echo $program["programName"] ."<br>";
		
			if ($previous != $program["programName"]) {			
				if ($previous != "") { // Footing before a header
						echo '</tr></table></div><p>&nbsp;</p>';
				}
				
				
				// Do our header
				?>
					<div class="greyboxheader" align=left onclick="div_toggle('<?=$program["id"]; ?>'); return false;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						  <tr>
							<td width="50%"><b><?=$program["programName"]; ?></b></td>
							<td width="50%"><div align="right"><i>Click to expand/contract</i>&nbsp;&nbsp;&nbsp;&nbsp;<img name="Arrow<?=$program["id"]; ?>" src="../graphics/arrow-down.gif"></div></td>
						  </tr>
						</table>
					</div>		
					<div class="toplessgreybox" id="<?=$program["id"]; ?>" style="display:none">
					  <table width="100%"  border="0" cellspacing="0" cellpadding="5">
									
				<?
						  echo '
						  <tr>
						  <td width="40%">' .$program["description"] .'</td>
						  <td width="25%">' .$program["SKU"] .'</td>
						  <td width="25%">$'; printf("%.2f", $program["price"]); echo '</td>
						  <td width="10%"><div align="center"><input type="checkbox" name="sku[' .$program["id"] .']" value="on"></div></td>		
						  </tr>
							';
			
			}  // End if Prev != Corrent
			
			 
			else { 
				  echo '
				  <tr>
					  <td width="40%">' .$program["description"] .'</td>
					  <td width="25%">' .$program["SKU"] .'</td>
					  <td width="25%">$'; printf("%.2f", $program["price"]); echo '</td>
					  <td width="10%"><div align="center"><input type="checkbox" name="sku[' .$program["id"] .']" value="on"></div></td>		
					  </tr>
						';
			} // End if Prev == Current
			
		$previous = $program["programName"];

	} // end of foreach loop
	
	echo '</table></div>';
			
} // End Generate Cert Function

/*
			<div align="center">
				<div class="greyboxheader" align=left>
					<b>Step 1: Create a New Company </b>
				</div>		
			<div class="toplessgreybox">
              <table width="100%"  border="0" cellspacing="0" cellpadding="5">
                <tr>
                  <td width="25%"><strong>Name</strong></td>
                  <td width="15%"><strong>Version</strong></td>
                  <td width="45%"><strong>Comments</strong></td>
                  <td width="15%"><div align="center"></div></td>
                </tr>
                <tr>
                  <td>Super Switch 345 </td>
                  <td>1.2.3</td>
                  <td>This thing just ROCKS! </td>
                  <td><div align="center"><a href="productsedit.php?f=2">Edit</a> | <a href="productsedit.php?f=5">Delete</a> </div></td>
                </tr>
              </table>
			</div>
		  </div>
*/
?>
