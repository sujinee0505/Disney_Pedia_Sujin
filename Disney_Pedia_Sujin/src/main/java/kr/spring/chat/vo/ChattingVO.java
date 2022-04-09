package kr.spring.chat.vo;

import java.sql.Date;

public class ChattingVO {
	private int chat_num; // 채팅 번호
	private int to_num; // 메시지수신번호(글작성자회원번호)
	private int from_num; // 메시지발신번호(선채팅자회원번호)
	private int chatstate_num; // 읽기상태(0읽지 않음, 1 읽음)default 0
	private String content; // 내용
	private int chatboard_num; // 게시글번호
	private String send_date; // 발신일 default sysdate
	private String name;
	private String date_time;
	private String date;
	private String time;

	public String getDate() {
		if (send_date != null)
			date = send_date.split(" ")[0];
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		if (send_date != null)
			time = send_date.split(" ")[1];
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getChat_num() {
		return chat_num;
	}

	public void setChat_num(int chat_num) {
		this.chat_num = chat_num;
	}

	public int getTo_num() {
		return to_num;
	}

	public void setTo_num(int to_num) {
		this.to_num = to_num;
	}

	public int getFrom_num() {
		return from_num;
	}

	public void setFrom_num(int from_num) {
		this.from_num = from_num;
	}

	public int getChatstate_num() {
		return chatstate_num;
	}

	public void setChatstate_num(int chatstate_num) {
		this.chatstate_num = chatstate_num;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getChatboard_num() {
		return chatboard_num;
	}

	public void setChatboard_num(int chatboard_num) {
		this.chatboard_num = chatboard_num;
	}

	public String getSend_date() {
		return send_date;
	}

	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}