package kr.spring.chat.vo;

import kr.spring.util.DurationFromNow;

public class ChatBoardReplyVO {
	private int re_num;
	private String re_content;
	private String re_date; //몇시간전, 몇분전... (하단set메서드에 날짜처리 해준다.)
	private String re_mdate;
	private int chatboard_num; //부모 글 번호
	private int mem_num; //댓글 작성자 번호
	
	private String name;//MemberVO에서 가져온 name

	public int getRe_num() {
		return re_num;
	}

	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}

	public String getRe_content() {
		return re_content;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	public String getRe_date() {
		return re_date;
	}

	public void setRe_date(String re_date) {
//		this.re_date = re_date;
		this.re_date = DurationFromNow.getTimeDiffLabel(re_date);
		
	}

	public String getRe_mdate() {
		return re_mdate;
	}

	public void setRe_mdate(String re_mdate) {
//		this.re_mdate = re_mdate;
		this.re_mdate = DurationFromNow.getTimeDiffLabel(re_mdate);
	}

	public int getChatboard_num() {
		return chatboard_num;
	}

	public void setChatboard_num(int chatboard_num) {
		this.chatboard_num = chatboard_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "ChatboardReplyVO [re_num=" + re_num + ", re_content=" + re_content + ", re_date=" + re_date
				+ ", re_mdate=" + re_mdate + ", chatboard_num=" + chatboard_num + ", mem_num=" + mem_num + ", name="
				+ name + "]";
	}

	
}
