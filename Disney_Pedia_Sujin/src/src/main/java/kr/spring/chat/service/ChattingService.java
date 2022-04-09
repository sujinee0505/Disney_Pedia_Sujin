package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import kr.spring.chat.vo.ChatBoardReplyVO;
import kr.spring.chat.vo.ChatBoardVO;
import kr.spring.chat.vo.ChattingVO;

public interface ChattingService {
	// [채팅]

	// [채팅메서드1. 채팅테이블에 채팅등록 INSERT : insertChat() ]
	public void insertChat(ChattingVO chattingVO);
	
	// [ 채팅메서드2. 채팅테이블에  등록된 대화기록 SELECT : getChattingDetail() ]
	public List<ChattingVO> getChattingDetail(ChattingVO chattingVO);
	
	// [ 채팅메서드3. 채팅목록의 메시지 갯수 SELECT : getChattingList() ]
	public List<ChattingVO> getChattingList(ChattingVO chattingVO);

}
