package kr.spring.contents.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.comment.vo.CommentVO;
import kr.spring.contents.vo.LikeVO;
import kr.spring.contents.vo.StarVO;

public interface ContentsMapper {

	public void insertStar(Map<String,Object> map);

	@Select("SELECT COUNT(*) FROM dcontents_star WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public int CheckStar(StarVO star);
	
	// 영화,회원일치하는 별점vo 반환
	@Select("SELECT * FROM dcontents_star WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public StarVO getStar(StarVO star);
	
	@Update("UPDATE dcontents_star SET star=#{star} WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public void updateStar(StarVO star);

	@Delete("DELETE FROM dcontents_star WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public void deleteStar(StarVO star);

	@Insert("INSERT INTO dcontents_like (clike_num, contents_num, contents_type, mem_num) VALUES (dcontents_like_seq.nextval,#{contents_num},#{contents_type},#{mem_num})")
	public void contentsLike(LikeVO like);

	@Select("SELECT COUNT(*) FROM dcontents_like WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num} ")
	public int checkLike(LikeVO like);

	@Delete("DELETE FROM dcontents_like WHERE contents_num=#{contents_num} AND contents_type=#{contents_type} AND mem_num=#{mem_num}")
	public void cancelLike(LikeVO like);

	@Select("SELECT COUNT(contents_num) count, contents_num  FROM dcontents_like WHERE contents_type=#{contents_type} GROUP BY contents_num ORDER BY count(contents_num) DESC")
	public List<LikeVO> getMostLike(String contents_type);

	@Select("SELECT * FROM dcontents_like WHERE mem_num = #{mem_num} AND contents_type = #{contents_type}")
	public List<LikeVO> getLikeList(LikeVO like);
	
	@Select("SELECT * FROM dcontents_star WHERE mem_num = #{mem_num} AND contents_type = #{contents_type}")
	public List<StarVO> getStarList(StarVO star);

	@Select("SELECT count(*) count, contents_type FROM dcontents_like WHERE mem_num = #{mem_num} GROUP BY contents_type")
	public List<LikeVO> getCountLike(int mem_num);

	@Select("SELECT count(*) count, contents_type FROM dcontents_star WHERE mem_num = #{mem_num} GROUP BY contents_type")
	public List<StarVO> getCountStar(int mem_num);

}
