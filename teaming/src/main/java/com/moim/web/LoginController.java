package com.moim.web;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.common.CookieUtil;
import com.moim.dao.ILocationDao;
import com.moim.exception.BizNotFoundException;
import com.moim.service.ILoginService;
import com.moim.service.IUserService;
import com.moim.vo.LocationVO;
import com.moim.vo.LoginVO;
import com.moim.vo.UserVO;

/**
 * 
 * @author 준오
 *
 */
@Controller
@RequestMapping("/login")
public class LoginController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Inject
	ILoginService loginService;
	
	@Inject
	ILocationDao locationDao;
	
	@Inject
	IUserService userService;
	
	@GetMapping("/login")
	public String loginGet() {
		return "login/login";
	}
	@PostMapping("/login")
	public String loginPost(HttpServletRequest req, HttpServletResponse resp, Model model, RedirectAttributes redirectAttributes) throws Exception{
		String userId = req.getParameter("userId");
		String userPassword = req.getParameter("userPassword");
		String save_id = req.getParameter("rememberMe");

		// 체크박스가 체크 되어 있지 않는 경우
		if (save_id == null) { 
			CookieUtil cookieUtil = new CookieUtil(req);
			// 저장된 쿠키가 있다면 삭제하기
			if (cookieUtil.exists("SAVE_ID")) {
				Cookie cookie = CookieUtil.createCookie("SAVE_ID", userId, "/", 0);
				resp.addCookie(cookie);
			}
			save_id = "";
		}
		// 체크박스가 체크 되어 있는 경우
		if (save_id.equals("Y")) {
			Cookie cookie = CookieUtil.createCookie("SAVE_ID", userId, "/", 60*60*24*7);
			resp.addCookie(cookie);
		}
		if (userId == null || userId.equals("") || userPassword == null || userPassword.equals("")) {
			// 아이디와 패스워드를 입력 안 했을 경우
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", "아이디 혹은 패스워드를 입력하지 않았습니다.");
			return "redirect:/login/login";
		}
		try {
			System.out.println(userId);
			Map<String, LoginVO> user = loginService.getUser(userId, userPassword);
			
//			LoginVO asd=  user.get("NOPE"); 키를 매개로 값 가져오기
			
			
			HttpSession session = req.getSession();
			session.setAttribute("USER_INFO", user);	// 세션에 세팅되는 유저 : ID, ROLE, PASSWORD, name, moimcode
			session.setMaxInactiveInterval(1800);
			
			UserVO user2 = userService.getUser(userId);
			
			if(user2.getUserDelYn().equals("Y")) {
				redirectAttributes.addFlashAttribute("check", "n");
				redirectAttributes.addFlashAttribute("fail", "이미 삭제된 계정입니다.");
				return "redirect:/login/login";
			}
			/*
			 * String prePage = (String) session.getAttribute("PREPAGE");
			 * session.removeAttribute("PREPAGE"); // 주소값을 저장했으니 session다시 삭제 / 삭제안하면 로그인
			 * 할때마다 해당 페이지로 감 if(prePage != null) { return "redirect:" + prePage; }
			 */
			redirectAttributes.addFlashAttribute("check", "y");
			redirectAttributes.addFlashAttribute("success", "로그인 완료");
			return "redirect:/";
		} catch (BizNotFoundException e) {
			redirectAttributes.addFlashAttribute("check", "n");
			redirectAttributes.addFlashAttribute("fail", "아이디와 패스워드를 확인해주세요.");
			return "redirect:/login/login";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest req, HttpServletResponse resp, RedirectAttributes redirectAttributes) {
		HttpSession session = req.getSession();
		session.removeAttribute("USER_INFO");
		redirectAttributes.addFlashAttribute("check", "y");
		redirectAttributes.addFlashAttribute("success", "로그아웃 완료");
		return "redirect:/";
	}
	
	
	@RequestMapping(path =  "/moim/locationDetail.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public List<LocationVO> locationDetail(String bigCode) {
		logger.debug("bigCode={}", bigCode);
		List<LocationVO> result =  locationDao.getLocationByParent(bigCode);
		return result;
	}
	
	@RequestMapping(path =  "/moim/locationDetail2.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public List<LocationVO> locationDetail2(String midCode) {
		logger.debug("midCode={}", midCode);
		List<LocationVO> result =  locationDao.getLocationByParent2(midCode);
		return result;
	}
	
}
