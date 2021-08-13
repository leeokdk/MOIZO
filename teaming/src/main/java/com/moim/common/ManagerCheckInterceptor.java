package com.moim.common;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.moim.vo.LoginVO;
import com.moim.vo.UserVO;


public class ManagerCheckInterceptor extends HandlerInterceptorAdapter{
// 모임공지 수정 삭제 등록, 멤버삭제, 모임 수정 삭제 에서 하기	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//userRole 세팅이 MEMBER인지 MANAGER인지 확인
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
		
		String moimCode = request.getParameter("moimCode");
		
		// 여기부터는 로그인이 되어있음. 그냥 에러보내기
		if(!userMap.get(moimCode).getRoleName().contains("MANAGER")) {		// 매니저가 아닌
			response.sendRedirect(request.getContextPath() + "/moim/moimView?moimCode=" + moimCode);				//403 에러( 접근권한 에러 )
			return false;
		}
		
		
		return true;
	}

}
