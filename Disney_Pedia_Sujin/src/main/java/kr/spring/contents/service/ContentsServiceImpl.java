package kr.spring.contents.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.contents.dao.ContentsMapper;
import kr.spring.contents.vo.LikeVO;
import kr.spring.contents.vo.StarVO;

@Service
public class ContentsServiceImpl implements ContentsService {

	@Autowired
	private ContentsMapper contentsMapper;

	// 별점 등록
	@Override
	public void insertStar(Map<String, Object> map) {
		contentsMapper.insertStar(map);
	}

	// 별점 기등록 여부 확인
	@Override
	public int CheckStar(StarVO star) {
		return contentsMapper.CheckStar(star);
	}

	// 별점 정보 확인 (점수 등)
	@Override
	public StarVO getStar(StarVO star) {
		return contentsMapper.getStar(star);
	}

	// 별점 수정
	@Override
	public void updateStar(StarVO star) {
		contentsMapper.updateStar(star);
	}

	// 별점 취소
	@Override
	public void deleteStar(StarVO star) {
		contentsMapper.deleteStar(star);
	}

	// 보고싶어요
	@Override
	public void contentsLike(LikeVO like) {
		contentsMapper.contentsLike(like);
	}

	// 보고싶어요 기등록 여부 확인
	@Override
	public int checkLike(LikeVO like) {
		return contentsMapper.checkLike(like);
	}

	// 보고싶어요 취소
	@Override
	public void cancelLike(LikeVO like) {
		contentsMapper.cancelLike(like);
	}

	// 보고싶어요가 가장 많은 컨텐츠 (메인에서 사용)
	@Override
	public List<LikeVO> getMostLike(String contents_type) {
		return contentsMapper.getMostLike(contents_type);
	}

	// 보고싶어요 목록
	@Override
	public List<LikeVO> getLikeList(LikeVO like) {
		return contentsMapper.getLikeList(like);
	}

	// 보고싶어요 개수 확인, 컨텐츠 타입별로 구분해야 하기 때문에 LikeVO에 담아서 저장 (마이페이지에서 사용)
	@Override
	public List<LikeVO> getCountLike(int mem_num) {
		return contentsMapper.getCountLike(mem_num);
	}

	// 평가(별점)한 목록
	@Override
	public List<StarVO> getStarList(StarVO star) {
		return contentsMapper.getStarList(star);
	}

	// 평가(별점)한 컨텐츠 갯수
	@Override
	public List<StarVO> getCountStar(int mem_num) {
		return contentsMapper.getCountStar(mem_num);
	}

}
