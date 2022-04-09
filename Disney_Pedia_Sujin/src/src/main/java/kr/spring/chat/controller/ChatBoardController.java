package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.chat.service.ChatBoardService;
import kr.spring.chat.vo.ChatBoardVO;
import kr.spring.chat.vo.ChattingVO;
import kr.spring.member.service.MemberService;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class ChatBoardController {
	private static final Logger logger = LoggerFactory.getLogger(ChatBoardController.class);
		
	@Autowired
	private ChatBoardService chatBoardService;

	//자바빈(VO)초기화
	@ModelAttribute
	public ChatBoardVO initCommand() {
		return new ChatBoardVO();
	}
	//**[글 등록]**
	//글 등록 폼
	@GetMapping("/chatboard/write.do")
	public String form() {
		return "chatBoardWrite";//tiles 설정(definition name)
	}

	//글 등록 폼에서 전송된 데이터 처리
	@PostMapping("/chatboard/write.do")
	public String submit(@Valid ChatBoardVO chatboardVO, BindingResult result, 
									HttpSession session, HttpServletRequest request) {

		logger.info("<<채팅게시판 글 저장>> : " + chatboardVO );
		//유효성 체크 
		//오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		//ChatBoardVO chatboardVO2 = chatBoardService.selectBoard(chatboardVO.getChatboard_num());

		//세션에서 회원번호를 읽어온다
		Integer user_num = (Integer)session.getAttribute("user_num");
		//글쓴 회원번호 셋팅
		chatboardVO.setMem_num(user_num);
		logger.info("<<memnum>> : " + chatboardVO );


		//ip셋팅 -설정 안햇음 왠지 채팅 떄 필요할지도모르겟다

		//글쓰기
		chatBoardService.insertBoard(chatboardVO);

		return "redirect:/chatboard/list.do";
	}
	
	//**[글 목록]**
	//게시판 글 목록
	@RequestMapping("/chatboard/list.do")
	public ModelAndView process(
							@RequestParam(value="pageNum",defaultValue="1")
							int currentPage,
							@RequestParam(value="keyfield",defaultValue="")
							String keyfield,
							@RequestParam(value="keyword",defaultValue="")
							String keyword,
							@RequestParam(value="sort",defaultValue="1")
							int sort, HttpSession session) {
		//데이터 넘기기
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("sort",sort);
		//글의 총갯수 또는 검색된 글의 갯수		
		int count = chatBoardService.selectRowCount(map);
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"list.do");
											//int totalCount, int rowCount,int pageCount,String pageUrl
											//rowcount 한 화면에 몇개 게시물을 띄울지/ pagecount =페이지 아래 몇개의 페이지(숫자)를 띄우게 할지
		map.put("start",page.getStartCount());
		map.put("end",page.getEndCount());

		List<ChatBoardVO> list = null;
		List<ChatBoardVO> list2 = null;
		if(count>0) {
			list = chatBoardService.selectList(map);
			list2 = chatBoardService.selectListHit(map);
		}
		logger.info("<<목록테스트2>> : " + list);
		
		
		//데이터가 준비되었으니 데이터를 표시한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chatBoardList");//tiles설정(definition name)

		mav.addObject("count",count);
		mav.addObject("list", list);
		mav.addObject("list2", list2);
		mav.addObject("pagingHtml", page.getPagingHtml());
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인이 되지 않은 경우
			mav.addObject("user_num",0);
		} else {// 로그인 된 경우
			mav.addObject("user_num",user_num);
		}
		 
		return mav;
	}
	
	//**[글 상세]**
	//게시판 글 상세
	@RequestMapping("/chatboard/detail.do")
	public ModelAndView process(@RequestParam int chatboard_num) {
		logger.info("<<게시판 글 상세 - 글 번호1>> : " + chatboard_num);
		
		//해당 글의 조회수 증가
		chatBoardService.updateHit(chatboard_num);
		//한건의 레코드를 읽어오고
		ChatBoardVO chatboard = chatBoardService.selectBoard(chatboard_num);

		//타이틀 HTML 불허
		chatboard.setTitle(StringUtil.useNoHtml(chatboard.getTitle()));
		
		//한건의 레코드를 ModelAndView에 넘기는데 생성자를 통해서 하나만 넘긴다.
		return new ModelAndView("chatBoardView","chatboard",chatboard);
									//tiles설정,  	 속성명, 	 	속성값
		
		/*ModelAndView mav = new ModelAndView();
		mav.setViewName("chatBoardView");//tiles설정
		
		mav.addObject("chatboard",chatboard);//byte배열로 반환
		mav.addObject("photo",chatboard.getPhoto());//byte배열로 반환
		mav.addObject("photo_name", chatboard.getPhoto_name());
		logger.info("<<mav>> : " + mav);
		
		return mav;
		*/
	}
	
	//이미지 출력
	@RequestMapping("/chatboard/imageView.do")
	public ModelAndView viewImage(@RequestParam int chatboard_num) {
		ChatBoardVO chatboard = chatBoardService.selectBoard(chatboard_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		mav.addObject("photo",chatboard.getPhoto());//byte배열로 반환
		mav.addObject("photo_name", chatboard.getPhoto_name());
		return mav;
	} 
	
	
	//수정 폼
	@GetMapping("/chatboard/update.do")
	public String formUpdate(@RequestParam int chatboard_num,
			                 Model model) {
		ChatBoardVO chatboard = chatBoardService.selectBoard(chatboard_num);
		
		model.addAttribute("chatboard", chatboard);		
		
		return "chatBoardModify";
	}
	
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/chatboard/update.do")
	public String submitUpdate(@Valid ChatBoardVO chatboardVO,
			                   BindingResult result,
			                   HttpServletRequest request,
			                   Model model) {
		
		logger.info("<<글 정보 수정>> : " + chatboardVO);
		
		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않으면 유효성 체크시 오류가 발생하고
			//파일 정보을 잃어버리기 때문에 폼을 호출할 때 다시 셋팅
			ChatBoardVO vo = chatBoardService.selectBoard(chatboardVO.getChatboard_num());
			 //chatboardVO.setFilename(vo.getFilename());
			return "chatBoardModify";
		}
		
		//ip셋팅
		//chatboardVO.setIp(request.getRemoteAddr());
		
		//글 수정
		chatBoardService.updateBoard(chatboardVO);
		
		//view에 표시할 메시지
		//model.addAttribute("content", "글 수정이 완료되었습니다.");
		//model.addAttribute("url", request.getContextPath() + "/chatboard/list.do");
		
		return "redirect:/chatboard/list.do";
	}
	 
	
	//**[글 삭제]**
	//게시판 글 삭제
	@RequestMapping("/chatboard/delete.do")
	public String submitDelete(@RequestParam int chatboard_num) {
		
		chatBoardService.deleteBoard(chatboard_num);
		
		return "redirect:/chatboard/list.do";
	}
	
	
	// *** 채팅자 수 알림***
	@RequestMapping("/chatboard/countChatMember.do")
	@ResponseBody 
	public Map<String, Object> countChatMember(ChattingVO chattingVO,HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		//한건의 레코드를 읽어오고
		int countMember = chatBoardService.countChatMember(chattingVO);
		
		Integer mem_num = (Integer) session.getAttribute("user_num");
		if (mem_num == null) {// 로그인이 되지 않은 경우
			map.put("result", "logout");
		} else {// 로그인 된 경우
				map.put("countMember", countMember);
			}
			map.put("result", "success");
		return map;
	}
}

