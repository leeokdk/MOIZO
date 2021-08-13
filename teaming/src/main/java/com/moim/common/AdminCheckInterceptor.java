package com.moim.common;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.vo.LoginVO;
import com.moim.vo.UserVO;

// admin 폴더 내 전체 ( admin/noticeList, noticeView 제외 )
public class AdminCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null) {
			response.sendRedirect(request.getContextPath() + "/login/login");
			return false;
		}
		
		Map<String , LoginVO> userMap = (Map<String , LoginVO>)session.getAttribute("USER_INFO");
		if(userMap == null) {
			response.sendRedirect(request.getContextPath() + "/login/login");
			return false;
		}
		// 여기부터는 로그인이 되어있음.
		if(!userMap.get("NOPE").getRoleName().contains("admin")) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "관리자만 볼 수 있음");				//403 에러( 접근권한 에러 )
			return false;
		}
		
		return true;
	}

}
