package newstagger.webapp.article;

import java.util.ArrayList;
import java.util.Date;

import newstagger.webapp.tags.Tag;

public class Article {
	private String url;
	private String headline;
	private String summary;
	private String text;
	private ArrayList<Tag> tags;
	private String feed;
	private Date data;
	private String source;
	private int num_of_tags;
	private String key;

	public Article(String key, String url, String headline, String summary,
			String text, ArrayList<Tag> tags, String feed, Date date, int num_of_tags, String source){
		
		this.key = key;
		this.url = url;
		this.headline = headline;
		this.summary = summary;
		this.text = text;
		this.tags = tags;
		this.feed = feed;
		this.data = date;
		this.source = source;
		this.num_of_tags = num_of_tags;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Date getDate() {
		return data;
	}
	
	public String getDateAsString() {
		return data.toString().replace(" GMT ", " ");
	}

	public void setDate(Date data) {
		this.data = data;
	}

	public String getFeed() {
		return feed;
	}

	public void setFeed(String feed) {
		this.feed = feed;
	}

	public ArrayList<Tag> getTags() {
		return tags;
	}
	
	public ArrayList<String> getHighRelTags() {
		ArrayList<String> hrt = new ArrayList<String>();
		for(Tag tag : tags){
			if(tag.isHighRel()){
				hrt.add(tag.getOrg());
			}
		}
		return hrt;
	}
	
	public ArrayList<String> getLowRelTags() {
		ArrayList<String> lrt = new ArrayList<String>();
		for(Tag tag : tags){
			if(!tag.isHighRel()){
				lrt.add(tag.getOrg());
			}
		}
		return lrt;
	}

	public void setTags(ArrayList<Tag> tags) {
		this.tags = tags;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public String getHeadline() {
		return headline;
	}

	public void setHeadline(String headline) {
		this.headline = headline;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getNumTags() {
		return num_of_tags;
	}

	public void setNumTags(int num_of_tags) {
		this.num_of_tags = num_of_tags;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
}
