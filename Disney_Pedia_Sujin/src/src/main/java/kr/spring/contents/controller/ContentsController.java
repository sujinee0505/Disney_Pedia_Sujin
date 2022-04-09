package kr.spring.contents.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.comment.service.CommentService;
import kr.spring.comment.vo.CommentVO;
import kr.spring.contents.service.CalendarService;
import kr.spring.contents.service.ContentsService;
import kr.spring.contents.vo.CalendarVO;
import kr.spring.contents.vo.ContentsVO;
import kr.spring.contents.vo.CreditsVO;
import kr.spring.contents.vo.LikeVO;
import kr.spring.contents.vo.StarVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.sort.SortByDate;
import kr.spring.util.GetInfoUtil;
import kr.spring.util.StringUtil;

@Controller
public class ContentsController {
	@Autowired
	private MemberService memberService;

	@Autowired
	private ContentsService contentsService;

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private CommentService commentService;

	@RequestMapping("/contents/detail.do")
	// 컨텐츠 타입(movie/tv), 컨텐츠 id를 인자로 받음
	public ModelAndView detail(@RequestParam String contents_type, @RequestParam int contents_num,
			HttpSession session) {
		GetInfoUtil util = new GetInfoUtil();
		ContentsVO contents = util.getInfoDetail(contents_type, contents_num);
		List<String> images = util.getImages(contents_type, contents_num);
		List<CreditsVO> cast = util.getCredits(contents_type, contents_num, "cast");
		List<CreditsVO> crew = util.getCredits(contents_type, contents_num, "crew");
		List<ContentsVO> reco = new ArrayList<ContentsVO>();

		// 임시로 사용할 List 생성
		List<ContentsVO> temp = new ArrayList<ContentsVO>();
		// 일단 모든 컨텐츠를 불러와서 저장
		temp = util.getInfoList(contents_type);

		for (int i = 0; i < temp.size(); i++) {
			List<Integer> list1 = new ArrayList<>(temp.get(i).getGenres()); // 모든 컨텐츠들의 장르를 for문을 돌면서 계속 바꿔주면서 넣어줌
			List<Integer> list2 = new ArrayList<>(contents.getGenres()); // 상세 페이지에 출력할 컨텐츠의 장르

			/* 즉, 하나의 컨텐츠의 장르와 여러개의 컨텐츠의 장르를 루프를 통해 매번 서로 비교하는것 */

			// 등록되어 있는 장르가 1개일 경우
			if (list2.size() == 1) {
				list1.retainAll(list2);
				if (list1.size() == 1) {
					ContentsVO vo = new ContentsVO();
					vo = temp.get(i);
					reco.add(vo);
				}
				// 등록되어 있는 장르가 2개일 경우
			} else if (list2.size() == 2) {
				list1.retainAll(list2);
				if (list1.size() == 2) {
					ContentsVO vo = new ContentsVO();
					vo = temp.get(i);
					reco.add(vo);
				}
			} else {
				list1.retainAll(list2);
				// 적어도 겹치는 장르가 세개 이상인 경우만 출력
				if (list1.size() >= 3) {
					ContentsVO vo = new ContentsVO();
					vo = temp.get(i);
					reco.add(vo);
				}
			}
		}
		ModelAndView mav = new ModelAndView();

		Integer user_num = (Integer) session.getAttribute("user_num");

		// CommentVO
		CommentVO comment = new CommentVO();
		comment.setContents_num(contents_num);
		comment.setContents_type(contents_type);
		List<CommentVO> commentList = commentService.selectList(comment); // 해당 컨텐츠에 달린 코멘트 리스트 불러오기
		mav.addObject("commentList", commentList);
		
		List<MemberVO> cmt_memberList = new ArrayList<MemberVO>(); // 각각의 코멘트 작성자 정보를 불러오기
		for (int i = 0; i < commentList.size(); i++) {
			MemberVO cmt_member = new MemberVO();
			cmt_member = memberService.selectMember(commentList.get(i).getMem_num()); // 코멘트 리스트에서 각각의 코멘트 작성자의 mem_num을 통해 상세 정보를 불러와 vo에 저장
			cmt_memberList.add(cmt_member); // List 타입으로 저장
			commentList.get(i).setCountReply(commentService.getCountReply(commentList.get(i).getComment_num())); // 각각의 코멘트에 달린 댓글 갯수를 출력하기 위함
			Integer countLike = commentService.getCountLike(commentList.get(i).getComment_num()); // 코멘트 좋아요 갯수
			if (countLike != null) {
				commentList.get(i).setCountLike(countLike); //각각의 코멘트의 좋아요 갯수
			}
		}
		mav.addObject("cmt_memberList", cmt_memberList); 
		if (user_num != null) { // 로그인 된 상태
			// star
			StarVO star = new StarVO();
			star.setContents_num(contents_num);
			star.setContents_type(contents_type);
			star.setMem_num(user_num);
			StarVO starVO = contentsService.getStar(star); // 로그인한 유저가 해당 컨텐츠를 평가했는지의 정보를 불러옴
			mav.addObject("starVO", starVO);

			comment.setMem_num(user_num); // 코멘트에 로그인한 유저가 좋아요를 눌렀는지 확인하기 위해 user_num 셋팅
			for (int i = 0; i < commentList.size(); i++) {
				comment.setComment_num(commentList.get(i).getComment_num()); // 루프를 돌며 코멘트 넘버 값을 바꿔줌 
				int checkCmtLike = commentService.checkCmtLike(comment);  // 각각 모든 코멘트들을 확인
				commentList.get(i).setCheckCmtLike(checkCmtLike); // 좋아요 여부 정보를 각각 저장 ( 0 → 좋아요 안 누름 / 1 → 좋아요 누름 ) 
			}
			mav.addObject("commentList", commentList);
			
			CommentVO getComment = commentService.getComment(comment); // 로그인한 유저가 작성한 코멘트 정보
			//getComment.setContent(StringUtil.hideBr(getComment.getContent())); //추가 ********
			int checkComment = commentService.checkComment(comment); // 해당 컨텐츠에 코멘트 작성 여부 확인
		
			mav.addObject("getComment", getComment);
			mav.addObject("checkComment", checkComment);

			LikeVO like = new LikeVO();
			like.setContents_num(contents_num);
			like.setContents_type(contents_type);
			like.setMem_num(user_num);
			int check = contentsService.checkLike(like); // 보고싶어요 등록 여부 확인
			mav.addObject("check", check); // 1 → 등록 되어 있음 0 → 등록 되어 있지 않음

			CalendarVO calendar = new CalendarVO();
			calendar.setContents_num(contents_num);
			calendar.setContents_type(contents_type);
			calendar.setMem_num(user_num);
			String dateCheck = calendarService.checkDate(calendar); // 캘린더 등록 여부 확인

			if (dateCheck != null) {
				mav.addObject("dateCheck", dateCheck); // 캘린더에 등록이 되어 있을 경우 날짜를 전달
			} else {
				mav.addObject("dateCheck", "noData"); // 캘린더에 등록이 되어 있지 않을 경우 noData라고 전달
			}

		} else if (user_num == null) { // 로그인 안돼있는 상태에서 디테일 페이지를 열람하면 오류가 발생하길래 임의의 값 전달
			mav.addObject("user_num", 0);
			mav.addObject("check", 0);
		}

		mav.setViewName("contentsDetail");
		mav.addObject("contents", contents); // 컨텐츠 상세 정보
		mav.addObject("images", images); // 컨텐츠 갤러리 이미지
		mav.addObject("cast", cast); // 컨텐츠 배우
		mav.addObject("crew", crew); // 컨텐츠 제작진
		mav.addObject("reco", reco); // 추천 컨텐츠
		return mav;
	}

