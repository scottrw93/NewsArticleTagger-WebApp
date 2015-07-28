package ucd.scott.fyp.article;

import java.util.Date;

import tag.Tags;

public class Article {
	private String url;
	private String headline;
	private String summary;
	private String text;
	private Tags tags;
	private String feed;
	private Date data;
	private String source;
	private final int id;
	private int num_of_tags;
	private String key;

	public Article(final int id, String key, String url, String headline, String summary,
			String text, Tags tags, String feed, Date date, int num_of_tags, String source){
		
		this.id = id;
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

	public int getId() {
		return id;
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

	public void setDate(Date data) {
		this.data = data;
	}

	public String getFeed() {
		return feed;
	}

	public void setFeed(String feed) {
		this.feed = feed;
	}

	public Tags getTags() {
		return tags;
	}

	public void setTags(Tags tags) {
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
