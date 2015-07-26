package ucd.scott.fyp;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;






@SuppressWarnings("serial")
public class WebAppTaggerServlet extends HttpServlet {


	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {

		String key = req.getParameter("key");
		resp.sendRedirect("/articleSummary.jsp?key="+key);
	}
}
