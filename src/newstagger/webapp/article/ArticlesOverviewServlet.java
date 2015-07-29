package newstagger.webapp.article;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
//import java.util.logging.Logger;


import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import newstagger.webapp.utils.EntityUtils;


public class ArticlesOverviewServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	//private static final Logger log = Logger.getLogger(ArticlesOverviewServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		List<String> feeds = getNewsFeeds();
		Map<String, Articles> articles_by_feed = new HashMap<String, Articles>();
		
		for(String feed : feeds){
			Filter filterFeed = new FilterPredicate("feed", FilterOperator.EQUAL, feed);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
			Query query = new Query("Article").setFilter(filterFeed).addSort("date", Query.SortDirection.DESCENDING);
			List<Entity> results = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
			Articles articles = new Articles();
			
			for(Entity result : results){
				Article article = EntityUtils.extractToArticle(result);
				articles.addArticle(article.getKey(), article);
			}
			articles_by_feed.put(feed, articles);
		}
		req.setAttribute("articles", articles_by_feed);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/jsp/index.jsp");
		dispatcher.forward(req, resp);
	}
	
	public List<String> getNewsFeeds() throws IOException{
		InputStream is = this.getServletContext().getResourceAsStream("/tagger.properties");
		List<String> feeds = new ArrayList<String>();
		Properties properties = new Properties();
		properties.load(is);
		
		String[] list = properties.getProperty("rss_feeds").split(",");
		for(String num : list){
			feeds.add(properties.getProperty("short.feed"+num));
		}
		return feeds;
	}
}