package ucd.scott.fyp.article;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Articles {
	private Map<Integer, Article> articles;

	public Articles(){
		articles = new HashMap<Integer, Article>();
	}

	public void addArticle(int id, Article article) {
		articles.put(id, article);
	}

	public Article getArticle(int id) throws Exception {
		if(articles.containsKey(id)){
			return articles.get(id);
		}
		throw new Exception("Article not found!");
	}
	
	public boolean constainsArticle(int id){
		return articles.containsKey(id);
	}
	
	//TODO Change to iterator
	public ArrayList<Article> articles(){
		return new ArrayList<Article>(articles.values());
	}
}
