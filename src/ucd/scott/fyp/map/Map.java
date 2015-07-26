package ucd.scott.fyp.map;

public class Map {
	public static String convert(String feed){
		if(feed.equals("technologyNews")) return "Technology";
		if(feed.equals("companyNews")) return "Company";
		if(feed.equals("domesticNews")) return "USA";
		if(feed.equals("bankruptcyNews")) return "Bankruptcy";
		if(feed.equals("scienceNews")) return "Science";
		if(feed.equals("businessNews")) return "Business";
		return "Not Found";
	}
}
