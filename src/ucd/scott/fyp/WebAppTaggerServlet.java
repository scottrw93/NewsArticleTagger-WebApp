package ucd.scott.fyp;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import ucd.scott.fyp.article.ArticlesOverviewServlet;






@SuppressWarnings("serial")
public class WebAppTaggerServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(WebAppTaggerServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {

		log.info((String)(req.getAttribute("obj")));
		String key = req.getParameter("key");
		resp.sendRedirect("/articleSummary.jsp?key="+key);
	}
}
