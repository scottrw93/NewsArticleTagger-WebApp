package ucd.scott.fyp.article;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Articles {
	private Map<String, Article> articles;

	public Articles(){
		articles = new HashMap<String, Article>();
	}

	public void addArticle(String key, Article article) {
		articles.put(key, article);
	}

	public Article getArticle(String key) throws Exception {
		if(articles.containsKey(key)){
			return articles.get(key);
		}
		throw new Exception("Article not found!");
	}
	
	public boolean constainsArticle(String key){
		return articles.containsKey(key);
	}
	
	//TODO Change to iterator
	public ArrayList<Article> articles(){
		return new ArrayList<Article>(articles.values());
	}
}
