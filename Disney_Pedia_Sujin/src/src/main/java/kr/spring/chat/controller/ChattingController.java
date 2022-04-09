package kr.spring.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.chat.service.ChatBoardService;
import kr.spring.chat.service.ChattingService;
import kr.spring.chat.vo.ChatBoardVO;
import kr.spring.chat.vo.ChattingVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;

/*
 * 1)채팅목록페이지 -> 2)채팅페이지
 */

@Controller
public class ChattingController {
	private static final Logger logger = LoggerFactory.getLogger(ChattingController.class);
	// log대상 지정
	@Autowired
	private ChattingService chattingService;
	@Autowired
	private ChatBoardService chatboardService;
	@Autowired
	private MemberService memberService;
	
	// *** 2-1)채팅  ***
	// 보드메서드. 게시물 정보 SELECT : selectBoard(Integer chatboard_num)
	// 멤버메서드. 회원정보 SELECT : selectMember(Integer mem_num)
	
	@GetMapping("/chatboard/chatting.do")
	public ModelAndView process(@RequestParam int chatboard_num, @RequestParam int trans_num, HttpSession session) {

		ChatBoardVO chatBoard = new ChatBoardVO();
		chatBoard = chatboardService.selectBoard(chatboard_num); // 게시글 번호로 게시글 정보 불러오기

		MemberVO member = new MemberVO();
		member = memberService.selectMember(trans_num); // chatBoardView에서 받아온 trans_num(게시글 작성자의 회원 번호)을 통해 회원 정보 불러오기
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chatting");
		mav.addObject("chatBoard", chatBoard);
		mav.addObject("member", member);
		mav.addObject("trans_num", trans_num);
		return mav;
	}

	// *** 2-1)채팅 내용 불러오기 ***
	// [채팅메서드2. 채팅테이블에 등록된 대화기록 SELECT : getChattingDetail() ]
	@RequestMapping("/chatboard/getChatting.do")
	@ResponseBody // chatting.jsp에서 ajax로 넘긴 chatboard_num 등이 알아서 데이터 바인딩 되어서 chattingVO에 저장돼있음
	public Map<String, Object> getChattingDetailCount(ChattingVO chattingVO, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		Integer mem_num = (Integer) session.getAttribute("user_num");
		
		if (mem_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			
			List<ChattingVO> getChatting = new ArrayList<ChattingVO>();
			getChatting = chattingService.getChattingDetail(chattingVO); // chatboard_num 등 chatting.jsp에서 받아온 값을 인자로
																			// 넣어서 sql문을 행하여 결과값을 List에 담아준다
			logger.info("<<채팅확인>> : " + getChatting);

			map.put("getChatting", getChatting);
			map.put("result", "success");
		}
		return map;
	}
//			for (int i = 0; i < getChatting.size(); i++) {
//				logger.info("<<mate_state변경하기>> : " + getChatting.get(i));
//			}
	
//			String date_time = chattingVO.getDate_time();
//			StringTokenizer st = new StringTokenizer(date_time," ");
//			String date = st.nextToken();
//			String time = st.nextToken();
//			chattingVO.setDate(date);
//			chattingVO.setTime(time);

	// *** 2-2)채팅 메세지 전송 ***
	// [채팅메서드1. 채팅테이블에 대화기록 등록 INSERT : insertChat() ]
	@RequestMapping("/chatboard/writeChat.do")
	@ResponseBody
	public Map<String, String> insertChat(ChattingVO chattingVO, HttpSession session) {

		Map<String, String> map = new HashMap<String, String>();

		Integer mem_num = (Integer) session.getAttribute("user_num");
		if (mem_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			chattingService.insertChat(chattingVO);
			map.put("result", "success");
		}
		return map;
	}
	
	
	// 보드메서드. 게시물 정보 SELECT : selectBoard(Integer chatboard_num)
	@GetMapping("/chatboard/chattingList.do")
	public ModelAndView getChattingList(@RequestParam int chatboard_num) {
		ChatBoardVO chatboard = new ChatBoardVO();
		chatboard = chatboardService.selectBoard(chatboard_num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chattingList");
		mav.addObject("chatboard", chatboard);
		return mav;
	}
	
	// [채팅메서드3. 채팅메시지 갯수 SELECT : getChattingList() ]
	@RequestMapping("/chatboard/chattingList.do")
	@ResponseBody
	public Map<String, Object> getChattingList(ChattingVO chattingVO, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		Integer mem_num = (Integer) session.getAttribute("user_num");
		if (mem_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
			chattingVO.setFrom_num(mem_num);
			List<ChattingVO> chattingList = new ArrayList<ChattingVO>();
			chattingList = chattingService.getChattingList(chattingVO);
			map.put("chattingList", chattingList);
			map.put("result", "success");
		}
		return map;
	}
	
	// *** 2-3)채팅 메세지 전송 ***
	// [ 보드/채팅메서드4. 모집상태 변경 UPDATE : update_mateState() ]
	@RequestMapping("/chatboard/updateMateState.do")
	@ResponseBody
	public Map<String, Object> update_mateState(ChatBoardVO chatboardVO, HttpSession session, int check) {
		
		logger.info("<<mate_state변경하기>> : " + chatboardVO);
		Map<String, Object> map1 = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();

		map1.put("check", check);
		map1.put("chatboard_num", chatboardVO.getChatboard_num());

		Integer mem_num = (Integer) session.getAttribute("user_num");
		if (mem_num == null) {// 로그인이 되지 않은 경우
			map2.put("result", "logout");

		} else {// 로그인 된 경우
			chatboardService.update_mateState(map1);
			logger.info("<<mate_state변경하기2>> : " + chatboardVO);
			map2.put("result", "success");
		}
		return map2;
	}

	

}
