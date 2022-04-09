package kr.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//회원제 서비스 URL이 동작되기 전에 요청을 낚아채서 로그인 판별을 한다.
//HandlerInterceptorAdapter를 상속받아야 기능구현이 가능하다.
public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
/*
 * preHandle재정의 :
 *  인자로  세가지를 받는데 그 중 handler맵핑은 요청하는 컨트롤러 정보를 가지고있다.
 *   ->요청에 의해서 호출되는 클래스를 찾아준다.
 *   
 * 정상적으로 로그인이 잘되어있으면  return true로 요청한 페이지를 호출하게 한다.
 */
	@Override
	public boolean preHandle(HttpServletRequest request, 
							HttpServletResponse response, 
							Object handler) throws Exception{
		logger.info("<<LoginCheckInterceptor 진입>>");
		
		//로그인 여부 검사
		HttpSession session = request.getSession();
		//user_num을 구해서 null이면 로그인 X
		if(session.getAttribute("user_num")==null) {
			
			response.sendRedirect(request.getContextPath()+"/main/interceptorLogin.do");
			
			return false;
		}
		//로그인 O
		return true;
	}
}

