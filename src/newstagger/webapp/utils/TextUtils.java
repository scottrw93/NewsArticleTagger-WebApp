package newstagger.webapp.utils;


public class TextUtils {

	public static String formatArticle(String text){

		if(text == null){
			return "Something Went Wrong!";
		}

		String tidy_text = text;
		String[] split = tidy_text.split("\\(Reuters\\) - ");

		if(split.length == 2){
			tidy_text = split[1];
		}

		String finalText = "";
		for(int i = 0; i < tidy_text.length(); i++){
			finalText += tidy_text.charAt(i);

			if(tidy_text.charAt(i) == '.'){
				if( i < tidy_text.length()-5 &&
						(Character.isUpperCase(tidy_text.charAt(i+1)) || tidy_text.charAt(i+1) == '"')) {

					if(checkNewParagraph(tidy_text, i+1)){
						finalText += "<br><br>";
					}
				}
			}			
		}

		return finalText;
	}

	public static String formatSummary(String summary){

		if(summary == null){
			return "Something Went Wrong!";
		}

		String[] tidy_summary = summary.split(" - ");

		if(tidy_summary.length == 2){
			summary = tidy_summary[1];
		}

		int len = 0, line_len = 70;
		while(summary.length() - len > line_len){
			for(int i=line_len+len; i>=len; i--){
				if(summary.charAt(i) == ' '){
					summary = summary.substring(0, i)+"<br>"+summary.substring(i, summary.length());
					len += line_len;
					break;
				}
			}
		}

		return summary;
	}

	private static boolean checkNewParagraph(String tidy_text, int i) {
		for(int j = i; j < i+4; j++){
			if(tidy_text.charAt(j) == '.' 
					|| tidy_text.charAt(j) == ')' 
					|| tidy_text.charAt(j) == ']' 
					|| ( Character.isDigit(tidy_text.charAt(j)) && j == i+1 )
					|| (j < i+2 && tidy_text.charAt(j) == ' '))

				return false;
		}
		return true;
	}
}
