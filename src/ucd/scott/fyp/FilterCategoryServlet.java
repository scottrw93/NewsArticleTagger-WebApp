package ucd.scott.fyp;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@SuppressWarnings("serial")
public class FilterCategoryServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String feed = req.getParameter("feed");
		resp.sendRedirect("/newsFeed.jsp?feed="+feed);
	}
}
