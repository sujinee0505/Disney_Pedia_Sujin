package kr.spring.comment.vo;

import kr.spring.util.DurationFromNow;

public class CommentReplyVO {

	private int reply_num; // 댓글 번호
	private int mem_num; // 댓글 작성자 번호
	private int comment_num; // 댓글이 달릴 코멘트 번호
	private String content; // 댓글 내용
	private String reg_date; // 댓글 작성일
	private String modify_date; // 댓글 수정일
	private String name; // 댓글 작성자 이름
	private String photo_name; // 댓글 작성자의 프로필 사진 여부 확인용

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getComment_num() {
		return comment_num;
	}

	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = DurationFromNow.getTimeDiffLabel(reg_date);
	}

	public String getModify_date() {
		return modify_date;
	}

	public void setModify_date(String modify_date) {
		this.modify_date = DurationFromNow.getTimeDiffLabel(modify_date);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

}
