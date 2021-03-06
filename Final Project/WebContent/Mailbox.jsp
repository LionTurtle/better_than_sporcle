<%@ page import="java.sql.*" %>
<%@ page import="better_sporcle.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Mailbox</title>
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
	.inbox {
		float: left;
		width: 400px;
	  	border: 1px dotted #4F2F4F;
	  	background-color: #B4EEB4;
	  	margin: 5px;
	  	padding: 5px;
	}
	.inbox li {
		list-style: none;
		margin: 5px;
	}
</style>
</head>
<body>
<div id="main">
<p>You are logged in as <a href="MyHomePage.jsp"><%=session.getAttribute("username")%></a>.</p>
<center><h1>My Mailbox</h1></center>
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
<ul class="inbox">
	<%
		Connection con = (Connection) this.getServletContext().getAttribute("Connection");
		Statement stmt = con.createStatement();
		stmt.executeQuery("USE " + MyDBInfo.MYSQL_DATABASE_NAME);
		ResultSet rs = stmt.executeQuery("SELECT * FROM messages WHERE username_to=\"" +  session.getAttribute("username") + "\" ORDER BY time_sent DESC");
		if (!rs.isBeforeFirst()) {
			out.println("<p>You have no messages :(</p>");
		} else {
			rs.beforeFirst();
			while (rs.next()) {
				String str = "<li>"+ rs.getString("message_type") + " from " + rs.getString("username_from") + ". ";
				if (rs.getString("message_type").equals("Friend Request")) {
					str += "<a href=\"ReadFriendRequest.jsp?id=" + rs.getString("username_from") + "\">Read</a>";
				}
				if (rs.getString("message_type").equals("Note")) {
					str += "<a href=\"ReadNote.jsp?from=" + rs.getString("username_from") + "&dt="+ rs.getTimestamp("time_sent")+"\">Read</a>";
				}
				str += "</li>";
				out.println(str);
			}
		}
	%>
</ul>
</div>
</body>
</html>