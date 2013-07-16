<%-- 
    Document   : ShowFoodItems
    Created on : May 30, 2010, 2:17:52 PM
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
<c:forEach var="food_item" items="${sessionScope.fooditems}">
    <tr>
    <td><input type ="radio" name="fi_id" value="${food_item.id}"/></td>
    <td><c:out value="${food_item.name}"/></td>
    <td><c:out value="${food_item.desc}"/></td>
    <td><c:out value="${food_item.price}"/></td>
    </tr>
</c:forEach>
</table>