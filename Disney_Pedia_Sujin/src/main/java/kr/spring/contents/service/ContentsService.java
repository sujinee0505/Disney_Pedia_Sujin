package kr.spring.contents.service;

import java.util.List;
import java.util.Map;

import kr.spring.contents.vo.LikeVO;
import kr.spring.contents.vo.StarVO;

public interface ContentsService {
	
	// 별점 등록
	public void insertStar(Map<String,Object> map);

	// 별점 기등록 여부 확인
	public int CheckStar(StarVO star);

	// 별점 정보 확인 (점수 등)
	public StarVO getStar(StarVO star);
	
	// 별점 수정
	public void updateStar(StarVO star);

	// 별점 취소
	public void deleteStar(StarVO star);
 
	// 보고싶어요
	public void contentsLike(LikeVO like);

	// 보고싶어요 기등록 여부 확인
	public int checkLike(LikeVO like);

	// 보고싶어요 취소
	public void cancelLike(LikeVO like);

	// 보고싶어요가 가장 많은 컨텐츠 (메인에서 사용)
	public List<LikeVO> getMostLike(String contents_type);

	// 보고싶어요 목록
	public List<LikeVO> getLikeList(LikeVO like);

	// 보고싶어요 개수 확인, 컨텐츠 타입별로 구분해야 하기 때문에 LikeVO에 담아서 저장 (마이페이지에서 사용)
	public List<LikeVO> getCountLike(int mem_num);
	
	// 평가(별점)한 목록
	public List<StarVO> getStarList(StarVO star);
	
	// 평가(별점)한 컨텐츠 갯수
	public List<StarVO> getCountStar(int mem_num);
}
