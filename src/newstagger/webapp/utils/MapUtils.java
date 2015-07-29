package newstagger.webapp.utils;

public class MapUtils {
	public static String convertFeedToTitle(String feed){
		if(feed.equals("technologyNews")) return "Technology";
		if(feed.equals("companyNews")) return "Company";
		if(feed.equals("domesticNews")) return "USA";
		if(feed.equals("bankruptcyNews")) return "Bankruptcy";
		if(feed.equals("scienceNews")) return "Science";
		if(feed.equals("businessNews")) return "Business";
		return "Not Found";
	}
}
