package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;

import kr.spring.chat.vo.ChattingVO;

public interface ChattingMapper {
	// ------------------  채팅_Mapper  ------------------

	// [ 채팅메서드1. 채팅테이블에 대화기록 등록 INSERT : insertChat() ]
	// [ 채팅메서드2. 채팅테이블에  등록된 대화기록 SELECT : getChattingDetail() ]
	// [ 채팅메서드3. 채팅목록의 메시지 갯수 SELECT : getChattingList() ]
	
	// [ 보드/채팅메서드4. 모집상태 변경 UPDATE : update_mateState(Map<String, Object> map) ]
	// : ->ChatBoardMapper.java에 작성
	// --------------------------------------------------

	
	// [채팅메서드1. 채팅테이블에 대화기록 등록 INSERT : insertChat() ]
	@Insert("INSERT INTO dchatting (chat_num,to_num,from_num,content,chatboard_num,send_date) "
			+ "VALUES (dchatting_seq.nextval,#{to_num},#{from_num},#{content},#{chatboard_num},sysdate)")
	public void insertChat(ChattingVO chattingVO);

	// [채팅메서드2. 채팅테이블에 등록된 대화기록 SELECT : getChattingDetail() ]
	//xml
	public List<ChattingVO> getChattingDetail(ChattingVO chattingVO);
	
	// [채팅메서드3. 채팅목록의 메시지 갯수 SELECT : getChattingList() ]
	//xml
	public List<ChattingVO> getChattingList(ChattingVO chattingVO);

}
