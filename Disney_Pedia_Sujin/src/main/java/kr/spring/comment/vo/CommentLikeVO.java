package kr.spring.comment.vo;

public class CommentLikeVO {
	private int comment_num; // 코멘트번호
	private int like_mem; // 좋아요를 누른 회원
	private int comment_mem; // 코멘트 작성 회원
	private String content; // 코멘트 내용
	private String contents_type; // 작성한 코멘트의 컨텐츠 타입
	private int contents_num; // 작성한 코멘트의 컨텐츠 번호
	private double star; // 만약 이미 등록한 별점이 존재한다면 별점을 저장할 변수
	private int countLike; // 코멘트에 눌린 좋아요 갯수
	private int countReply; // 코멘트에 달린 댓글 갯수

	public int getComment_num() {
		return comment_num;
	}

	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}

	public int getLike_mem() {
		return like_mem;
	}

	public void setLike_mem(int like_mem) {
		this.like_mem = like_mem;
	}

	public int getComment_mem() {
		return comment_mem;
	}

	public void setComment_mem(int comment_mem) {
		this.comment_mem = comment_mem;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContents_type() {
		return contents_type;
	}

	public void setContents_type(String contents_type) {
		this.contents_type = contents_type;
	}

	public int getContents_num() {
		return contents_num;
	}

	public void setContents_num(int contents_num) {
		this.contents_num = contents_num;
	}

	public double getStar() {
		return star;
	}

	public void setStar(double star) {
		this.star = star;
	}

	public int getCountLike() {
		return countLike;
	}

	public void setCountLike(int countLike) {
		this.countLike = countLike;
	}

	public int getCountReply() {
		return countReply;
	}

	public void setCountReply(int countReply) {
		this.countReply = countReply;
	}

}
