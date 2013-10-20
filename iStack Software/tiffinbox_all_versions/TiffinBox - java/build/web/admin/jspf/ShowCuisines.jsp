<%-- 
    Document   : ShowCuisines
    Created on : May 28, 2010, 3:20:41 PM
    Author     : bubble
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<table>
    <tr>
    <th>#</th>
    <th>Name</th>
    <th>Description</th>
    <th>Price</th>
    </tr>   
<c:forEach var="cuisine" items="${sessionScope.cuisines}">
    <tr>
    <td><input type ="radio" name="c_id" value="${cuisine.id}"/></td>
    <td><c:out value="${cuisine.name}"/></td>
    <td><c:out value="${cuisine.desc}"/></td>
    <td><c:out value="${cuisine.price}"/></td>
    </tr>
</c:forEach>
</table>