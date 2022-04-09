package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

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
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;

@Controller
public class ChatBoardController {
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
	public String submit(@Valid ChatBoardVO chatboardVO, BindingResult result, HttpSession session) {

		//유효성 체크 
		//오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}

		//세션에서 회원번호를 읽어온다
		Integer user_num = (Integer)session.getAttribute("user_num");
		//글쓴 회원번호 셋팅
		chatboardVO.setMem_num(user_num);

		//글쓰기
		chatBoardService.insertBoard(chatboardVO);

		return "redirect:/chatboard/list.do";
	}
	
	//**[글 목록]**
	//게시판 글 목록
	@RequestMapping("/chatboard/list.do")
	public ModelAndView process(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyfield", defaultValue = "") String keyfield,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "sort", defaultValue = "1") int sort, HttpSession session) {
		//데이터 넘기기
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("sort",sort);
		//글의 총갯수 또는 검색된 글의 갯수		
		int count = chatBoardService.selectRowCount(map);
		
		String addKey = "";
		if (sort == 2) {
			addKey = "&sort=2";
		}
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"list.do",addKey);
											//int totalCount, int rowCount,int pageCount,String pageUrl
											//rowcount 한 화면에 몇개 게시물을 띄울지/ pagecount =페이지 아래 몇개의 페이지(숫자)를 띄우게 할지
		
		map.put("start",page.getStartCount()-1);
		map.put("end",page.getEndCount());

		List<ChatBoardVO> list = null;
		if(count>0) {
			list = chatBoardService.selectList(map);
		}
		
		//데이터가 준비되었으니 데이터를 표시한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("chatBoardList");//tiles설정(definition name)

		mav.addObject("count",count);
		mav.addObject("list", list);
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
		
		//해당 글의 조회수 증가
		chatBoardService.updateHit(chatboard_num);
		//한건의 레코드를 읽어오고
		ChatBoardVO chatboard = chatBoardService.selectBoard(chatboard_num);

		//타이틀 HTML 불허
		chatboard.setTitle(StringUtil.useNoHtml(chatboard.getTitle()));
		//줄바꿈 처리
		chatboard.setContent(StringUtil.useBrHtml(chatboard.getContent()));
		
		//한건의 레코드를 ModelAndView에 넘기는데 생성자를 통해서 하나만 넘긴다.
		return new ModelAndView("chatBoardView","chatboard",chatboard);
		 							//tiles설정,  	 속성명, 	 	속성값
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
	public String formUpdate(@RequestParam int chatboard_num, Model model) {
		ChatBoardVO chatboard = chatBoardService.selectBoard(chatboard_num);
		
		model.addAttribute("chatboard", chatboard);		
		
		return "chatBoardModify";
	}
	
	//수정 폼에서 전송된 데이터 처리
	@PostMapping("/chatboard/update.do")
	public String submitUpdate(@Valid ChatBoardVO chatboardVO, BindingResult result, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼을 호출
		if(result.hasErrors()) {
			//title 또는 content가 입력되지 않으면 유효성 체크시 오류가 발생하고
			//파일 정보을 잃어버리기 때문에 폼을 호출할 때 다시 셋팅
			ChatBoardVO vo = chatBoardService.selectBoard(chatboardVO.getChatboard_num());
			 //chatboardVO.setFilename(vo.getFilename());
			return "chatBoardModify";
		}
		
		//글 수정
		chatBoardService.updateBoard(chatboardVO);
		
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

