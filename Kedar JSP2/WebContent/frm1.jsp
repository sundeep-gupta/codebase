<html>

<head>

<script language="javascript">

function effectParent(){
	if(document.getElementById("combo").value == 'kedar')
		parent.document.getElementById("two").src="/Off/kedar.jsp"
	else
		parent.document.getElementById("two").src="/Off/nath.jsp"
}

</script>

</head>

<body>
<font size="5" align="center">	Kedarnath	</font>
<br />	<br />
<select name="combo" onChange="javascript:effectParent()">
	<option value="kedar">	kedar	</option>
	<option value="nath">	nath	</option>
</select>


</body>

</html>