package ucd.scott.fyp.tags;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Tags {
	private int articleID;
	private List<String> tags;

	public Tags(int articleID){
		this.setArticleID(articleID);
		tags = new ArrayList<String>();
	}

	public int getArticleID() {
		return articleID;
	}

	public void setArticleID(int articleID) {
		this.articleID = articleID;
	}
	
	public void addTag(String tag){
		tags.add(tag);
	}
	
	public Iterator<String> iterator(){
		return tags.iterator();
	}
}
