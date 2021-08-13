package com.moim.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// moim 폴더 내 전체, admin/noticeView 매핑 ( 지역가져오기 메서드 두개 제외)
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession(false);	// 파라미터가 없거나 true는 session 이 없으면 새로 생성함. false는 session 이 없으면 return null;
		// session은 보통 없을 경우가 거의 없음. 
		
		// ajax 요청인지, 브라우저 요청인지 구별
		// ajax 요청이고 로그인이 되어있어야만 return 을 true로
		String ajax = request.getHeader("X-requested-with");
			if(session == null) {
				if(ajax != null) {		// session 없고 ajax 일 때
					response.sendError(HttpServletResponse.SC_UNAUTHORIZED);		// ajax의 error 로 감.
					return false;
				}
				response.sendRedirect(request.getContextPath() + "/login/login");
				return false;
			}
			if(session.getAttribute("USER_INFO") == null) {		// session 은 있는데 로그인 세션이 없으면
				if(ajax != null) {
					// 로그인없이 댓글등록 할 때
					// Referer 저장
					session.setAttribute("PRECONTENT", request.getParameter("reContent"));
					session.setAttribute("PREPAGE", request.getHeader("Referer"));
					
//					request.getHeader("Referer") == localhost:8080/a/free/freeView.wow ( 해당 페이지 이전의 페이지 정보를 저장함 )
					response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
					return false;
				}
				response.sendRedirect(request.getContextPath() + "/login/login");
				return false;
			}
			return true;
	}
}
