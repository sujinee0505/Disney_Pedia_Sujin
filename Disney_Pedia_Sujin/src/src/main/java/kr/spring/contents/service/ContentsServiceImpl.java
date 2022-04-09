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

	// 별점
	@Override
	public void insertStar(Map<String,Object> map) {
		contentsMapper.insertStar(map);
	}

	@Override
	public int CheckStar(StarVO star) {		
		return contentsMapper.CheckStar(star);
	}
	
	@Override
	public StarVO getStar(StarVO star) {
		return contentsMapper.getStar(star);
	}

	@Override
	public void updateStar(StarVO star) {
		contentsMapper.updateStar(star);
	}

	@Override
	public void deleteStar(StarVO star) {
		contentsMapper.deleteStar(star);
	}

	
	// 보고싶어요
	@Override
	public void contentsLike(LikeVO like) {
		contentsMapper.contentsLike(like);
	}

	@Override
	public int checkLike(LikeVO like) {
		return contentsMapper.checkLike(like);
	}

	@Override
	public void cancelLike(LikeVO like) {
		contentsMapper.cancelLike(like);
	}

	@Override
	public List<LikeVO> getMostLike(String contents_type) {
		return contentsMapper.getMostLike(contents_type);
	}

	@Override
	public List<LikeVO> getLikeList(LikeVO like) {
		return contentsMapper.getLikeList(like);
	}

	@Override
	public List<LikeVO> getCountLike(int mem_num) {
		return contentsMapper.getCountLike(mem_num);
	}

	@Override
	public List<StarVO> getStarList(StarVO star) {
		return contentsMapper.getStarList(star);
	}

	@Override
	public List<StarVO> getCountStar(int mem_num) {
		return contentsMapper.getCountStar(mem_num);
	}

}
