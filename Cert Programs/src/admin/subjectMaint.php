<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><title>KeyLabs Certs - Log Entry SUBJECT Maintenance</title></head>
<body>
<p>Log Subject Maintenance</p>
<form name="subjectMaint" action="subjectSave.php" method=post><table border=1 cellspacing=0 cellpadding=2 bordercolor="#FFFFFF"><tr bgcolor="#CCCCCC"><td>Subject</td><td>Options</td><tr bgcolor="#EEEEEE" onmouseover="this.style.backgroundColor='#ccccff';" onmouseout="this.style.backgroundColor='#eeeeee';">

	  <td><input type=text name=text0 size=25 maxlength=25 value="Comment Only"></td>
          <td valign=top><a href="delSubject.php?s=Comment Only">Del</a></td>
          </tr><tr bgcolor="#EEEEEE" onmouseover="this.style.backgroundColor='#ccccff';" onmouseout="this.style.backgroundColor='#eeeeee';">
	  <td><input type=text name=text1 size=25 maxlength=25 value="Daily Update"></td>
          <td valign=top><a href="delSubject.php?s=Daily Update">Del</a></td>
          </tr><tr bgcolor="#EEEEEE" onmouseover="this.style.backgroundColor='#ccccff';" onmouseout="this.style.backgroundColor='#eeeeee';">
	  <td><input type=text name=text2 size=25 maxlength=25 value="Email Sent"></td>
          <td valign=top><a href="delSubject.php?s=Email Sent">Del</a></td>

          </tr><tr bgcolor="#EEEEEE" onmouseover="this.style.backgroundColor='#ccccff';" onmouseout="this.style.backgroundColor='#eeeeee';">
	  <td><input type=text name=text3 size=25 maxlength=25 value="Status Change"></td>
          <td valign=top><a href="delSubject.php?s=Status Change">Del</a></td>
          </tr><tr bgcolor="#EEEEEE" onmouseover="this.style.backgroundColor='#ccccff';" onmouseout="this.style.backgroundColor='#eeeeee';">
	<td><input type=text name=newSubject value="" size=25 maxlength=25></td>
	<td>&nbsp;</td>
	</tr></table><input type=submit name=submit value="Add Subject"></body>
</html>
