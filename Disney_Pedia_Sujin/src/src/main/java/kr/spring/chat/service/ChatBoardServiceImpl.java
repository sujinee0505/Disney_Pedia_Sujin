package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.chat.dao.ChatBoardMapper;
import kr.spring.chat.vo.ChatBoardReplyVO;
import kr.spring.chat.vo.ChatBoardVO;
import kr.spring.chat.vo.ChattingVO;

@Service
public class ChatBoardServiceImpl implements ChatBoardService{

	@Autowired
	private ChatBoardMapper chatBoardMapper;

	@Override
	public List<ChatBoardVO> selectList(Map<String, Object> map) {
		return chatBoardMapper.selectList(map);
	}
	@Override 
	public List<ChatBoardVO> selectListHit(Map<String, Object> map) {
		return chatBoardMapper.selectListHit(map);
	}
	
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatBoardMapper.selectRowCount(map);
	}

	@Override
	public void insertBoard(ChatBoardVO chatboard) {
		chatBoardMapper.insertBoard(chatboard);
	}

	@Override
	public ChatBoardVO selectBoard(Integer chatboard_num) {
		return chatBoardMapper.selectBoard(chatboard_num);
	}

	@Override
	public void updateHit(Integer chatboard_num) {
		chatBoardMapper.updateHit(chatboard_num);
	}

	@Override
	public void updateBoard(ChatBoardVO chatboard) {
		chatBoardMapper.updateBoard(chatboard);
	}

	@Override
	public void deleteBoard(Integer chatboard_num) {
		//글에 채팅이 존재하면 채팅을 우선 삭제하고 게시글을 삭제
		chatBoardMapper.deleteChatByBoard(chatboard_num);
		chatBoardMapper.deleteBoard(chatboard_num);
	}
 
	@Override
	public void deleteFile(Integer chatboard_num) {
		//chatBoardMapper.deleteFile(chatboard_num);
	}
	
	
	@Override
	public void update_mateState(Map<String, Object> map) {
		chatBoardMapper.update_mateState(map);
	}
	@Override
	public int countChatMember(ChattingVO chattingVO) {
		return chatBoardMapper.countChatMember(chattingVO);
	}

	
	
}
