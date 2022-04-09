package kr.spring.contents.service;

import java.util.List;
import java.util.Map;

import kr.spring.contents.vo.LikeVO;
import kr.spring.contents.vo.StarVO;

public interface ContentsService {
	public void insertStar(Map<String,Object> map);

	public int CheckStar(StarVO star);
	
	public StarVO getStar(StarVO star);
	
	public void updateStar(StarVO star);

	public void deleteStar(StarVO star);

	public void contentsLike(LikeVO like);

	public int checkLike(LikeVO like);

	public void cancelLike(LikeVO like);

	public List<LikeVO> getMostLike(String contents_type);

	public List<LikeVO> getLikeList(LikeVO like);

	public List<LikeVO> getCountLike(int mem_num);
	
	public List<StarVO> getStarList(StarVO star);
	
	public List<StarVO> getCountStar(int mem_num);
}
