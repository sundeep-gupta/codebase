<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="content">
    <div id="welcome">
        <h1>Welcome to E-Tiffin!</h1>
        <p><strong>E-Tiffin</strong> is an online Tiffin Box service portal.</p>
    </div>
    <div class="floating-box" style="margin-right: 20px;">
        <p><img src="images/img05.jpg" alt="" width="200" height="90" title="A butterfly" /></p>
        <h2 class="title">Today's Menu</h2>
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
    <div class="floating-box">
        <c:if test="${requestScope.message != null}">
            ${requestScope.message}
        </c:if>

			<p><img src="images/img06.jpg" alt="" width="200" height="90" title="A snail" /></p>
			<h2 class="title">Services</h2>
            <%
            // We'll soon put today's Menu here.
            %>
			<ol>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ol>
		</div>
	</div>
	<!-- end #content -->
	<div id="sidebar">
		<div id="links">
			<ul>
				<li><a href="#">Services</a></li>
				<li><a href="#">Subscriptions</a></li>
                <c:if test="${sessionScope['user'] != null}">
                    <li><a href="Logout">Logout</a></li>
                </c:if>
                <c:if test="${sessionScope['user'] == null}">
                    <form action="Login" method="post">
                        <div><label for="email">Username</label><span><input id="email" type="text" name="email" size="20"/></span></div>
                        <div><label for="password">Password</label><input type="password" name="password" size="20"/></div>
                        <div><input type="submit" value="Log In"/></div>
                    </form>
                </c:if>
            </ul>
		</div>
		<div>
			<h2>A Blockquote</h2>
			<blockquote>

			</blockquote>
		</div>
	</div>
	<!-- end #sidebar -->
	<div style="clear: both; height: 1px;"></div>