package ucd.scott.fyp.article;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.FilterOperator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ArticlesOverviewServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private static final Logger log = Logger.getLogger(ArticlesOverviewServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		Articles articles = new Articles();
		List<String> feeds = getNewsFeeds();
		int id = 0;
		
		for(String feed : feeds){
			Filter filterFeed = new FilterPredicate("feed", FilterOperator.EQUAL, feed);
			DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

			Query query = new Query("Article").setFilter(filterFeed).addSort("date", Query.SortDirection.DESCENDING);
			List<Entity> results = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
			
			for(Entity result : results){
        		String key = KeyFactory.keyToString(result.getKey());
				String headline = (String) result.getProperty("headline");
				String summary = (String) result.getProperty("summary");
				String tags = (String) result.getProperty("tags");
				String url = (String) result.getProperty("url");
				Date date = (Date) result.getProperty("date");
				Integer numTags = tags.split("\'[HML]\'").length-1;
				
				Article article = new Article(id, key, url, headline, summary, "", null, feed, date, numTags, "");
				articles.addArticle(id, article);
				id++;
			}
		}
		req.setAttribute("articles", articles);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
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