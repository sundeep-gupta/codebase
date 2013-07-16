<?php
session_start();
if (!$_SESSION["email"]) {
    // User not logged in, redirect to login page
    Header("Location: index.php");
}
?>


<html>
  <head>
    <link rel="stylesheet" href="modern-grid.css">
  </head>
  <body onload="ajaxFunction()">
    <script language="javascript" type="text/javascript">
    <!-- 
        //Browser Support Code
      function ajaxFunction(){
        var ajaxRequest;  // The variable that makes Ajax possible!
	try {
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
			var ajaxDisplay = document.getElementById('ajaxDiv');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	}
    var taskname = document.getElementById('taskname').value;
	var priority = document.getElementById('priority').value;
//	var sex = document.getElementById('sex').value;
	var queryString = "?taskname=" + taskname + "&priority=" + priority;
	ajaxRequest.open("GET", "show.php" + queryString, true);
	ajaxRequest.send(null); 
}

function ajaxFunctionIn(){
	var ajaxRequest;  // The variable that makes Ajax possible!
	


         

	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
			var ajaxDisplay = document.getElementById('ajaxDiv');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	}
    var taskname = document.getElementById('taskname').value;
	var priority = document.getElementById('priority').value;
//	var sex = document.getElementById('sex').value;
	var queryString = "?taskname=" + taskname + "&priority=" + priority;
	ajaxRequest.open("GET", "update.php" + queryString, true);
	ajaxRequest.send(null); 
}

function ajaxFunctionDel(){
	var ajaxRequest;  // The variable that makes Ajax possible!
	var argv = ajaxFunctionDel.arguments;
	var t2id = argv[0];
	
	try{
		// Opera 8.0+, Firefox, Safari
		ajaxRequest = new XMLHttpRequest();
	} catch (e){
		// Internet Explorer Browsers
		try{
			ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try{
				ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e){
				// Something went wrong
				alert("Your browser broke!");
				return false;
			}
		}
	}
	// Create a function that will receive data sent from the server
	ajaxRequest.onreadystatechange = function(){
		if(ajaxRequest.readyState == 4){
			var ajaxDisplay = document.getElementById('ajaxDiv');
			ajaxDisplay.innerHTML = ajaxRequest.responseText;
		}
	}
 //   var priority = document.getElementById('priority').value;
	var tid = document.getElementById('tid').value;
//	var sex = document.getElementById('sex').value;
	//var queryString = "?tid=" + tid;
		var queryString = "?t2id=" + t2id;
	ajaxRequest.open("GET", "del.php" + queryString, true);
	ajaxRequest.send(null); 
}


//-->
</script>
<div class="row">
    <div class="twelve columns">
      <h1>tTrack </h1>
    </div>
  </div>
  
<div class="example">

<form class="form2" onsubmit="return button_1();">
<div class="row">
<div class="four columns">
<input class="text" type="text" size="35" id="taskname" placeholder="Enter task here.." required/>
</div>
<div class="four columns">
<select id='priority'>
<option value='UrgentImportant'>High Impact/Risk</option>
<option value='UrgentNImportant'>High Risk</option>
<option value='NUrgentImportant'>High Impact</option>
<option value='NUrgentNImportant'>Low Impact</option>
</select>

<!--input type="button" onclick="ajaxFunctionIn()" value='Add' /-->
<!--button type="submit" onclick="ajaxFunction()"><img src="images/add-icon2.png" alt="" />Add</button-->
<input type="button" class="button_add2" onclick="ajaxFunctionIn()"  />
<input type="button" class="button_add3" onClick="window.location='logout.php'"  />
<!--a href="logout.php" class="button_add3"><img src="images/icon-logoff.png"></a-->
</div>
<!--p>Select Priority <br />
UrgentImportant:<input type="checkbox" value="UrgentImportant" name="priority">:<br />
UrgentNImportant:<input type="checkbox" value="UrgentNImportant" name="priority">:<br />
NUrgentImportant:<input type="checkbox" value="NUrgentImportant" name="priority">:<br />
NUrgentNImportant:<input type="checkbox" value="NUrgentNImportant" name="priority">:<br />
-->
<div class="two columns">

</div>
</div>
</form>	

<div id='ajaxDiv'></div>
   
  
</div>



</body>
</html>
