package kr.spring.chat.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import kr.spring.member.vo.MemberVO;

public class ChatBoardVO {
	private int chatboard_num; //채팅게시글 번호
	private int mem_num; //작성회원 번호 
	@NotEmpty
	private String title; //채팅게시글 제목
	@NotEmpty
	private String content; //채팅게시글 내용
	private Date reg_date; //채팅게시글 작성일
	
	private int hit; //조회수
	private int mate_state;//0:모집중/1:모집완료
	 
	//*테이블에 없지만 JOIN해서 빈번하게 사용하므로 추가
	//@NotEmpty
	private String name; //회원이름(닉네임)
	//private String photo; //회원사진
	private byte[] photo; //이미지파일,일반파일도 넣을 수 있는 자료실로 사용
	
	private String photo_name;
	
	private MultipartFile upload;
	
	//이미지 BLOB 처리
	public void setUpload(MultipartFile upload) throws IOException{
		this.upload = upload;
		//MutipartFile -> byte[]
		setPhoto(upload.getBytes());
		//파일 이름
		setPhoto_name(upload.getOriginalFilename());
	}
	
	/*
	private MemberVO dmemberVO; 
	
	
	
	public MemberVO getDmemberVO() {
		return dmemberVO;
	}
	public void setDmemberVO(MemberVO dmemberVO) {
		this.dmemberVO = dmemberVO;
	}
	*/
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
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
	public byte[] getPhoto() {
		return photo;
	}
	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	
	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getMate_state() {
		return mate_state;
	}
	public void setMate_state(int mate_state) {
		this.mate_state = mate_state;
	}
	
	
	@Override
	public String toString() {
		return "ChatBoardVO [chatboard_num=" + chatboard_num + ", mem_num=" + mem_num + ", title=" + title
				+ ", content=" + content + ", reg_date=" + reg_date + ", hit=" + hit + ", mate_state=" + mate_state
				+ ", name=" + name + ", photo=" + photo + "]";
	}
	
	
	
	
	
}
