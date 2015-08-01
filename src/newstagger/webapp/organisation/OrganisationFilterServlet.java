package newstagger.webapp.organisation;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import newstagger.webapp.article.Article;
import newstagger.webapp.tags.Tag;
import newstagger.webapp.utils.EntityUtils;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;

public class OrganisationFilterServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(OrganisationFilterServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		String org = req.getParameter("org");
		
		Filter filterFeed = new FilterPredicate("name", FilterOperator.EQUAL, org);
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Query query = new Query("Company").setFilter(filterFeed).addSort("date", Query.SortDirection.DESCENDING);
		PreparedQuery results = datastore.prepare(query);
		
		List<Tag> mentions = new ArrayList<Tag>();

		for(Entity entity : results.asIterable()){
			Article article = null;
			try {
				article = EntityUtils.extractToArticle(datastore.get((Key) entity.getProperty("article")));
				String rel = (String) entity.getProperty("rel");
				mentions.add(new Tag(org, rel, article));
			} catch (EntityNotFoundException e) {
				log.warning("Failed to pull artilce details");
			}
		}
		
		req.setAttribute("mentions", mentions);
		req.setAttribute("name", org);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/jsp/organisationFilter.jsp");
		dispatcher.forward(req, resp);
	}
}
