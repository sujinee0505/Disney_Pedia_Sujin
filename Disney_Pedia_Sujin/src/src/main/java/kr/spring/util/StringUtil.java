package kr.spring.util;

public class StringUtil {
	//HTML 태그를 허용하면서 줄바꿈
	public static String useBrHtml(String str) {
		if(str == null) return null;
		
		return str.replaceAll("\r\n", "<br>")
				  .replaceAll("\r", "<br>")
				  .replaceAll("\n", "<br>");
	}
	
	//HTML 태그를 허용하지 않으면서 줄바꿈
	public static String useBrNoHtml(String str) {
		if(str == null) return null;
		
		return str.replaceAll("<", "&lt;")
				  .replaceAll(">", "&gt;")
				  .replaceAll("\r\n", "<br>")
				  .replaceAll("\r", "<br>")
				  .replaceAll("\n", "<br>");
	}
	
	//HTML 태그를 허용하지 않음
	public static String useNoHtml(String str) {
		if(str == null) return null;
		
		return str.replaceAll("<", "&lt;")
				  .replaceAll(">", "&gt;");
	}
	
	//<br>태그 \r로 변경해서 보여지게하기
	public static String hideBr(String str) {
		if(str == null) return null;
		
		return str.replaceAll("<br>", "\r\n")
				  .replaceAll("<br>", "\r")
				  .replaceAll("<br>", "\n");
	}
	
	//특정 문자열 이후에 ...으로 처리
	public static String shortWords(int length, String content) {
		if(content == null) return null;
		
		if(content.length() > length) {
			return content.substring(0,length) + " ...";
		}
		return content;
	}
	
}





