<%-- 
    Document   : EditCuisineForm
    Created on : May 28, 2010, 3:58:48 PM
    Author     : bubble
--%>
<%-- TODO : Read the values of the given c_id and populate it
 request.getParameter("c_id")
--%>


<%@page import="java.sql.*" %>
<%@page import="com.bubble.tiffinbox.model.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%

    String id = request.getParameter("id");
    String message = "";
    String query = "SELECT id, name, description, price FROM cuisine WHERE id = ?";
    try {
        Connection connection = DBConnectionFactory.getConnection();
        PreparedStatement pStatement = connection.prepareStatement(query);
        pStatement.setInt(1, Integer.parseInt(id));
        ResultSet rs = pStatement.executeQuery();

        if (rs.next()) {
            Cuisine cuisine = new Cuisine();
            cuisine.setId(rs.getInt("id"));
            cuisine.setName(rs.getString("name"));
            cuisine.setDesc(rs.getString("description"));
            cuisine.setPrice(rs.getInt("price"));
            request.setAttribute("cuisine", cuisine);
        } else {
            message = "Failed to fetch the record!";
        }
    } catch (SQLException sqle) {
        message = "Failed to insert the record! " + sqle.getMessage();
    } catch (ClassNotFoundException cnfe) {
        message = "Failed to insert the record! " + cnfe.getMessage();
    }
%>
<c:if test="${requestScope.cuisine != null}">
    <form action="">
        <input type="hidden" name="c_id" id="c_id" value="${requestScope.cuisine.id}"/>
        <label for="c_name">Name :</label><input type="text" id="c_name" name="c_name" value="${requestScope.cuisine.name}"/><br/>
        <label for="c_desc">Description :</label><input type="text" id="c_desc" name="c_desc" value="${requestScope.cuisine.desc}"/><br/>
        <label for="c_price">Price :</label><input type="text" id="c_price" name="c_desc" value="${requestScope.cuisine.price}"/><br/>
        <a href="javascript:editCuisine()">Save</a>
    </form>
</c:if>

