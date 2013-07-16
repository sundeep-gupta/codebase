<head>

<script language="javascript">

	function addMoreFiles(){
//		document.getElementById("file1").style.display="block";
//		document.getElementById("fileInput").style.display="block";


  var tbl = document.getElementById('fileTable');
  var lastRow = tbl.rows.length;


  // if there's no header row in the table, then iteration = lastRow + 1
  var iteration = lastRow;
  var row = tbl.insertRow(lastRow);

  
  // left cell
 // var cellLeft = row.insertCell(0);
//  var textNode = document.createTextNode(iteration);
//  cellLeft.appendChild(textNode);


  // right cell
  var colOne = row.insertCell(0);
  var el = document.createElement('input');
  el.setAttribute('type', 'file');
  el.setAttribute('name', 'file' + iteration);
  el.setAttribute('id', 'file' + iteration);
  el.setAttribute('size', '35');
//  el.setAttribute('value', 'Nag');

  colOne.appendChild(el);

  var colTwo = row.insertCell(1);
  var el1 = document.createElement('img');
  el1.setAttribute('src', 'C:\\Documents and Settings\\050330\\My Documents\\My Pictures\\gifs\\sc_gertolf_lighter.gif');
  el1.setAttribute('id', 'remove' + iteration);
//  el1.setAttribute('width', '200');
//  el1.setAttribute('onCilck', call removeFile());
  el1.onclick = function() { removeFile(iteration); };

  colTwo.appendChild(el1);



	}

	function removeFile(a){
		document.getElementById('file' + a).style.display="none";
		document.getElementById('remove' + a).style.display="none";
		
	}

</script>

</head>


<form name="upload" method="post" action="/kndn/jmxUploadFile.jsp" enctype="multipart/form-data">

<table name="fileTable" id="fileTable" />
<tr> <td> <input type="file" name="file" size="35" />	</td> </tr>
<br />
<input type="text" name="pra" />

<!-- <tr style="display:none;" id=file1> <td> <input type="file" name="file" id="fileInput" style="display:none" />  --> 

</td> </tr>

</table>

<br /> <br />


<input type="button" name="addMoreFiles1" value="More Files..." onClick="addMoreFiles()"> 


&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<input type="submit" value="   Upload   " />
</form>