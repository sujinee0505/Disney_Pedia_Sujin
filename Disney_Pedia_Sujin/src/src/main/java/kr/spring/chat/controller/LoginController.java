package kr.spring.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@RequestMapping("/main/interceptorLogin.do")
	public String main() {
		
		
		//타일스 설정
		return "interceptorLogin";
	}
}
