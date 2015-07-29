package ucd.scott.fyp.tags;

public class Tag {
	private String org;
	private String rel;

	public Tag(String org, String rel){
		this.org = org;
		this.rel = rel;
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
}
