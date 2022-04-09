package kr.spring.contents.vo;

public class StarVO {

	private int star_num; // 별점id
	private int contents_num; // 컨텐츠id
	private int mem_num; // 회원번호
	private Double star; // 별점(0.5~5)
	private String contents_type;
	// 수진
	private int count;

	public int getStar_num() {
		return star_num;
	}

	public void setStar_num(int star_num) {
		this.star_num = star_num;
	}

	public int getContents_num() {
		return contents_num;
	}

	public void setContents_num(int contents_num) {
		this.contents_num = contents_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public Double getStar() {
		return star;
	}

	public void setStar(Double star) {
		this.star = star;
	}

	public String getContents_type() {
		return contents_type;
	}

	public void setContents_type(String contents_type) {
		this.contents_type = contents_type;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "StarVO [star_num=" + star_num + ", contents_num=" + contents_num + ", mem_num=" + mem_num + ", star="
				+ star + ", contents_type=" + contents_type + ", count=" + count + "]";
	}

}
