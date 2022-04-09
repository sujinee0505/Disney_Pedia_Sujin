package kr.spring.comment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.comment.service.CommentService;
import kr.spring.comment.vo.CommentLikeVO;
import kr.spring.comment.vo.CommentReplyVO;
import kr.spring.comment.vo.CommentVO;
import kr.spring.contents.vo.ContentsVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.GetInfoUtil;
import kr.spring.util.StringUtil;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;


	@Autowired
	private MemberService memberService;

	// 자바빈(vo) 초기화
	@ModelAttribute
	public CommentVO initCommand() {
		return new CommentVO();
	}

	// =====코멘트 등록=====
	// 코멘트 등록 폼 호출
	@GetMapping("/contents/commentWrite.do")
	public String commentform(HttpServletRequest request) {
		return "commentWrite";
	}

	// 코멘트 ajax 등록
	@RequestMapping("/contents/commentWrite.do")
	@ResponseBody
	public Map<String, String> commentSubmit(CommentVO commentVO, HttpSession session, int star_num) {

		Map<String, String> map = new HashMap<String, String>();
		Map<String, Object> insert_map = new HashMap<String, Object>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			// CommentVO에 회원 번호 셋팅
			commentVO.setMem_num(user_num); // 코멘트 작성
			insert_map.put("commentVO", commentVO);
			insert_map.put("star_num", star_num); // 만약 이미 등록된 별점이 있다면 dcontents_star 테이블에서 해당 star_num을 끌고와서 저장할 예정
			commentService.insertComment(insert_map);
			map.put("result", "success");
		}
		return map;
	}

	// =====코멘트 수정=====
	// 코멘트 수정 폼 호출
	@GetMapping("/contents/commentUpdate.do")
	public String commentUpdate(CommentVO commentVO) {
		
		return "commentUpdate";
	}
	
	@RequestMapping("/member/getComment.do")
	@ResponseBody
	public Map<String, String> commentUpdate_member(CommentVO commentVO, HttpSession session) {

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			String content = commentService.getComment(commentVO).getContent();
			map.put("result", "success");
			map.put("content", content);
		}
		return map;
	}

	// 코멘트 ajax 수정
	@RequestMapping(value = {"/contents/commentUpdate.do", "/member/commentUpdate.do"})
	@ResponseBody
	public Map<String, String> commentUpdate(CommentVO commentVO, HttpSession session) {

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			// 업데이트
			commentService.updateComment(commentVO);
			map.put("result", "success");
		}
		return map;
	}

	// 코멘트 ajax 삭제
	@RequestMapping(value = {"/contents/commentDelete.do","/member/commentDelete.do"})
	@ResponseBody
	public Map<String, String> commentDelete(CommentVO commentVO, HttpSession session) {

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			// 삭제
			commentService.deleteComment(commentVO);
			map.put("result", "success");
		}
		return map;
	}

	// 내가 쓴 코멘트 목록
	@RequestMapping("/member/myComment.do")
	public ModelAndView myComment(int mem_num) {
		List<CommentVO> commentList = new ArrayList<CommentVO>();
		commentList = commentService.selectListByMem_num(mem_num); // 내가 작성한 코멘트 목록 불러오기

		GetInfoUtil util = new GetInfoUtil();
		List<ContentsVO> contentsList = new ArrayList<ContentsVO>();
		
		for (int i = 0; i < commentList.size(); i++) {
			ContentsVO contents = new ContentsVO();
			contents = util.getInfoDetail(commentList.get(i).getContents_type(), commentList.get(i).getContents_num()); // 영화 상세정보 불러오기
			contentsList.add(contents);
			commentList.get(i).setCountReply(commentService.getCountReply(commentList.get(i).getComment_num()));
			commentList.get(i).setContent(StringUtil.useBrHtml(commentList.get(i).getContent())); //추가)코멘트 줄바꿈 적용
			Integer countLike = commentService.getCountLike(commentList.get(i).getComment_num()); // 코멘트 좋아요 갯수
			if (countLike != null) {
				commentList.get(i).setCountLike(countLike); // 각각의 코멘트의 좋아요 갯수
			}
			
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("myComment");
		mav.addObject("commentList", commentList);
		mav.addObject("contentsList", contentsList);
		return mav;
	}

	// 내가 좋아요 한 코멘트 목록
	@RequestMapping("/member/likeComment.do")
	public ModelAndView likeComment(int mem_num) {
		List<CommentLikeVO> cmtLikeList = commentService.selectListLikeByMem_num(mem_num); // 내가 좋아요 한 코멘트 목록 불러오기
		
		GetInfoUtil util = new GetInfoUtil();
		
		List<ContentsVO> contentsList = new ArrayList<ContentsVO>();
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		for (int i = 0; i < cmtLikeList.size(); i++) {
			ContentsVO contents = new ContentsVO();
			contents = util.getInfoDetail(cmtLikeList.get(i).getContents_type(), cmtLikeList.get(i).getContents_num()); // 영화 상세정보 불러오기
			contentsList.add(contents);
			MemberVO member = new MemberVO();
			member = memberService.selectMember(cmtLikeList.get(i).getComment_mem()); // 내가 좋아요 한 코멘트의 작성자 상세정보 불러오기
			memberList.add(member);
			cmtLikeList.get(i).setCountReply(commentService.getCountReply(cmtLikeList.get(i).getComment_num()));
			Integer countLike = commentService.getCountLike(cmtLikeList.get(i).getComment_num()); // 코멘트 좋아요 갯수
			if (countLike != null) {
				cmtLikeList.get(i).setCountLike(countLike); // 각각의 코멘트의 좋아요 갯수
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("likeComment");
		mav.addObject("cmtLikeList", cmtLikeList);
		mav.addObject("contentsList", contentsList);
		mav.addObject("memberList", memberList);
		return mav;
	}

	// 코멘트 상세페이지
	@RequestMapping("/contents/cmtDetail.do")
	public ModelAndView selectComment(HttpSession session, CommentVO commentVO) {
		CommentVO comment = commentService.selectComment(commentVO.getComment_num()); // 코멘트 상세정보 불러오기
		MemberVO member = memberService.selectMember(comment.getMem_num()); // 코멘트 작성자의 상세정보 불러오기

		comment.setContent(StringUtil.useBrHtml(comment.getContent()));//추가)내용 줄바꿈 출력
		
		GetInfoUtil util = new GetInfoUtil();
		
		ContentsVO contents = util.getInfoDetail(commentVO.getContents_type(), commentVO.getContents_num()); // 코멘트 컨텐츠의 상세 정보 불러오기
		Integer countLike = commentService.getCountLike(comment.getComment_num()); // 코멘트 좋아요 갯수
		Integer countReply = commentService.getCountReply(comment.getComment_num()); // 코멘트의 좋아요 갯수
		
		if (countLike == null) {
			countLike = 0;
		}
		
		ModelAndView mav = new ModelAndView();
		
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if (mem_num != null) { // 로그인 된 경우
			CommentVO comment_user = new CommentVO();
			comment_user.setComment_num(comment.getComment_num());
			comment_user.setMem_num(mem_num);
			
			int checkCmtLike = commentService.checkCmtLike(comment_user); // 해당 코멘트에 로그인 한 유저가 댓글을 작성했는지 여부 확인
			mav.addObject("checkCmtLike", checkCmtLike);
		} else {  // 로그인이 되지 않은 경우
			mem_num = 0;
			int checkCmtLike = 0;
			mav.addObject("checkCmtLike", checkCmtLike);
		}

		mav.setViewName("commentDetail");
		mav.addObject("comment", comment);
		mav.addObject("contents", contents);
		mav.addObject("countLike", countLike);
		mav.addObject("countReply", countReply);
		mav.addObject("user_num", mem_num);
		mav.addObject("member", member);
		return mav;
	}

	// 코멘트 등록 폼 호출
	@GetMapping("/contents/replyWrite.do")
	public String replyForm(HttpServletRequest request) {
		return "replyWrite";
	}

	// 코멘트 댓글 작성
	@RequestMapping("/contents/replyWrite.do")
	@ResponseBody
	public Map<String, Object> replySubmit(CommentReplyVO reply, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			reply.setMem_num(user_num);
			// 댓글 작성
			Integer countReply = commentService.getCountReply(reply.getComment_num()); // 댓글 갯수 확인
			if (countReply == null) {
				countReply = 0;
			}
			map.put("countReply", countReply); // 새 댓글 작성 후 댓글 수 업데이트 할 때 필요
			commentService.insertReply(reply);
			map.put("result", "success");
		}
		return map;
	}

	// 코멘트 댓글 목록
	@RequestMapping("/contents/listReply.do")
	@ResponseBody
	public Map<String, Object> listReply(int comment_num, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		List<CommentReplyVO> reply = commentService.selectListReply(comment_num);
		map.put("reply", reply);

		return map;
	}

	// 코멘트 댓글 수정
	@RequestMapping("/contents/replyUpdate.do")
	@ResponseBody
	public Map<String, String> replyUpdate(CommentReplyVO reply, HttpSession session) {

		Map<String, String> map = new HashMap<String, String>();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {
			map.put("result", "logout");
		} else {
			commentService.updateReply(reply);
			map.put("result", "success");
		}
		return map;
	}

	// 코멘트 댓글 삭제
	@RequestMapping("/contents/replyDelete.do")
	@ResponseBody
	public Map<String, String> replyDelete(HttpSession session, int reply_num) {

		Map<String, String> map = new HashMap<String, String>();

		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {
			map.put("result", "logout");
		} else {
			commentService.deleteReply(reply_num);
			map.put("result", "success");
		}
		return map;
	}
}
