package better_sporcle;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendFriendRequestServlet
 */
@WebServlet("/SendFriendRequestServlet")
public class SendFriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendFriendRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//make change to database
		Connection con = (Connection) getServletContext().getAttribute("Connection");
		try {
			Statement stmt = con.createStatement();
			stmt.executeQuery("USE " + MyDBInfo.MYSQL_DATABASE_NAME);
			String me = "\"" + (String) request.getSession().getAttribute("username") + "\"";
			String them = "\"" + request.getParameter("them") + "\"";
			stmt.executeUpdate("INSERT INTO friends VALUES (" + me + "," + them + "," + 0 + ")");
			stmt.executeUpdate("INSERT INTO messages (username_to,username_from,message_type,message_text) VALUES (" + them + "," + me + ",\"Friend Request\",\"request_sent\")");
			RequestDispatcher rd = request.getRequestDispatcher("User.jsp?id="+request.getParameter("them"));
			rd.forward(request, response);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
