<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Composing Note</title>
<style type="text/css">
	#main {
		width: 900px;
		margin: auto;
	}
	.vertical_menu {
		float: left;
		width: 200px;
	  	border: 1px dotted #4F2F4F;
	  	background-color: #EED2EE;
	  	margin: 5px;
	  	padding: 5px;
	}
	.vertical_menu li {
		list-style: none;
		margin: 5px;
	}
	.vertical_menu li a {
	  	text-decoration: none;
	  	color: black;
	}
	.vertical_menu li a:hover {
	  	text-decoration: underline;
	}
</style>
</head>
<body>
<div id="main">
<p>You are logged in as <a href="MyHomePage.jsp"><%=session.getAttribute("username")%></a>.</p>
<center><h1>Composing Note</h1></center>
<ul class="vertical_menu">
	<li><a href="MyHomePage.jsp">Home</a></li>
	<li><a href="MyHomePage.jsp">My History</a></li>
	<li><a href="MyHomePage.jsp">My Achievements</a></li>
	<li><a href="Mailbox.jsp">My Messages</a></li>
	<li><a href="MyHomePage.jsp">My Friends</a></li>
	<li>
		<form action="SearchServlet" method="post">
			<input type="text" name="SearchTerm" size=20px>
			<input type="submit" value="Search">
		</form>
	</li>
</ul>
<p>Composing Note to <a href=<%= "\"User.jsp?id=" + request.getParameter("id") + "\"" %>><%=request.getParameter("id") %></a>:</p>
<form action="SendNoteServlet" method="post">
	<textarea rows="4" cols="45" name="message"></textarea>
	<input type="hidden" name="them" value=<%="\"" + request.getParameter("id") + "\"" %>>
	<p></p>
	<p>Note: maximum character length is 255</p>
	<input type="submit" value="Send">
</form>
</div>
</body>
</html>