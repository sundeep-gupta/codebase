<html>


<jsp:useBean id="obj" class="k.Prj2" scope="request" />
<jsp:setProperty name="obj" property="groupname" />
<jsp:setProperty name="obj" property="shortname" />
<jsp:setProperty name="obj" property="address1" />
<jsp:setProperty name="obj" property="address2" />
<jsp:setProperty name="obj" property="address3" />
<jsp:setProperty name="obj" property="city" />
<jsp:setProperty name="obj" property="county" />
<jsp:setProperty name="obj" property="state" />
<jsp:setProperty name="obj" property="zip" />
<jsp:setProperty name="obj" property="country" />
<jsp:setProperty name="obj" property="phone" />
<jsp:setProperty name="obj" property="tollfreenumber" />
<jsp:setProperty name="obj" property="fax" />
<jsp:setProperty name="obj" property="website" />
<jsp:setProperty name="obj" property="description" />
<jsp:setProperty name="obj" property="esrch5" param="use" />


<% 	obj.srchcg2(); 	%>

Customer group updated

<center> <a href="/kndn/jsp2"> Back to home page </a>


</html>