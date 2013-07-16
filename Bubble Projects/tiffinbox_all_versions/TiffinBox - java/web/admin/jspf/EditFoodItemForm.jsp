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
    String query = "SELECT id, name, description, price FROM food_items WHERE id = ?";
    try {
        Connection connection = DBConnectionFactory.getConnection();
        PreparedStatement pStatement = connection.prepareStatement(query);
        pStatement.setInt(1, Integer.parseInt(id));
        ResultSet rs = pStatement.executeQuery();

        if (rs.next()) {
            FoodItem foodItem = new FoodItem();
            foodItem.setId(rs.getInt("id"));
            foodItem.setName(rs.getString("name"));
            foodItem.setDesc(rs.getString("description"));
            foodItem.setPrice(rs.getInt("price"));
            request.setAttribute("food_item", foodItem);
        } else {
            message = "Failed to insert the record!";
        }
    } catch (SQLException sqle) {
        message = "Failed to insert the record! " + sqle.getMessage();
    } catch (ClassNotFoundException cnfe) {
        message = "Failed to insert the record! " + cnfe.getMessage();
    }
%>

<c:if test="${requestScope.food_item != null}">
    <form action="">
        <input type="hidden" name="f_id" id="f_id" value="${requestScope.food_item.id}"/>
        <label for="fi_name">Name :</label><input type="text" id="f_name" name="f_name" value="${requestScope.food_item.name}"/><br/>
        <label for="fi_desc">Description :</label><input type="text" id="f_desc" name="f_desc" value="${requestScope.food_item.desc}"/><br/>
        <label for="fi_price">Price :</label><input type="text" id="f_price" name="f_desc" value="${requestScope.food_item.price}"/><br/>
        <a href="javascript:editFoodItem()">Save</a>
    </form>
</c:if>
Now using EL : ${param.id}

