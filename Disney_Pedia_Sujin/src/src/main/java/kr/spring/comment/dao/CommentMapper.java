package kr.spring.comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.comment.vo.CommentLikeVO;
import kr.spring.comment.vo.CommentReplyVO;
import kr.spring.comment.vo.CommentVO;

public interface CommentMapper {

	/* 코멘트 */

	// 코멘트 작성
	public void insertComment(Map<String, Object> map);

	// 코멘트 작성 여부 확인(1->기록있음,0->기록없음)
	@Select("SELECT COUNT(*) FROM dcomment WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public int checkComment(CommentVO comment);

	// 코멘트 한 건 vo로 반환(영화,회원일치하는 레코드)
	@Select("SELECT * FROM dcomment WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public CommentVO getComment(CommentVO comment);

	// 코멘트 수정
	@Update("UPDATE dcomment SET content=#{content}, modify_date=SYSDATE WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public void updateComment(CommentVO commentVO);

	// 코멘트 삭제
	@Delete("DELETE FROM dcomment WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public void deleteComment(CommentVO commentVO);

	// 코멘트 목록 불러오기
	@Select("SELECT a.*, s.star FROM (SELECT d.name, d.photo_name, c.* FROM dmember_detail d JOIN dcomment c ON d.mem_num=c.mem_num ) a "
			+ "LEFT OUTER JOIN dcontents_star s ON a.star_num = s.star_num WHERE a.contents_type=#{contents_type} and a.contents_num=#{contents_num} ORDER BY a.comment_num DESC")
	public List<CommentVO> selectList(CommentVO comment); 

	// 코멘트 상세 정보
	@Select("SELECT c.*, s.star FROM dcomment c LEFT OUTER JOIN dcontents_star s ON c.star_num = s.star_num WHERE c.comment_num=#{comment_num}")
	public CommentVO selectComment(int comment_num);

	/* 코멘트 좋아요/댓글 */

	// 코멘트 좋아요
	@Insert("INSERT INTO dcomment_like (commentlike_num, comment_num, mem_num) VALUES (dcomment_like_seq.nextval,#{comment_num},#{mem_num})")
	public void commentLike(CommentVO comment);

	// 코멘트 좋아요 취소
	@Delete("DELETE FROM dcomment_like WHERE comment_num =#{comment_num} AND mem_num=#{mem_num}")
	public void cancelCmtLike(CommentVO comment);

	// 해당 코멘트 좋아요 갯수
	@Select("SELECT COUNT(*) FROM dcomment_like WHERE comment_num = #{comment_num} GROUP BY comment_num")
	public Integer getCountLike(int comment_num);

	// 코멘트 좋아요 여부 확인
	@Select("SELECT COUNT(*) FROM dcomment_like WHERE comment_num=#{comment_num} AND mem_num=#{mem_num}")
	public int checkCmtLike(CommentVO comment);

	// 코멘트 댓글 목록 불러오기
	@Select("SELECT r.*, d.name,d.photo_name FROM dcomment_reply r JOIN dmember_detail d ON r.mem_num = d.mem_num  WHERE comment_num=#{comment_num} ORDER BY reply_num ASC")
	public List<CommentReplyVO> selectListReply(int comment_num);

	// 코멘트 댓글 갯수
	@Select("SELECT COUNT(*) FROM dcomment_reply WHERE comment_num=#{comment_num}")
	public int getCountReply(int comment_num);

	// 코멘트 댓글 작성
	@Insert("INSERT INTO dcomment_reply (reply_num, comment_num, mem_num, content) VALUES (dcomment_reply_seq.nextval, #{comment_num}, #{mem_num}, #{content})")
	public void insertReply(CommentReplyVO reply);

	// 코멘트 댓글 수정
	@Update("UPDATE dcomment_reply SET content=#{content}, modify_date=SYSDATE WHERE reply_num=#{reply_num}")
	public void updateReply(CommentReplyVO reply);

	// 코멘트 댓글 삭제
	@Delete("DELETE FROM dcomment_reply WHERE reply_num=#{reply_num}")
	public void deleteReply(int reply_num);

	/* 메인/마이 페이지에서 사용 */

	// 가장 코멘트가 많이 달린 컨텐츠 (메인페이지에서 사용)
	@Select("SELECT COUNT(contents_num) count, contents_num  FROM dcomment WHERE contents_type=#{contents_type} GROUP BY contents_num ORDER BY count(contents_num) DESC")
	public List<CommentVO> getMostCommented(String contents_type);

	// 내 코멘트 목록
	@Select("SELECT star, c.mem_num,  c.contents_type, c.contents_num, content, c.comment_num FROM dcomment c "
			+ "LEFT OUTER JOIN dcontents_star s ON c.star_num = s.star_num WHERE c.mem_num = #{mem_num}  ORDER BY c.comment_num DESC" )
	public List<CommentVO> selectListByMem_num(int mem_num);

	// 내가 좋아요한 코멘트 목록
	@Select("SELECT a.*, s.star FROM dcontents_star s RIGHT OUTER JOIN "
			+ "(SELECT l.commentLike_num, l.mem_num like_mem, c.mem_num comment_mem, c.content, c.contents_type, c.contents_num, c.comment_num,c.star_num "
			+ "FROM dcomment_like l JOIN dcomment c ON l.comment_num=c.comment_num) a ON a.star_num=s.star_num WHERE like_mem = #{mem_num} ORDER BY a.commentLike_num DESC")
	public List<CommentLikeVO> selectListLikeByMem_num(int mem_num);
}
