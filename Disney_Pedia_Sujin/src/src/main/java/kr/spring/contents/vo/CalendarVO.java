package kr.spring.contents.vo;

public class CalendarVO {

	private int cal_num;
	private int contents_num;
	private int mem_num;
	private String custom_date;
	private String contents_type;
	private String poster_path;
	private String path;

	public int getCal_num() {
		return cal_num;
	}

	public void setCal_num(int cal_num) {
		this.cal_num = cal_num;
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

	public String getCustom_date() {
		return custom_date;
	}

	public void setCustom_date(String custom_date) {
		this.custom_date = custom_date;
	}

	public String getContents_type() {
		return contents_type;
	}

	public void setContents_type(String contents_type) {
		this.contents_type = contents_type;
	}

	public String getPoster_path() {
		return poster_path;
	}

	public void setPoster_path(String poster_path) {
		this.poster_path = poster_path;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
}