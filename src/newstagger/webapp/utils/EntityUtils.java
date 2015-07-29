package newstagger.webapp.utils;

import java.util.ArrayList;
import java.util.Date;

import newstagger.webapp.article.Article;
import newstagger.webapp.tags.Tag;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Text;

public class EntityUtils {

	@SuppressWarnings("unchecked")
	public static Article extractToArticle(Entity result){
		ArrayList<Tag> tags = new ArrayList<Tag>();

		String key = KeyFactory.keyToString(result.getKey());
		String headline = (String) result.getProperty("headline");
		String summary = (String) result.getProperty("summary");
		String url = (String) result.getProperty("url");
		Text text = (Text) result.getProperty("text");
		String feed = (String) result.getProperty("feed");
		Date date = (Date) result.getProperty("date");
		Long numTags = (Long) result.getProperty("num_of_tags");

		ArrayList<String> orgs = (ArrayList<String>)result.getProperty("tag_orgs");
		ArrayList<String> rels = (ArrayList<String>)result.getProperty("tag_rel");

		for(int i=0; i<numTags; i++){
			tags.add(new Tag(orgs.get(i), rels.get(i)));
		}

		return new Article(key, url, headline, TextUtils.formatSummary(summary), 
				TextUtils.formatArticle(text.getValue()), tags, feed, date, numTags.intValue(), "");
	}

	public static Entity extractFromArticle(Article article){
		return null;
	}
}
