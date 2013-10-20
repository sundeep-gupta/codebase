<%-- 
    Document   : index
    Created on : May 28, 2010, 1:18:30 PM
    Author     : bubble
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<c:choose>
    <c:when test="${sessionScope['user'].role == 'admin'}">
        <div id="content">
            <div id="adminmenu">
            <ul>
                <li class="first"><a href="javascript:showCuisineMenu(this)"><b>C</b>uisine</a></li>
                <li><a href="javascript:showFoodItem(this)"><b>F</b>ood Item</a></li>
                <li><a href="javascript:showUser()" ><b>U</b>sers</a></li>
                <li><a href="javascript:showSubscriptions()"><b>S</b>ubscription</a></li>
                <li><a href="javascript:showSupply()"><b>S</b>upply</a></li>
                <li><a href="javascript:showReports()">Reports</a></li>
                <li><a href="javascript:adminLogout()">Sign Out</a><li>
            </ul>
            </div>
            <div id="submenu"></div>
            <div id="center_body" class="floating-box" style="margin-right: 20px;">
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div id="content">
            <h1>Admin Login</h1>
            <c:if test="${requestScope['message'] != null}">
                ${requestScope.message}
            </c:if>
            <form name="login_form" action="" method="post" onsubmit="return adminLogin()">
                <div id="field">
                    <div id="input">
                    <label id="l_id" for="id">Login :</label>
                    <input type="text" name="email" id="id" maxlength="50"/>
                    </div>
                    <div id="field_error"></div>
                </div>
                <div id="field">
                    <div id="input">
                    <label id="l_password" for="password">Password :</label>
                    <input type="password" name="password" id="password" maxlength="50"/>
                    </div>
                    <div id="field_error"></div>
                </div>
                <div id="field">
                    <input id="submit" type="button" name="submit" value="Login" onclick="javascript:adminLogin()"/>
                </div>
            </form>
            <a href="">Forgot Password!</a>
        </div>
    </c:otherwise>
</c:choose>
	<!-- end #sidebar -->
	
