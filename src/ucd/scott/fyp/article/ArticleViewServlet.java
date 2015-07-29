package ucd.scott.fyp.article;

import java.io.IOException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.*;



@SuppressWarnings("serial")
public class ArticleViewServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(ArticleViewServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {

		log.info((String)(req.getAttribute("obj")));
		String key = req.getParameter("key");
		resp.sendRedirect("/articleSummary.jsp?key="+key);
	}
}
