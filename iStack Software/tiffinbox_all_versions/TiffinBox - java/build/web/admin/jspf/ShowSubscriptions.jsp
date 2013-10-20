<%-- 
    Document   : ShowSubscriptions
    Created on : Jun 13, 2010, 8:37:53 PM
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
<c:forEach var="subscription" items="${sessionScope.subscriptions}">
    <tr>
    <td><input type ="radio" name="fi_id" value="${subscription.id}"/></td>
    <td><c:out value="${subscription.name}"/></td>
    <td><c:out value="${subscription.desc}"/></td>
    <td><c:out value="${subscription.price}"/></td>
    </tr>
</c:forEach>
</table>