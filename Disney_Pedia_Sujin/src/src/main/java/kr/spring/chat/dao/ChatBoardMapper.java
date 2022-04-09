package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.chat.vo.ChatBoardReplyVO;
import kr.spring.chat.vo.ChatBoardVO;
import kr.spring.chat.vo.ChattingVO;

public interface ChatBoardMapper {
	
	//**글 목록
	//xml
	public List<ChatBoardVO> selectList(Map<String,Object> map); 
	public List<ChatBoardVO> selectListHit(Map<String,Object> map); 
	//xml
	public int selectRowCount(Map<String,Object> map);

	//**글 등록 폼에서 전송된 데이터 처리 
	@Insert("INSERT INTO dchatboard (chatboard_num,mem_num,title,content,reg_date) " +
			"VALUES (dchatboard_seq.nextval,#{mem_num},#{title},#{content},SYSDATE)")
	public void insertBoard(ChatBoardVO board); 
	
	//**글 상세
	@Select("SELECT * FROM dchatboard b JOIN dmember_detail m "
			+ "ON b.mem_num=m.mem_num WHERE b.chatboard_num=#{chatboard_num}")
	public ChatBoardVO selectBoard(Integer chatboard_num);
	
	//**조회수
	@Update("UPDATE dchatboard SET hit=hit+1 WHERE chatboard_num=#{chatboard_num}")
	public void updateHit(Integer chatboard_num);//조회수
	
 
	//**글 수정
	//xml
	public void updateBoard(ChatBoardVO chatboard);

	//**글 삭제
	@Delete("DELETE FROM dchatboard WHERE chatboard_num=#{chatboard_num}")
	public void deleteBoard(Integer chatboard_num);
	//글 삭제시 해당 글의 채팅이 존재하면 글 삭제 전 채팅 삭제한다
	@Delete("DELETE FROM DCHATTING WHERE chatboard_num=#{chatboard_num}")
	public void deleteChatByBoard(Integer chatboard_num);
	
	// [ 보드/채팅메서드4. 모집상태 변경 UPDATE : update_mateState() ]
	//xml
	public void update_mateState(Map<String, Object> map);
	
	//**채팅 온 갯수 (뱃지알림)
	//작성자는 제외한 from_num카운트하기
	@Select("SELECT COUNT(DISTINCT FROM_NUM) FROM DCHATTING "
			+ "WHERE chatboard_num=#{chatboard_num} AND FROM_NUM != #{from_num}")
	public Integer countChatMember(ChattingVO chattingVO);
}
	

