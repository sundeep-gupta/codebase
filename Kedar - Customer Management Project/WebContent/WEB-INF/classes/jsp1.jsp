<html>
    <head>
        <title>PCC-Login Page</title>
        <script language="javascript">
            <!--
            function login(){
                if( document.LoginForm.loginID.value == "" ) {
                    alert("Please enter login Id.");
                    document.LoginForm.loginID.focus();
                    return;
                }
                if( document.LoginForm.password.value == "" ) {
                    alert("Please enter Password.");
                    document.LoginForm.password.focus();
                    return;
                }
                document.forms("LoginForm").submit();
            }
            //-->
        </script>
    </head>
    <body bgcolor="#6E6039">
    <form name="LoginForm" method="post" action="/kndn/jsp2">
    <br><br><br><br>
    <table background="images/2login.jpg" border="0" width="750" height="435" align="center" cellspacing="0">
        <tr>
            <td align="right" valign="top" height="90" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td align="right" valign="center" width="73%">&nbsp;</td>
            <td align="left" ><font face="arial" color="#003355" size="2">User ID</font></td>
            <td align="left" valign="center" ><input type="text" name="loginID" size="12"></td>
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td align="left"><font face="arial" color="#003355" size="2">Password</font></td>
            <td align="left" valign="center"><input type="password" name="password" size="12"></td>
        </tr>
        <tr>
            <td align="right">&nbsp;</td>
            <td align="right">&nbsp;</td>
            <td align="left"><a href="javascript:login()"><img src="images/loginbutton.gif" border="0"></a></td>
        </tr>
        <tr>
            <td align="right" valign="top" height="250" colspan="3">&nbsp;</td>
        </tr>
    </table>
    </form>
    </body>
<html>
