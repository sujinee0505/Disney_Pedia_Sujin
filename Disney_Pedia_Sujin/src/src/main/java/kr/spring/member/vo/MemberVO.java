package kr.spring.member.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private int mem_num;
	@Pattern(regexp = "^[A-Za-z0-9]{4,12}$")
	private String id;
	private int auth;
	private String name;
	@Pattern(regexp = "^[A-Za-z0-9]{4,12}$")
	private String passwd;
	private MultipartFile upload;
	private byte[] photo;
	private String photo_name;
	private String introduction;
	private Date reg_date;
	private Date modify_date;
	private int follow_num;
	private int active_mem;
	private int passive_mem;
	private String path;

	// 비밀번호 변경시 현재 비빌번호를 저장하는 용도로 사용
	@Pattern(regexp = "^[A-Za-z0-9]{4,12}$")
	private String now_passwd;

	// 비밀번호 일치 여부 체크
	public boolean isCheckedPassword(String userPasswd) {
		if (auth > 1 && passwd.equals(userPasswd)) {
			return true;
		}
		return false;
	}

	// 이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException {
		this.upload = upload;
		// MutipartFile -> byte[]
		setPhoto(upload.getBytes());
		// 파일 이름
		setPhoto_name(upload.getOriginalFilename());
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public Date getModify_date() {
		return modify_date;
	}

	public void setModify_date(Date modify_date) {
		this.modify_date = modify_date;
	}

	public int getFollow_num() {
		return follow_num;
	}

	public void setFollow_num(int follow_num) {
		this.follow_num = follow_num;
	}

	public int getActive_mem() {
		return active_mem;
	}

	public void setActive_mem(int active_mem) {
		this.active_mem = active_mem;
	}

	public int getPassive_mem() {
		return passive_mem;
	}

	public void setPassive_mem(int passive_mem) {
		this.passive_mem = passive_mem;
	}

	public String getNow_passwd() {
		return now_passwd;
	}

	public void setNow_passwd(String now_passwd) {
		this.now_passwd = now_passwd;
	}

	@Override
	public String toString() {
		return "MemberVO [mem_num=" + mem_num + ", id=" + id + ", auth=" + auth + ", name=" + name + ", passwd="
				+ passwd + ", upload=" + upload + ", photo_name=" + photo_name + ", introduction=" + introduction
				+ ", reg_date=" + reg_date + ", modify_date=" + modify_date + ", follow_num=" + follow_num
				+ ", active_mem=" + active_mem + ", passive_mem=" + passive_mem + ", now_passwd=" + now_passwd + "]";
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public MultipartFile getUpload() {
		return upload;
	}

}