	// 검색 결과 목록 출력
	@RequestMapping("/contents/search.do")
	public ModelAndView process(@RequestParam String keyword_header,
			@RequestParam(value = "category", defaultValue = "contents") String category) {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("contentsSearch");

		if (category.equals("contents") || category == null) {
			GetInfoUtil util = new GetInfoUtil();

			// 영화에 해당하는 검색 결과와 시리즈에 해당하는 검색 결과를 각각 추출하여 별도의 새로운 List객체에 담기 위한 List객체 생성
			List<ContentsVO> search_result = new ArrayList<ContentsVO>();

			// 영화 목록을 저장할 List객체 생성
			List<ContentsVO> movie = null;
			// 전체 영화 목록을 List에 저장
			movie = util.getInfoList("movie");
			for (int i = 0; i < movie.size(); i++) {
				// 전체 영화 목록 중 제목과 줄거리에 keyword가 포함되는 vo객체만 따로 추출
				if (movie.get(i).getTitle().contains(keyword_header) || movie.get(i).getOverview().contains(keyword_header)) {
					// 저장을 위한 새로운 ContentsVO생성
					ContentsVO contents = new ContentsVO();
					// 조건에 해당하는 경우에만 vo에 저장
					contents = movie.get(i);
					// 루프를 돌면서 List에 추가해준다
					search_result.add(contents);
				}
			}

			List<ContentsVO> tv = null;
			tv = util.getInfoList("tv");
			for (int i = 0; i < tv.size(); i++) {
				if (tv.get(i).getTitle().contains(keyword_header) || tv.get(i).getOverview().contains(keyword_header)) {
					ContentsVO contents = new ContentsVO();
					contents = tv.get(i);
					search_result.add(contents);
				}
			}

			// 위의 과정을 통해 생성된 List를 공개날짜순으로 다시 정렬
			Collections.sort(search_result, new SortByDate());
			mav.addObject("search_result", search_result);

			// 검색 대상이 user일 경우
		} else if (category.equals("users")) {
			List<MemberVO> user_list = new ArrayList<MemberVO>();
			String name = keyword_header;
			user_list = memberService.searchUsers(name);
			mav.addObject("user_list", user_list);
		}
		return mav;
	}

}
