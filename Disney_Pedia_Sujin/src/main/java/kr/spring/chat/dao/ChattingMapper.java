package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;

import kr.spring.chat.vo.ChattingVO;

public interface ChattingMapper {
	
	// [채팅메서드1. 채팅테이블에 대화기록 등록 INSERT : insertChat() ]
	@Insert("INSERT INTO dchatting (chat_num,to_num,from_num,content,chatboard_num) "
			+ "VALUES (dchatting_seq_nextval(),#{to_num},#{from_num},#{content},#{chatboard_num})")
	public void insertChat(ChattingVO chattingVO);

	// [채팅메서드2. 채팅테이블에 등록된 대화기록 SELECT : getChattingDetail() ]
	public List<ChattingVO> getChattingDetail(ChattingVO chattingVO);
	
	// [채팅메서드3. 채팅목록의 메시지 갯수 SELECT : getChattingList() ]
	public List<ChattingVO> getChattingList(ChattingVO chattingVO);

}
