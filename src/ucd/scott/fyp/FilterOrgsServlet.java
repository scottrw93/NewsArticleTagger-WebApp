package ucd.scott.fyp;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




@SuppressWarnings("serial")
public class FilterOrgsServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String org = req.getParameter("org");
		resp.sendRedirect("/organisationFeed.jsp?org="+org);
	}
}
