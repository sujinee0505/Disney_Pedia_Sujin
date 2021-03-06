package kr.spring.contents.vo;

public class LikeVO {
	private int contents_num; // 컨텐츠 ID
	private String contents_type; // 컨텐츠 타입
	private int mem_num; // 회원 번호
	private int count; // 보고싶어요 갯수

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getContents_num() {
		return contents_num;
	}

	public void setContents_num(int contents_num) {
		this.contents_num = contents_num;
	}

	public String getContents_type() {
		return contents_type;
	}

	public void setContents_type(String contents_type) {
		this.contents_type = contents_type;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	@Override
	public String toString() {
		return "LikeVO [contents_num=" + contents_num + ", contents_type=" + contents_type + ", mem_num=" + mem_num
				+ ", count=" + count + "]";
	}

}
