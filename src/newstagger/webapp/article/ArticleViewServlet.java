package newstagger.webapp.article;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import newstagger.webapp.utils.EntityUtils;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;


public class ArticleViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Logger log = Logger.getLogger(ArticleViewServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String encryKey = req.getParameter("key");
		
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key key = KeyFactory.stringToKey(encryKey);//should catch illegal argument here
		Entity entity = null;

		try {
			entity = datastore.get(key);
		} catch (EntityNotFoundException e) {
			resp.sendRedirect("pagenotfound");//Will give 404 error, should create error page
			log.log(Level.WARNING, "Page not found: "+e.getStackTrace());
			return;
		}
		
		Article article = EntityUtils.extractToArticle(entity);
		req.setAttribute("article", article);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/jsp/articleSummary.jsp");
		dispatcher.forward(req, resp);
	}
}
