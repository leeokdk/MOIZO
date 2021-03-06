package com.moim.web;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moim.dao.IHobbyDao;
import com.moim.dao.ILocationDao;
import com.moim.exception.BizNotEffectedException;
import com.moim.exception.BizNotFoundException;
import com.moim.service.IAdminNoticeService;
import com.moim.service.ILoginService;
import com.moim.service.IMoimService;
import com.moim.service.IUserService;
import com.moim.vo.AdminNoticeSearchVO;
import com.moim.vo.AdminNoticeVO;
import com.moim.vo.HobbyVO;
import com.moim.vo.LocationVO;
import com.moim.vo.LoginVO;
import com.moim.vo.MoimSearchVO;
import com.moim.vo.MoimVO;
import com.moim.vo.UserSearchVO;
import com.moim.vo.UserVO;

/**
 * 
 * @author juno
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Inject
	IAdminNoticeService aNoticeService;
	
	@Inject
	IMoimService moimService;
	
	@Inject
	IUserService userService;
	
	@Inject
	IHobbyDao hobbyDao;
	
	@Inject
	ILoginService loginService;
	
	@Inject
	ILocationDao locationDao;
	
	@ModelAttribute("hobbyList")
	public List<HobbyVO> hobbyList(){
		List<HobbyVO> hobbyList = hobbyDao.getHobbyCode();
		return hobbyList;
	}
	@ModelAttribute("locationList")
	public List<LocationVO> locationList(){
		List<LocationVO> locationList = locationDao.getBigLocation();
		return locationList;
	}
	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/*			관리자 페이지 통합			 */
	@RequestMapping("/admin")
	public String adminList() {
		return "admin/admin";
	}
	
	
	/*			속 공지게시판 관리			 */
	@RequestMapping("/noticeListForAdmin")
	public String adminNoticeList(@ModelAttribute("searchVO") AdminNoticeSearchVO searchVO, Model model) {
		logger.debug("searchVO={}", searchVO);
		model.addAttribute("searchVO", searchVO);
		List<AdminNoticeVO> aNoticeList = aNoticeService.getBoardList(searchVO);
		model.addAttribute("aNoticeList", aNoticeList);
		return "admin/noticeListForAdmin";
	}
	
	/*			속 모임 관리			 */
	@RequestMapping("/moimListForAdmin")
	public String moimList(@ModelAttribute("searchVO") MoimSearchVO searchVO, Model model) {
		searchVO.setRowSizePerPage(4);
		model.addAttribute("searchVO", searchVO);
		List<MoimVO> moimList = moimService.getMoimList(searchVO);
		logger.debug("searchVO={}", searchVO);
		logger.debug("moimList={}", moimList);
		model.addAttribute("moimList", moimList);
		return "admin/moimListForAdmin";
	}	

	@RequestMapping("/moimDelete")
	public String removeMoim(RedirectAttributes redirectAttributes, @ModelAttribute("moim") MoimVO moim
			, Model model) {
		logger.debug("moimVO={}", moim );
		try {
			moimService.removeMoim(moim);
		} catch (BizNotEffectedException ene) {
			model.addAttribute("ene",ene);
		} catch (BizNotFoundException enf) {
			model.addAttribute("enf",enf);
		}
		redirectAttributes.addFlashAttribute("deleteMoimByAdmin", "success");
		return "redirect:/admin/moimList";
	}
	
	/*			속 유저 관리			 */
	@RequestMapping("/userDelete")
	public String userDelete(RedirectAttributes redirectAttributes, @RequestParam("userId") String userId) {
		UserVO user;
		try {
			user = userService.getUser(userId);
			userService.removeUser(user);
		} catch (BizNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (BizNotEffectedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		redirectAttributes.addFlashAttribute("deleteUserByAdmin", "success");
		return "redirect:/admin/userList";
	}
	
	@RequestMapping("/userList")
	public String userList(@ModelAttribute("searchVO") UserSearchVO searchVO, Model model) {
		searchVO.setRowSizePerPage(4);
		model.addAttribute("searchVO", searchVO);
		List<UserVO> userList = userService.getUserList(searchVO);
		logger.debug("searchVO={}", searchVO);
		model.addAttribute("userList", userList);
		
		return "admin/userList";
	}	
	
	@RequestMapping("/userInfo")
	public String userInfo(@RequestParam("userId")String userId, Model model) {
		try {
			UserVO user = userService.getUser(userId);
			LocationVO location = (LocationVO) locationDao.getUserLocation(user);
			model.addAttribute("userLocation", location);
			model.addAttribute("user", user);
		} catch (BizNotFoundException e) {
			e.printStackTrace();
		}
		
		return "admin/userInfo";
	}	
	
	/**
	 * 모임 삭제 관리
	 * @author juno
	 */	
	@RequestMapping(value = "/moimDelete.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String removeMoim(@RequestBody Map<String,String> map, HttpServletRequest req) {
		String moimCode = map.get("moimCode");		
		logger.debug("map={}", map );
		
		String result = "";
		
				MoimVO moim;
				try {
					moim = moimService.getMoim(moimCode);
					logger.debug("moim={}", moim );
					moimService.removeMoim(moim);
					result = "TRUE";
				} catch (BizNotFoundException e) {
					result = "FALSE";
				} catch (BizNotEffectedException e) {
					result = "FALSE";
				}
		
		return result;
	}

	/**
	 * 유저 삭제 관리
	 * @author juno
	 */	
	@RequestMapping(value = "/userDelete.ajax", produces= "application/json; charset=UTF-8" )
	@ResponseBody
	public String removeUser(@RequestBody Map<String,String> map, HttpServletRequest req) {
		String userId = map.get("userId");		
		logger.debug("map={}", map );
		
		String result = "";
		
		try {
			UserVO user = userService.getUser(userId);
			logger.debug("user={}", user );
			
			Map<String, LoginVO> login = loginService.getUser(user.getUserId(), user.getUserPassword());
			LoginVO delLogin = login.get("NOPE");
			loginService.removeLogin(delLogin);
			
			result = "TRUE";
		} catch (BizNotFoundException e) {
			result = "FALSE";
		} catch (BizNotEffectedException e) {
			result = "FALSE";
		}

		return result;
	}
	
}
