
/**************************************************************************
 * Service Class Java Script functions
 *************************************************************************/

	function rowOverEffect(object) 
	{
		if (object.className == 'dataTableRow') {
			object.className = 'dataTableRowOver';
			setClassNames(object, "dataTableContentOver");
		}
	}

	function rowOutEffect(object) 
	{
		if (object.className == 'dataTableRowOver') {
			object.className = 'dataTableRow';
			setClassNames(object, getCellClassName(object.rowIndex));
		}
	}

	function selectRow(rowNode)
	{
	    unSelectRow();

	    rowNode.className = "dataTableRowSelected";
	    setClassNames(rowNode, "dataTableContentSelected");

		var selectedID = selectedRowServiceID();
		if (selectedID < 1000) {
			disableMoveUpDown();
		} else {
			enableMoveUpDown();
		}
		//DebugOut("Sel" + selectedID);
	}

	function unSelectRow()
	{
		var table = getServiceTable();
	    var selectedIndex = selectedRowIndex(table);
		if (selectedIndex >= 0) {
			table.rows[selectedIndex].className = "dataTableRow";
			setClassNames(table.rows[selectedIndex], 
						  getCellClassName(selectedIndex));
		}
	}
	
	function getCellClassName(index) 
	{
		if (index % 2 == 1) {
			return("dataTableContentEvenRow");
		} else {
			return("dataTableContent");
		}
	}

	function selectedRowIndex(table)
	{
		var index;
	    for (var index = 0; index < table.rows.length; index++) {
		//DebugOut(table.rows[index].className);
		    if (table.rows[index].className == "dataTableRowSelected") {
			    return(index);
			}
		}
		return(-1);
	}

	function selectedRowServiceID()
	{
		var table = getServiceTable();

	    // Find the current index
	    var selectedIndex = selectedRowIndex(table);
		if (selectedIndex < 0) return(null);


		//DebugOut(selectedIndex);
		var inputs = table.rows[selectedIndex].getElementsByTagName("input");
		if (!inputs || !inputs[0]) return(null);
		var a = inputs[0].name.split("_");
		return(a[1]);
	}

	function reverseClassName(node)
	{
		var tds = node.getElementsByTagName("td");
		if (tds.length > 0) {
			if (tds[0].className == "dataTableContentEvenRow") {
				setClassNames(node, "dataTableContent");
			} else if (tds[0].className == "dataTableContent") {
				setClassNames(node, "dataTableContentEvenRow");
			} 
		}
	}

	function setClassNames(node, className) 
	{
		var tds = node.getElementsByTagName("td");
		//DebugOut(tds.length);
	    for (var i=0; i<tds.length; i++) {
			//DebugOut(tds[i].className);
		    tds[i].className = className;
		}
	}

	function getServiceTable()
	{
		var serviceTable;
		serviceTable = document.getElementById("serviceTable");
		return(serviceTable);
	}

	function swapRow(table, index1, index2)
	{
	    row1 = table.rows[index1];
	    row2 = table.rows[index2];
		//DebugOut("middle");
		//DebugOut(table.rows[index1].className);
		//table.tBodies[0].removeChild(table.tBodies[0].firstChild);
		table.tBodies[0].insertBefore(row2, row1);
		//table.insertBefore(tmp2, table.rows[index2]);
		//table.insertBefore(tmp2, table.rows[index2]);
		//DebugOut("end");
		// reverse the display
		reverseClassName(row1);
		reverseClassName(row2);
	}

