package ucd.scott.fyp.datastore;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.logging.Logger;

import javax.servlet.http.*;

import parsers.Story;
import parsers.Tag;
import tagger.RunTagger;

import com.google.appengine.api.datastore.*;


@SuppressWarnings("serial")
public class DatastoreUpdaterServlet extends HttpServlet {
	private static final Logger log = Logger.getLogger(DatastoreUpdaterServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			List<String> feeds = new ArrayList<String>();

			InputStream is = this.getServletContext().getResourceAsStream("/tagger.properties");
			Properties props = new Properties();
			props.load(is);

			String[] nums = props.getProperty("rss_feeds").split(",");

			for(String feed : nums){
				feeds.add(props.getProperty("url.feed"+feed));
			}

			RunTagger tagger = new RunTagger();
			tagger.loadRssStreams(feeds.toArray(new String[feeds.size()]));

			ArrayList<Story> articles = tagger.tagArticles();
			uploadArticles(articles);

		} catch (Exception e) {
			log.warning("Failed to update database.\n"+e.getStackTrace());
			e.printStackTrace();
		}
	}

	private void uploadArticles(ArrayList<Story> articles) {
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		
		for(Story article : articles){

			String url = article.getUrl();
			String headline = article.getHeadline();
			String summary = article.getSummary();
			Text text = new Text(article.getStoryText());
			ArrayList<Tag> tags = article.getTags();
			String feed = article.getFeed();
			String image = article.getImage();

			log.info("Headline: "+headline);

			DateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.ENGLISH);
			Date date;

			try {
				date = format.parse(article.getDate());
			} catch (ParseException e) {
				date = new Date();
				log.warning("Failed to get date.");
				e.printStackTrace();
			}
			try {
				Entity entity = new Entity("Article", headline);
				entity.setProperty("url", url);
				entity.setProperty("headline", headline);
				entity.setProperty("summary", summary);
				entity.setProperty("text", text);
				entity.setProperty("feed", feed);
				entity.setProperty("image", image);
				entity.setProperty("date", date);
				entity = addTagsToEntity(entity, tags);
				datastore.put(entity);
			} catch(Exception e){
				log.warning("Failed to load article to db... ");
			}
		}
	}
	
	private Entity addTagsToEntity(Entity entity, List<Tag> tags) {
		List<String> orgs = new ArrayList<String>();
		List<String> rel = new ArrayList<String>();
		
		for(Tag tag : tags){
			orgs.add(tag.getCompany());
			rel.add(tag.getRelevance());
		}
		entity.setProperty("tag_orgs", orgs);
		entity.setProperty("tag_rel", rel);
		entity.setProperty("num_of_tags", orgs.size());
		
		return entity;
	}
}
