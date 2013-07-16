<%-- 
    Document   : register
    Created on : May 8, 2010, 12:25:21 PM
    Author     : bubble
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Registration Page</title>
</head>
<body>
<h4>Register here...</h4>
<div>
<% 
if(request.getAttribute("message") != null) {
    out.print(request.getAttribute("message"));
}
%></div>
<form method="POST" action="Register">
Email ID (UserID):  <input type="text" name="email" size="20"><br/>
Password:  <input type ="password" name="password" size="15"> (Max 15 Chars) <br/>
Name:  <input type ="text" name= "name" size="20"> <br/>
Phone:  <input type ="text" name= "phone" size="14"><br/>
House/Flat No:  <input type ="text" name= "street1" size="20"> <br/>
Society/Appartment Name:  <input type ="text" name= "street2" size="20"><br/>
Area:  <input type ="text" name= "area" size="20"><br/>
City:  <input type ="text" name= "city" size="20"><br/>
Country:  <input type ="text" name= "country" size="20"><br/><br/>
<input type="submit" value="Register">
</form>
</body>
</html>
