package newstagger.webapp.tags;

import newstagger.webapp.article.Article;

public class Tag {
	private String org;
	private String rel;
	private Article article;

	public Tag(String org, String rel){
		this.org = org;
		this.rel = rel;
		this.article = null;
	}
	
	public Tag(String org, String rel, Article article){
		this.org = org;
		this.rel = rel;
		this.setArticle(article);
	}

	public String getRel() {
		return rel;
	}

	public void setRel(String rel) {
		this.rel = rel;
	}

	public String getOrg() {
		return org;
	}

	public void setOrg(String org) {
		this.org = org;
	}

	public boolean isHighRel() {
		return rel.equals("H");
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}
}
